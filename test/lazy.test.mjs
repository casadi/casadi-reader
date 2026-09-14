import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {decode,open,LazyBlob} from '../src/index.js';
const text=readFileSync(new URL('./fixtures/resource.casadi',import.meta.url),'utf8');
const payload=readFileSync(new URL('./fixtures/payload.zip',import.meta.url));
const blob=document=>document.objects[document.root].fields.find(f=>f.name==='ZipMemResource::blob').value;
test('native Resource fields and deferred ZIP bytes agree',()=>{
 const eager=blob(decode(text,{type:'Resource'}));
 const lazy=blob(decode(text,{type:'Resource',lazy:true}));
 assert(lazy instanceof LazyBlob);
 assert.deepEqual(eager.$bytes,Array.from(payload));assert.deepEqual(Array.from(lazy.read()),eager.$bytes);
 assert.throws(()=>lazy.read(lazy.byteLength-1,2),/bounds/);
 assert.equal(JSON.parse(JSON.stringify(lazy)).kind,'deferred_bytes');
});
test('large archive skips encoded file I/O until a slice is requested',async()=>{
 const offset=blob(decode(text,{type:'Resource',lazy:true})).offset,size=16*1024*1024;
 const bytes=Buffer.alloc(8);bytes.writeBigUInt64LE(BigInt(size));
 const encoded=Array.from(bytes,b=>String.fromCharCode(97+(b&15),97+(b>>4))).join('');
 const file=new Blob([text.slice(0,2*(offset-8)),encoded,'ab'.repeat(size)]);
 let read=0;
 const tracked={size:file.size,slice(a,b){read+=b-a;return file.slice(a,b);}};
 const lazy=blob(await open(tracked,{type:'Resource',lazy:true}));
 assert(read<65536,'metadata reads remain bounded');
 const before=read;assert.deepEqual(Array.from(await lazy.read(size-3,3)),[16,16,16]);assert.equal(read-before,6);
});
test('bad opaque bytes are checked on access',()=>{
 const original=blob(decode(text,{type:'Resource',lazy:true}));
 const bad=text.slice(0,2*original.offset)+'zz'+text.slice(2*original.offset+2);
 const deferred=blob(decode(bad,{type:'Resource',lazy:true}));
 assert.throws(()=>deferred.read(0,1),/encoding/);
 assert.throws(()=>decode(bad,{type:'Resource'}),/encoding/);
});
