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
    int data[maxsize];  //���ݴ洢
    int length;         //Ŀǰ���Ա�ĳ���
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
    int tempdata;  //��ʱ���ݣ��������������ֵ
    l->length=0;  //��ʼ����Ϊ0
    for(int i=0;i<=maxsize;i++){
        printf("�������%d��Ԫ�ص�ֵ��-1����\n", i+1);
        scanf("%d", &tempdata);   //���ܿ���̨�����룬����������ʱ������
        if(tempdata==-1){   //�ж��Ƿ�Ϊ����������
            return OK;   //��Ϊ���������䣬��ֱ�ӽ�������
        }
        l->data[i] = tempdata;   //�����ǽ����������ʱ���ݴ���ڶ�Ӧλ����
        l->length++;   //ÿ����һ�����ݣ��򳤶�length+1
    }
    return OK;
}
  Status printList(SqList *l){
    for(int i=0;i<l->length;i++){   //forѭ�������ķ�ʽ�������Ա��Ԫ�ز����д�ӡ
        printf("\n��%d��Ԫ��Ϊ%d", i+1, l->data[i]);
    }
    return OK;
}
int main(int argc, const char * argv[])
{
  SqList sqlistA;
  printf("���������Ա�A�����ݣ�\n");
  CreatList(&sqlistA);
    printList(&sqlistA);  
}

