select *
from products
order by unitprice desc

select productname,sum(unitprice) as 'sum unitprice'
from products
group by productname

select supplierid ,count(*)
from products
group by supplierid
having count(*)=1
order by 

