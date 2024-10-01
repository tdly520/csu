#include<iostream>

using namespace std;

int main() {

    int n, a[100];

    cin >> n;

    for (int i = 0; i < n; i++) //这里开始输入一段数组

    {

        cin >> a[i];

    }

    for (int j = 0; j < n - 1; j++)//这里开始冒泡排序，将数组按大到小排序

    {

        for (int l = 0; l < n-j-1; l++) {

            if (a[l] > a[l + 1]) {

                int temp = a[l];

                a[l] = a[l + 1];

                a[l + 1] = temp;

            }

        }

    }

    for (int b = 0; b < n-1;b++) //这里去重复的数字

    {

        for (int q = b + 1; q < n; q++) {

            if (a[b] == a[q]) {//当出现相同的时候

                for (int k = q; k < n - 1; k++)

                    a[k] = a[k + 1];//这里就是q后面的数（q+1所在位置的数）赋给q所在位置

                n--;//这时候数组总长度减1

                q--;//q也需要跟着一起减1

            }

        }

    }

    cout << n << endl;

    for (int m = 0; m < n; m++) {

        cout << a[m] << " ";

    }

    cout << endl;

    return 0;

}

