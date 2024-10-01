#include<bits/stdc++.h>
#include<string>
#include<stdio.h>
typedef struct student

	{                                      //定义结构体 
		int num;                                      
		student *next;
	}student,*stu; 
	               	
int ListLength(stu L)                                 //求链表长度 
	{
		int len = 0;
		stu p = L;
		while(p->next!=NULL)
		{
			p = p->next;
			len++;
		}
		return len;
	}

stu InitList(stu L)
{
	stu head = (stu)malloc(sizeof(student));               //初始化空链表 
	head->next = NULL;
	head->num =0;
	L = head;
	return L;
}
stu CreatList()                                                //创建链表              
	{
		stu head,t;
		head = (stu)malloc(sizeof(student));
		head->num = 0;
		head->next = NULL;
		t = head;                                          //让t指针指向head结点 
		int temp;
		while(scanf("%d",&temp)!=EOF)                      //EOF文本读入结束标志  也可以手动输入ctril+z结束 
		{
			stu p;
			p = (stu)malloc(sizeof(student));               //申请空间 
			p->num = temp;                                    
			t->next = p;                                     //t（正指向head）的next指针指向新的结点 
			t = p;                                           //让t指向现在的p结点  t 始终指向最后一个结点 
		}
		t->next = NULL;                                     //最后把t所指结点的next指针放空  否则后面判断p->next==NULL出错 
		return head;                                        //最后返回head  指向链表的头结点 
	}
	
stu del(stu L,int x)
	{
		stu pre = L,p = L->next;    //pre永远指向p前面的结点  间隔一个元素 
		while(p->num!=x&&p->next!=NULL)        //一直使用p找到要删除的元素 p指向删除元素时pre指向前驱结点 
		{
			pre = p;                                     //pre 指向下一个结点 因为p指向的就是pre的下一个结点  
			p = p->next;                                  //p指向下一个结点 
		}
		pre->next = p->next;                             //pre指向p->next所指的元素  
		free(p);
		return L;
	}
	

	
int GetElem(stu L,int n)                                //获取第n个元素的数据 
	{
		if(L->next==NULL){                              //判空 
			return 0;
		} 
		int num = 0;
		stu p = L;                                      //指向L的头 
		for(int j =1;j<=n;j++)                           //注意循环1-n 
		{
			p = p->next;
		}
		num = p->num;                                  
		return num;
	} 
	
	int Compare(int a,int b)                        //比较函数 
	{
	if(a>b)
	{
	return 1;	
	}
	if(a<b)
	{
		return -1;
	}
	if(a==b)
	{
		return 0;
	}
}
	
int  LocateElem(stu L,int x)                         //查找链表L中是否有和x相同的数据 
{
	if(L->next==NULL){
		return 0;
	}
	stu p =L;
	for(int i =1;i<=ListLength(L)+1;i++)
	{
		if(Compare(p->num,x)==0)
		{
			return 1;                               //有相同的返回1 
		}
		
		p = p->next;	
	}
	 return 0;
	
}
 
stu Insert(stu &L,int x){                                //插入  按照递增顺序 
	stu pre = L,p = L->next;
	if(L->next!=NULL)                                     //L是否为空 
	{
	while(p->num<x&&p->next!=NULL)          //直到找到比x大的元素此时pre指向前一个  p指向比x大的那个   或者到最末尾  
	{
		pre = p;
		p = p->next;
	}
	pre = pre->next;                                      //pre指向前一个 
	stu t;
	t = (stu)malloc(sizeof(student));
	t->num = x;
	t->next = pre->next;                                  //新节点的next指向原本pre->next指向的元素  （插进去了） 
	pre->next = t;                                        //最后再把pre->next指向新节点就行 
	return L;
	}
	else                                                  //如果链表为空的话  就直接插入 
	{
		stu t;
		t = (stu)malloc(sizeof(student));
		t->num = x;
		t->next = NULL;
		L->next = t;
		return L;
	}                                                  
}
stu MergeList(stu list1,stu list2,stu &listc)                //第二种合并  直接合并成新链表listc （默认递增输入） 
{	int i = 1,j = 1,k = 0;
	int ai,bj,La_len,Lb_len;
	La_len = ListLength(list1);
	Lb_len = ListLength(list2);
	while((i<=La_len)&&(j<=Lb_len))                            //i j 都小于长度时 
	{
		ai = GetElem(list1,i);
		bj = GetElem(list2,j);
		if(ai<=bj)
		{
			Insert(listc,ai);
			++i;
		}
		if(ai>bj) 
		{
			Insert(listc,bj);                        //循环出问题1   
			++j;
		}
	}
	while(i<=La_len)                                            //只剩下 list1了  就直接插入 
	{
		ai = GetElem(list1,i);
		Insert(listc,ai);
		++i;
	} 
	while(j<=Lb_len)                                             //同上 只剩list2 
	{
		bj = GetElem(list2,j);
		Insert(listc,bj);
		++j;
	}
	return listc;
} 	
void Union(stu &list1,stu list2)                             //第一种合并  将 list2元素逐个插入到kist1中 且 不重复（默认递增输入） 
{
	int temp;
		int l1_len = ListLength(list1); 
		int l2_len = ListLength(list2);
		
		for(int i =1;i<=l2_len;i++)
		{
			temp = GetElem(list2,i);                       //拿到list2第i个元素的值给temp 
			if(!LocateElem(list1,temp))                   //再到list1中去找有没有相同的  没有的话就把元素插到list1里面去 
			{	
				Insert(list1,temp); 
			}
		}
}
int main()
	{
		stu list1,list2,listc,t;
		printf("请输入list1：\n");                                   //逐个输入 都要回车 
		list1 = CreatList();
		printf("list2：\n");
		list2 = CreatList();
		listc = InitList(listc);
    	listc = MergeList(list1,list2,listc);
	Union(list1,list2); 
	//	MergeList(list1,list2,listc);                               //MergeList示例 
 		for(t = list1->next;t!=NULL;t = t->next)
		{	
			printf("%d\n",t->num);
			
		}
		return 0;
	} 
	
