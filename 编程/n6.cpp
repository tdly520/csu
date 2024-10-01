/*#include<iostream>
#include<algorithm>
#include<stack>
#include<map>
#include<string>
using namespace std;
stack<char>st;
stack<int>num;
map<int ,int>m;

int main(){
	string s;
	while(cin>>s)
	{
		
	for(int i=0;s[i];i++){
	   if(st.empty()){
	   	  st.push(s[i]);
	   	  num.push(i+1);
			 i++;
	   }
		char temp=st.top();
		
	     if(temp=='('&&s[i]==')'){
	    	int tnum=num.top();num.pop();
	    	m[tnum]=i+1;
	    	st.pop();
		}
		else {
			st.push(s[i]);
			num.push(i+1);
		}
	}

		for(map<int,int>::iterator it=m.begin();it!=m.end();++it){
			cout<<it->first<<" "<<it->second<<endl;
		
	}
	
     m.clear() ;
	}
	
	return 0;
}
*/
/**
 * 题目：括号匹配（括号位序）: http://pipioj.online/problem.php?id=1036
 */

#include <stdio.h>
#include <bits/stdc++.h>

using namespace std;

// 保存位序标号的节点
typedef struct {
    long left, right;
} PosNode;

// 依次打印括号对位序
void showBracketPosition(stack<PosNode> stack) {
    PosNode node;
    while (!stack.empty()) {
        node = stack.top();
        printf("%ld %ld\n", node.left, node.right);
        stack.pop(); // 打印完一组即移除
    }
}
/**
 * 计算一组正确包含左右()对的下标
 * 为了保证顺序，使用两个栈来保存信息 bStack: 保存当前读取的括号位置； pStack: 保存括号对位序的栈
 *      实现思路：
 *          1. 为了保证顺序，从字符串尾往头读取；
 *          2. 读取到右括号，直接入bStack;
 *          3. 读取到左括号，将当前左括号的位置和 bStack 栈顶(即相应右括号位置)存入 pStack 中
 *          4. 完成后将 pStack 栈中位置信息对依次输出即可
 *          [注]： 因是从尾往头按右括号位序依次将括号对位序存入pStack中，可保证是按左括号正序输出
 *          [注]： 默认输入为正确的输入，未做错误处理
 * @param str ：输入字符串
 * @return
 *
 */
bool getBracketPosition(string str) {
    long len = str.length();
    if (len == 0) return false;
    long i = len - 1;
    stack<long> bStack; // 存放括号位置的栈
    stack<PosNode> pStack; // 存放匹配括号的位置信息栈
    char RBrackt = ')';
    PosNode node;
    while (i >= 0) {
        if (RBrackt == str[i]) {
            // 右括号位置直接入栈，
            // 注意：此处直接保存字符串中下标，匹配时与右括号位置一同+1计算
            bStack.push(i);
        } else {
            node.right = bStack.top() + 1; // 右括号为栈顶信息
            node.left = i + 1;   // 左括号为当前读取位置
            pStack.push(node); // 位置信息入栈
            bStack.pop(); // 移除已匹配成功栈顶
        }
        i--;
    }
    showBracketPosition(pStack);
}

int main() {
    string str;
    while (cin >> str) { // 循环读入字符串
        getBracketPosition(str);
    }
}
