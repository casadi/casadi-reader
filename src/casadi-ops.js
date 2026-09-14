import scheme from './scheme.js';
export const OP=Object.fromEntries(Object.entries(scheme.operations).map(([name,id])=>[name.slice(3).toLowerCase(),id]));
