#include <iostream>
#include <cstring>
#include <cstdlib>
#include <unistd.h>
#include <cstdio>
using namespace std;


char map[5][21] =
{
        {'#','#','#','#','#','#','#','#','#','#','#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
        {'#','x',' ',' ',' ',' ',' ',' ',' ',' ',' ', ' ', ' ', '#', ' ', ' ', ' ', '!', ' ', '#'},
        {'#','#',' ','#',' ',' ',' ',' ',' ',' ','#', ' ', ' ', 'o', ' ', ' ', ' ', ' ', ' ', '#'},
        {'#',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ', ' ', ' ', '#', ' ', ' ', ' ', '#', ' ', '#'},
        {'#','#','#','#','#','#','#','#','#','#','#', '#', '#', '#', '#', '#', '#', '#', '#', '#'}
        
};
void DrawMap()
{
    for (int i = 0; i <= 4; i++)
    {
        for (int j = 0; j <= 20; j++)
        {
            cout << map[i][j];
        }
        cout << endl;       
    }
}
void PlayGame()
{
    int r , l;//�˵��±�
    for (int i = 0; i <= 4; i++)
    {
        for (int j = 0; j <= 20; j++)
        {
            if (map[i][j] == '!')
            {
                r = i;
                l =j;
            }
        }
    }
    char ch = getchar();  //��ȡ����
    if (ch == 'w' || ch == 'W')
    {
        if (map[r - 1][l] == ' ')//�˵�ǰ���ǿյػ�Ŀ�ĵ�
        {
            map[r][l] = ' ';
            r--;
            map[r][l] = '!';
        }
        if (map[r - 1][l] == 'o')  //�˵�ǰ��������
        {
            if (map[r - 2][l] == ' ' || map[r - 2][l] == 'x')//���ӵ�ǰ��
            {
                map[r - 2][l] = 'o';
                map[r - 1][l] = '!';
                map[r][l] = ' ';
            }
        }
    }
    if (ch == 's' || ch == 'S')
    {
        if (map [r + 1][l] == ' ')//��ǰ���ǿյ�
        {
                
            map[r][l] = ' ';
            r++;
            map[r][l] = '!';
        }
    if (map[r + 1][l] == 'o')//�˵�ǰ��������
    {
        if (map[r + 2][l] == ' ' || map[r + 2][l] == 'x')
        {
            map[r + 2][l] = 'o';
            map[r + 1][l] = '!';
            map[r][l] = ' ';
        }
    }
}
if (ch == 'a' || ch == 'A')
{
    if (map[r][l - 1] == ' ')
    {
        map[r][l] = ' ';
        l--;
        map[r][l] = '!';
        }
        if (map[r][l - 1] == 'o')
        {
            if (map[r][l - 2] == ' ' || map[r][l - 2] == 'x')
            {
                map[r][l - 2] = 'o';
                map[r][l - 1] = '!';
                map[r][l] = ' ';
            }
        }
    }
    if (ch == 'd' || ch == 'D')
    {
        if (map[r][l + 1] == ' ')
        {
            map[r][l] = ' ';
            l++;
            map[r][l] = '!';
        }
        if (map[r][l + 1] == 'o')
        {
            if (map[r][l + 2] == ' ' || map[r][l + 2] == 'x')
            {
                map[r][l + 2] = 'o';
                map[r][l + 1] = '!';
                map[r][l] = ' ';
            }
        }
    }
}


int main()
{
    
    while (map[1][1] == 'x')
    {
        system("export TERM=xterm && clear");
        DrawMap();
        PlayGame();
    }
    system("export TERM=xterm && clear");
    DrawMap();
    cout << "��ϲͨ�أ�" << endl;
    
    
    
    return 0;
}

