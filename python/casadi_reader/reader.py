"""Bounded reader for CasADi MX functions and embedded Resource streams."""
import json
import math
import mmap
from pathlib import Path
import struct

from ._scheme import SCHEME
OP = {name[3:].lower(): value for name, value in SCHEME['operations'].items()}
NAMES = {value: name for name, value in OP.items()}
UNARY = {OP[n] for n in ('neg exp log sqrt sq twice sin cos tan asin acos atan not floor ceil '
                        'fabs sign erf inv sinh cosh tanh asinh acosh atanh').split()}
BINARY = {OP[n] for n in ('add sub mul div pow constpow lt le eq ne and or fmod copysign '
                         'if_else_zero fmin fmax atan2').split()}
MAPPING = {OP[n] for n in ('getnonzeros', 'setnonzeros', 'addnonzeros')}


class Source:
    """A text string or read-only mapping; payload pages need not be read."""
    def __init__(self, text=None, path=None, max_bytes=1024**3):
        self.mapping = None
        if path is not None:
            with open(path, 'rb') as stream:
                self.mapping = mmap.mmap(stream.fileno(), 0, access=mmap.ACCESS_READ)
            self.data = self.mapping
        else:
            if not isinstance(text, str):
                raise TypeError('Expected serialized text')
            self.data = text
        self.start, end = 0, len(self.data)
        whitespace = (' ', '\t', '\r', '\n', 32, 9, 13, 10)
        while self.start < end and self.data[self.start] in whitespace:
            self.start += 1
        while end > self.start and self.data[end-1] in whitespace:
            end -= 1
        if (end-self.start) % 2 or (end-self.start)//2 > max_bytes:
            self.close()
            raise ValueError('Invalid .casadi encoding or file too large')
        self.byte_length = (end-self.start)//2
        self.decoded_bytes = 0

    def byte(self, offset):
        if not 0 <= offset < self.byte_length:
            raise ValueError('Encoded source offset out of bounds')
        a, b = self.data[self.start+2*offset:self.start+2*offset+2]
        if isinstance(a, str):
            a, b = ord(a), ord(b)
        a, b = a-97, b-97
        if not (0 <= a <= 15 and 0 <= b <= 15):
            raise ValueError('Invalid .casadi encoding at byte '+str(offset))
        self.decoded_bytes += 1
        return a | (b << 4)

    def read(self, offset, size):
        if size < 0 or offset < 0 or offset+size > self.byte_length:
            raise ValueError('Encoded source range out of bounds')
        return bytes(self.byte(offset+i) for i in range(size))

    def close(self):
        if self.mapping is not None:
            self.mapping.close()
            self.mapping = None

    def __del__(self):
        self.close()


class LazyBlob:
    """Retains the encoded source; read() decodes only the requested range."""
    def __init__(self, source, offset, byte_length):
        self._source, self.offset, self.byte_length = source, offset, byte_length

    def read(self, offset=0, size=None):
        size = self.byte_length-offset if size is None else size
        if offset < 0 or size < 0 or offset+size > self.byte_length:
            raise ValueError('Blob slice out of bounds')
        return self._source.read(self.offset+offset, size)

    def to_dict(self):
        return {'kind': 'deferred_bytes', 'offset': self.offset,
                'byteLength': self.byte_length, 'encoding': 'casadi-nibbles'}

    def close(self):
        """Release the mapped file; subsequent reads through its handles fail."""
        self._source.close()


