
#include<bits/stdc++.h>
using namespace std;
int  hui(int d)
{
    int y=0;
	while(d!=0)
	{
	y=y*10+d%10;
	d=d/10;
}
	return y; 	
}
int main()
{
      string a,ans;
      cin>>a;
      
      int cnt=0;
      for(int i=0;i<a.size();i++)
      {
      	if(a[i]>='0'&&a[i]<='9')  cnt++;
      	
		  else break;
		   
	  }
	  bool q=true;
	  if(cnt==1) ans=a[0];
	  else {for(int i=cnt-1;i>=0;i--)
	  {
	  while(a[i]=='0'&&q)
	  {
	  
	  i=i-1; 
	  }
	  
		   q=false;
		   ans=ans+a[i];
	  }
	  }
	  ans+=a[cnt];
	  q=true;
	  int i=0;
	  if(a[cnt]=='/'){
	  for( i=a.size()-1;i>=cnt+1;i--)
	  {  while(a[i]=='0'&&q)
	  {
	  
	  i=i-1; 
	  }	q=false;
	  ans+=a[i];
	  }
	  	
	  }
	 
	  else  {q=true;if(a.size()-cnt-1==1) ans+=a[a.size()-1];
	  else{ for( i=cnt+1;i<a.size();i++)
	  {	 
	    while(a[i]=='0'&&q)
	  {
	  
	  i=i+1; 
	  }	 
	  break;
	  }
	  for(int j=a.size()-1;j>=i;j--)
	  {ans+=a[j];
	  }
	  }
	  }
	 
	  cout<<ans;
	  
	return 0;
}
