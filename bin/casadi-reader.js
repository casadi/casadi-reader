#!/usr/bin/env node
import {readFile,writeFile} from 'node:fs/promises';
import {decode} from '../dist/index.js';
try {
  const args=process.argv.slice(2),options={};const positional=[];
  for(let i=0;i<args.length;i++){
    if(args[i]==='--lazy')options.lazy=true;
    else if(args[i]==='--type') {if(!args[i+1])throw Error('Missing --type value');options.type=args[++i];}
    else if(args[i]==='--resource')options.type='Resource';
    else if(args[i].startsWith('--'))throw Error('Unknown option '+args[i]);
    else positional.push(args[i]);
  }
  const [input,output,...extra]=positional;
  if(!input||extra.length)throw Error('Usage: casadi-reader [--lazy] [--type TYPE] INPUT [OUTPUT.json]');
  const json=JSON.stringify(decode(await readFile(input,'utf8'),options),null,2)+'\n';
  if(output)await writeFile(output,json);else process.stdout.write(json);
}catch(error){console.error(error.message);process.exitCode=1;}
