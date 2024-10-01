#include<stdio.h>
#include <windows.h>
#include<stdlib.h>
#include<easyx.h>
#include<conio.h>


//�����ֵ�ͷ�ļ����
#include<mmsystem.h>
#pragma comment(lib,"WINMM.LIB")

IMAGE img[6];//ͼƬ����ָ��
void begin()//ͼƬ���غ���
{    
    loadimage(&img[0],"land.jpg",60,60);//����ͼƬ
	loadimage(&img[1],"wall.jpg",60,60);//(IMAGE ����ָ��,ͼƬ�ļ���,���,�߶�)
	loadimage(&img[2],"BoxYellow.jpg",60,60);
	loadimage(&img[3],"ManDOWN1.jpg",60,60);
	loadimage(&img[4],"aim.jpg",60,60);
	loadimage(&img[5],"BoxRed.jpg",60,60);//������Ŀ�ĵ�ʱ

	//��������
	mciSendString("open back.mp3 alias bgm ",0,0,0);
		
	mciSendString("play bgm repeat",0,0,0);
}
int q[11][13] = {      //��ʼ����ͼ   
  0,0,0,1,1,1,1,1,1,1,0,0,0,
  1,1,1,1,0,0,0,0,0,1,0,0,0,
  1,0,2,0,4,1,1,1,4,1,0,0,0,
  1,0,1,0,1,0,0,0,0,1,1,0,0,
  1,0,1,0,0,0,2,1,0,0,1,0,0,
  1,0,1,0,0,6,0,0,1,0,1,0,0,
  1,0,4,1,0,0,2,0,1,0,1,0,0,
  1,1,0,2,0,0,1,0,1,0,1,1,1,
  0,1,0,1,1,1,4,0,0,0,0,0,1,
  0,1,0,0,0,0,0,1,1,0,0,3,1,
  0,1,1,1,1,1,1,1,1,1,1,1,1//0�ǿյأ�1��ǽ�ڣ�2�����ӣ�3�����4��Ŀ�ĵأ�6��������Ŀ�ĵ����� 
};

int map[11][13] = {      //��ʼ����ͼ   
  0,0,0,1,1,1,1,1,1,1,0,0,0,
  1,1,1,1,0,0,0,0,0,1,0,0,0,
  1,0,2,0,4,1,1,1,4,1,0,0,0,
  1,0,1,0,1,0,0,0,2,1,1,0,0,
  1,0,1,0,0,0,0,1,0,0,1,0,0,
  1,0,1,0,0,6,0,0,1,0,1,0,0,
  1,0,4,1,0,0,2,0,1,0,1,0,0,
  1,1,0,2,0,0,1,0,1,0,1,1,1,
  0,1,0,1,1,1,4,0,0,0,0,0,1,
  0,1,0,0,0,0,0,1,1,0,0,3,1,
  0,1,1,1,1,1,1,1,1,1,1,1,1//0�ǿյأ�1��ǽ�ڣ�2�����ӣ�3�����4��Ŀ�ĵأ�6��������Ŀ�ĵ����� 
};

void drawmap()
{
	BeginBatchDraw();// ��ֹ��ͼ����,����������ڿ�ʼ������ͼ��ִ�к��κλ�ͼ����������ʱ���������ͼ�����ϣ�ֱ��ִ�� EndBatchDraw �Ž�֮ǰ�Ļ�ͼ�����
	for(int i=0;i<11;i++)//��
	{
		for(int j=0;j<13;j++)//��
		{
			//ÿ�е�����ͼ
			switch(map[i][j])
			{
			case 0://�յ�  
				putimage(j*60,i*60,&img[0]);//void putimage(int left,int top,void *buf,int ops),(x����,y����,����ָ��)
				break;
			 case 1://ǽ 
				putimage(j*60,i*60,&img[1]);
				break;
			case 2://����  
				putimage(j*60,i*60,&img[2]);
				break;
			case 3:
			case 7://����  
					putimage(j*60,i*60,&img[3]);
				break;
			case 4://Ŀ�ĵ�  
				putimage(j*60,i*60,&img[4]);
				break;
			case 6://���ӵ���Ŀ�ĵ�  
				putimage(j*60,i*60,&img[5]);
				break;
			default:
				break;
			}
		}
	}
	EndBatchDraw();
}


