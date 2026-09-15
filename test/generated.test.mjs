import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp, mkdir, copyFile, cp, appendFile, rm} from 'node:fs/promises';
import {spawnSync} from 'node:child_process';
import {tmpdir} from 'node:os';
import {join, dirname} from 'node:path';
import {fileURLToPath} from 'node:url';
const root=fileURLToPath(new URL('..',import.meta.url));
test('CI freshness check rejects a stale generated source asset',async()=>{
  const temporary=await mkdtemp(join(tmpdir(),'casadi-reader-generation-'));
  try {
    const script='scripts/generate-reader-assets.py';
    for(const relative of ['scripts','schemes','src','python','native','matlab','julia']) {
      await cp(join(root,relative),join(temporary,relative),{recursive:true,
        filter:source=>!source.includes('__pycache__')&&!source.includes('/deps/usr')&&!source.includes('/deps/build')});
    }
    const check=()=>spawnSync('python3',[script,'--check'],{cwd:temporary,encoding:'utf8'});
    assert.equal(check().status,0);
    await appendFile(join(temporary,'src/scheme.js'),'// stale\n');
    const failed=check();assert.equal(failed.status,1);assert.match(failed.stderr,/Stale reader assets: src\/scheme.js/);
  }finally{await rm(temporary,{recursive:true,force:true});}
});
