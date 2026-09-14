#include <casadi_reader/reader.h>
#include <stdio.h>
#include <string.h>
#define CHECK(x) do {if(!(x)){fprintf(stderr,"Failed line %d: %s (%s)\n",__LINE__,#x,error);return 1;}}while(0)
int main(int argc,char** argv) {
  char path[4096],error[256];unsigned char data[4];cr_document* d;
  CHECK(argc==2);
  snprintf(path,sizeof(path),"%s/arithmetic.casadi",argv[1]);
  d=cr_open(path,0,0,error,sizeof(error));CHECK(d);CHECK(strstr(cr_json(d),"casadi_json"));CHECK(cr_blob_count(d)==0);cr_close(d);
  snprintf(path,sizeof(path),"%s/resource.casadi",argv[1]);
  d=cr_open(path,1,1,error,sizeof(error));CHECK(d);CHECK(cr_blob_count(d)==1);CHECK(cr_blob_size(d,0)==1144);
  CHECK(cr_blob_read(d,0,0,data,4,error,sizeof(error))==0);CHECK(memcmp(data,"PK\003\004",4)==0);
  CHECK(cr_blob_read(d,0,1143,data,4,error,sizeof(error))==-1);
  CHECK(cr_blob_read(d,1,0,data,1,error,sizeof(error))==-1);cr_close(d);
  CHECK(!cr_open(NULL,0,0,error,sizeof(error)));CHECK(error[0]);cr_close(NULL);
  return 0;
}
