#include<stdio.h>
#include<string.h>
#include<math.h>

#include<string.h>
#include<stdio.h>

typedef int Status;

#define LIST_INIT_SIZE 100
#define LISTINCREMENT 10
//#define OK 1
//#define ERROR 0
#define TRUE 1
#define FALSE 0
#define maxsize 100

typedef int  ElemType;
typedef struct DulNode{
    ElemType data;
    struct DulNode *prior;
    struct DulNode *next; 
}DulNode,*DuLinkList;
 
 Status Initlink(DuLinkList &l)
 {
   l = (DulNode*)malloc(sizeof(DulNode));
    if(!l)
        return 0;
    l->prior = NULL;
    l->next = NULL;

 }
 void inita(DuLinkList &l)
 {
    int len;
    printf("想要的长度");
    scanf("%d",&len);
    DulNode *p=l;
    for(int i=1;i<=len;i++)
    {
      DulNode *s=(DulNode*)malloc(sizeof(DulNode));
     p->next=s;
     scanf("%d",&s->data);
     s->prior=p;
     s->next=NULL;
     p=s;
    }
 }
 void printlist(DuLinkList l)
{
  DulNode *p=l;
  while(p->next!=NULL)
  {
    
    p=p->next;printf("%d ",p->data);
  }
  printf("\n");

}

Status listinsert(DuLinkList l,int i,ElemType e)
{
   DulNode *p;
   p=l;
   int j=0;
   while(p&&j<i-1)
   {
    p=p->next;
    j++;
   }
   if(!p||j>i)  return false;
   DulNode *s=(DulNode*)malloc(sizeof(DulNode));
   s->data=e;
    s->next=p->next;
   p->next=s;
   s->prior=p;
   s->next->prior=s;
  return true;

}

Status deleteList(DuLinkList l,int i)
{
  DulNode *p,*s;
  p=l;
  int j=0;
   while(p&&j<i-1)
   {
    p=p->next;
    j++;
   }
  s=p->next;
s->next->prior=p;
   p->next=s->next;
   
   free(s);
return true;
}



 int main()
 {
  DuLinkList l;
  Initlink(l);
inita(l);
printlist(l);
int m,n;
printf("想要在第几个位子插入什么\n");
scanf("%d %d",&m,&n);

listinsert(l,m,n);
printlist(l);
printf("删除第几个位子\n");
scanf("%d",&m);
deleteList(l,m);
printlist(l);
  system("pause");
	return 0;
 }