#include<bits/stdc++.h>
using namespace std;
int main(){

double  b;
double a;
FILE *fp = fopen("1.txt","r");
if (fp)
{
    char buf[200] = {0};
    while (fgets(buf,sizeof(buf),fp) != NULL)  //fgets()�����ж�ȡ
    {
        sscanf(buf,"%lf",&b); //ͬʱ��ȡһ��txt
        printf("b: %lf\n",b);
//        printf("a: %lf\n",a);
    }for(int i=0;i<=10;i++)
{
	cout<<buf[i];
}
}
fclose(fp);


}
