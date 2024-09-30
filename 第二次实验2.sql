----û��д��business����popular_comp�����鼮�����߱�ź�����
select au_id ,au_lname,au_fname
from authors
where au_id in(
select au_id from titleauthor
where title_id not in (
select  title_id from titles
where type ='business' or type = 'popular_comp'))

---��ѯ������۸���20Ԫ���ϵ����߱�ź�����
select au_id ,au_lname,au_fname
from authors
where au_id in(
select au_id from titleauthor
where title_id  in (
select  title_id from titles
where price >20 ))

---��˰����80%��state=ks��������Ϣ

select au_id ,au_lname,au_fname
from authors
where state='KS' and au_id in(
select au_id from titleauthor
where title_id in (
select title_id from roysched
where royalty>80))

---��ѯ��������С��5����
SELECT state, count(au_id)
FROM authors
GROUP BY state
HAVING count(au_id) < 5
---��ѯ�۸���ߵ�������ߣ�����д�������������
select t.title ,a.au_lname
from titles as t 
inner join titleauthor as te on( t.title_id=te.title_id)inner join authors as a on(a.au_id=te.au_id)
  where t.price=(SELECT MAX(price)
    FROM titles)

---��ѯ�������ٵ�10��������߱�д�������������
select a.au_id ,t.title
from authors as a inner join titleauthor as te on(te.au_id=a.au_id)
inner join titles as t on(t.title_id=te.title_id)
WHERE t.title_id IN (
    SELECT TOP 10 title_id
    FROM sales
    ORDER BY qty ASC
)
---��ѯд�˼۸�PRICE����ƽ���۵��飬�������ڵ���STATE=CA���������ƣ�ͼ�����ƣ��۸�
select t.title,a.au_lname,t.price 
from authors as a inner join titleauthor as te on(te.au_id=a.au_id)
inner join titles as t on(t.title_id=te.title_id)
where t.price >(
select avg(price)
from titles)
