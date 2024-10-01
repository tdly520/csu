#include<stdio.h>
#include<string.h>
#include<math.h>

#include<string.h>
#include<stdio.h>
#define LIST_INIT_SIZE 100
#define LISTINCREMENT 10
#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0
#define maxsize 100
typedef int Status;
typedef int ElemType;


typedef struct{
     ElemType * elem;
     int length;
     int listsize;        
}SqList;
  void InistSqList(SqList &l)
  {
     l.elem=(ElemType *)malloc(LIST_INIT_SIZE*sizeof(ElemType));
  if(!l.elem) exit(OVERFLOW);
  l.length=0;
  l.listsize=LIST_INIT_SIZE;
  //return OK;

  }

void PrintSqList(SqList &l)    
{
	int i;
	for(i=0;i<l.length;i++){
		printf("%d ",l.elem[i]);
	}
}
void CreateSqList(SqList &l)    
{
	int i=0;
  printf("输入元素直到为-1截至\n");
  scanf("%d",&l.elem[i]);
	
	while(l.elem[i]!=-1 && i<19)    
    {
		l.length ++;
		i++;
    scanf("%d",&l.elem[i]);
		
	}
}
Status Insertlist(SqList &l,int i,ElemType e)
{ ElemType *q,*newbase,*p;
  if(i<1 || i>l.length+1) return ERROR;
  if(l.length>=l.listsize) 
  {
    newbase=(ElemType *)malloc((l.listsize+LIST_INIT_SIZE)*sizeof(ElemType));
     if(!newbase) exit(OVERFLOW);
     l.elem=newbase;
     l.listsize+=LISTINCREMENT;

  } 
 
  q=&(l.elem[i-1]);
  for(p=&(l.elem[l.length-1]);p>=q;--p)*(p+1)=*p;
  *q=e;
  ++l.length;
  return OK;

}
Status deleteList(SqList &l, int i, ElemType e){
    if(l.length==0){   
        printf("删除失败");
        return ERROR;
    }
    if(i==0||i>l.length){
        printf("位置错误");
        return ERROR;
    }
    e = l.elem[i-1];  
    if(i!=l.length){  
        for(int n=i;n<l.length;n++){
            l.elem[n-1] = l.elem[n];
        }
        l.length--;
        return e;
    }
    l.elem[i-1] = 0; 
    return e;
}

int main(){
	SqList q;
	InistSqList(q);
	CreateSqList(q);
	PrintSqList(q);
  printf("\n");
  int m,n;
  printf("插入元素的位子:\n");
  scanf("%d",&m);
   printf("插入元素的值:\n");
   scanf("%d",&n);
  Insertlist(q,m,n);

  PrintSqList(q);
  printf("删除元素的位置:\n");
scanf("%d",&m);
deleteList(q,m,n);
PrintSqList(q);
  system("pause");
	return 0;
}