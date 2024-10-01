#include<stdio.h>
#include<string.h>
#include<math.h>

#include<string.h>
#include<stdio.h>
#define LIST_INIT_SIZE 100
#define LISTINCREMENT 10
//#define OK 1
//#define ERROR 0
#define TRUE 1
#define FALSE 0
#define maxsize 100
typedef int Status;
typedef int ElemType;
typedef struct lnode{
  ElemType data;
  struct lnode *next;
}lnode ,*linklist;

bool InitList(linklist &l)   
{
     l=(lnode*)malloc(sizeof(lnode));  
    if(l==NULL)  {
      return false;
    }
        
    l->next=NULL;  
    return true;
}
Status getelem(linklist l,int i,ElemType &e)
{
  lnode *p;
  int j;
  p=l->next ;j=1;
  while(p&&j<i)
  {
    p=p->next;
    j++;

  }
  if(!p||j>i)  return false;
  e=p->data;
  return true;

}

void inita(linklist &l)  
{    
     int len;
     printf("想要的长度\n");
     scanf("%d",&len);
     lnode *p=l;
     
     for(int i=1;i<=len;i++)
     { 
       lnode *s=(lnode*)malloc(sizeof(lnode));

        scanf("%d",&s->data);
        s->next=NULL;
        p->next=s;
        p=s;
       

     }
     
}
void printlist(linklist &l)
{
  lnode *p=l;
  while(p->next!=NULL)
  {
    
    p=p->next;printf("%d ",p->data);
  }
  printf("\n");

}
Status listinsert(linklist l,int i,ElemType e)
{
   lnode *p;
   p=l;
   int j=0;
   while(p&&j<i-1)
   {
    p=p->next;
    j++;
   }
   if(!p||j>i)  return false;
   lnode *s=(lnode*)malloc(sizeof(lnode));
   s->data=e;
    s->next=p->next;
   p->next=s;
  return true;

}
Status deleteList(linklist l,int i)
{
  lnode *p,*s;
  p=l;
  int j=0;
   while(p&&j<i-1)
   {
    p=p->next;
    j++;
   }
  s=p->next;

   p->next=s->next;
   
   free(s);
return true;
}
int main()
{
  linklist l;
  InitList(l);
  inita(l);
printlist(l);
int i;
printf("获取元素的位置\n");
scanf("%d",&i);
int ans,e;
getelem(l,i,ans);
printf("在%d位置元素是%d\n",i,ans);
printf("请输入想要在第几个位置插入什么\n");
scanf("%d  %d",&i,&e);
listinsert(l,i,e);
printlist(l);
printf("想要删除位子\n");
scanf("%d",&i);
deleteList(l,i);
printlist(l);

   system("pause");
	return 0;
}
