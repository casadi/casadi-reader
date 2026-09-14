import {readFile,writeFile} from 'node:fs/promises';
const source=process.argv[2];
if(!source)throw Error('Usage: node scripts/vendor-scheme.mjs PATH/TO/misc/serialization_scheme.json');
const text=await readFile(source,'utf8'),scheme=JSON.parse(text);
if(scheme.format!=='casadi_serialization_scheme'||scheme.version!==1)throw Error('Unsupported scheme');
for(const target of ['schemes/serialization_scheme.json','python/casadi_reader/serialization_scheme.json'])
  await writeFile(new URL('../'+target,import.meta.url),text);
console.log('Vendored scheme for CasADi '+scheme.casadi_version+'; regenerate native constants with python scripts/generate-native-scheme.py.');
