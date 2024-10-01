#include <bits/stdc++.h>
using namespace std;
 
bool vis[9][9];
struct Node{
	int x,y;
	int path;
};
int dir[8][2]={2,1,2,-1,-2,-1,-2,1,1,2,1,-2,-1,-2,-1,2};
char s[4],e[4];
int sx,xy,ex,ey;
 
bool check(int x,int y){
	if(x<=0||x>8||y<=0||y>8||vis[x][y])
		return false;
	else
		return true;
}
int bfs(int sx,int sy,int ex,int ey){
	memset(vis,0,sizeof(vis));
	queue<Node> q;
	q.push({sx,sy,0});
	vis[sx][sy]=1;
	while(q.size()){
		Node now=q.front();
		q.pop();
		if(now.x==ex&&now.y==ey){//已经到达终点 
			return now.path;
		}
		for(int i=0;i<8;i++){
			int xx=now.x+dir[i][0];
			int yy=now.y+dir[i][1];
			if(check(xx,yy)){
				q.push({xx,yy,now.path+1});
				vis[xx][yy]=1;
			}
		}
	}
}
 
int main(int argc, char** argv) {
	
	while(scanf("%s\0",s)!=EOF){
		scanf("%s",e);
		int sx=s[0]-'a'+1,sy=s[1]-'0';
		int ex=e[0]-'a'+1,ey=e[1]-'0';
		
		int path=bfs(sx,sy,ex,ey);
		
		printf("To get from %s to %s takes %d knight moves.\n",s,e,path);
	}
	return 0;
}
