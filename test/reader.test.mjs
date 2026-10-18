import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {spawnSync} from 'node:child_process';
import {decode} from '../src/index.js';
const fixture=name=>readFileSync(new URL(`./fixtures/${name}.casadi`,import.meta.url),'utf8');
for(const name of ['arithmetic','mapping','slice','assignment','assignment_vector','sparse','sx','sx_nested','mx_sx_call','mx_constants','mx_new_ops','mapped_sx','switch_sx','options_sx','onnx'])test('native plain/debug layouts agree: '+name,()=>{
 const plain=decode(fixture(name)),decorated=decode(fixture(name+'.debug'));
 assert.deepEqual(plain,decorated);
 assert(!/"(?:offset|byteLength)"\s*:/.test(JSON.stringify(plain)));
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
test('unknown function discriminators fail explicitly',()=>{
 const text=fixture('arithmetic');
 const encode=s=>Array.from(Buffer.from(s),b=>String.fromCharCode(97+(b&15),97+(b>>4))).join('');
 assert.throws(()=>decode(text.replace(encode('MXFunction'),encode('QXFunction'))),/Unknown serialization discriminator/);
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
for(const type of ['mx','sx'])test(type+' expression vectors decode ordered dependencies in plain/debug files',()=>{
 const plain=decode(fixture(type+'_expression'));
 assert.deepEqual(plain,decode(fixture(type+'_expression_debug')));
 assert.equal(plain.root,null);assert.equal(plain.roots.length,1);
 assert.equal(plain.roots[0].length,2);
});

test('irregular assignment indices have a resolved vector type',()=>{
 const doc=decode(fixture('assignment_vector'));
 const field=doc.objects.flatMap(o=>o.fields).find(f=>f.name==='SetNonzerosVector::nonzeros');
 assert.equal(field.type,'std::vector<casadi_int>');
 assert.deepEqual(field.value,[0,3,5]);
});
test('files of earlier CasADi releases read as in CasADi, which also refuses some',()=>{
 const releases=new URL('./fixtures/releases/',import.meta.url);
 const expected=JSON.parse(readFileSync(new URL('expected.json',releases),'utf8'));
 const read=name=>decode(readFileSync(new URL(name,releases),'utf8'));
 for(const [name,outcome] of Object.entries(expected)){
  if(outcome!=='read'){assert.throws(()=>read(name),new RegExp(outcome),name);continue;}
  if(name.endsWith('.debug.casadi'))assert.deepEqual(read(name),read(name.replace('.debug.casadi','.casadi')),name);
 }
 // CasADi 3.5.5 wrote version 1 of MXFunction; the current scheme writes 3.
 const versions=read('mx_3.5.5.casadi').objects.flatMap(o=>o.fields||[]).filter(f=>f.name==='MXFunction::serialization::version');
 assert.deepEqual(versions.map(f=>f.value),[1]);
});
