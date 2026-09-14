#include <casadi_reader/reader.h>
#include "scheme.hpp"
#include <algorithm>
#include <cmath>
#include <cstring>
#include <fstream>
#include <functional>
#include <iomanip>
#include <limits>
#include <map>
#include <memory>
#include <sstream>
#include <stdexcept>
#include <vector>
namespace {
// Small JSON value used internally. Shared wire objects become indices immediately.
struct J {
  enum Kind { Null, Bool, Number, String, Array, Object } kind=Null;
  std::string scalar;
  std::vector<J> a;
  std::map<std::string,J> o;
  J()=default;
  J(int64_t n):kind(Number),scalar(std::to_string(n)) {}
  J(int n):J(int64_t(n)) {}
  J(const char* s):kind(String),scalar(s) {}
  J(std::string s):kind(String),scalar(std::move(s)) {}
  static J boolean(bool b) { J v; v.kind=Bool; v.scalar=b?"true":"false"; return v; }
  static J array() { J v; v.kind=Array; return v; }
  static J object() { J v; v.kind=Object; return v; }
  J& operator[](const std::string& k) { return o[k]; }
  const J& at(const std::string& k) const { return o.at(k); }
  int64_t n() const { if(kind!=Number) throw std::runtime_error("Expected number"); return std::stoll(scalar); }
  static std::string quote(const std::string& s) {
    std::ostringstream out; out << '"';
    for(unsigned char c:s) {
      if(c=='"'||c=='\\') out << '\\' << c;
      else if(c<32) out << "\\u00" << "0123456789abcdef"[c>>4] << "0123456789abcdef"[c&15];
      else out << c;
    }
    return out.str()+'"';
  }
  std::string dump() const {
    if(kind==Null) return "null";
    if(kind==String) return quote(scalar);
    if(kind==Number||kind==Bool) return scalar;
    std::string s=kind==Array?"[":"{"; bool first=true;
    if(kind==Array) for(const auto& v:a) { if(!first)s+=','; first=false; s+=v.dump(); }
    else for(const auto& v:o) { if(!first)s+=','; first=false; s+=quote(v.first)+':'+v.second.dump(); }
    return s+(kind==Array?"]":"}");
  }
};
struct Source {
  std::ifstream file;
  uint64_t start=0, size=0;
  explicit Source(const char* path):file(path,std::ios::binary) {
    if(!file) throw std::runtime_error("Cannot open file");
    file.seekg(0,std::ios::end); auto end=file.tellg();
    if(end<0) throw std::runtime_error("Cannot size file");
    uint64_t n=uint64_t(end);
    auto whitespace=[](char c){return c==' '||c=='\t'||c=='\r'||c=='\n';};
    char c;
    while(start<n) { file.seekg(start); file.get(c); if(!whitespace(c))break; ++start; }
    while(n>start) { file.seekg(n-1); file.get(c); if(!whitespace(c))break; --n; }
    if((n-start)%2 || (n-start)/2>uint64_t(1)<<30) throw std::runtime_error("Invalid encoded file size");
    size=(n-start)/2;
  }
  void read(uint64_t offset, unsigned char* output, size_t n) {
    if(offset>size||n>size-offset) throw std::runtime_error("Source range out of bounds");
    file.clear(); file.seekg(start+2*offset);
    for(size_t i=0;i<n;++i) {
      char a,b;
      if(!file.get(a)||!file.get(b)) throw std::runtime_error("Truncated file");
      if(a<'a'||a>'p'||b<'a'||b>'p') throw std::runtime_error("Invalid nibble encoding");
      output[i]=(a-'a')|((b-'a')<<4);
    }
  }
};
struct Blob {uint64_t offset,size;};
struct Reader {
  std::shared_ptr<Source> source;
  uint64_t pos=0; int depth=0; bool lazy;
  struct Ref {char kind; J value;};
  std::vector<Ref> shared;
  J objects=J::array(); std::vector<Blob> blobs;
  Reader(std::shared_ptr<Source> s,bool l):source(std::move(s)),lazy(l) {}
  [[noreturn]] void fail(const std::string& s) {throw std::runtime_error(".casadi byte "+std::to_string(pos)+": "+s);}
  uint64_t take(uint64_t n) {if(pos>source->size||n>source->size-pos)fail("Truncated file"); auto p=pos;pos+=n;return p;}
  uint64_t bits(int n) {unsigned char bytes[8];source->read(take(n),bytes,n);uint64_t v=0;for(int i=0;i<n;++i)v|=uint64_t(bytes[i])<<(8*i);return v;}
  int byte() {return int(bits(1));}
  int32_t integer() {auto b=uint32_t(bits(4));int32_t v;std::memcpy(&v,&b,4);return v;}
  int64_t lng() {auto b=bits(8);int64_t v;std::memcpy(&v,&b,8);return v;}
  double real() {auto b=bits(8);double v;std::memcpy(&v,&b,8);return v;}
  bool boolean() {int b=byte();if(b>1)fail("Invalid boolean");return b!=0;}
  int64_t count(int64_t n) {if(n<0||n>1000000)fail("Invalid or excessive collection size");return n;}
  std::string string() {
    auto n=count(integer()); std::string v(size_t(n), '\0');
    source->read(take(n), reinterpret_cast<unsigned char*>(&v[0]), size_t(n));
    for(size_t i=0;i<v.size();) {
      uint32_t c=static_cast<unsigned char>(v[i++]);
      if(c<0x80) continue;
      int trailing; uint32_t minimum;
      if(c>=0xc2&&c<=0xdf) {trailing=1; minimum=0x80; c&=0x1f;}
      else if(c>=0xe0&&c<=0xef) {trailing=2; minimum=0x800; c&=0xf;}
      else if(c>=0xf0&&c<=0xf4) {trailing=3; minimum=0x10000; c&=7;}
      else fail("Invalid UTF-8 string");
      while(trailing--) {
        if(i==v.size()) fail("Truncated UTF-8 string");
        auto b=static_cast<unsigned char>(v[i++]);
        if((b&0xc0)!=0x80) fail("Invalid UTF-8 continuation");
        c=(c<<6)|(b&0x3f);
      }
      if(c<minimum||c>0x10ffff||(c>=0xd800&&c<=0xdfff)) fail("Invalid UTF-8 code point");
    }
    return v;
  }
  J vector(const std::function<J()>& read) {auto n=count(lng());J a=J::array();for(int64_t i=0;i<n;++i)a.a.push_back(read());return a;}
  J longs() {return vector([&]{return J(lng());});}
  void empty_map() {if(lng())fail("Nonempty option/cache dictionaries are unsupported");}
  void version(const std::string& name,int expected) {
    if(!scheme_version(name,expected))fail("Unsupported vendored class version");
    if(integer()!=expected)fail("Unsupported "+name+" serialization version");
  }
  J object(char kind,const std::function<J()>& read) {
    int flag=byte();
    if(flag=='r') {
      auto id=lng();
      if(id<0||uint64_t(id)>=shared.size())fail("Invalid shared reference");
      auto r=shared[size_t(id)];
      if(r.kind!=kind&&r.value.kind!=J::Null)fail("Shared reference type mismatch");
      return r.value;
    }
    if(flag!='d')fail("Invalid object definition");
    if(++depth>256)fail("Object nesting limit exceeded");
    J value=read(); --depth; J ref;
    if(value.kind!=J::Null) {
      if(kind=='R') ref=value;
      else {ref=J(int64_t(objects.a.size()));objects.a.push_back(std::move(value));}
    }
    count(int64_t(shared.size())+1); shared.push_back({kind,ref}); return ref;
  }
  J sparsity() {return object('S',[&]{
    auto v=longs();if(v.a.empty())return J();
    if(v.a.size()<3)fail("Invalid sparsity");
    auto rows=count(v.a[0].n()),cols=count(v.a[1].n());
    if(v.a.size()<size_t(3+cols))fail("Invalid sparsity");
    J s=J::object(),shape=J::array(),col=J::array(),row=J::array();shape.a={J(rows),J(cols)};
    col.a.assign(v.a.begin()+2,v.a.begin()+3+cols);row.a.assign(v.a.begin()+3+cols,v.a.end());
    if(col.a.front().n()!=0||col.a.back().n()!=int64_t(row.a.size()))fail("Invalid sparsity");
    int64_t prev=0;for(auto x:col.a){auto n=x.n();if(n<prev||n>int64_t(row.a.size()))fail("Invalid sparsity");prev=n;}
    for(auto x:row.a)if(x.n()<0||x.n()>=rows)fail("Invalid sparsity");
    s["kind"]="sparsity";s["shape"]=shape;s["colind"]=col;s["row"]=row;return s;
  });}
  J slice() {J s=J::object();s["start"]=J(lng());s["stop"]=J(lng());s["step"]=J(lng());return s;}
  J expand(const J& s) {
    auto start=s.at("start").n(),stop=s.at("stop").n(),step=s.at("step").n();
    if(!step)fail("Zero slice step");J a=J::array();
    for(auto i=start;step>0?i<stop:i>stop;) {
      count(int64_t(a.a.size())+1);a.a.push_back(J(i));
      if((step>0&&i>INT64_MAX-step)||(step<0&&i<INT64_MIN-step))break;
      i+=step;
    }
    return a;
  }
  std::string number(double v) {
    if(std::isnan(v))return "NaN";if(std::isinf(v))return v>0?"Infinity":"-Infinity";
    if(v==0)return "0";std::ostringstream s;s<<std::setprecision(17)<<v;return s.str();
  }
  J mx() {return object('X',[&]{
    int op=integer(),sub=0;std::string constant;
    auto name=scheme_operation(op);bool unary=is_unary(name),binary=is_binary(name);
    bool mapping=name=="getnonzeros"||name=="setnonzeros"||name=="addnonzeros";
    if(binary)sub=byte();
    else if(name=="const") {
      sub=byte();if(sub=='D')constant=number(real());else if(sub=='I')constant=std::to_string(lng());
      else if(sub=='0'||sub=='1')constant=std::string(1,char(sub));else if(sub=='-')constant="-1";
      else if(sub!='a')fail("Unsupported constant subtype");
    }else if(mapping)sub=byte();
    else if(!unary&&name!="parameter"&&name!="input"&&name!="output"&&name!="reshape"&&name!="transpose")fail("Unsupported MX operation "+name);
    J deps=vector([&]{return mx();}),sp=sparsity(),info=J::object(),node=J::object();
    if(sp.kind==J::Null&&name!="output")fail("Null node sparsity");
    node["kind"]="mx";node["op"]=J(op);node["operation"]=name;node["deps"]=deps;node["sp"]=sp;
    if(unary||binary){if(integer()!=op)fail("Inconsistent operation ID");}
    else if(name=="parameter")node["symbol"]=string();
    else if(name=="input"||name=="output"){info["ind"]=J(lng());info["segment"]=J(lng());info["offset"]=J(lng());}
    else if(name=="const") {
      J values=J::array();if(sub=='a')values=vector([&]{return J(number(real()));});
      else values.a.assign(objects.a.at(size_t(sp.n())).at("row").a.size(),J(constant));
      node["constants"]=values;
    }else if(mapping) {
      if(sub=='a'){auto nz=longs();info["nz"]=nz;node["mapping"]=nz;}
      else if(sub=='b'){auto s=slice();info["slice"]=s;node["mapping"]=expand(s);}
      else if(sub=='c') {
        auto inner=slice(),outer=slice();info["inner"]=inner;info["outer"]=outer;
        auto ins=expand(inner),outs=expand(outer);count(int64_t(ins.a.size())*int64_t(outs.a.size()));J map=J::array();
        for(auto o:outs.a)for(auto i:ins.a){auto a=o.n(),b=i.n();if((b>0&&a>INT64_MAX-b)||(b<0&&a<INT64_MIN-b))fail("Mapping overflow");map.a.push_back(J(a+b));}
        node["mapping"]=map;
      }else fail("Unsupported mapping subtype");
      if(name!="getnonzeros")info["add"]=J::boolean(name=="addnonzeros");
    }
    node["info"]=info;return node;
  });}
  J function() {return object('F',[&]{
    if(boolean())return J();auto type=string();if(type!="MXFunction")fail("Unsupported function type "+type);
    version("ProtoFunction",2);auto name=string();for(int i=0;i<5;++i)boolean();version("FunctionInternal",8);
    vector([&]{return J::boolean(boolean());});vector([&]{return J::boolean(boolean());});
    auto ins=vector([&]{return sparsity();}),outs=vector([&]{return sparsity();});
    auto input_names=vector([&]{return J(string());}),output_names=vector([&]{return J(string());});
    if(boolean())fail("JIT functions unsupported");boolean();if(string()!="source")fail("Embedded JIT unsupported");
    boolean();string();empty_map();string();boolean();empty_map();function();real();
    for(int i=0;i<8;++i)boolean();real();real();boolean();boolean();lng();boolean();real();string();
    boolean();boolean();boolean();lng();boolean();boolean();string();string();
    for(int i=0;i<4;++i)empty_map();function();vector([&]{return function();});for(int i=0;i<8;++i)lng();
    version("XFunction",1);auto input_nodes=vector([&]{return mx();});version("MXFunction",3);
    auto instructions=vector([&]{J i=J::object();i["node"]=mx();i["arg"]=longs();i["res"]=longs();return i;});
    longs();vector([&]{return mx();});vector([&]{real();return J();});boolean();boolean();boolean();vector([&]{return mx();});
    if(ins.a.size()!=input_names.a.size()||outs.a.size()!=output_names.a.size())fail("Invalid function ports");
    J f=J::object();f["kind"]="function";f["name"]=name;f["type"]=type;f["ins"]=ins;f["outs"]=outs;
    f["inputNames"]=input_names;f["outputNames"]=output_names;f["inputNodes"]=input_nodes;f["instructions"]=instructions;return f;
  });}
  J document(bool resource) {
    if(lng()!=scheme_magic||lng()!=scheme_protocol)fail("Unsupported serialization header");
    if(boolean())fail("Debug serialization unsupported");J doc=J::object();doc["version"]=J(1);
    if(resource) {
      auto value=object('R',[&]{
        version("ResourceInternal",1);auto type=string(),mode=string();version(type,1);
        J r=J::object();r["type"]=type;r["serializeMode"]=mode;
        if(type=="ZipMemResource") {
          auto size=lng();if(size<0)fail("Negative blob size");auto offset=take(uint64_t(size));
          blobs.push_back({offset,uint64_t(size)});
          if(lazy) {
            J b=J::object();b["kind"]="deferred_bytes";b["offset"]=J(int64_t(offset));b["byteLength"]=J(size);b["encoding"]="casadi-nibbles";r["blob"]=b;
          }else {
            // Bound eager JSON expansion; lazy mode supports the full source limit.
            count(size);std::vector<unsigned char> bytes(size_t(size),0);source->read(offset,bytes.data(),bytes.size());
            J b=J::array();for(auto c:bytes)b.a.push_back(J(int(c)));r["blob"]=b;
          }
        }else if(type=="ZipResource"||type=="DirResource")r["path"]=string();else fail("Unsupported Resource "+type);
        return r;
      });doc["format"]="casadi_resource";doc["resource"]=value;
    }else {
      if(byte()!=5)fail("Expected serialized Function");auto root=function();if(root.kind==J::Null)fail("Null Function");
      doc["format"]="casadi_json";doc["serializationProtocol"]=J(int64_t(scheme_protocol));doc["root"]=root;doc["objects"]=objects;
    }
    if(pos!=source->size)fail("Trailing data or unsupported layout");return doc;
  }
};
void error_text(char* buffer,size_t capacity,const char* message) noexcept {
  if(buffer&&capacity){std::strncpy(buffer,message,capacity-1);buffer[capacity-1]=0;}
}
}
struct cr_document {std::shared_ptr<Source> source;std::vector<Blob> blobs;std::string json;};
extern "C" {
cr_document* cr_open(const char* path,int resource,int lazy,char* error,size_t cap) {
  try {
    if(!path)throw std::invalid_argument("Null path");
    auto d=std::unique_ptr<cr_document>(new cr_document);d->source=std::make_shared<Source>(path);
    Reader r(d->source,lazy!=0);d->json=r.document(resource!=0).dump();d->blobs=std::move(r.blobs);
    error_text(error,cap,"");return d.release();
  }catch(const std::exception& e){error_text(error,cap,e.what());}catch(...){error_text(error,cap,"Unknown reader error");}return nullptr;
}
const char* cr_json(const cr_document* d){return d?d->json.c_str():nullptr;}
size_t cr_blob_count(const cr_document* d){return d?d->blobs.size():0;}
uint64_t cr_blob_size(const cr_document* d,size_t i){return d&&i<d->blobs.size()?d->blobs[i].size:0;}
int cr_blob_read(cr_document* d,size_t i,uint64_t offset,void* buffer,size_t length,char* error,size_t cap) {
  try {
    if(!d||i>=d->blobs.size()||(!buffer&&length))throw std::invalid_argument("Invalid document, blob or buffer");
    auto b=d->blobs[i];if(offset>b.size||length>b.size-offset)throw std::out_of_range("Blob range out of bounds");
    d->source->read(b.offset+offset,static_cast<unsigned char*>(buffer),length);error_text(error,cap,"");return 0;
  }catch(const std::exception& e){error_text(error,cap,e.what());}catch(...){error_text(error,cap,"Unknown reader error");}return -1;
}
void cr_close(cr_document* d){delete d;}
}
