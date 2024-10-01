#include<stdio.h>
long chengzhongcishu(long n)
{
long cishu = 0;
if(n == 1) return 0;
else if(n == 2 || n == 3) return 1;
else {
cishu++;
while(n>3){
if(n % 3 == 0){
n = n/3;
cishu++;
}else {
n = n/3 +1;
cishu++;
}

}

return cishu;

}}
int main()
{
    int a;
    while(scanf("%d",&a)!= EOF&&a!=0 )
                           
    {
    	
    
        int count ;
        count=chengzhongcishu(a);

     
        printf("%d\n", count);
        
        
        
    
	}
    
    
    
    
    return 0;
}

