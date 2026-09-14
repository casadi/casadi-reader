import {OP} from './casadi-ops.js';
import scheme from './scheme.js';
import {EncodedSource, LazyBlob, LazyFileBlob} from './source.js';

// Experimental positional reader for protocol 3 / FunctionInternal 8 / MXFunction 3.
// No CasADi runtime, evaluation, dynamic loading or native graph export is used.
const names=new Map(Object.entries(OP).map(([name,id])=>[id,name]));
const unary=new Set(['neg','exp','log','sqrt','sq','twice','sin','cos','tan','asin','acos','atan',
  'not','floor','ceil','fabs','sign','erf','inv','sinh','cosh','tanh','asinh','acosh','atanh'].map(n=>OP[n]));
const binary=new Set(['add','sub','mul','div','pow','constpow','lt','le','eq','ne','and','or',
  'fmod','copysign','if_else_zero','fmin','fmax','atan2'].map(n=>OP[n]));
const mappingOps=new Set([OP.getnonzeros,OP.setnonzeros,OP.addnonzeros]);
const maxItems=1000000;

class Reader {
  constructor(text, options={}) {
    this.source=new EncodedSource(text,options);
    this.lazy=!!options.lazy;this.pos=0;this.shared=[];this.depth=0;
    this.length=this.source.byteLength;
  }
  fail(message){throw Error(`.casadi byte ${this.pos}: ${message}`);}
  take(n){if(n<0 || this.pos+n>this.length)this.fail('Truncated file');const p=this.pos;this.pos+=n;return p;}
  byte(){return this.source.byte(this.take(1));}
  bool(){const b=this.byte();if(b>1)this.fail('Invalid boolean');return !!b;}
  int(){return this.source.view(this.take(4),4).getInt32(0,true);}
  long(){const n=this.source.view(this.take(8),8).getBigInt64(0,true);if(n>BigInt(Number.MAX_SAFE_INTEGER)||n<BigInt(Number.MIN_SAFE_INTEGER))this.fail('Integer outside JavaScript safe range');return Number(n);}
  double(){return this.source.view(this.take(8),8).getFloat64(0,true);}
  count(n){if(!Number.isSafeInteger(n)||n<0||n>maxItems)this.fail('Invalid or excessive collection size');return n;}
  string(){const n=this.count(this.int()),start=this.take(n);return new TextDecoder('utf-8',{fatal:true}).decode(this.source.read(start,n));}
  vector(read){const n=this.count(this.long());return Array.from({length:n},()=>read.call(this));}
  blob(){const length=this.long(),offset=this.take(length);return this.lazy?new LazyBlob(this.source,offset,length):this.source.read(offset,length);}
  emptyMap(){if(this.long()!==0)this.fail('Nonempty option/cache dictionaries are outside this proof of concept');return {};}
  version(name,expected){if(!scheme.class_versions[name]?.includes(expected))this.fail(`Vendored scheme does not describe ${name} version ${expected}`);const v=this.int();if(v!==expected)this.fail(`Unsupported ${name} serialization version ${v}; expected ${expected}`);}
  object(kind,read){
    const flag=this.byte();
    if(flag===114){const id=this.long(),entry=this.shared[id];if(!entry||(entry.kind!==kind&&entry.value!==null))this.fail(`Invalid shared-object reference ${id}: expected ${kind}, got ${entry?.kind}; objects=${this.shared.map(e=>e.kind)}`);return entry.value;}
    if(flag!==100)this.fail('Invalid shared-object definition');
    if(++this.depth>256)this.fail('Object nesting limit exceeded');
    const value=read.call(this);--this.depth;
    if(this.shared.length>=maxItems)this.fail('Too many shared objects');
    this.shared.push({kind,value});return value;
  }
  sparsity(){return this.object('S',function(){
    const v=this.vector(this.long);if(!v.length)return null;
    const [rows,cols]=v;this.count(rows);this.count(cols);
    const colind=v.slice(2,3+cols),row=v.slice(3+cols);
    if(colind.length!==cols+1||colind[0]!==0||colind[cols]!==row.length||
       colind.some((x,i)=>x<0||x>row.length||(i&&x<colind[i-1]))||row.some(x=>x<0||x>=rows))this.fail('Invalid sparsity');
    return {shape:[rows,cols],colind,row};
  });}
  slice(){return {start:this.long(),stop:this.long(),step:this.long()};}
  expand(s){
    if(!s.step)this.fail('Zero slice step');
    const n=this.count(Math.max(0,Math.ceil((s.stop-s.start)/s.step)));
    return Array.from({length:n},(_,i)=>s.start+i*s.step);
  }
  mx(){return this.object('X',function(){
    const op=this.int(),name=names.get(op)||String(op);let subtype,value;
    if(binary.has(op))subtype=this.byte();
    else if(op===OP.const){subtype=String.fromCharCode(this.byte());
      if(subtype==='D')value=this.double();else if(subtype==='I')value=this.long();
      else if(['0','1','-'].includes(subtype))value=subtype==='-'?-1:Number(subtype);
      else if(subtype!=='a')this.fail(`Unsupported constant subtype ${subtype}`);
    } else if(mappingOps.has(op))subtype=String.fromCharCode(this.byte());
    else if(!unary.has(op)&&![OP.parameter,OP.input,OP.output,OP.reshape,OP.transpose].includes(op))this.fail(`Unsupported MX operation ${name} (${op})`);
    const deps=this.vector(this.mx),sp=this.sparsity(),info={};
    if(!sp&&op!==OP.output)this.fail('Null node sparsity');
    const node={op,deps,sp,info};
    if(unary.has(op)||binary.has(op)){if(this.int()!==op)this.fail('Inconsistent operation ID');}
    else if(op===OP.parameter)node.symbol=this.string();
    else if(op===OP.input||op===OP.output){info.ind=this.long();info.segment=this.long();info.offset=this.long();}
    else if(op===OP.const){node.constants=subtype==='a'?this.vector(this.double):Array(sp.row.length).fill(value);}
    else if(mappingOps.has(op)){
      if(subtype==='a'){info.nz=this.vector(this.long);node.mapping=info.nz;}
      else if(subtype==='b'){info.slice=this.slice();node.mapping=this.expand(info.slice);}
      else if(subtype==='c'){
        info.inner=this.slice();info.outer=this.slice();
        const inner=this.expand(info.inner),outer=this.expand(info.outer);this.count(inner.length*outer.length);
        node.mapping=outer.flatMap(o=>inner.map(i=>i+o));
      }else this.fail(`Unsupported mapping subtype ${subtype}`);
      if(op!==OP.getnonzeros)info.add=op===OP.addnonzeros;
    }
    return node;
  });}
  function(){return this.object('F',function(){
    if(this.bool())return null;
    const type=this.string();if(type!=='MXFunction')this.fail(`Unsupported function type ${type}; this prototype reads MXFunction`);
    this.version('ProtoFunction',2);const name=this.string();for(let i=0;i<5;i++)this.bool();
    this.version('FunctionInternal',8);
    this.vector(this.bool);this.vector(this.bool);
    const ins=this.vector(this.sparsity),outs=this.vector(this.sparsity);
    const inputNames=this.vector(this.string),outputNames=this.vector(this.string);
    if(this.bool())this.fail('JIT functions are unsupported');this.bool();
    if(this.string()!=='source')this.fail('Linked/embedded JIT libraries are unsupported');
    this.bool();this.string();this.emptyMap();this.string();this.bool();
    this.emptyMap();this.function();this.double();
    for(let i=0;i<8;i++)this.bool();
    this.double();this.double();this.bool();this.bool();this.long();this.bool();this.double();this.string();
    this.bool();this.bool();this.bool();this.long();this.bool();this.bool();this.string();this.string();
    for(let i=0;i<4;i++)this.emptyMap();this.function();this.vector(this.function);
    for(let i=0;i<8;i++)this.long();
    this.version('XFunction',1);const inputNodes=this.vector(this.mx);
    this.version('MXFunction',3);const n=this.count(this.long()),instructions=[];
    for(let i=0;i<n;i++)instructions.push({node:this.mx(),arg:this.vector(this.long),res:this.vector(this.long)});
    this.vector(this.long);this.vector(this.mx);this.vector(this.double);this.bool();this.bool();this.bool();
    this.vector(this.mx);
    if(ins.length!==inputNames.length||outs.length!==outputNames.length)this.fail('Invalid function ports');
    return {name,type,ins,outs,inputNames,outputNames,inputNodes,instructions};
  });}
}

