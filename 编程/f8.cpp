#include<bits/stdc++.h>
#include<string>
using namespace std;
int con=0;
void del_samechar(int *str,int num)
{int *p=str,*q,i=1;
 while(i<=num)
 {q=p+1;
  while(*p==*q) {
  	q++;con++;
  }
  if(q==p+1)
  {
  	*str++=*p++;
  	//*str=*p;
  	//str++;
  	//p++;
  }
    else {q--;
    p=q;	
	}
    i++;
  } 

}

int main()
{
   int a;
    scanf("%d",&a);
      int b[a+1],t;  
	for(int i=0;i<a;i++)
    {
    	scanf("%d",&b[i]);
	}
	for(int m=0;m<a-1;m++)
    {              
        
        for(int j=0;j<a-m-1;j++)
        {
            if(b[j]>b[j+1])
            {
                t=b[j];
                b[j]=b[j+1];
                b[j+1]=t;
            }
        }

}

del_samechar(b,a);
	cout<<a-con<<endl;
	for(int i=0;i<a-con;i++)
    {
    	printf("%d ",b[i]);
	}
     
	

	return 0;
}
