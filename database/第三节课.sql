-----����ѯ-----
����������

select title,price,pub_id
from titles

select pub_id,pub_name
from publishers

select title,price,t.pub_id as '���PUB_id',p.pub_id as '����PUB_id',pub_name 
from titles as t,publishers as p
where t.pub_id=p.pub_id

select title,price,pub_name 
from titles as t,publishers as p
where t.pub_id=p.pub_id

-----����---
select * from employee
select * from jobs

----��Ա�����գ�����ְ������

select t.fname,t.lname,p.job_desc
from employee as t,jobs as p
where t.job_id=p.job_id

----��Զ�----
----��������������
select * from titles
select * from authors
select * from titleauthor

select t.title ,a.au_fname,a.au_lname
from titleauthor as te,titles as t,authors as a
where te.title_id=t.title_id and te.au_id=a.au_id

---��Զ࣬һ�Զ�һ����

----�������������֣�����������

select t.title,a.au_fname,a.au_lname ,p.pub_name
from titles as t,titleauthor as te,authors as a, publishers as p
where te.title_id=t.title_id and te.au_id=a.au_id and t.pub_id=p.pub_id

select t.title,a.au_fname,a.au_lname ,p.pub_name
from titles as t,titleauthor as te,authors as a, publishers as p
where te.title_id=t.title_id and te.au_id=a.au_id and t.pub_id=p.pub_id and t.price<20

-----���Ӳ�ѯ-----
--ȫ���� ��������
select title ,price,titles.pub_id,pub_name
from titles ,publishers

--������
select title,price,pub_name
from titles as t inner join publishers as p
on t.pub_id=p.pub_id

select t.title ,a.au_fname,a.au_lname
from titleauthor as te inner join titles as t on(te.title_id=t.title_id) inner join authors as a on (te.au_id=a.au_id)

select t.title ,a.au_fname,a.au_lname,p.pub_name
from titleauthor as te inner join titles as t on(te.title_id=t.title_id) inner join authors as a on (te.au_id=a.au_id)
inner join publishers as p on(t.pub_id=p.pub_id)
where price <10

----������----
select * from stores
select *from discounts
 
select stor_name,discounttype
from stores as s inner join discounts as d
on(s.stor_id=d.stor_id)

����������

select stor_name,discounttype
from stores as s left outer  join discounts as d
on(s.stor_id=d.stor_id)

����������
select stor_name,discounttype
from stores as s right outer  join discounts as d
on(s.stor_id=d.stor_id)

ȫ��������
select stor_name,discounttype
from stores as s full outer  join discounts as d
on(s.stor_id=d.stor_id)

---����
select au_lname,au_fname,state from authors
select pub_id,pub_name ,state from publishers

select au_lname,au_fname,p.state,p.pub_name
from authors as a inner join publishers as p on(a.state=p.state and a.state='CA')

select au_lname,au_fname,au_fname,a.state,p.state,p.pub_name
from authors as a left outer  join publishers as p on(a.state=p.state )


---�Ӳ�ѯ��Ƕ�ײ�ѯ��---
��ѯ�������ҵ�鼮�ĳ�����ı�ź�����

select pub_id  from titles
where type ='business'

select pub_id  from titles
where pub_id in(139,0736)

select pub_id  ,pub_name from publishers
where pub_id in
(  select pub_id from titles
   where type='business'
   )

select distinct p.pub_id,p.pub_name
from titles as t inner join publishers as p on(t.pub_id=p.pub_id)
where type='business'

---���������˵���������ź�����


select* from publishers
where pub_id in (
select pub_id from titles 
where price=(
select min(price) from titles 
))
--����˵ļ۸�����Щ����д��

select* from publishers
where pub_id in (
select pub_id from titles 
where price=(
select min(price) from titles 
))
select au_fname,au_lname from authors 
where au_id in(

select au_id from titleauthor
where title_id in(
select title_id from titles 
where price=(
select min(price) from titles 
))
)

