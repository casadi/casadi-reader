import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp, mkdir, copyFile, appendFile, rm} from 'node:fs/promises';
import {spawnSync} from 'node:child_process';
import {tmpdir} from 'node:os';
import {join, dirname} from 'node:path';
import {fileURLToPath} from 'node:url';
const root=fileURLToPath(new URL('..',import.meta.url));
test('CI freshness check rejects a stale generated source asset',async()=>{
  const temporary=await mkdtemp(join(tmpdir(),'casadi-reader-generation-'));
  try {
    const script='scripts/generate-reader-assets.py';
    for(const relative of [script,'schemes/serialization_scheme.json',
      'src/scheme.js','python/casadi_reader/_scheme.py','native/src/scheme.hpp']){
      const target=join(temporary,relative);
      await mkdir(dirname(target),{recursive:true});
      await copyFile(join(root,relative),target);
    }
    const check=()=>spawnSync('python3',[script,'--check'],{cwd:temporary,encoding:'utf8'});
    assert.equal(check().status,0);
    await appendFile(join(temporary,'src/scheme.js'),'// stale\n');
    const failed=check();assert.equal(failed.status,1);assert.match(failed.stderr,/Stale reader assets: src\/scheme.js/);
  }finally{await rm(temporary,{recursive:true,force:true});}
});