/** Parse a default Function.save() file; unsupported serialization layouts fail explicitly. */
export function decodeCasadi(text,options={}){
  const r=new Reader(text,options);
  if(r.long()!==scheme.wire.magic)r.fail('Invalid serialization magic');
  if(r.long()!==scheme.wire.protocol)r.fail('Unsupported serialization protocol');
  if(r.bool())r.fail('Debug serialization is outside this proof of concept');
  if(r.byte()!==5)r.fail('Expected a serialized Function');
  const f=r.function();if(!f)r.fail('Null Function');
  if(r.pos!==r.length)r.fail('Trailing data or unsupported serialization layout');
  const ids=new Map(r.shared.filter(e=>e.value!==null).map((e,i)=>[e.value,i]));
  const ref=value=>value===null?null:ids.get(value);
  const objects=r.shared.filter(e=>e.value!==null).map(({kind,value})=>{
    if(kind==='S')return {kind:'sparsity',...value};
    if(kind==='X')return {kind:'mx',...value,operation:names.get(value.op),...(value.constants?{constants:value.constants.map(String)}:{}),deps:value.deps.map(ref),sp:ref(value.sp)};
    if(kind==='F')return {kind:'function',...value,ins:value.ins.map(ref),outs:value.outs.map(ref),
      inputNodes:value.inputNodes.map(ref),instructions:value.instructions.map(i=>({...i,node:ref(i.node)}))};
    throw Error('Unsupported object kind');
  });
  return {format:'casadi_json',version:1,serializationProtocol:3,root:ref(f),objects};
}

