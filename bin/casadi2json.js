#!/usr/bin/env node
import {readFile,writeFile} from 'node:fs/promises';
import {decodeCasadi} from '../src/index.js';
try {
  const [input,output,...extra]=process.argv.slice(2);
  if(!input||extra.length)throw Error('Usage: casadi2json INPUT.casadi [OUTPUT.json]');
  const json=JSON.stringify(decodeCasadi(await readFile(input,'utf8')),null,2)+'\n';
  if(output)await writeFile(output,json);else process.stdout.write(json);
}catch(error){console.error(error.message);process.exitCode=1;}
