select *
into mytitle
from titles

--ɾ�����������

select * from mytitle
where type ='business'

delete mytitle
where type ='busineass'

delete mttitle
where price between 2 and 10

delete mytitle
where title like '%computer'

---��ϵ��������ɾ��

select *
into mysale
from sales

select *
into mytitle
from titles

delete from mytitle

---ɾ����ҵ�鼮�����ۼ�¼
select * from mysale
where title_id in(
   select title_id from mytitle
   where type='business'
   )
   
delete mysale
where title_id in(
   select title_id from mytitle
   where mytitle.type='business'
   )

select * 
from mysale inner join mytitle 
on mysale.title_id=mytitle.title_id 
where type='mod_cook'

select *
from mysale,mytitle
where mysale.title_id=mytitle.title_id
and mytitle.type='popular_comp'

---����������
---��ʵ�壬���ã��û��Զ���
select * from publishers
where pub_id='9952'

delete  publishers
where pub_id='9952'
--DELETE ����� REFERENCE Լ��"FK__pub_info__pub_id__571DF1D5"��ͻ���ó�ͻ���������ݿ�"pubs"����"dbo.pub_info", column 'pub_id'��

delete pub_info
where pub_id='9952'

delete  publishers
where pub_id='9952'
---DELETE ����� REFERENCE Լ��"FK__employee__pub_id__5EBF139D"��ͻ���ó�ͻ���������ݿ�"pubs"����"dbo.employee", column 'pub_id'��

delete employee
where pub_id='9952'

delete publishers
where pub_id='9952'

delete mytitle
where title_id='BU1032'

delete titles
where title_id='BU1032'

delete titleauthor
where title_id='BU1032'

delete titles
where title_id='BU1032'

delete sales
where title_id='BU1032'

delete titles
where title_id='BU1032'

delete roysched
where title_id='BU1032'

delete titles
where title_id='BU1032'

=======update========

update  mytitle
set price=price*0.2

update mytitle
set price=999
where title_id='BU1111'

select * from mytitle

update mytitle
set price=888,ytd_sales=100
where title_id ='BU1111'


select * from mytitle
where pub_id in(
   select pub_id from publishers
   where state='CA')

select * from mytitle as m inner join publishers as p
on (m.pub_id=p.pub_id)
where p.state='CA'

update mytitle
set price=price *  2
from mytitle as m,publishers as p
where  m.pub_id=p.pub_id and p.state='CA'

update titles
set pub_id='ABCD'
where title_id='BU1111'
��Ϣ 547������ 16��״̬ 0���� 130 ��
UPDATE ����� FOREIGN KEY Լ��"FK__titles__pub_id__412EB0B6"��ͻ���ó�ͻ���������ݿ�"pubs"����"dbo.publishers", column 'pub_id'��
�������ֹ��

=============insert===========
teacher ��
teacherid  PK in not null
teachername varchar (50) not null
phone varchar (50),null
gender varchar(10) default '��' not null

select * from teacher

insert teacher values (3,'������,��3333��,'��')

insert teacher(teacherid,teachername,phone)
values (5,'����','5555')

delete mytitle

insert mytitle
select * from titles

insert mytitle
select title_id  from titles

select * from teacher
select * from course
select * from student

insert 







