#!/usr/bin/env node
import {readFile,writeFile} from 'node:fs/promises';
import {decodeCasadi,decodeResource} from '../src/index.js';
try {
  const args=process.argv.slice(2),options={lazy:args.includes('--lazy')},resource=args.includes('--resource');
  const [input,output,...extra]=args.filter(a=>a!=='--lazy'&&a!=='--resource');
  if(!input||extra.length)throw Error('Usage: casadi-reader [--lazy] [--resource] INPUT [OUTPUT.json]');
  const read=resource?decodeResource:decodeCasadi;
  const json=JSON.stringify(read(await readFile(input,'utf8'),options),null,2)+'\n';
  if(output)await writeFile(output,json);else process.stdout.write(json);
}catch(error){console.error(error.message);process.exitCode=1;}
