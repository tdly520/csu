------where 给出查询条件，过滤行，留下符合条件的行--------
--> < = ----
select *
from titles
where price between 10 and 20

-----is null, is not null-----
select *
from titles
where price is null

--枚举 in not in-----
select *
from titles
where type in ('business', 'mod_cook')

--模糊查询like + 完全统配符号%---*
select *
from titles
where title like '%computer%'

select *
from titles
where title like 'computer%'

select *
from titles
where title like '%computer'

--模糊查询 字符统配like_---
select au_fname
from authors
where au_fname like '_heryl'

select au_fname
from authors
where au_fname like 'D___'

---模糊查询， 单字符带范围统配 like---
select au_fname
from authors
where au_fname like '[k-z]heryl'

--and or not多条件查询----
select *
from titles
where price between 10 and 20  and type in( 'business' ,'mod_cook')