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
    int data[maxsize];  //数据存储
    int length;         //目前线性表的长度
}SqList;
  /*
  Status initlist_sq(sqlist &l)
  {
     l.elem=(elemytpe *)malloc(LIST_INIT_SIZE*sizeof(elemtype));
  if(!i.elem) exit(overflow);
  l.length=0;
  l.listsize=LIST_INIT_SIZE;
  return ok;

  }*/
  Status CreatList(SqList *l){
    int tempdata;  //临时数据，用来保存输入的值
    l->length=0;  //初始长度为0
    for(int i=0;i<=maxsize;i++){
        printf("请输入第%d个元素的值，-1结束\n", i+1);
        scanf("%d", &tempdata);   //接受控制台的输入，并保存在临时数据中
        if(tempdata==-1){   //判断是否为输入结束语句
            return OK;   //若为输入结束语句，则直接结束方法
        }
        l->data[i] = tempdata;   //若不是结束语句则将临时数据存放在对应位置中
        l->length++;   //每放入一个数据，则长度length+1
    }
    return OK;
}
  Status printList(SqList *l){
    for(int i=0;i<l->length;i++){   //for循环遍历的方式访问线性表的元素并进行打印
        printf("\n第%d个元素为%d", i+1, l->data[i]);
    }
    return OK;
}
int main(int argc, const char * argv[])
{
  SqList sqlistA;
  printf("请输入线性表A的内容：\n");
  CreatList(&sqlistA);
    printList(&sqlistA);  
}

