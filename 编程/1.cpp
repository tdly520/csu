#include<iostream>
#include<cstdio>
#include<cstdlib>
using namespace std;
struct node{
	int value;
	struct node*next;
};
//struct node*list;
int main()
{
	int m,n;
	cin>>m>>n;
	struct node *list=NULL,*cur,*rear;
	
	for(int i=1;i<=m;i++)
	{
		cur=(struct node*) malloc(sizeof(struct node));//也可以用new node来新建节点 
		cur->value=i;
		if(i==1)  list=cur;
		else rear->next=cur;
		rear=cur;
	}
	rear->next=list;
	for(int i=1;i<=m;i++)
	{
		for(int j=1;j<n-1;j++)
		{
			list=list->next;
		}
		cout<<list->next->value<<" ";
		cur=list->next;
		list->next=cur->next;
		list=list->next;
		free(cur);
	}
	return 0;
}
