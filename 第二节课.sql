------select3-----
--�ۺϺ���---
1.count
2.max
3,min
4.avg
5.sum

select*
from titles
select count(*)
from titles
select count(title)
from titles
where price >8
select count(price)
from titles
where price >10

select min(price)
from titles

select avg(price)
from titles
where type='mod_cook'

select sum(price)
from titles

select sum(price)
from titles
where type='mod_cook'
 
select max(price),avg(price��,,sum(ytd_sales),count(*)
from titles

select avg(price) as 'avg price',max(price) as'max price',min(price) as 'min price'
from titles
where type='business'

select type ,avg(price) as 'avg price',max(price) as'max price',min(price) as 'min price'
from titles
group by type

select type ,avg(price) as 'avg price',max(price) as'max price',min(price) as 'min price'
from titles
group by pub_id
--ѡ���б��е��� 'titles.type' ��Ч
--��Ϊ����û�а����ھۺϺ����� GROUP BY �Ӿ��С�

select distinct type
from titles

select pub_id,type ,avg(price) as 'avg price',max(price) as'max price',min(price) as 'min price'
from titles
group by pub_id,type
--������select����ı��������group

select pub_id,type ,count(*),avg(ytd_sales),avg(price),max(price)
from titles
where  ytd_sales>10000
group by pub_id

select pub_id ,avg(price) as 'avg price',max(price) as'max price',sum(ytd_sales) as 'sum price'
from titles
group by pub_id
having sum(ytd_sales) >25000

select *
from titles
order by price desc

select type ,pub_id,avg(price)
from titles
group by type,pub_id
order by avg(price) desc