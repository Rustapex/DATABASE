-- 400p

-- view / sub query

desc acorntbl;

select name, point, sum(point) over()
from acorntbl;

select name, point, sum(point) over(
-- [partition by]
order by point) as sum
-- [rows | range between unbounded preceding and current row ])
from acorntbl;


select deptno, ename, sal
from emp;


CREATE TABLE t_emp
(
eid VARCHAR2(13) NOT NULL PRIMARY KEY ,
ename VARCHAR2(20) ,
salary NUMBER(5) ,
deptno NUMBER(5) ,
comm NUMBER(5)
);
COMMIT;
INSERT INTO t_emp VALUES ('e001' , '신동엽' , 280,10,100) ;
INSERT INTO t_emp VALUES ('e002' , '유재석' , 250,20,50) ;
INSERT INTO t_emp VALUES ('e003' , '전현무' , 190,30,0) ;
INSERT INTO t_emp VALUES ('e004' , '양세영' , 300,20,0) ;
INSERT INTO t_emp VALUES ('e005' , '양세찬' , 290,40,100) ;
CREATE TABLE t_dept
(
deptno NUMBER(5) NOT NULL PRIMARY KEY ,
dname VARCHAR2(20)
);

INSERT INTO t_dept VALUES (10 , '영업팀') ;
INSERT INTO t_dept VALUES (20 , '기획팀') ;
INSERT INTO t_dept VALUES (30 , '관리팀') ;
INSERT INTO t_dept VALUES (40 , '마케팅팀') ;
INSERT INTO t_dept VALUES (50 , '재무팀');
commit;

desc t_dept;
desc t_emp;




-- 뷰 사용 이유 : 보안 (컬럼 숨기기), 사용자 편의성 / 쿼리 단순화 / 재사용 / 불필요한 정보 재사용 방지


-- 단순뷰(simple view) : 보통 하나의 기본 테이블(base table) 에서 만든 뷰를 말한다.

-- 복합뷰(complex view) : 보통 아래 같은 경우를 묶어 부른다.

--여러 테이블 JOIN
--GROUP BY, DISTINCT, 집계
--때로는 서브쿼리 포함

-- 인라인뷰 (Oracle - inline viewMySQL - derived table)
-- FROM 절의 서브쿼리 결과를 테이블처럼 사용하는 것


-- create vew 

-- 단순뷰 ( table 하나로 만든 뷰)
create view t_view (deptno, dname)
as
    select deptno, ename
    from t_emp;
    
-- 복합뷰 ( join query )

create view t2_view (ename, salary, dname)
as
    select e.ename, e.salary, d.dname
    from t_emp e
    join t_dept d
    on e.deptno = d.deptno;
    
select * from t2_view;


-- 뷰 삭제하기

drop view t2_view;


--뷰사용해 보기 ( 에이콘 몰에서 조회하기  -상품별 판매수량 조회하기  )
--뷰 경험하기
desc tbl_test_customer;
desc tbl_test_goods;
desc tbl_test_order;

create view v_order (pname, pcount)
as
    select g.pname "상품", count(*) as "판매수량"
    from tbl_test_customer c
    join tbl_test_order o
        on c.id = o.id
    join tbl_test_goods g
        on g.pcode = o.pcode
    group by pname;
    
select * from v_order;

drop view v_order;



-- 서브 쿼리 : 쿼리 안에 쿼리가 있는형태
-- 메인 쿼리 : 바깥 쿼리
    
    
-- 2. 서브쿼리가 올 수 있는 위치

--  Oracle 공식 문서는 FROM 절의 서브쿼리를 inline view, 
-- oracle WHERE 절의 서브쿼리를 nested subquery / MySQL derived table

-- WHERE 절
-- 가장 전형적인 위치다.
-- 조건 비교용으로 쓴다.
-- 단일행/다중행/다중컬럼 서브쿼리가 모두

-- 단일행(1행 ~열), 스칼라 서브쿼리 ( 1행1열)
select ename, salary
from t_emp
where salary > (select salary from t_emp where ename = '신동엽');



 


-- 2-2. FROM 절
--  인라인 뷰(Oracle), derived table(MySQL)다.
-- FROM 안에서 “임시 결과 집합”을 테이블처럼 다룬다. 
-- Oracle “FROM clause subquery = inline view / MySQL “derived table

--사용 이유
--복잡한 집계 결과를 먼저 만들고
--그 결과를 바깥에서 다시 JOIN/필터링하려고


