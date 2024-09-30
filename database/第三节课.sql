-----多表查询-----
书名，单价

select title,price,pub_id
from titles

select pub_id,pub_name
from publishers

select title,price,t.pub_id as '外键PUB_id',p.pub_id as '主键PUB_id',pub_name 
from titles as t,publishers as p
where t.pub_id=p.pub_id

select title,price,pub_name 
from titles as t,publishers as p
where t.pub_id=p.pub_id

-----例子---
select * from employee
select * from jobs

----雇员名，姓，工作职务描述

select t.fname,t.lname,p.job_desc
from employee as t,jobs as p
where t.job_id=p.job_id

----多对多----
----书名，作者名字
select * from titles
select * from authors
select * from titleauthor

select t.title ,a.au_fname,a.au_lname
from titleauthor as te,titles as t,authors as a
where te.title_id=t.title_id and te.au_id=a.au_id

---多对多，一对多一起来

----书名，作者名字，出版社名字

select t.title,a.au_fname,a.au_lname ,p.pub_name
from titles as t,titleauthor as te,authors as a, publishers as p
where te.title_id=t.title_id and te.au_id=a.au_id and t.pub_id=p.pub_id

select t.title,a.au_fname,a.au_lname ,p.pub_name
from titles as t,titleauthor as te,authors as a, publishers as p
where te.title_id=t.title_id and te.au_id=a.au_id and t.pub_id=p.pub_id and t.price<20

-----连接查询-----
--全连接 交叉连接
select title ,price,titles.pub_id,pub_name
from titles ,publishers

--内连接
select title,price,pub_name
from titles as t inner join publishers as p
on t.pub_id=p.pub_id

select t.title ,a.au_fname,a.au_lname
from titleauthor as te inner join titles as t on(te.title_id=t.title_id) inner join authors as a on (te.au_id=a.au_id)

select t.title ,a.au_fname,a.au_lname,p.pub_name
from titleauthor as te inner join titles as t on(te.title_id=t.title_id) inner join authors as a on (te.au_id=a.au_id)
inner join publishers as p on(t.pub_id=p.pub_id)
where price <10

----外连接----
select * from stores
select *from discounts
 
select stor_name,discounttype
from stores as s inner join discounts as d
on(s.stor_id=d.stor_id)

左向外连接

select stor_name,discounttype
from stores as s left outer  join discounts as d
on(s.stor_id=d.stor_id)

右向外连接
select stor_name,discounttype
from stores as s right outer  join discounts as d
on(s.stor_id=d.stor_id)

全向外连接
select stor_name,discounttype
from stores as s full outer  join discounts as d
on(s.stor_id=d.stor_id)

---例子
select au_lname,au_fname,state from authors
select pub_id,pub_name ,state from publishers

select au_lname,au_fname,p.state,p.pub_name
from authors as a inner join publishers as p on(a.state=p.state and a.state='CA')

select au_lname,au_fname,au_fname,a.state,p.state,p.pub_name
from authors as a left outer  join publishers as p on(a.state=p.state )


---子查询（嵌套查询）---
查询出版过商业书籍的出版社的编号和名字

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

---出版过最便宜的书出版社编号和名称


select* from publishers
where pub_id in (
select pub_id from titles 
where price=(
select min(price) from titles 
))
--最便宜的价格，是那些作者写的

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

