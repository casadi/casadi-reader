/** Encoded input is retained; lazy mode avoids allocating a decoded copy. */
export class EncodedSource {
  constructor(text,{lazy=false,maxBytes=1024*1024*1024}={}) {
    if(typeof text!=='string')throw Error('Expected .casadi file text');
    this.text=text.trim();this.byteLength=this.text.length/2;this.decodedBytes=0;
    if(!Number.isSafeInteger(this.byteLength)||this.byteLength>maxBytes)throw Error('Invalid .casadi encoding or file too large');
    if(!lazy && /[^a-p]/.test(this.text))throw Error('Invalid .casadi encoding');
  }
  byte(offset){
    if(!Number.isSafeInteger(offset)||offset<0||offset>=this.byteLength)throw Error('Encoded source offset out of bounds');
    const a=this.text.charCodeAt(2*offset)-97,b=this.text.charCodeAt(2*offset+1)-97;
    if(a<0||a>15||b<0||b>15)throw Error('Invalid .casadi encoding at byte '+offset);
    this.decodedBytes++;return a|(b<<4);
  }
  read(offset,length){
    if(!Number.isSafeInteger(length)||length<0||offset<0||offset+length>this.byteLength)throw Error('Encoded source range out of bounds');
    return Uint8Array.from({length},(_,i)=>this.byte(offset+i));
  }
  view(offset,length){return new DataView(this.read(offset,length).buffer);}
}

/** Payload bytes are decoded on demand, without loading/unpacking the archive. */
export class LazyBlob {
  #source;
  constructor(source,offset,byteLength){this.#source=source;this.offset=offset;this.byteLength=byteLength;}
  read(offset=0,length=this.byteLength-offset){
    if(!Number.isSafeInteger(offset)||!Number.isSafeInteger(length)||offset<0||length<0||offset+length>this.byteLength)throw Error('Blob slice out of bounds');
    return this.#source.read(this.offset+offset,length);
  }
  toJSON(){return {kind:'deferred_bytes',offset:this.offset,byteLength:this.byteLength,encoding:'casadi-nibbles'};}
}

/** File/Blob payload handle: even the encoded payload is read only on demand. */
export class LazyFileBlob {
  #file;
  constructor(file,offset,byteLength){this.#file=file;this.offset=offset;this.byteLength=byteLength;}
  async read(offset=0,length=this.byteLength-offset){
    if(!Number.isSafeInteger(offset)||!Number.isSafeInteger(length)||offset<0||length<0||offset+length>this.byteLength)throw Error('Blob slice out of bounds');
    const text=await this.#file.slice(2*(this.offset+offset),2*(this.offset+offset+length)).text();
    return new EncodedSource(text).read(0,length);
  }
  toJSON(){return {kind:'deferred_file_bytes',offset:this.offset,byteLength:this.byteLength,encoding:'casadi-nibbles'};}
}

// Synchronous decoder suspends on a missing page; open() loads it and retries.
// Opaque ranges are skipped by length, so their pages are never requested.
export class MissingPage extends Error {
  constructor(index){super('Encoded page not loaded');this.index=index;}
}
export class PagedSource {
  constructor(size,{maxBytes=1024*1024*1024}={}){
    if(!Number.isSafeInteger(size)||size%2||size/2>maxBytes)throw Error('Invalid encoded file size');
    this.byteLength=size/2;this.pageBytes=16384;this.pages=new Map();
  }
  byte(offset){
    if(!Number.isSafeInteger(offset)||offset<0||offset>=this.byteLength)throw Error('Source offset out of bounds');
    const index=Math.floor(offset/this.pageBytes),page=this.pages.get(index);
    if(!page)throw new MissingPage(index);
    return page.byte(offset-index*this.pageBytes);
  }
  read(offset,length){return Uint8Array.from({length},(_,i)=>this.byte(offset+i));}
  view(offset,length){return new DataView(this.read(offset,length).buffer);}
}
