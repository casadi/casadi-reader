import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {decodeCasadi,decodeResource,LazyBlob} from '../src/index.js';
import {EncodedSource} from '../src/source.js';
// These helpers build protocol framing; native fixtures independently check the codec.
const encode=bytes=>Array.from(bytes,b=>String.fromCharCode(97+(b&15),97+(b>>4))).join('');
const i64=n=>{const b=Buffer.alloc(8);b.writeBigInt64LE(BigInt(n));return b;};
const i32=n=>{const b=Buffer.alloc(4);b.writeInt32LE(n);return b;};
const string=s=>Buffer.concat([i32(Buffer.byteLength(s)),Buffer.from(s)]);
const prefix=size=>encode(Buffer.concat([i64(123456789012345),i64(3),Buffer.from([0,100]),
 i32(1),string('ZipMemResource'),string('embed'),i32(1),i64(size)]));

test('lazy MX decoding preserves ordinary JSON',()=>{
 for(const name of ['arithmetic','mapping','slice','assignment','sparse']){
  const text=readFileSync(new URL(`./fixtures/${name}.casadi`,import.meta.url),'utf8');
  assert.deepEqual(decodeCasadi(text,{lazy:true}),decodeCasadi(text));
 }
});
test('16 MiB archive stays undecoded until a slice is requested',()=>{
 const size=16*1024*1024,text=prefix(size)+'kp'.repeat(size);
 let bytes=0;const original=EncodedSource.prototype.byte;
 EncodedSource.prototype.byte=function(offset){bytes++;return original.call(this,offset);};
 try {
  const {resource}=decodeResource(text,{lazy:true});
  assert(resource.blob instanceof LazyBlob);assert.equal(resource.blob.byteLength,size);
  assert(bytes<256,`Decoded ${bytes} bytes while opening a deferred archive`);
  const before=bytes;
  assert.deepEqual([...resource.blob.read(size-3,3)],[250,250,250]);
  assert.equal(bytes-before,3);
  const json=JSON.stringify(resource);
  assert(json.length<256);assert(json.includes('deferred_bytes'));
  assert.throws(()=>resource.blob.read(size,1),/bounds/);
 }finally{EncodedSource.prototype.byte=original;}
});
test('eager and deferred blobs agree; bad payload is diagnosed on access',()=>{
 const text=prefix(4)+encode(Buffer.from([0,1,128,255]));
 assert.deepEqual(decodeResource(text).resource.blob,decodeResource(text,{lazy:true}).resource.blob.read());
 const malformed=text.slice(0,-1)+'z';
 assert.throws(()=>decodeResource(malformed),/encoding/);
 const resource=decodeResource(malformed,{lazy:true}).resource;
 assert.throws(()=>resource.blob.read(),/encoding/);
 assert.throws(()=>decodeResource(text.slice(0,-2),{lazy:true}),/Truncated/);
});
test('native embedded Resource uses the same deferred archive codec as FMU resources',()=>{
 const text=readFileSync(new URL('./fixtures/resource.casadi',import.meta.url),'utf8');
 const expected=readFileSync(new URL('./fixtures/payload.zip',import.meta.url));
 const eager=decodeResource(text),lazy=decodeResource(text,{lazy:true});
 assert.equal(lazy.resource.type,'ZipMemResource');
 assert.deepEqual(Buffer.from(lazy.resource.blob.read()),expected);
 assert.deepEqual(Buffer.from(eager.resource.blob),expected);
});
test('File/Blob lazy opening reads only the header, then the requested encoded slice',async()=>{
 const {openResource}=await import('../src/index.js');
 const size=16*1024*1024,blob=new Blob([prefix(size),'kp'.repeat(size)]),reads=[];
 const file={size:blob.size,slice(start,end){reads.push([start,end]);return blob.slice(start,end);}};
 const {resource}=await openResource(file,{lazy:true});
 assert.deepEqual(reads,[[0,256]]);
 assert.deepEqual([...await resource.blob.read(size-2,2)],[250,250]);
 assert.equal(reads[1][1]-reads[1][0],4);
 assert(JSON.stringify(resource).length<256);
});
