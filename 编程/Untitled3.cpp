//
//  main.c
//  SQList
//
//  Created by Eason on 2020/7/28.
//  Copyright ? 2020 Eason. All rights reserved.
//

#include<stdio.h>
#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0
#define maxsize 100
typedef int Status;
typedef int ElemType;
//���Ա�Ĵ洢�ṹ
typedef struct{
    int data[maxsize];  //���ݴ洢
    int length;         //Ŀǰ���Ա�ĳ���
}SqList;
//�������Ա�
Status CreatList(SqList *L){
    int tempdata;  //��ʱ���ݣ��������������ֵ
    L->length=0;  //��ʼ����Ϊ0
    for(int i=0;i<=maxsize;i++){
        printf("�������%d��Ԫ�ص�ֵ��-1����\n", i+1);
        scanf("%d", &tempdata);   //���ܿ���̨�����룬����������ʱ������
        if(tempdata==-1){   //�ж��Ƿ�Ϊ����������
            return OK;   //��Ϊ���������䣬��ֱ�ӽ�������
        }
        L->data[i] = tempdata;   //�����ǽ����������ʱ���ݴ���ڶ�Ӧλ����
        L->length++;   //ÿ����һ�����ݣ��򳤶�length+1
    }
    return OK;
}
//��ȡ���Ա�ĳ���
Status getLength(SqList *L){
    return L->length;
}
//�������Ա�
Status insertList(SqList *L, int i, ElemType e){
    if(L->length==maxsize){  //�ж����Ա��Ƿ�����
        printf("Ŀǰ���Ա�ĳ��������������ٲ���Ԫ��");
        return ERROR;
    }
    if(i<1||i>L->length+1){   //�жϲ���λ���Ƿ�Ϸ�
        printf("������Ĳ���λ������");
        return ERROR;
    }
    if(i!=L->length+1){   //�ж��Ƿ��ǲ������Ա�����������ǵĻ�Ҫ�������Ա��Ԫ�غ��Ʋ���
        for(int i=i;i<L->length;i++){
            L->data[i]=L->data[i-1];
        }
    }
    L->data[i-1]=e;   //����ǲ������Ա�������ֱ��д��Ϳɡ��������������Ѿ�������ɣ�������Ԫ��д���Ӧλ�ü���
    return OK;
}
//��ӡ���Ա�
Status printList(SqList *L){
    for(int i=0;i<L->length;i++){   //forѭ�������ķ�ʽ�������Ա��Ԫ�ز����д�ӡ
        printf("\n��%d��Ԫ��Ϊ%d", i+1, L->data[i]);
    }
    return OK;
}
//ɾ�����Ա�
Status deleteList(SqList *L, int i, int *e){
    if(L->length==0){   //�ж�Ŀǰ��˳����Ƿ�Ϊ�գ���Ϊ���򲻿ɽ���ɾ������
        printf("���Ա�ĳ���Ϊ0�����ɽ���ɾ������");
        return ERROR;
    }
    if(i==0||i>L->length){
        printf("�������ɾ��λ�����󣬲��ɽ���ɾ������");
        return ERROR;
    }
    e = L->data[i-1];  //��Ҫɾ��λ�õ�Ԫ�ش洢����
    if(i!=L->length){  //���Ҫɾ����λ�ò��������ôҪ����˳����ǰ�Ʋ���
        for(int n=i;n<L->length;n++){
            L->data[n-1] = L->data[n];
        }
        L->length--;
        return e;
    }
    L->data[i-1] = 0;  //���Ҫɾ����λ���������ôֱ�ӽ����һ��Ԫ����0
    return e;
}
//�ϲ����Ա������ಢ��
Status Union(SqList *LA, SqList *LB){
    int lengtha = LA->length;
    int lengthb = LB->length;
    int isEqual = 0;   //�ж��Ƿ������ͬԪ�صı�־
    for(int i=0;i<lengthb;i++){
        if(searchList(LA, LB->data[i])){   //�ж�LA���Ƿ������ƶ�Ԫ����ȵ�Ԫ��
            isEqual = 1;   //�����У����ж���1��TRUE��
        }
        if(!isEqual){    //���ж�Ϊ��1��0��������ȵ�ʱ��ִ�в������������LA�ĳ���+1
            insertList(LA, ++lengtha, LB->data[i]);
            LA->length++;
        }
        isEqual = 0;   //�ж���һ�����ٴ�ѭ���ж���һ������Ӧ���жϱ�־��ʼ��Ϊ0
    }
    return OK;
}
//���Ա����Ԫ��
Status searchList(SqList *LA, int e){
    int lengtha = LA->length;  //���Ա�ĳ���
    for(int i=0;i<lengtha;i++){   //�������Ա�
        if(LA->data[i]==e){   //�Ƚϵ�ǰ���Ա�Ԫ���Ƿ����
            return TRUE;
        }
    }
    return FALSE;
}
//ɾ�����Ա���ָ����Ԫ��
Status deleteValue(SqList *L, int e){
    int i=0;  //ѭ�������ļ���λ
    while(L->data[i]!=e&&i<L->length){  //ѭ��Ҫô�ҵ���ͬԪ��Ҫôȫ������
        i++;
    }
    if(i<L->length){   //�������ȫ����������������ҵ�����ͬ��Ԫ��
        for(int n=i;n<L->length;n++){  //�������Ա�ɾ��Ԫ�ص��������б�����ǰ�ƶ�
            L->data[n]=L->data[n+1];
        }
        L->length--;  //����ɾ�����������Ա�ĳ���-1
        return OK;
    }
    printf("���Ա���û�ж�Ӧ��Ԫ�أ��޷�ɾ��");  //�����ȫ����������������Ա���û��ָ����Ԫ��
    return ERROR;
}
//�ཻ���Ա������ϵĽ�����
Status mergeList(SqList *LA, SqList *LB){
    int lengthb = LB->length;  //����ѭ��ʹ��B���Ա�ĳ���
    int isEqual = 0;  //�ж��Ƿ���ȵı�־λ
    for(int i=0;i<lengthb;i++){   //ѭ���������Ա�B�е�Ԫ�����Ա�A���бȽ�
        if(searchList(LA, LB->data[i])){   //�жϵ�ǰA���Ƿ������B�е�Ԫ��
            isEqual = 1;   //����еĻ�����ʶλ��1��true��
        }
        if(isEqual){   //����������Ҫ����ɾ������
            deleteValue(LA,LB->data[i]);   //��ƥ�䵽����B�е�Ԫ����ȵ�Ԫ�ؽ���ɾ��
        }
        isEqual = 0;  //�µ�һ�ֽ���ʶλ��ʼ����0
    }
    return OK;
}
int main(int argc, const char * argv[]) {
    SqList sqlistA;
    SqList sqlistB;
    int e;
    printf("���������Ա�A�����ݣ�\n");
    CreatList(&sqlistA);
    printList(&sqlistA);
    printf("\n���������Ա�B�����ݣ�\n");
    CreatList(&sqlistB);
    printList(&sqlistB);
    printf("\nĿǰ���Ա�A�ĳ���Ϊ%d", getLength(&sqlistA));
    printf("\nĿǰ���Ա�B�ĳ���Ϊ%d", getLength(&sqlistB));
    Union(&sqlistA, &sqlistB);
    printf("\n�ϲ�������Ա�A�ĳ���Ϊ%d, ���Ա�A������Ϊ��", getLength(&sqlistA));
    printList(&sqlistA);
    mergeList(&sqlistA, &sqlistB);
    printf("\n�������Ա�B�����ཻ�����Ա�A�ı���ˣ�");
    printList(&sqlistA);
    insertList(&sqlistA, 2, 9);
    printf("\n�����Ա�A�еĵڶ���λ�ò���Ԫ��9������ã�");
    printList(&sqlistA);
    deleteList(&sqlistA, 2, e);
    printf("\n�����Ա�A���еڶ���λ��Ԫ��ɾ��������ã�");
    printList(&sqlistA);
    return 0;
}

