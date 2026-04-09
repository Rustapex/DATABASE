-- 254p 연습문제

-- 나이가 교재와 다름, 4(결과 5개)

--1. 학생이름, 1전공 학과번호(deptno1), 1전공 학과 이름을 출력
desc student;
desc department;

select s.name "STU_NAME", s.deptno1 "DEPTNO1", d.dname "DEPT_NAME"
from student s
join department d
    on s.deptno1 = d.deptno;
    
    
--2. 현재 지급이 있는 사원의 이름(name), 직급(position), 현재연봉, 해당 직급의 연봉의 하한액, 상한액 출력
desc emp2;
desc p_grade;

select p.name NAME, p.position POSITION,  p.pay PAY, e.ls "Low PAY", e.hp "hight Pay"
from (select position, 
            to_char(s_pay, '99,999,999') as ls, 
            to_char(e_pay, '99,999,999') as hp  
        from p_grade) e
join (select position, 
            to_char(pay, '99,999,999') as pay , 
            name from emp2 ) p
    on e.position = p.position;
    
-- 3. 사원들의 이름과 나이, 현재직급, 예상 직급을 출력
-- 예상 직급은 나이로 계산하여 해당 나이가 받아야 하는 직급을 의미
-- 나이는 오늘(sysdate) 기준, trunc으로 소수점 이하 절삭


-- 오늘 조회
select sysdate from dual; -- 시간단위까지는 안 나옴

-- 예상 나이 계산 months_between(sysdate,birthday)/12 [사이에 몇개월인지 반환] 해서 예상 나이 조회  -> turnc 로 절삭
select trunc(months_between(sysdate, birthday)/12) as "나이"
from emp2;

-- 예상 직급 계산 (s_age <= age <= e_age) 인 age로 예상 직급 조회
select p.position f_pos , e1.c_age c_age, e1.name NAME
from p_grade p 
join (select name, trunc(months_between(sysdate, birthday)/12) as c_age
    from emp2) e1
    on c_age >= p.s_age and c_age <= p.e_age;

-- 현재 직급 내용이랑 합치기

select e1.name NAME, e1.c_age AGE, nvl(e1.position, '  ') CURR_POSITION, nvl(p.position, '  ') BE_POSITION  
from p_grade p
right outer join (select name, position, trunc(months_between(sysdate, birthday)/12) as c_age
    from emp2) e1
    on e1.c_age >= p.s_age and e1.c_age <= p.e_age;
    
    
    
-- 4. 고객이 자기 포인트보다 낮은 포인트의 상품 중 한 가지를 선택할 수 있다고 할 때 
-- notebook을 선택할 수 있는 고객명, 포인트 ,상품명을 출력

desc customer;
desc gift;

select * from customer;
select * from gift;

select * from gift order by g_end desc;

-- 고객의 포인트보다 낮은 상품들  구하기 (1)

-- inner join (2)
select *
from customer c
join gift g
    on c.point >= g.g_end;


-- 고객 point 보다 낮은 상품들 중 가장 좋은 상품 번호 구하기 (3)
select c.gname, c.point, max(g.gno)
from customer c
join gift g
    on c.point >= g.g_start
group by c.gname, c.point;

-- notebook 의 상품번호 구하기 (4)

select gno
from gift
where gname = 'Notebook';


-- (3)에서의 번호와 (4) 비교해서 notebook 선택할 수 있는지 판별
select c2.name CUST_NAME, c2.point POINT, g2.gname GIFT_NAME
from (select gno, gname from gift where gname = 'Notebook') g2
join (select c1.gname as name, c1.point as point, max(g.gno) as m_gno
        from customer c1
        join gift g
            on c1.point > g.g_start
        group by c1.gname, c1.point) c2
    on g2.gno <= c2.m_gno;


-- 4번 다시 풀기

-- 4-1 customer - gift 테이블 조인해서 customer 별로 받을 수 있는 상품 모두 조회

-- 4-1-1 customer의 point가 gift 의 g_start 보다 같거나 큰지 판별 ON JOIN 조건

select *
from customer c
join gift g
    on c.point > g.g_start;

-- 4-1-2 where 절에서 gname이 notebook인지 

select c.gname CUST_NAME, c.point POINT, g.gname GIFT_NAME
from customer c
join gift g
    on c.point > g.g_start
where g.gname = 'Notebook';

-- 5반
select * from professor;  -- self 조인 

--1980-06-23
--1979-01-01

select *
from professor  p1
join professor  p2 
on  p1.hiredate  >   p2.hiredate 
where p1.profno  =1002;


-- count(*)  :  null 카운트
select p1.profno, p1.name , p1.hiredate , count(*)
from professor  p1
left outer  join professor  p2 
on  p1.hiredate  >   p2.hiredate 
group by  p1.profno, p1.name , p1.hiredate;



 

 
select p1.profno, p1.name , p1.hiredate , count(*)
from professor  p1
left outer    join professor  p2 
on  p1.hiredate  >   p2.hiredate 
group by  p1.profno, p1.name , p1.hiredate;
 
 
 
select p1.profno, p1.name , p1.hiredate , count( p2.hiredate)
from professor  p1
left outer  join professor  p2 
on  p1.hiredate  >   p2.hiredate 
group by  p1.profno, p1.name , p1.hiredate;
 
 
  --그룹바이 되기 전 상태 
select p1.profno, p1.name , p1.hiredate ,  p2.hiredate 
from professor  p1
left outer  join professor  p2 
on  p1.hiredate  >   p2.hiredate ;



-- 6번

select * 
from emp e1
join emp e2
on e1.hiredate > e2.hiredate;

select e1.empno EMPNO, e1.ename ENAME, e1.hiredate HIREDATE, count(e2.hiredate) as COUNT
from emp e1
left outer join emp e2
on e1.hiredate > e2.hiredate
group by e1.empno, e1.ename, e1.hiredate
order by 4;

