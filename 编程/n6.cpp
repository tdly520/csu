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
 * ��Ŀ������ƥ�䣨����λ��: http://pipioj.online/problem.php?id=1036
 */

#include <stdio.h>
#include <bits/stdc++.h>

using namespace std;

// ����λ���ŵĽڵ�
typedef struct {
    long left, right;
} PosNode;

// ���δ�ӡ���Ŷ�λ��
void showBracketPosition(stack<PosNode> stack) {
    PosNode node;
    while (!stack.empty()) {
        node = stack.top();
        printf("%ld %ld\n", node.left, node.right);
        stack.pop(); // ��ӡ��һ�鼴�Ƴ�
    }
}
/**
 * ����һ����ȷ��������()�Ե��±�
 * Ϊ�˱�֤˳��ʹ������ջ��������Ϣ bStack: ���浱ǰ��ȡ������λ�ã� pStack: �������Ŷ�λ���ջ
 *      ʵ��˼·��
 *          1. Ϊ�˱�֤˳�򣬴��ַ���β��ͷ��ȡ��
 *          2. ��ȡ�������ţ�ֱ����bStack;
 *          3. ��ȡ�������ţ�����ǰ�����ŵ�λ�ú� bStack ջ��(����Ӧ������λ��)���� pStack ��
 *          4. ��ɺ� pStack ջ��λ����Ϣ�������������
 *          [ע]�� ���Ǵ�β��ͷ��������λ�����ν����Ŷ�λ�����pStack�У��ɱ�֤�ǰ��������������
 *          [ע]�� Ĭ������Ϊ��ȷ�����룬δ��������
 * @param str �������ַ���
 * @return
 *
 */
bool getBracketPosition(string str) {
    long len = str.length();
    if (len == 0) return false;
    long i = len - 1;
    stack<long> bStack; // �������λ�õ�ջ
    stack<PosNode> pStack; // ���ƥ�����ŵ�λ����Ϣջ
    char RBrackt = ')';
    PosNode node;
    while (i >= 0) {
        if (RBrackt == str[i]) {
            // ������λ��ֱ����ջ��
            // ע�⣺�˴�ֱ�ӱ����ַ������±꣬ƥ��ʱ��������λ��һͬ+1����
            bStack.push(i);
        } else {
            node.right = bStack.top() + 1; // ������Ϊջ����Ϣ
            node.left = i + 1;   // ������Ϊ��ǰ��ȡλ��
            pStack.push(node); // λ����Ϣ��ջ
            bStack.pop(); // �Ƴ���ƥ��ɹ�ջ��
        }
        i--;
    }
    showBracketPosition(pStack);
}

int main() {
    string str;
    while (cin >> str) { // ѭ�������ַ���
        getBracketPosition(str);
    }
}
