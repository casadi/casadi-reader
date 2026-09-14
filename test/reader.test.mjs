import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {spawnSync} from 'node:child_process';
import {decodeCasadi} from '../src/index.js';
const fixture=name=>readFileSync(new URL(`./fixtures/${name}.casadi`,import.meta.url),'utf8');
for(const name of ['arithmetic','mapping','slice','assignment','sparse'])test('decode native Function.save(): '+name,()=>{
 const decoded=JSON.parse(JSON.stringify(decodeCasadi(fixture(name))));
 const f=decoded.objects[decoded.root];
 const oracle=JSON.parse(readFileSync(new URL(`./fixtures/${name}.json`,import.meta.url),'utf8'));
 assert.equal(f.name,oracle.name);assert.equal(f.type,oracle.type);
 assert.equal(f.instructions.length,oracle.nodes.length);
 const info=JSON.parse(readFileSync(new URL(`./fixtures/${name}.info.json`,import.meta.url),'utf8'));
 const sp=id=>{const {shape,colind,row}=decoded.objects[id];return {shape,colind,row};};
 assert.deepEqual(f.ins.map(sp),oracle.inputs.map(p=>p.sparsity));
 assert.deepEqual(f.outs.map(sp),oracle.outputs.map(p=>p.sparsity));
 for(const [i,ins] of f.instructions.entries()){
  const node=decoded.objects[ins.node],ref=oracle.nodes[i];
  assert.equal(node.op,ref.op);assert.deepEqual(node.info,info[i]);
  if(ref.mapping)assert.deepEqual(node.mapping,ref.mapping);
 }
});
test('malformed encodings, truncation, protocol and debug mode fail',()=>{
 const text=fixture('mapping');
 for(const bad of ['',text.slice(0,-2),text+'aa',text+'z','a',text.slice(1)])assert.throws(()=>decodeCasadi(bad));
 // Protocol is the second 64-bit value. The debug flag follows it.
 assert.throws(()=>decodeCasadi(text.slice(0,16)+'e'+text.slice(17)),/protocol/);
 assert.throws(()=>decodeCasadi(text.slice(0,32)+'ba'+text.slice(34)),/Debug serialization/);
});
test('CLI produces ordinary JSON without native dependencies',()=>{
 const run=spawnSync(process.execPath,['bin/casadi-reader.js','test/fixtures/mapping.casadi'],{encoding:'utf8',cwd:new URL('..',import.meta.url)});
 assert.equal(run.status,0,run.stderr);assert.equal(JSON.parse(run.stdout).format,'casadi_json');
});
