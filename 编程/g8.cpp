/*********************************
*   ���ڣ�2013-2-21
*   ���ߣ�SJF0115
*   ���: ����OJ ��Ŀ1141: ����������
*   ��Դ��http://acmclub.com/problem.php?id=1141
*   �����AC
*   ��Դ��2006�껪�пƼ���ѧ������о�����������
*   �ܽ᣺
**********************************/
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
 
typedef struct Integer{
	int len;//����
	char N[1001];//����
}Integer;
//������
int cmp(const void *a,const void *b){
	struct Integer *c = (Integer *)a;
	struct Integer *d = (Integer *)b;
	if(c->len != d->len){
		return c->len - d->len;
	}
	else{
		return strcmp(c->N,d->N);
	}
}
 
int main()
{
	int n,i;
	Integer array[101];
	while(scanf("%d",&n) != EOF){
		//����
		for(i = 0;i < n;i++){
			scanf("%s",array[i].N);
			array[i].len = strlen(array[i].N);
		}
		//����
		qsort(array,n,sizeof(array[0]),cmp);
		//���
		for(i = 0;i < n;i++){
			printf("%s\n",array[i].N);
		}
	}
	return 0;
}
