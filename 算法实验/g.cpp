#include <stdio.h>



int sum,n;
int data[1000]={0},book[1000]={0};
void bfs(int t){
	if(t>1){
		if(t==2){
            sum++;
        }
        else if((data[t-2]-data[t-3])*(data[t-1]-data[t-3])<0){//数组下标是从0开始的，所以要多减去一个1 
            sum++;
        }
        else return ;
	}
	for(int i = 1;i <= n;i++){
		if(book[i]==0){
			data[t] = i;//标记 
			book[i] = 1;//标记 
			bfs(t+1);
			book[i] = 0;//回溯 
		}
	}
	return ;
}
int main(){
	sum=0;
	while(scanf("%d",&n)!=EOF)
{
	bfs(0);
	printf("%d\n",sum); 
	}	
	
	return 0;
} 
