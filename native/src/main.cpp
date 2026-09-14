#include <casadi_reader/reader.hpp>
#include <iostream>
int main(int argc,char** argv) {
  try {
    bool resource=false,lazy=false;std::string path;
    for(int i=1;i<argc;++i){std::string a=argv[i];if(a=="--resource")resource=true;else if(a=="--lazy")lazy=true;else if(path.empty())path=a;else throw std::runtime_error("Unexpected argument");}
    if(path.empty())throw std::runtime_error("Usage: casadi-reader-native [--resource] [--lazy] FILE");
    casadi_reader::Document d(path,resource,lazy);std::cout<<d.json()<<'\n';
  }catch(const std::exception& e){std::cerr<<e.what()<<'\n';return 1;}
}
