import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {spawnSync} from 'node:child_process';
import {decode} from '../src/index.js';
import scheme from '../src/scheme.js';
const fixture=name=>readFileSync(new URL(`./fixtures/${name}.casadi`,import.meta.url),'utf8');
const structural=value=>{
 if(Array.isArray(value))return value.map(structural);
 if(value&&typeof value==='object')return Object.fromEntries(Object.entries(value).filter(([k])=>!['offset','byteLength'].includes(k)).map(([k,v])=>[k,structural(v)]));
 return value;
};
for(const name of ['arithmetic','mapping','slice','assignment','sparse','sx','sx_nested','mx_sx_call','mx_constants','mx_new_ops','mapped_sx','switch_sx','options_sx','onnx'])test('native plain/debug layouts agree: '+name,()=>{
 const plain=decode(fixture(name)),decorated=decode(fixture(name+'.debug'));
 assert.deepEqual(structural(plain),structural(decorated));
 assert.equal(plain.format,'casadi_serialization');
 const root=plain.objects[plain.root];assert.equal(root.type,'Function');
 assert(root.fields.some(f=>f.name==='ProtoFunction::name'));
 for(const object of plain.objects){assert(!('operation' in object));assert(!('mapping' in object));assert(!('instructions' in object));}
});
test('ONNX bytes are retained without parsing the model',()=>{
 const document=decode(fixture('onnx'),{lazy:true,lazyThreshold:64});
 const field=document.objects[document.root].fields.find(f=>f.name==='OnnxFunction::model_data');
 const value=field.value;
 const bytes=typeof value==='string'?new TextEncoder().encode(value):value.read?value.read():Uint8Array.from(value.$bytes);
 assert.deepEqual(bytes,new Uint8Array(readFileSync(new URL('./fixtures/onnx-model.bin',import.meta.url))));
 assert(document.objects[document.root].fields.some(f=>f.name==='OnnxFunction::in::shapes'));
});
test('new function discriminators need layout data, not runtime code',()=>{
 const text=fixture('arithmetic');
 const encode=s=>Array.from(Buffer.from(s),b=>String.fromCharCode(97+(b&15),97+(b>>4))).join('');
 const changed=text.replace(encode('MXFunction'),encode('QXFunction'));
 assert.throws(()=>decode(changed),/Unknown serialization discriminator/);
 const extended=structuredClone(scheme);
 const cases=extended.reader.types.Function.body[1].body[1].cases;
 cases.QXFunction=cases.MXFunction;
 const document=decode(changed,{scheme:extended});
 assert(document.objects[document.root].fields.some(f=>f.name==='FunctionInternal::base_function'&&f.value==='QXFunction'));
});
test('malformed encoding, truncation, references and protocol fail',()=>{
 const text=fixture('mapping');
 for(const bad of ['',text.slice(0,-2),text+'aa',text+'z','a',text.slice(1)])assert.throws(()=>decode(bad));
 assert.throws(()=>decode(text.slice(0,16)+'e'+text.slice(17)),/protocol/);
});
test('CLI emits structural JSON',()=>{
 const run=spawnSync(process.execPath,['bin/casadi-reader.js','test/fixtures/mapping.casadi'],{encoding:'utf8',cwd:new URL('..',import.meta.url)});
 assert.equal(run.status,0,run.stderr);assert.equal(JSON.parse(run.stdout).format,'casadi_serialization');
});
