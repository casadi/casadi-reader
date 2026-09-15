// Generated; edit scripts/templates/native/reader.cpp.in.
#include <casadi_reader/reader.h>
#include "scheme.hpp"
#include <regex>
#include <locale>
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
  std::string text;
  bool memory=false;
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
  Source(const char* data,size_t length):text(data,length),memory(true) {
    uint64_t end=length;
    while(start<end&&std::isspace(static_cast<unsigned char>(text[start])))++start;
    while(end>start&&std::isspace(static_cast<unsigned char>(text[end-1])))--end;
    if((end-start)%2||(end-start)/2>(uint64_t(1)<<30))throw std::runtime_error("Invalid encoded file size");
    size=(end-start)/2;
  }
  void read(uint64_t offset, unsigned char* output, size_t n) {
    if(offset>size||n>size-offset) throw std::runtime_error("Source range out of bounds");
    if(!memory){file.clear(); file.seekg(start+2*offset);}
    for(size_t i=0;i<n;++i) {
      char a,b;
      if(memory){a=text[start+2*(offset+i)];b=text[start+2*(offset+i)+1];}
      else if(!file.get(a)||!file.get(b)) throw std::runtime_error("Truncated file");
      if(a<'a'||a>'p'||b<'a'||b>'p') throw std::runtime_error("Invalid nibble encoding");
      output[i]=(a-'a')|((b-'a')<<4);
    }
  }
};
struct Blob {uint64_t offset,size;};
// Parser for the generator's embedded JSON data, never for the serialized input.
struct SchemeParser {
  const std::string text; size_t p=0;
  explicit SchemeParser(const char* s):text(s) {}
  void space(){while(p<text.size()&&std::isspace(static_cast<unsigned char>(text[p])))++p;}
  char get(){if(p==text.size())throw std::runtime_error("Truncated generated scheme");return text[p++];}
  void expect(char c){space();if(get()!=c)throw std::runtime_error("Invalid generated scheme");}
  J value(){
    space();char c=get();
    if(c=='"'){
      std::string s;
      while((c=get())!='"'){
        if(c=='\\'){
          c=get();
          if(c=='n')c='\n';else if(c=='r')c='\r';else if(c=='t')c='\t';
          else if(c=='b')c='\b';else if(c=='f')c='\f';
          else if(c=='u'){
            unsigned v=0;for(int i=0;i<4;++i){char h=get();v=v*16+(h<='9'?h-'0':h-'a'+10);}
            if(v<128)s+=char(v);else if(v<2048){s+=char(192|(v>>6));s+=char(128|(v&63));}
            else{s+=char(224|(v>>12));s+=char(128|((v>>6)&63));s+=char(128|(v&63));}continue;
          }
        }s+=c;
      }return J(s);
    }
    if(c=='['||c=='{'){
      J j=c=='['?J::array():J::object();char close=c=='['?']':'}';space();
      if(p<text.size()&&text[p]==close){++p;return j;}
      for(;;){if(c=='[')j.a.push_back(value());else{J key=value();expect(':');j[key.scalar]=value();}
        space();char sep=get();if(sep==close)return j;if(sep!=',')throw std::runtime_error("Invalid scheme separator");}
    }
    size_t start=p-1;while(p<text.size()&&text[p]!=','&&text[p]!=']'&&text[p]!='}'&&!std::isspace(static_cast<unsigned char>(text[p])))++p;
    std::string token=text.substr(start,p-start);
    if(token=="null")return J();if(token=="true"||token=="false")return J::boolean(token=="true");
    J j;j.kind=J::Number;j.scalar=token;return j;
  }
};
const J& scheme(){static const J s=SchemeParser(scheme_json).value();return s;}
const J& optional(const J& j,const std::string& key){auto it=j.o.find(key);static const J nil;return it==j.o.end()?nil:it->second;}
bool truth(const J& j){return j.kind==J::Bool?j.scalar=="true":j.kind==J::Number?j.scalar!="0":j.kind==J::String?!j.scalar.empty():j.kind!=J::Null;}
std::string trim(std::string s){auto a=s.find_first_not_of(" \t\n\r");return a==std::string::npos?"":s.substr(a,s.find_last_not_of(" \t\n\r")-a+1);}
std::vector<std::string> arguments_of(const std::string& s){
  std::vector<std::string> v;size_t start=0;int depth=0;
  for(size_t i=0;i<s.size();++i){if(s[i]=='<')++depth;if(s[i]=='>')--depth;if(s[i]==','&&!depth){v.push_back(s.substr(start,i-start));start=i+1;}}
  v.push_back(s.substr(start));return v;
}
struct Reader {
  std::shared_ptr<Source> source;
  uint64_t pos=0;int depth=0;bool lazy,debug=false;
  std::vector<int64_t> shared;
  J objects=J::array();std::vector<Blob> blobs;
  Reader(std::shared_ptr<Source> s,bool l):source(std::move(s)),lazy(l) {}
  [[noreturn]] void fail(const std::string& s){throw std::runtime_error(".casadi byte "+std::to_string(pos)+": "+s);}
  uint64_t take(uint64_t n){if(n>source->size-pos)fail("Truncated or excessive payload");auto p=pos;pos+=n;return p;}
  uint64_t count(const J& j){if(j.kind!=J::Number)fail("Invalid collection size");auto n=j.n();if(n<0||n>1000000)fail("Invalid or excessive collection size");return uint64_t(n);}
  uint64_t size(const J& j){if(j.kind!=J::Number)fail("Excessive payload size");auto n=j.n();if(n<0)fail("Negative payload size");return uint64_t(n);}
  uint64_t bits(int n){unsigned char bytes[8];source->read(take(n),bytes,n);uint64_t v=0;for(int i=0;i<n;++i)v|=uint64_t(bytes[i])<<(8*i);return v;}
  int byte(){return int(bits(1));}
  void decoration(char tag){if(debug&&byte()!=tag)fail(std::string("Expected wire decoration ")+tag);}
  J number(const std::string& type){
    decoration(type=="int"?'i':type=="unsignedint"?'u':type=="casadi_int"?'J':type=="size_t"?'K':'d');
    const auto b=bits(type=="int"||type=="unsignedint"?4:8);
    if(type=="double"){
      double d;std::memcpy(&d,&b,8);
      if(!std::isfinite(d)){J j=J::object();j["$float"]=std::isnan(d)?"NaN":d>0?"Infinity":"-Infinity";return j;}
      std::ostringstream s;s.imbue(std::locale::classic());s<<std::setprecision(17)<<d;J j;j.kind=J::Number;j.scalar=s.str();return j;
    }
    if(type=="unsignedint")return J(int64_t(b));
    if(type=="size_t"&&b>9007199254740991ULL){J j=J::object();j["$integer"]=std::to_string(b);return j;}
    int64_t value;
    if(type=="int"){uint32_t u=uint32_t(b);int32_t i;std::memcpy(&i,&u,4);value=i;}else std::memcpy(&value,&b,8);
    if(value>9007199254740991LL||value< -9007199254740991LL){J j=J::object();j["$integer"]=std::to_string(value);return j;}
    return J(value);
  }
  bool utf8(const std::string& s){
    for(size_t i=0;i<s.size();){unsigned c=static_cast<unsigned char>(s[i++]);if(c<128)continue;
      int n;unsigned min;
      if(c>=194&&c<=223){n=1;min=128;c&=31;}else if(c>=224&&c<=239){n=2;min=2048;c&=15;}else if(c>=240&&c<=244){n=3;min=65536;c&=7;}else return false;
      while(n--){if(i==s.size())return false;unsigned b=static_cast<unsigned char>(s[i++]);if((b&192)!=128)return false;c=(c<<6)|(b&63);}
      if(c<min||c>0x10ffff||(c>=0xd800&&c<=0xdfff))return false;
    }return true;
  }
  J payload(uint64_t offset,uint64_t n,bool defer){
    if(defer){blobs.push_back({offset,n});J j=J::object();j["kind"]="deferred_bytes";j["offset"]=J(int64_t(offset));j["byteLength"]=J(int64_t(n));j["encoding"]="casadi-nibbles";return j;}
    if(n>1000000)fail("Excessive eager byte payload; use lazy mode");
    std::vector<unsigned char> bytes(size_t(n),0);source->read(offset,bytes.data(),bytes.size());J v=J::array();for(auto b:bytes)v.a.push_back(J(int(b)));J j=J::object();j["$bytes"]=v;return j;
  }
  J string(){
    decoration('s');auto n=size(number("int")),offset=take(n);
    if(lazy&&n>=65536)return payload(offset,n,true);
    std::string text(size_t(n),'\0');if(n)source->read(offset,reinterpret_cast<unsigned char*>(&text[0]),size_t(n));
    if(utf8(text))return J(text);return payload(offset,n,lazy);
  }
  void name(const std::string& n){if(debug){J j=string();if(j.kind!=J::String||j.scalar!=n)fail("Expected serialized field "+n);}}
  J expression(const std::string& raw,const std::map<std::string,J>& scope){
    auto e=trim(raw);auto found=scope.find(e);if(found!=scope.end())return found->second;
    if(e=="true"||e=="false")return J::boolean(e=="true");
    if(!e.empty()&&e[0]=='"')return SchemeParser(e.c_str()).value();
    if(std::regex_match(e,std::regex("-?[0-9]+")))return J(int64_t(std::stoll(e)));
    for(const auto& op:{"||","&&","==","!="}){auto p=e.find(op);if(p!=std::string::npos){auto a=expression(e.substr(0,p),scope),b=expression(e.substr(p+2),scope);
      return J::boolean(std::string(op)=="||"?truth(a)||truth(b):std::string(op)=="&&"?truth(a)&&truth(b):std::string(op)=="=="?a.dump()==b.dump():a.dump()!=b.dump());}}
    if(!e.empty()&&e[0]=='!')return J::boolean(!truth(expression(e.substr(1),scope)));
    std::smatch m;if(std::regex_match(e,m,std::regex("(\\w+)\\s*\\+\\s*(\".*\")")))return J(expression(m[1],scope).scalar+SchemeParser(m[2].str().c_str()).value().scalar);
    fail("Scheme expression is unavailable: "+e);
  }
  const J& layout(const std::string& n){
    const auto& layouts=scheme().at("reader").at("layouts");
    auto it=layouts.o.find(n);if(it!=layouts.o.end())return it->second;
    fail("Serialization layout absent from scheme: "+n);
  }
  std::string specialize(const std::string& type,const std::map<std::string,J>& scope){
    std::regex token("\\b(MatType|Scalar|T)\\b");std::string result;size_t last=0;
    for(auto i=std::sregex_iterator(type.begin(),type.end(),token);i!=std::sregex_iterator();++i){result+=type.substr(last,i->position()-last);auto found=scope.find(i->str());result+=found==scope.end()?i->str():found->second.scalar;last=i->position()+i->length();}return result+type.substr(last);
  }
  void program(const J& steps,J& record,std::map<std::string,J>& scope){
    if(++depth>256)fail("Layout nesting limit exceeded");
    for(const auto& step:steps.a){auto op=step.at("op").scalar;
      if(op=="field"){
        const auto& fixed=optional(step,"name");auto n=fixed.kind==J::String?fixed.scalar:expression(step.at("name_expression").scalar,scope).scalar;
        if(optional(step,"type").kind!=J::String)fail("Unresolved serialization type: "+n);
        auto type=specialize(step.at("type").scalar,scope);name(n);J v=value(type),f=J::object();
        f["name"]=n;f["type"]=type;f["value"]=v;record["fields"].a.push_back(f);count(J(int64_t(record["fields"].a.size())));
        const auto& bind=optional(step,"bind");if(bind.kind==J::String){scope[bind.scalar]=v;if(v.kind==J::Array)scope[bind.scalar+".size()"]=J(int64_t(v.a.size()));}
      }else if(op=="version"){
        auto n=step.at("name").scalar+"::serialization::version";name(n);J v=number("int");if(v.dump()!=step.at("value").dump())fail("Unsupported "+step.at("name").scalar+" version "+v.dump());
        J f=J::object();f["name"]=n;f["type"]="int";f["value"]=v;record["fields"].a.push_back(f);
      }else if(op=="call"){
        auto n=step.at("layout").scalar;record["layouts"].a.push_back(J(n));for(const auto& p:optional(step,"params").o)scope[p.first]=p.second;program(layout(n),record,scope);
      }else if(op=="if"){
        if(truth(expression(step.at("condition").scalar,scope)))program(step.at("body"),record,scope);
      }else if(op=="repeat"){
        auto n=count(expression(step.at("count").scalar,scope));for(uint64_t i=0;i<n;++i)program(step.at("body"),record,scope);
      }else if(op=="select"){
        auto tag=expression(step.at("bind").scalar,scope);const auto& cases=step.at("cases").o;auto it=cases.find(tag.scalar);
        if(it==cases.end())fail("Unknown serialization discriminator "+step.at("bind").scalar+"="+tag.scalar);program(it->second,record,scope);
      }else fail("Unsupported scheme instruction: "+(optional(step,"reason").kind==J::String?step.at("reason").scalar:op));
    }--depth;
  }
  J value(std::string type){
    type.erase(std::remove_if(type.begin(),type.end(),[](char c){return std::isspace(static_cast<unsigned char>(c));}),type.end());
    if(type=="int"||type=="unsignedint"||type=="casadi_int"||type=="size_t"||type=="double")return number(type);
    if(type=="char")return J(byte());
    if(type=="bool"){decoration('b');int b=byte();if(b>1)fail("Invalid boolean");return J::boolean(b!=0);}
    if(type=="std::string")return string();
    if(type=="std::istream"||type=="std::stringstream"){decoration('B');auto n=size(number("size_t")),offset=take(n);return payload(offset,n,lazy);}
    if(type=="Dict")return value("std::map<std::string,GenericType>");
    if(type.find("std::vector<")==0){decoration('V');auto n=count(number("casadi_int"));J a=J::array();for(uint64_t i=0;i<n;++i)a.a.push_back(value(type.substr(12,type.size()-13)));return a;}
    if(type.find("std::map<")==0){decoration('D');auto types=arguments_of(type.substr(9,type.size()-10));auto n=count(number("casadi_int"));J j=J::object(),a=J::array();for(uint64_t i=0;i<n;++i){J pair=J::array();pair.a.push_back(value(types.at(0)));pair.a.push_back(value(types.at(1)));a.a.push_back(pair);}j["$map"]=a;return j;}
    if(type.find("std::pair<")==0){decoration('p');J a=J::array();for(const auto& t:arguments_of(type.substr(10,type.size()-11)))a.a.push_back(value(t));return a;}
    const auto& types=scheme().at("reader").at("types").o;auto found=types.find(type);if(found==types.end())fail("Serialization type absent from scheme: "+type);const auto& def=found->second;
    const auto& tag=optional(def,"decoration");if(tag.kind==J::String)decoration(tag.scalar[0]);
    if(truth(optional(def,"shared"))){name("Shared::flag");int flag=byte();if(flag=='r'){name("Shared::reference");auto id=number("casadi_int");if(id.kind!=J::Number||id.n()<0||uint64_t(id.n())>=shared.size())fail("Invalid shared reference");J r=J::object();r["$ref"]=J(shared[size_t(id.n())]);return r;}if(flag!='d')fail("Invalid shared definition");}
    J record=J::object();record["type"]=type;record["fields"]=J::array();record["layouts"]=J::array();std::map<std::string,J> scope;program(def.at("body"),record,scope);
    if(!truth(optional(def,"shared")))return record;
    count(J(int64_t(objects.a.size()+1)));int64_t id=objects.a.size();objects.a.push_back(std::move(record));shared.push_back(id);J r=J::object();r["$ref"]=J(id);return r;
  }
  J document(const std::string& type){
    if(number("casadi_int").dump()!=scheme().at("wire").at("magic").dump())fail("Invalid serialization magic");
    if(number("casadi_int").dump()!=scheme().at("wire").at("protocol").dump())fail("Unsupported serialization protocol");
    int b=byte();if(b>1)fail("Invalid debug flag");debug=b!=0;J roots=J::array();
    if(!type.empty())roots.a.push_back(value(type));else while(pos<source->size){auto tag=std::to_string(byte());const auto& t=optional(scheme().at("reader").at("file_types"),tag);if(t.kind!=J::String)fail("Unsupported serialized file type "+tag);roots.a.push_back(value(t.scalar));}
    if(pos!=source->size)fail("Trailing serialization data");
    J d=J::object();d["format"]="casadi_serialization";d["version"]=J(1);d["serializationProtocol"]=scheme().at("wire").at("protocol");d["root"]=roots.a.size()==1?optional(roots.a[0],"$ref"):J();d["roots"]=roots;d["objects"]=objects;return d;
  }
};
void error_text(char* buffer,size_t capacity,const char* message) noexcept {
  if(buffer&&capacity){std::strncpy(buffer,message,capacity-1);buffer[capacity-1]=0;}
}
}
struct cr_document {std::shared_ptr<Source> source;std::vector<Blob> blobs;std::string json;};
extern "C" {
cr_document* cr_open_type(const char* path,const char* type,int lazy,char* error,size_t cap) {
  try {
    if(!path)throw std::invalid_argument("Null path");
    auto d=std::unique_ptr<cr_document>(new cr_document);d->source=std::make_shared<Source>(path);
    Reader r(d->source,lazy!=0);d->json=r.document(type?type:"").dump();d->blobs=std::move(r.blobs);
    error_text(error,cap,"");return d.release();
  }catch(const std::exception& e){error_text(error,cap,e.what());}catch(...){error_text(error,cap,"Unknown reader error");}return nullptr;
}
cr_document* cr_open(const char* path,int resource,int lazy,char* error,size_t cap) {
  return cr_open_type(path,resource?"Resource":nullptr,lazy,error,cap);
}
cr_document* cr_decode(const char* text,size_t length,const char* type,int lazy,char* error,size_t cap) {
  try {
    if(!text)throw std::invalid_argument("Null text");
    auto d=std::unique_ptr<cr_document>(new cr_document);d->source=std::make_shared<Source>(text,length);
    Reader r(d->source,lazy!=0);d->json=r.document(type?type:"").dump();d->blobs=std::move(r.blobs);
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
