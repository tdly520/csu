------where ������ѯ�����������У����·�����������--------
--> < = ----
select *
from titles
where price between 10 and 20

-----is null, is not null-----
select *
from titles
where price is null

--ö�� in not in-----
select *
from titles
where type in ('business', 'mod_cook')

--ģ����ѯlike + ��ȫͳ�����%---*
select *
from titles
where title like '%computer%'

select *
from titles
where title like 'computer%'

select *
from titles
where title like '%computer'

--ģ����ѯ �ַ�ͳ��like_---
select au_fname
from authors
where au_fname like '_heryl'

select au_fname
from authors
where au_fname like 'D___'

---ģ����ѯ�� ���ַ�����Χͳ�� like---
select au_fname
from authors
where au_fname like '[k-z]heryl'

--and or not��������ѯ----
select *
from titles
where price between 10 and 20  and type in( 'business' ,'mod_cook')