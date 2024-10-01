#include<bits/stdc++.h>
using namespace std;
  bool zhi(int a)
     {
	 bool q=true;
	 for(int i=2;i<= int(sqrt(a));i++)
     {
     	if(a % i==0) {
		 q=false;break;
		 }
	 }
	 return q;
	 }
	 int main()
{
	
   int c,z,x,w;
   z=0;w=0;
   x=2;
   cin>>c;
   if(c<2) {cout<<0;return 0;
   }
   
   do
   {
   	if(zhi(x))
   	{
   		z=z+x;
   		cout<<x<<endl;
   		w=w+1;
	   }
	   x++;
   }while(z+x<=c);
  
  

   cout<<w<<endl;
	return 0;
	
}