/** Inspect a raw SerializingStream Resource, including embedded FMU archives. */
export function decodeResource(text,options={}) {
  return resourceDocument(new Reader(text,options));
}
function resourceDocument(r) {
  if(r.long()!==scheme.wire.magic||r.long()!==scheme.wire.protocol)r.fail('Unsupported serialization header');
  if(r.bool())r.fail('Debug Resource streams are not supported by this entry point');
  const resource=r.object('R',function(){
    this.version('ResourceInternal',1);
    const type=this.string(),serializeMode=this.string();
    this.version(type,1);
    if(type==='ZipMemResource')return {type,serializeMode,blob:this.blob()};
    if(type==='ZipResource'||type==='DirResource')return {type,serializeMode,path:this.string()};
    this.fail('Unsupported resource type '+type);
  });
  if(r.pos!==r.length)r.fail('Trailing Resource data');
  return {format:'casadi_resource',version:1,resource};
}
export const readCasadi=decodeCasadi;
export {LazyBlob};

/** Open an unpadded raw Resource stream from a browser File/Blob. */
export async function openResource(file,{lazy=false,maxBytes=1024*1024*1024}={}) {
  if(!Number.isSafeInteger(file.size)||file.size%2||file.size/2>maxBytes)throw Error('Invalid encoded file size');
  if(!lazy)return decodeResource(await file.text(),{maxBytes});
  for(let prefix=256;;prefix*=2){
    const text=await file.slice(0,Math.min(file.size,prefix)).text();
    const reader=new Reader(text,{lazy:true,maxBytes});
    reader.length=file.size/2;
    try {
      const document=resourceDocument(reader),blob=document.resource.blob;
      if(blob instanceof LazyBlob)document.resource.blob=new LazyFileBlob(file,blob.offset,blob.byteLength);
      return document;
    }catch(error){
      if(!/offset out of bounds|range out of bounds/.test(error.message)||prefix>=file.size||prefix>=1024*1024)throw error;
    }
  }
}