class Reader:
    def __init__(self, source, lazy=False):
        self.source, self.lazy = source, lazy
        self.pos, self.depth, self.shared = 0, 0, []

    def fail(self, message):
        raise ValueError(f'.casadi byte {self.pos}: {message}')

    def take(self, size):
        if size < 0 or self.pos+size > self.source.byte_length:
            self.fail('Truncated file')
        start, self.pos = self.pos, self.pos+size
        return start

    def byte(self): return self.source.byte(self.take(1))
    def integer(self): return struct.unpack('<i', self.source.read(self.take(4), 4))[0]
    def long(self): return struct.unpack('<q', self.source.read(self.take(8), 8))[0]
    def double(self): return struct.unpack('<d', self.source.read(self.take(8), 8))[0]

    def boolean(self):
        value = self.byte()
        if value > 1: self.fail('Invalid boolean')
        return bool(value)

    def count(self, n):
        if not 0 <= n <= 1000000: self.fail('Invalid or excessive collection size')
        return n

    def string(self):
        size = self.count(self.integer())
        return self.source.read(self.take(size), size).decode('utf8')

    def vector(self, read): return [read() for _ in range(self.count(self.long()))]

    def empty_map(self):
        if self.long(): self.fail('Nonempty option/cache dictionaries are unsupported')

    def version(self, name, expected):
        if expected not in SCHEME['class_versions'].get(name, []):
            self.fail('Vendored scheme does not describe '+name)
        value = self.integer()
        if value != expected: self.fail(f'Unsupported {name} serialization version {value}')

    def object(self, kind, read):
        flag = self.byte()
        if flag == ord('r'):
            index = self.long()
            if not 0 <= index < len(self.shared): self.fail('Invalid shared-object reference')
            other, value = self.shared[index]
            if kind != other and value is not None: self.fail('Shared-object type mismatch')
            return value
        if flag != ord('d'): self.fail('Invalid shared-object definition')
        self.depth += 1
        if self.depth > 256: self.fail('Object nesting limit exceeded')
        value = read()
        self.depth -= 1
        self.count(len(self.shared)+1)
        self.shared.append((kind, value))
        return value

    def sparsity(self):
        def read():
            v = self.vector(self.long)
            if not v: return None
            if len(v) < 3: self.fail('Invalid sparsity')
            rows, cols = v[:2]
            self.count(rows); self.count(cols)
            colind, row = v[2:3+cols], v[3+cols:]
            if (len(colind) != cols+1 or colind[0] != 0 or colind[-1] != len(row)
                    or any(a > b or a < 0 for a, b in zip(colind, colind[1:]))
                    or any(i < 0 or i >= rows for i in row)):
                self.fail('Invalid sparsity')
            return {'shape': [rows, cols], 'colind': colind, 'row': row}
        return self.object('S', read)

    def slice(self): return dict(zip(('start', 'stop', 'step'), (self.long() for _ in range(3))))

    def expand(self, s):
        if not s['step']: self.fail('Zero slice step')
        values = range(s['start'], s['stop'], s['step'])
        self.count(len(values))
        return list(values)

    def mx(self):
        def read():
            op, subtype, value = self.integer(), None, None
            if op in BINARY: subtype = self.byte()
            elif op == OP['const']:
                subtype = chr(self.byte())
                if subtype == 'D': value = self.double()
                elif subtype == 'I': value = self.long()
                elif subtype in ('0', '1', '-'): value = -1 if subtype == '-' else int(subtype)
                elif subtype != 'a': self.fail('Unsupported constant subtype '+subtype)
            elif op in MAPPING: subtype = chr(self.byte())
            elif op not in UNARY and op not in [OP[n] for n in ('parameter', 'input', 'output', 'reshape', 'transpose')]:
                self.fail('Unsupported MX operation '+NAMES.get(op, str(op)))
            deps, sp, info = self.vector(self.mx), self.sparsity(), {}
            if sp is None and op != OP['output']: self.fail('Null node sparsity')
            node = {'op': op, 'deps': deps, 'sp': sp, 'info': info}
            if op in UNARY | BINARY:
                if self.integer() != op: self.fail('Inconsistent operation ID')
            elif op == OP['parameter']: node['symbol'] = self.string()
            elif op in (OP['input'], OP['output']):
                for name in ('ind', 'segment', 'offset'): info[name] = self.long()
            elif op == OP['const']:
                node['constants'] = self.vector(self.double) if subtype == 'a' else [value]*len(sp['row'])
            elif op in MAPPING:
                if subtype == 'a': info['nz'] = node['mapping'] = self.vector(self.long)
                elif subtype == 'b':
                    info['slice'] = self.slice(); node['mapping'] = self.expand(info['slice'])
                elif subtype == 'c':
                    info['inner'], info['outer'] = self.slice(), self.slice()
                    inner, outer = self.expand(info['inner']), self.expand(info['outer'])
                    self.count(len(inner)*len(outer)); node['mapping'] = [i+o for o in outer for i in inner]
                else: self.fail('Unsupported mapping subtype '+str(subtype))
                if op != OP['getnonzeros']: info['add'] = op == OP['addnonzeros']
            return node
        return self.object('X', read)

    def function(self):
        def read():
            if self.boolean(): return None
            kind = self.string()
            if kind != 'MXFunction': self.fail('Unsupported function type '+kind)
            self.version('ProtoFunction', 2); name = self.string()
            for _ in range(5): self.boolean()
            self.version('FunctionInternal', 8)
            self.vector(self.boolean); self.vector(self.boolean)
            ins, outs = self.vector(self.sparsity), self.vector(self.sparsity)
            input_names, output_names = self.vector(self.string), self.vector(self.string)
            if self.boolean(): self.fail('JIT functions are unsupported')
            self.boolean()
            if self.string() != 'source': self.fail('Linked/embedded JIT libraries are unsupported')
            self.boolean(); self.string(); self.empty_map(); self.string(); self.boolean()
            self.empty_map(); self.function(); self.double()
            for _ in range(8): self.boolean()
            self.double(); self.double(); self.boolean(); self.boolean(); self.long(); self.boolean()
            self.double(); self.string(); self.boolean(); self.boolean(); self.boolean(); self.long()
            self.boolean(); self.boolean(); self.string(); self.string()
            for _ in range(4): self.empty_map()
            self.function(); self.vector(self.function)
            for _ in range(8): self.long()
            self.version('XFunction', 1); input_nodes = self.vector(self.mx)
            self.version('MXFunction', 3)
            instructions = [{'node': self.mx(), 'arg': self.vector(self.long), 'res': self.vector(self.long)}
                            for _ in range(self.count(self.long()))]
            self.vector(self.long); self.vector(self.mx); self.vector(self.double)
            self.boolean(); self.boolean(); self.boolean(); self.vector(self.mx)
            if len(ins) != len(input_names) or len(outs) != len(output_names): self.fail('Invalid function ports')
            return {'name': name, 'type': kind, 'ins': ins, 'outs': outs, 'inputNames': input_names,
                    'outputNames': output_names, 'inputNodes': input_nodes, 'instructions': instructions}
        return self.object('F', read)

    def header(self):
        if self.long() != SCHEME['wire']['magic']: self.fail('Invalid serialization magic')
        if self.long() != SCHEME['wire']['protocol']: self.fail('Unsupported serialization protocol')
        if self.boolean(): self.fail('Debug serialization is unsupported by this reader')

    def end(self):
        if self.pos != self.source.byte_length: self.fail('Trailing data or unsupported serialization layout')


