.MODEL SMALL  ;�������Ĵ洢ģʽ��С�ͳ���һ�����Сģʽsmall

.DATA
     ;�˴��������ݶδ���  
     OPER1  DB  1, 2,30h,0
	 OPER2  DW  1234h, 5678h
.STACK 
     ;�˴������ջ�δ���

.CODE
.STARTUP  ;������ڵ㣬�Զ���ʼ��DS��SS
 
     ;�˴�������Դ����
    MOV  AX, WORD PTR  OPER1+1
    MOV  AL, BYTE PTR  OPER2
    
.EXIT 0
   END
