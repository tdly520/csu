========ע��======
--����ע�ͣ��ҿ���ע��һ��

/*
����ע�Ͷ��а汾
�ҿ���ע�Ͷ���
*/
=======�������ͺ����ú���==

--������ֵ���͵����ú���
select sin(30),cos(90),pi(),floor(3.14)

--�����ַ��������ú���
select left('abcdefg',3),right('abcdefg',3),SUBSTRING('abcdefg',3,2)

--�������ڵ����ú���
select getdate(),datepart(dd,getdate())

select datediff(dd,'2003-11-30',getdate())

======��������ת��=======
select 'abcd'+1234
select 'abcd'+cast(1234 as varchar(10))

select cast('4321.99' as float(2))+1234

=====����==========
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
����һ���۸����䣬ȥ���飬���û���ҵ�����������˵���
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

---����һ���ַ�����ģ��ƥ����ص��飬���û���ҵ����ͷ���������ߵ��Ǳ���
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
      when 'Boston' then '��ʿ��'
	  else '����ʶ'
   end as '����',
   case country 
      when 'USA' then '����'
	  when 'Germany' then '�¹�'
   end as '����'
from publishers

select au_id,au_lname,
   case state
      when 'CA' then'����'
      else '��֪��'
   end as '��'
from authors

select * from authors

select *,
CASE state 
 when 'CA' then '����'
 when 'KS' then '����˹'
 else '��Ҳ��֪��'
end as '��'
from authors

select 
