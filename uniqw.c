#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFMAX 1024
#define ARGV1 argv[1]
#define ARGV2 argv[2]

int open(char *fn);

FILE *fp;

int main(int argc,char *argv[])
{
  char bufn[BUFMAX],bufo[BUFMAX];
  char *buf_n,*buf_o;

  char *buf_cn,*buf_co;
  
  int er  = 0;
  int num = 0;
  
  if( argc != 3 ){
    printf("正しく引数が入力されていません.\n");
    printf("uniqw file numの指定が必要.\n");
    exit(1);
  }
  er=open(argv[1]);
  num=atoi(argv[2]);
  if( num > BUFMAX ){printf("BUFMAX outrange\n"); exit(1);}
  if(er==1)exit(1);
  buf_n=bufn; buf_o=bufo;
  *buf_n='\0'; *buf_o='\0';
  buf_cn=(char *)malloc(sizeof(char)*num);
  buf_co=(char *)malloc(sizeof(char)*num);

  fscanf(fp,"%s\n",buf_o);
  printf("%s\n",buf_o);
  while( fscanf(fp,"%s\n",buf_n) != -1 ){
    strncpy(buf_co,buf_o,num);
    strncpy(buf_cn,buf_n,num);
    if(strcmp(buf_cn,buf_co)!=0)printf("%s\n",buf_n);
    strncpy(buf_o,buf_n,strlen(buf_n));
  }


  fclose(fp);
  return 0;
}

int open(char *fn){
  fp = fopen(fn,"r");
  if( fp == NULL )return 1;
  return 0;
}