void play()//��λ
{
    //���˵�λ��
	int x,y;
	for(int i=0;i<11;i++)
	{
		for(int j=0;j<13;j++)
		{
			if(map[i][j] == 3|| map[i][j] == 7)
			{
				x=i;
				y=j;
			}
		}
	}
switch(_getch())
    {
	case 'W':
	case 'w':
		//����
		if(map[x-1][y]==0||map[x-1][y]==4)   //���Ϸ��ǿյػ�Ŀ�ĵ�
		{
			map[x-1][y]+=3;//������ȥ +3
			map[x][y]-=3;//ԭλ��-3
		}
		else if(map[x-1][y]==2||map[x-1][y]==6) //�Ϸ�Ϊ���ӻ�������Ŀ�ĵ���
		{
			if(map[x-2][y]==0||map[x-2][y]==4)  //�����Ϸ��ǿյػ�Ŀ�ĵ�
			{
				//������ȥ������Ҳ����ȥ
				map[x-2][y]+=2;
				map[x-1][y]+=1;//-2  +3 --+1
				map[x][y]-=3;
			}
		}
		break;
	case 'S':
	case 's':
		//����
		if(map[x+1][y]==0||map[x+1][y]==4)   //���·��ǿյػ�Ŀ�ĵ�
		{
			map[x+1][y]+=3;//������ȥ +3
			map[x][y]-=3;//ԭλ��-3
		}
		else if(map[x+1][y]==2||map[x+1][y]==6) //�·�Ϊ���ӻ�������Ŀ�ĵ���
		{
			if(map[x+2][y]==0||map[x+2][y]==4)  //�����·��ǿյػ�Ŀ�ĵ�
			{
				//������ȥ������Ҳ����ȥ
				map[x+2][y]+=2;
				map[x+1][y]+=1;//-2  +3 =+1
				map[x][y]-=3;
			}
		}
		break;
	case 'A':
	case 'a':
		//����
		if(map[x][y-1]==0||map[x][y-1]==4)   //�����ǿյػ�Ŀ�ĵ�
		{
			map[x][y-1]+=3;//�������� +3
			map[x][y]-=3;//ԭλ��-3
		}
		else if(map[x][y-1]==2||map[x][y-1]==6) //��Ϊ���ӻ�������Ŀ�ĵ���
		{
			if(map[x][y-2]==0||map[x][y-2]==4)  //�������ǿյػ�Ŀ�ĵ�
			{
				//�������ߣ�����Ҳ�������
				map[x][y-2]+=2;
				map[x][y-1]+=1;//-2  +3 --+1
				map[x][y]-=3;
			}
		}
		break;
	case 'D':
	case 'd':
		//����
		if(map[x][y+1]==0||map[x][y+1]==4)   //���ҷ��ǿյػ�Ŀ�ĵ�
		{
			map[x][y+1]+=3;//�������� +3
			map[x][y]-=3;//ԭλ��-3
		}
		else if(map[x][y+1]==2||map[x][y+1]==6) //�ҷ�Ϊ���ӻ�������Ŀ�ĵ���
		{
			if(map[x][y+2]==0||map[x][y+2]==4)  //�����ҷ��ǿյػ�Ŀ�ĵ�
			{
				//�������ߣ�����Ҳ�����ұ�
				map[x][y+2]+=2;
				map[x][y+1]+=1;//-2  +3 --+1
				map[x][y]-=3;
			}
		}
		break;
	case'r':
	case'R':  memcpy(map, q, sizeof(map));
		
		break;

	default ://����������case������£����default, ����д��ֱ������switch
		break;
	}
	PlaySound("Boxmove.WAV",nullptr,SND_FILENAME | SND_ASYNC);
}


int flag;
void  judge()
{
	flag=2;//��ֵ
	for(int i=0;i<11;i++)//��
	{
		for(int j=0;j<13;j++)//��
		{
			if(map[i][j]==2)
			{
				//����δ����
				flag=0;
				if(map[i-1][j]==1||map[i+1][j]==1)
				{
					//�����ǵ�ǽ
					if(map[i][j-1]==1||map[i][j-1]==1)
					{
						//��Ϸ����                   
						flag=1;						//flag ����
						return;						//=0 ���� 
													//=1 ����
													//=2  Ӯ
						
					}
				}
			}
		}
	}
}


void  box()
{
	if(flag==1)
	{
		MessageBox(GetHWnd(),"��Ǹ�������ˡ��ٳ���һ�ΰ�","LOSE",MB_OK);//ͷ�ļ�Ϊwindows.h ,����ͼ�����ݿ�Ͳ���Ҫ
		
	}
	else
	{
		PlaySound("success.wav",nullptr,SND_FILENAME | SND_ASYNC);
		MessageBox(GetHWnd(),"��ϲ����Ӯ��!","VICTORY",MB_OK); //MB_OK����Ϣ����һ����ť��OK������ȱʡֵ��
	}
}



IMAGE iae;
void tip()
{
	loadimage(&iae,"logo.jpg",780,360);
	putimage(0,0,&iae);
	settextcolor(LIGHTCYAN);
	settextstyle(24,0,_T("����"));
	outtextxy(240,350,_T("��ʼ��Ϸ    �밴 B/b "));
	outtextxy(240,400,_T("�ƶ��밴   wasd/WASD"));
	outtextxy(240, 450, _T("���¿�ʼ    �밴 R/r"));
	outtextxy(220,500,_T("�����԰������Ƶ�Ŀ�ĵأ�"));
	outtextxy(480,600,_T("----��ͨ2215�¿�����Ʒ----"));
}

int main()
{
	initgraph(780, 660);//ÿ�������С60*60   ���ڴ�С780*660
	
	tip();
	if (_getch() == 'B' || _getch() == 'b')
	{
		begin();
	a:

		while (1)
		{
			drawmap();
			judge();
			if (flag)  break;//�ж��Ƿ����
			play();
		}

		box();
		//if (_getch() == 'R' || _getch() == 'r')
		   if(flag==1) { memcpy(map, q, sizeof(map)); goto a; }
			




		getchar();
		closegraph();//�رմ���
		return 0;
	}
}
