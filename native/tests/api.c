#include <casadi_reader/reader.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define CHECK(x) do {if(!(x)){fprintf(stderr,"Failed line %d: %s (%s)\n",__LINE__,#x,error);return 1;}}while(0)
int main(int argc,char** argv) {
  char path[4096],error[256];unsigned char data[4];cr_document* d;
  CHECK(argc==2);
  snprintf(path,sizeof(path),"%s/arithmetic.casadi",argv[1]);
  d=cr_open(path,0,0,error,sizeof(error));CHECK(d);CHECK(strstr(cr_json(d),"casadi_serialization"));CHECK(cr_blob_count(d)==0);cr_close(d);
  snprintf(path,sizeof(path),"%s/resource.casadi",argv[1]);
  d=cr_open(path,1,1,error,sizeof(error));CHECK(d);CHECK(cr_blob_count(d)==1);CHECK(cr_blob_size(d,0)==1144);
  CHECK(cr_blob_read(d,0,0,data,4,error,sizeof(error))==0);CHECK(memcmp(data,"PK\003\004",4)==0);
  CHECK(cr_blob_read(d,0,1143,data,4,error,sizeof(error))==-1);
  CHECK(cr_blob_read(d,1,0,data,1,error,sizeof(error))==-1);cr_close(d);
  snprintf(path,sizeof(path),"%s/sx.debug.casadi",argv[1]);
  d=cr_open(path,0,0,error,sizeof(error));CHECK(d);CHECK(strstr(cr_json(d),"SXFunction::serialize_body"));cr_close(d);
  {
    FILE* f=fopen(path,"rb");long length;char* text;
    CHECK(f);fseek(f,0,SEEK_END);length=ftell(f);rewind(f);
    text=(char*)malloc((size_t)length);CHECK(text);
    CHECK(fread(text,1,(size_t)length,f)==(size_t)length);fclose(f);
    d=cr_decode(text,(size_t)length,NULL,0,error,sizeof(error));free(text);
    CHECK(d);CHECK(strstr(cr_json(d),"casadi_serialization"));cr_close(d);
  }
  CHECK(!cr_open(NULL,0,0,error,sizeof(error)));CHECK(error[0]);cr_close(NULL);
  return 0;
}
