#include<bits/stdc++.h>
#include<string>
#include<stdio.h>
typedef struct student

	{                                      //����ṹ�� 
		int num;                                      
		student *next;
	}student,*stu; 
	               	
int ListLength(stu L)                                 //�������� 
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
	stu head = (stu)malloc(sizeof(student));               //��ʼ�������� 
	head->next = NULL;
	head->num =0;
	L = head;
	return L;
}
stu CreatList()                                                //��������              
	{
		stu head,t;
		head = (stu)malloc(sizeof(student));
		head->num = 0;
		head->next = NULL;
		t = head;                                          //��tָ��ָ��head��� 
		int temp;
		while(scanf("%d",&temp)!=EOF)                      //EOF�ı����������־  Ҳ�����ֶ�����ctril+z���� 
		{
			stu p;
			p = (stu)malloc(sizeof(student));               //����ռ� 
			p->num = temp;                                    
			t->next = p;                                     //t����ָ��head����nextָ��ָ���µĽ�� 
			t = p;                                           //��tָ�����ڵ�p���  t ʼ��ָ�����һ����� 
		}
		t->next = NULL;                                     //����t��ָ����nextָ��ſ�  ��������ж�p->next==NULL���� 
		return head;                                        //��󷵻�head  ָ�������ͷ��� 
	}
	
stu del(stu L,int x)
	{
		stu pre = L,p = L->next;    //pre��Զָ��pǰ��Ľ��  ���һ��Ԫ�� 
		while(p->num!=x&&p->next!=NULL)        //һֱʹ��p�ҵ�Ҫɾ����Ԫ�� pָ��ɾ��Ԫ��ʱpreָ��ǰ����� 
		{
			pre = p;                                     //pre ָ����һ����� ��Ϊpָ��ľ���pre����һ�����  
			p = p->next;                                  //pָ����һ����� 
		}
		pre->next = p->next;                             //preָ��p->next��ָ��Ԫ��  
		free(p);
		return L;
	}
	

	
int GetElem(stu L,int n)                                //��ȡ��n��Ԫ�ص����� 
	{
		if(L->next==NULL){                              //�п� 
			return 0;
		} 
		int num = 0;
		stu p = L;                                      //ָ��L��ͷ 
		for(int j =1;j<=n;j++)                           //ע��ѭ��1-n 
		{
			p = p->next;
		}
		num = p->num;                                  
		return num;
	} 
	
	int Compare(int a,int b)                        //�ȽϺ��� 
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
	
int  LocateElem(stu L,int x)                         //��������L���Ƿ��к�x��ͬ������ 
{
	if(L->next==NULL){
		return 0;
	}
	stu p =L;
	for(int i =1;i<=ListLength(L)+1;i++)
	{
		if(Compare(p->num,x)==0)
		{
			return 1;                               //����ͬ�ķ���1 
		}
		
		p = p->next;	
	}
	 return 0;
	
}
 
stu Insert(stu &L,int x){                                //����  ���յ���˳�� 
	stu pre = L,p = L->next;
	if(L->next!=NULL)                                     //L�Ƿ�Ϊ�� 
	{
	while(p->num<x&&p->next!=NULL)          //ֱ���ҵ���x���Ԫ�ش�ʱpreָ��ǰһ��  pָ���x����Ǹ�   ���ߵ���ĩβ  
	{
		pre = p;
		p = p->next;
	}
	pre = pre->next;                                      //preָ��ǰһ�� 
	stu t;
	t = (stu)malloc(sizeof(student));
	t->num = x;
	t->next = pre->next;                                  //�½ڵ��nextָ��ԭ��pre->nextָ���Ԫ��  �����ȥ�ˣ� 
	pre->next = t;                                        //����ٰ�pre->nextָ���½ڵ���� 
	return L;
	}
	else                                                  //�������Ϊ�յĻ�  ��ֱ�Ӳ��� 
	{
		stu t;
		t = (stu)malloc(sizeof(student));
		t->num = x;
		t->next = NULL;
		L->next = t;
		return L;
	}                                                  
}
stu MergeList(stu list1,stu list2,stu &listc)                //�ڶ��ֺϲ�  ֱ�Ӻϲ���������listc ��Ĭ�ϵ������룩 
{	int i = 1,j = 1,k = 0;
	int ai,bj,La_len,Lb_len;
	La_len = ListLength(list1);
	Lb_len = ListLength(list2);
	while((i<=La_len)&&(j<=Lb_len))                            //i j ��С�ڳ���ʱ 
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
			Insert(listc,bj);                        //ѭ��������1   
			++j;
		}
	}
	while(i<=La_len)                                            //ֻʣ�� list1��  ��ֱ�Ӳ��� 
	{
		ai = GetElem(list1,i);
		Insert(listc,ai);
		++i;
	} 
	while(j<=Lb_len)                                             //ͬ�� ֻʣlist2 
	{
		bj = GetElem(list2,j);
		Insert(listc,bj);
		++j;
	}
	return listc;
} 	
void Union(stu &list1,stu list2)                             //��һ�ֺϲ�  �� list2Ԫ��������뵽kist1�� �� ���ظ���Ĭ�ϵ������룩 
{
	int temp;
		int l1_len = ListLength(list1); 
		int l2_len = ListLength(list2);
		
		for(int i =1;i<=l2_len;i++)
		{
			temp = GetElem(list2,i);                       //�õ�list2��i��Ԫ�ص�ֵ��temp 
			if(!LocateElem(list1,temp))                   //�ٵ�list1��ȥ����û����ͬ��  û�еĻ��Ͱ�Ԫ�ز嵽list1����ȥ 
			{	
				Insert(list1,temp); 
			}
		}
}
int main()
	{
		stu list1,list2,listc,t;
		printf("������list1��\n");                                   //������� ��Ҫ�س� 
		list1 = CreatList();
		printf("list2��\n");
		list2 = CreatList();
		listc = InitList(listc);
    	listc = MergeList(list1,list2,listc);
	Union(list1,list2); 
	//	MergeList(list1,list2,listc);                               //MergeListʾ�� 
 		for(t = list1->next;t!=NULL;t = t->next)
		{	
			printf("%d\n",t->num);
			
		}
		return 0;
	} 
	
