
#include <stdio.h>
int main()
{
    char v[100000];//��һ���㹻������顣
    int i = 0, j;
    FILE *fp;//�ļ�ָ��
 
    fp = fopen("1.txt", "r");//���ı���ʽ���ļ���
    if(fp == NULL) //���ļ�����
        return -1;
    while(fscanf(fp, "%s", &v[i]) != EOF) //��ȡ���ݵ����飬ֱ���ļ���β(����EOF)
        i++;
    fclose(fp);//�ر��ļ�
 
    for(j = 0; j < i; j ++)//ѭ���������Ԫ�ء�
    {
        printf("%s", v[j]);
    }
    return 0;
}
