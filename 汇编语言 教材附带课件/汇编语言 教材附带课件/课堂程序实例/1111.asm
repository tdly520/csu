.MODEL SMALL  ;�������Ĵ洢ģʽ��С�ͳ���һ�����Сģʽsmall

.DATA
     ;�˴��������ݶδ���  
     BYTE_ARRAY  LABEL  BYTE
     WORD_ARRAY  DW  50  DUP (20h)
       tos  LABEL  WORD
       aay dw 11h
.STACK
     ;�˴������ջ�δ���

.CODE
.STARTUP  ;������ڵ㣬�Զ���ʼ��DS��SS
 
     ;�˴�������Դ����
     mov	ax,tos
    
.EXIT 0
   END
