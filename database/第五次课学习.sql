create
drop
alter
drop table mytitle

select * from mytitle

insert
update
delete

select * from titles
select * from publishers
 
select t.title,t.price,p.pub_name
from titles as t,publishers as p
where t.pub_id=p.pub_id

create view v_nsdd
as 
  select t.title,t.price,p.pub_name
from titles as t,publishers as p
where t.pub_id=p.pub_id

drop view v_nsdd
select * from v_nsdd




create view v_nsdd_discount2
as 
  select t.title,
  t.price as price_raw ,t.price *0.8 as price_2,p.pub_name
from titles as t,publishers as p
where t.pub_id=p.pub_id

select * from v_nsdd_discount2

select * from View_1

1.索引定义
2.索引的数据结构b树
3.簇索引与非簇索引
