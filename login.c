#include<stdio.h>
#include<string.h>
#include<stdlib.h>
//append name
void append(char name[]){
FILE *li;
li=fopen("LoggedIn.csv","at");
if(li==NULL){
return;
}
fprintf(li,"%s\n",name);
fclose(li);
}
//main
void main(){
char data[100];
char usn[100];
char psw[100];
char pair[100];
int nm=atoi(getenv("CONTENT_LENGTH"))+1;
fgets(data,nm,stdin);
int i=0;
int j=0;
i+=9;
//get variable and put psw and usn together
while(data[i]!='&'&&data[i+1]!='p'){
usn[j]=data[i];
pair[j]=data[i];
i++;
j++;
}
usn[j]='\0';
pair[j]=',';
int k=j+1;
j=0;
i+=10;
while(i<nm){
pair[k]=data[i];
k++;
i++;
}
pair[k]='\0';

//read file
FILE *mb=fopen("./Members.csv","rt");
if(mb==NULL){
return;
}
int isvalid=0;
char ch;
char name[100];
//find "," in each line
while(!feof(mb)){
 ch=fgetc(mb);
 if(ch==','){
  fgets(name,100,mb);
  int cmp=1;
  i=0;
  //string compare one char by one char 
  while(name[i]!='\n'){
   if(name[i]!=pair[i]){
    cmp=0;
    break;
   }
   i++;
  }
  if(pair[i]!='\0'){
   cmp=0;
  }
  if(cmp==1){
   isvalid=1;
   break;
   }
 }
}
fclose(mb);


//print page
printf("Content-Type:text/html\n\n");
if(isvalid==0){
 printf("<html><head><title>program</title></head><body><h1>password not valid</h1>");
 printf("<br><a href=\"http://www.cs.mcgill.ca/~yxia18/store/home.html\">home</a>");
 printf("<br><a href=\"http://www.cs.mcgill.ca/~yxia18/store/login.html\">login</a>");
 printf("</body></html>");
}
else{
 append(usn);
 FILE *ct=fopen("./catalogue.html","rt");
 if(ct==NULL){
 return;
 }
 //find mark
 while(!feof(ct)){
  ch=fgetc(ct);
  if(feof(ct)){break;}
  putchar(ch);
  //insert usn
  if(ch=='@'){
    printf(" value=%s",usn);
   }
 }
fclose(ct);
}
}
