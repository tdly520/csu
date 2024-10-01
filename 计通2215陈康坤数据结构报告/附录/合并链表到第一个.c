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
     printf("请输入想要的链表长度\n");
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
Status Getelem(linklist l,int i,ElemType &e)
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

Status listlength(linklist l)
{
  lnode *p;
  p=l;
  int j=0;
  while(p!=NULL)
  {
    j++;
    p=p->next;
  }
  
  return j-1;
}
void mergelist (linklist l1,linklist l2)
{
  lnode *m,*n;
  m=l1,n=l2;
  int len1,len2;
  int e1,e2,e;
  len1=listlength(l1);
  len2=listlength(l2);
//printf("%d %d\n",len1,len2);
  for(int i=1;i<=len2;i++)
  {
    Getelem(l2,i,e2);
    bool q=1;
    for(int j=1;j<=len1;j++)
    {
      Getelem(l1,j,e1);
      //printf("%d %d\n",e1,e2);
      if(e1==e2) {q=0;
      break;
      }
      
    }
if(q){
  listinsert(l1,++len1,(int)e2);
}
    


  }
  

}
int main()
{
  linklist l1,l2;
  
  InitList(l1);
  inita(l1);
printlist(l1);
InitList(l2);
  inita(l2);
printlist(l2);


printf("合并两个链表到第一个的链表\n");
mergelist(l1,l2);
printlist(l1);
 system("pause");
	return 0;
}
