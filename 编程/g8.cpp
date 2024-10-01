/*********************************
*   日期：2013-2-21
*   作者：SJF0115
*   题号: 天勤OJ 题目1141: 大整数排序
*   来源：http://acmclub.com/problem.php?id=1141
*   结果：AC
*   来源：2006年华中科技大学计算机研究生机试真题
*   总结：
**********************************/
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
 
typedef struct Integer{
	int len;//长度
	char N[1001];//数字
}Integer;
//排序函数
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
		//输入
		for(i = 0;i < n;i++){
			scanf("%s",array[i].N);
			array[i].len = strlen(array[i].N);
		}
		//排序
		qsort(array,n,sizeof(array[0]),cmp);
		//输出
		for(i = 0;i < n;i++){
			printf("%s\n",array[i].N);
		}
	}
	return 0;
}
