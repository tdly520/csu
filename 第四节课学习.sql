select *
into mytitle
from titles

--删除计算机类书

select * from mytitle
where type ='business'

delete mytitle
where type ='busineass'

delete mttitle
where price between 2 and 10

delete mytitle
where title like '%computer'

---关系到多个表的删除

select *
into mysale
from sales

select *
into mytitle
from titles

delete from mytitle

---删除商业书籍的销售记录
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

---数据完整性
---域，实体，引用，用户自定义
select * from publishers
where pub_id='9952'

delete  publishers
where pub_id='9952'
--DELETE 语句与 REFERENCE 约束"FK__pub_info__pub_id__571DF1D5"冲突。该冲突发生于数据库"pubs"，表"dbo.pub_info", column 'pub_id'。

delete pub_info
where pub_id='9952'

delete  publishers
where pub_id='9952'
---DELETE 语句与 REFERENCE 约束"FK__employee__pub_id__5EBF139D"冲突。该冲突发生于数据库"pubs"，表"dbo.employee", column 'pub_id'。

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
消息 547，级别 16，状态 0，第 130 行
UPDATE 语句与 FOREIGN KEY 约束"FK__titles__pub_id__412EB0B6"冲突。该冲突发生于数据库"pubs"，表"dbo.publishers", column 'pub_id'。
语句已终止。

=============insert===========
teacher 表
teacherid  PK in not null
teachername varchar (50) not null
phone varchar (50),null
gender varchar(10) default '男' not null

select * from teacher

insert teacher values (3,'赵三’,‘3333’,'男')

insert teacher(teacherid,teachername,phone)
values (5,'赵五','5555')

delete mytitle

insert mytitle
select * from titles

insert mytitle
select title_id  from titles

select * from teacher
select * from course
select * from student

insert 