--2-3. SELECT 절 :  스칼라 서브쿼리
--여기서는 서브쿼리 결과가 컬럼 한 칸처럼 들어간다.
--그래서 반드시 1행 1열이어야 한다.


-- 3-1. 단일행 서브쿼리 ( 단일칼럼[스칼라 서브쿼리], 다중칼럼 모두 가능)
-- 정의는 “행이 하나만 반환되는 서브쿼리”다.

-- 단일행 서브쿼리에 주로 쓰는 연산자
--   =, <>, !=, >, >=, <, <=
-- Oracle은 ANY, ALL도 비교 연산자와 함께 사용
-- 단일행이면 보통 일반 비교 연산자 전부 가능

--3-2. 다중행 서브쿼리
--정의는 “행이 여러 개 반환되는 서브쿼리”다.
--다중행 서브쿼리에 주로 쓰는 연산자
--
--IN : 여러 값 중 하나와 같으면 참
--NOT IN : 여러 값 모두와 달라야 참
--EXISTS : 결과 행이 한 건이라도 있으면 참
--ANY : 여러 값 중 하나와 비교해 참이면 참
--ALL : 모든 값과 비교해 참이어야 참

--3-3. 다중컬럼 서브쿼리 : 정의는 바깥쪽에서 여러 컬럼을 묶어서 비교하는 서브쿼리
-- 컬럼 수(모양)는 맞아야 / 행 수는 연산자에 따라 다르다

--4. 연관 서브쿼리 / 비연관 서브쿼리
--
--이건 “몇 번 실행되느냐”로 외우면 헷갈린다.
--정의 기준은 실행 횟수가 아니라, 서브쿼리가 바깥 쿼리의 컬럼을 참조하느냐 여부다.

--4-1. 비연관 서브쿼리
--바깥 쿼리와 독립적으로 실행 가능하다.

--4-2. 연관 서브쿼리
-- 서브쿼리 안에서 바깥 쿼리의 값을 참조한다.

--자료형에 따른 차이
--
--여기서 중요한 건 “숫자/날짜/문자열에 따라 연산자가 완전히 달라진다”라기보다,
--그 자료형에 비교가 의미가 있느냐다.

--숫자: >, <, = 자연스럽다
--날짜: >, <, BETWEEN 자연스럽다
--문자열: =, IN, LIKE는 자주 씀. > <도 문법상 가능하지만 
-- 정렬 규칙/문자셋/대소문자 영향 때문에 실무에서 조심해서 쓴다
--실수: 숫자와 같지만, 부동소수 오차 때문에 = 직접 비교는 주의


-- 가장 어린 사람 조회하기
desc acorntbl;

select id, name, birthday
from acorntbl
where birthday = (select max(birthday) from acorntbl) ;

select id, name ,birthday
from acorntbl
order by birthday desc
fetch first 1 row only;

-- 생일이 가장 큰 사람 
select max(birthday) from acorntbl;


desc acorntbl;

-- acorntbl 테이블에서 포인트가 가장 높은 사람의 이름 조회하시오
select name
from acorntbl
order by point desc
fetch first 1 row only;

select name
from acorntbl
where point = (select max(point) from acorntbl);

-- acorntbl 테이블에서 포인트의 평균 이상 사람의 이름 조회

select name
from acorntbl
where point >= (select avg(point) from acorntbl);


-- emp 테이블에서 가장 높은 급여 받는 사람 이름 조회
desc emp;

select ename
from emp
where sal = (select max(sal) from emp);

select ename
from emp
where sal >=  all (select sal from emp);



--429p 연습문제

--1번 
desc student;
desc department;

select s.name STUD_NAME , d.dname DEPT_NAME
from student s
join department d
    on s.deptno1 = d.deptno
where s.deptno1 = (select deptno1 from student where name = 'Anthony Hopkins');



-- 2번
desc professor;
desc department;

select p.name PROF_NAME , p.hiredate HIREDATE , d.dname DEPT_NAME
from professor p
join department d
    on p.deptno = d.deptno
where p.hiredate > (select hiredate from professor where name = 'Meg Ryan');

-- 3번
desc student;

-- 전공 번호별 평균 몸무게 쿼리
-- 일반 쿼리 조인 1번 쿼리
-- where 절에서 비교 
select name, weight
from student
where weight > (select avg(weight) as avg_w
                from student 
                where deptno1 = 201);


    
    

