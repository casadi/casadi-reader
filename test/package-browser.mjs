// Serve the extracted npm tarball as static files, like a package CDN.
import assert from 'node:assert/strict';
import {execFileSync} from 'node:child_process';
import {mkdtemp, readFile, rm} from 'node:fs/promises';
import {createServer} from 'node:http';
import {tmpdir} from 'node:os';
import {join, resolve, sep} from 'node:path';
import {fileURLToPath} from 'node:url';
import {chromium} from 'playwright';
import {decodeCasadi} from '../src/index.js';
const root=fileURLToPath(new URL('..',import.meta.url));
const temporary=await mkdtemp(join(tmpdir(),'casadi-reader-cdn-'));
let browser, server;
try {
  execFileSync('npm',['run','build'],{cwd:root,stdio:'inherit'});
  const [packed]=JSON.parse(execFileSync('npm',['pack','--ignore-scripts','--json','--pack-destination',temporary],{cwd:root,encoding:'utf8'}));
  execFileSync('tar',['-xf',join(temporary,packed.filename),'-C',temporary]);
  assert(!packed.files.some(f=>f.path.endsWith('.json')&&f.path!=='package.json'),'No runtime JSON assets');
  assert(!packed.files.some(f=>f.path.startsWith('src/')||f.path.startsWith('schemes/')));
  const packageRoot=join(temporary,'package');
  const metadata=JSON.parse(await readFile(join(packageRoot,'package.json'),'utf8'));
  assert.equal(metadata.unpkg,metadata.exports['.']);
  const requests=[];
  server=createServer(async(req,res)=>{
    try {
      const pathname=new URL(req.url,'http://localhost').pathname;
      requests.push(pathname);
      if(pathname==='/'){res.setHeader('Content-Type','text/html');res.end('<!doctype html><title>Reader package</title>');return;}
      const path=resolve(packageRoot,'.'+pathname);
      assert(path.startsWith(packageRoot+sep));
      res.setHeader('Content-Type','text/javascript');
      res.end(await readFile(path));
    }catch{res.statusCode=404;res.end();}
  });
  await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
  browser=await chromium.launch({headless:true});
  const page=await browser.newPage();
  const errors=[];page.on('pageerror',error=>errors.push(error.message));
  await page.goto(`http://127.0.0.1:${server.address().port}/`);
  const entry=metadata.exports['.'].slice(1);
  for(const name of ['arithmetic','mapping','slice','assignment','sparse','sx','sx_nested','mx_sx_call','onnx']){
    const text=await readFile(join(root,`test/fixtures/${name}.casadi`),'utf8');
    const result=await page.evaluate(async({entry,text})=>(await import(entry)).decodeCasadi(text),{entry,text});
    assert.deepEqual(result,decodeCasadi(text));
  }
  const resource=await readFile(join(root,'test/fixtures/resource.casadi'),'utf8');
  const bytes=await page.evaluate(async({entry,resource})=>{
    const reader=await import(entry);
    const doc=await reader.open(new Blob([resource]),{type:'Resource',lazy:true});
    const blob=doc.objects[doc.root].fields.find(f=>f.name==='ZipMemResource::blob').value;
    return Array.from(await blob.read(0,4));
  },{entry,resource});
  assert.deepEqual(bytes,[80,75,3,4]);
  assert.deepEqual(errors,[]);
  assert.deepEqual(requests.filter(p=>p.endsWith('.js')),[entry]);
  assert(!requests.some(p=>p.endsWith('.json')));
  console.log('PASS: packed npm ESM works over HTTP; one JS request, no scheme JSON or CasADi runtime');
} finally {
  if(browser)await browser.close();
  if(server)await new Promise(resolve=>server.close(resolve));
  await rm(temporary,{recursive:true,force:true});
}
