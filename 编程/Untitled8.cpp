#include<iostream>

using namespace std;

int main() {

    int n, a[100];

    cin >> n;

    for (int i = 0; i < n; i++) //���￪ʼ����һ������

    {

        cin >> a[i];

    }

    for (int j = 0; j < n - 1; j++)//���￪ʼð�����򣬽����鰴��С����

    {

        for (int l = 0; l < n-j-1; l++) {

            if (a[l] > a[l + 1]) {

                int temp = a[l];

                a[l] = a[l + 1];

                a[l + 1] = temp;

            }

        }

    }

    for (int b = 0; b < n-1;b++) //����ȥ�ظ�������

    {

        for (int q = b + 1; q < n; q++) {

            if (a[b] == a[q]) {//��������ͬ��ʱ��

                for (int k = q; k < n - 1; k++)

                    a[k] = a[k + 1];//�������q���������q+1����λ�õ���������q����λ��

                n--;//��ʱ�������ܳ��ȼ�1

                q--;//qҲ��Ҫ����һ���1

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

