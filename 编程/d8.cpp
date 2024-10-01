#include<bits/stdc++.h>
#include<string>
using namespace std;
char * removeDuplicates(char * s)
{
    int len=strlen(s);
    int top=0;
    char* stack=(char*)malloc((len+1)*sizeof(char));
    for(int i=0;i<len;i++)
    {
        if(top>0 &&stack[top-1]==s[i])//保证栈不会下溢
        {
            top--;
        }
        else
        {
            stack[top++]=s[i];
        }
    }
    stack[top]='\0';
    return stack;
}

int main()
{
   char a[100009],*p;
gets(a);
 p=removeDuplicates(a);
 printf("%s",p);
 return 0;
}



     
	



