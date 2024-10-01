#include<iostream>
#include<cstdio>
#include<cstdlib>
using namespace std;
struct node{
	int value;
	struct node*next;
};
int main()
{
	int n;
	cin>>n;
	int x,y;
	struct node *cur,*rear,*list=NULL,*temp,*head;
	cur=(struct node*) malloc(sizeof(struct node));
		cur->value=1;
		list=cur;
		//rear=cur;
		head=cur;
	for(int i=2;i<=n;i++)
	{
		
		cin>>x>>y;
		if(y==0){list=head;
			for(int j=1;j<i;j++)
			{   if(list->next->value==x) break;
				else list=list->next;
			}
			cur=(struct node*) malloc(sizeof(struct node));
			rear=list->next;
			cur->value=i;
			list->next=cur;
			cur->next=rear;
				
			}
				
			
			
			
		else
		{list=head;
			for(int j=1;j<i;j++)
			{   if(list->value==x) break;
				else list=list->next;
			}
			cur=(struct node*) malloc(sizeof(struct node));
			cur->value=i;
			rear=list->next;
			list->next=cur;
			cur->next=rear;	}
	}
	rear->next=head;
	int m;
	cin>>m;
	
	for(int i=1;i<=m;i++)
	{
		cin>>x;
		list=head;
		bool you=0;
		for(int j=1;j<=n;j++)
		{
			if(list->next->value==x)  {
			you=1;
			n=n-1;break;	
			}
			else list=list->next;
		}
		if(you) {
			rear=list->next;
			list->next=rear->next;
			
		}
		
		
	}
//	rear->next=head;
	list=head;
	for(int i=1;i<=n;i++)
	{
		cout<<list->value<<" ";
		list=list->next;
	}
	
	
}