def _decode(source, lazy=False):
    r = Reader(source, lazy)
    r.header()
    if r.byte() != 5: r.fail('Expected a serialized Function')
    f = r.function()
    if f is None: r.fail('Null Function')
    r.end()
    values = [(kind, value) for kind, value in r.shared if value is not None]
    ids = {id(value): i for i, (_, value) in enumerate(values)}
    ref = lambda value: None if value is None else ids[id(value)]
    objects = []
    for kind, value in values:
        item = dict(value)
        if kind == 'S': item['kind'] = 'sparsity'
        elif kind == 'X':
            item.update(kind='mx', operation=NAMES[value['op']], deps=list(map(ref, value['deps'])), sp=ref(value['sp']))
            if 'constants' in value:
                item['constants'] = [_number_string(v) for v in value['constants']]
        elif kind == 'F':
            item.update(kind='function', ins=list(map(ref, value['ins'])), outs=list(map(ref, value['outs'])),
                        inputNodes=list(map(ref, value['inputNodes'])),
                        instructions=[dict(i, node=ref(i['node'])) for i in value['instructions']])
        objects.append(item)
    return {'format': 'casadi_json', 'version': 1, 'serializationProtocol': 3, 'root': ref(f), 'objects': objects}


def _number_string(value):
    if math.isnan(value): return 'NaN'
    if math.isinf(value): return 'Infinity' if value > 0 else '-Infinity'
    return str(int(value)) if value == int(value) else str(value)


def loads(text, *, lazy=False):
    return _decode(Source(text=text), lazy)


def read_casadi(path, *, lazy=False):
    return _decode(Source(path=path), lazy)


def _resource(source, lazy=False):
    r = Reader(source, lazy); r.header()
    def read():
        r.version('ResourceInternal', 1)
        kind, mode = r.string(), r.string(); r.version(kind, 1)
        value = {'type': kind, 'serializeMode': mode}
        if kind == 'ZipMemResource':
            size = r.long(); offset = r.take(size)
            value['blob'] = LazyBlob(source, offset, size) if lazy else source.read(offset, size)
        elif kind in ('ZipResource', 'DirResource'): value['path'] = r.string()
        else: r.fail('Unsupported resource type '+kind)
        return value
    resource = r.object('R', read); r.end()
    return {'format': 'casadi_resource', 'version': 1, 'resource': resource}


def loads_resource(text, *, lazy=False):
    return _resource(Source(text=text), lazy)


def read_resource(path, *, lazy=False):
    return _resource(Source(path=path), lazy)


def to_json(document, **options):
    def encode(value):
        if isinstance(value, LazyBlob): return value.to_dict()
        if isinstance(value, bytes): return list(value)
        raise TypeError(type(value).__name__+' is not JSON serializable')
    return json.dumps(document, default=encode, **options)
