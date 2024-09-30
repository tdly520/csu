========注释======
--我是注释，我可以注释一行

/*
我是注释多行版本
我可以注释多行
*/
=======数据类型和内置函数==

--面向数值类型的内置函数
select sin(30),cos(90),pi(),floor(3.14)

--面向字符串的内置函数
select left('abcdefg',3),right('abcdefg',3),SUBSTRING('abcdefg',3,2)

--面向日期的内置函数
select getdate(),datepart(dd,getdate())

select datediff(dd,'2003-11-30',getdate())

======数据类型转换=======
select 'abcd'+1234
select 'abcd'+cast(1234 as varchar(10))

select cast('4321.99' as float(2))+1234

=====变量==========
declare 
   @var_a varchar(100)
set 
   @var_a ='abcd'

declare
   @var_b varchar(100),
   @var_c varchar(100)

set @var_b='bbb'
set @var_c='ccc'

select @var_b,@var_c


declare 
   @var_a varchar(100)
set 
   @var_a ='cooking'
select * from titles
where title like '%'+@var_a+'%'

=========if-else=======
给定一个价格区间，去找书，如果没有找到，返回最便宜的书
declare 
  @var_count int,
  @var_max int,
  @var_min int
set @var_min=100
set @var_max=200
set @var_count=(select count(*) from titles where price between @var_min and @var_max)
if @var_count>0
begin 
  select * from titles where price between 10 and 20
end
else 
begin
  select top 3  * from titles order by price
end

---输入一个字符串，模糊匹配相关的书，如果没有找到，就返回销量最高的那本书
declare 
   @var_ckk varchar(10),
   @var_a int
set @var_ckk='computer'
set @var_a=(select count(*) from titles where title like '%'+@var_ckk+'%')
if @var_a>0
begin
    select *
	from titles
	where title like '%'+@var_ckk+'%'
end
else
begin 
select top 3 * from titles order by ytd_sales desc
end



=====while======

while(select avg(price) from titles )<200
begin 
  update titles set price =price*2
end

==========case===========
select pub_id,pub_name,
   case city
      when 'Boston' then '波士顿'
	  else '不认识'
   end as '城市',
   case country 
      when 'USA' then '美国'
	  when 'Germany' then '德国'
   end as '国家'
from publishers

select au_id,au_lname,
   case state
      when 'CA' then'加州'
      else '不知道'
   end as '州'
from authors

select * from authors

select *,
CASE state 
 when 'CA' then '加州'
 when 'KS' then '堪萨斯'
 else '我也不知道'
end as '州'
from authors

select 
