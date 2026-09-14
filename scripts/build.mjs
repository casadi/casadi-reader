import {build} from 'esbuild';
import {fileURLToPath} from 'node:url';
await build({
  absWorkingDir: fileURLToPath(new URL('..', import.meta.url)),
  entryPoints: {index:'src/index.js'},
  outdir:'dist', bundle:true, format:'esm', platform:'browser', target:'es2020',
});
