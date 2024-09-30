----没有写过business或者popular_comp类型书籍的作者编号和姓名
select au_id ,au_lname,au_fname
from authors
where au_id in(
select au_id from titleauthor
where title_id not in (
select  title_id from titles
where type ='business' or type = 'popular_comp'))

---查询出版物价格在20元以上的作者编号和姓名
select au_id ,au_lname,au_fname
from authors
where au_id in(
select au_id from titleauthor
where title_id  in (
select  title_id from titles
where price >20 ))

---版税大于80%且state=ks的作者信息

select au_id ,au_lname,au_fname
from authors
where state='KS' and au_id in(
select au_id from titleauthor
where title_id in (
select title_id from roysched
where royalty>80))

---查询作者数量小于5的州
SELECT state, count(au_id)
FROM authors
GROUP BY state
HAVING count(au_id) < 5
---查询价格最高的书的作者，和他写的所有书的名称
select t.title ,a.au_lname
from titles as t 
inner join titleauthor as te on( t.title_id=te.title_id)inner join authors as a on(a.au_id=te.au_id)
  where t.price=(SELECT MAX(price)
    FROM titles)

---查询销量较少的10本书的作者编写的所有书的书名
select a.au_id ,t.title
from authors as a inner join titleauthor as te on(te.au_id=a.au_id)
inner join titles as t on(t.title_id=te.title_id)
WHERE t.title_id IN (
    SELECT TOP 10 title_id
    FROM sales
    ORDER BY qty ASC
)
---查询写了价格PRICE高于平均价的书，而且所在的州STATE=CA的作者名称，图书名称，价格
select t.title,a.au_lname,t.price 
from authors as a inner join titleauthor as te on(te.au_id=a.au_id)
inner join titles as t on(t.title_id=te.title_id)
where t.price >(
select avg(price)
from titles)
