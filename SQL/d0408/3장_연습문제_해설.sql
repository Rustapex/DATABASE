-- 210p 3장 연습문제

--1. 

desc emp;

select sal+ comm 
from emp;

select sal + nvl(comm, 0)
from emp;

select
    max(sal + nvl(comm, 0)) as max,
    min(sal + nvl(comm,0)) as min,
    round(avg(sal + nvl(comm,0)) , 1) as avg
from emp;



--2
desc student;

select count(decode(to_char(birthday, 'mm') ,'01', '/')) as JAN
from student;
