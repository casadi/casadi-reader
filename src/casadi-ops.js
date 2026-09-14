import scheme from '../schemes/serialization_scheme.json' with {type:'json'};
export const OP=Object.fromEntries(Object.entries(scheme.operations).map(([name,id])=>[name.slice(3).toLowerCase(),id]));
