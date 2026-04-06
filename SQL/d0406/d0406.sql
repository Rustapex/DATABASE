create table tbl_test_customer(
    id varchar2(20) not null primary key ,
    name varchar2(20) ,
    address varchar2(20),
    tel varchar2(20)
);

create table tbl_test_goods(
  pcode varchar2(20) not null primary key,
  pname varchar(20) ,
  price number(4)
);

create table tbl_test_order(
  ocode varchar2(20) not null primary key,
  odate date,
  id varchar2(20),
 pcode varchar2(20),
 sale_cnt number(6)
);



insert into tbl_test_customer values( 'H001' ,'송주창', '라스베가스', '010-3030-2222');
insert into tbl_test_customer values( 'H002' ,'여도현', 'L.A', '010-2424-2222');
insert into tbl_test_customer values( 'H003' ,'김재민', '워싱턴D.C', '010-1010-2121');
insert into tbl_test_customer values( 'H004' ,'이정하', '뉴욕', '010-3333-2222');
insert into tbl_test_customer values( 'H005' ,'장해든', '텍사스', '010-9090-2222');
insert into tbl_test_customer values( 'H006' ,'김민경', '서울', '010-7878-1234');
commit;

 


insert into tbl_test_goods values('P001' ,'쫀드기', 1000);
insert into tbl_test_goods values('P002' ,'눈깔사탕', 100);
insert into tbl_test_goods values('P003' ,'아폴로', 200);
insert into tbl_test_goods values('P004' ,'뻥튀기', 2000);
commit;


insert into tbl_test_order values('J001' , '20210110' , 'H001', 'P001', 2);
insert into tbl_test_order values('J002' , '20210110' , 'H002', 'P002', 5);
insert into tbl_test_order values('J003' , '20210110' , 'H003', 'P003', 2);
insert into tbl_test_order values('J004' , '20210110' , 'H004', 'P004', 1);
insert into tbl_test_order values('J005' , '20210110' , 'H005', 'P002', 3);
insert into tbl_test_order values('J006' , '20210110' , 'H001', 'P002', 3);
insert into tbl_test_order values('J007' , '20210110' , 'H002', 'P001', 1);
insert into tbl_test_order values('J008' , '20210110' , 'H001', 'P002', 4);
 commit;


 -- 고객 별 판매급액 조회
 desc prod_sales;
 
 select cust_nm, sum(sales_amt) "판매 금액"
 from prod_sales
 group by cust_nm;
 
// sql  조인 표준 

SELECT  name, address, tel, odate, pname, sale_cnt, price, sale_cnt * price
FROM   tbl_test_order o
JOIN     tbl_test_customer c
ON       o.id = c.id
JOIN     tbl_test_goods g
ON       o.pcode = g.pcode ;




SELECT   *
FROM   tbl_test_order o
JOIN     tbl_test_customer c
ON       o.id = c.id;
 


SELECT   *
FROM   tbl_test_order o
JOIN     tbl_test_customer c
ON       o.id = c.id
JOIN     tbl_test_goods g
ON       o.pcode = g.pcode ;
-----

SELECT * FROM TBL_TEST_CUSTOMER; // 고객
SELECT * FROM TBL_TEST_goods; // 상품
SELECT * FROM TBL_TEST_order; // 주문

desc TBL_TEST_order;
desc TBL_TEST_CUSTOMER;

-- 주문 정보 조회하기( 주문일자, 주문자 이름, 구매 수량)
select *
from tbl_test_order o
join tbl_test_customer c
on o.id = c.id;

select o.odate, c.name, o.sale_cnt
from tbl_test_order o
join tbl_test_customer c
on o.id = c.id;

select o.odate, c.name, o.sale_cnt
from tbl_test_order o
inner join tbl_test_customer c
on o.id = c.id;

-- 고객 테이블에 자기 정보 insert
insert into tbl_test_customer values( 'SYS' ,'손영석', '빈', '010-9999-1111');
COMMIT;

--주문일자, 상품명, 상품단가, 주문 수량, 주문금액 조회하기
desc TBL_TEST_goods;

select odate, sale_cnt
from tbl_test_order;

select pname, price
from TBL_TEST_goods ;

select o.odate, g.pname, g.price, o.SALE_CNT, g.price * o.sale_cnt as "주문금액" 
from tbl_test_order o
inner join TBL_TEST_goods g
on o.pcode = g.pcode;




-- 주문일자, 고객명, 고객 전화번호, 상품이름, 상품 단가, 주문수량, 주문금액 -조회

select o.odate "주문일자", c.name "고객명", c.tel "고객전화번호", g.pname "상품이름", 
    g.price"상품단가", o.sale_cnt "주문수량", g.price * o.sale_cnt "주문금액" 
from TBL_TEST_goods g
inner join tbl_test_order o
on o.pcode = g.pcode
inner join tbl_test_customer  c
on o.id = c.id;

desc TBL_TEST_goods;
desc tbl_test_order;
desc tbl_test_customer;

-- 고객별 주문 수량 합계 출력

select c.name, sum(o.sale_cnt) as orderCnt
from tbl_test_order o
inner join tbl_test_customer c
on o.id = c.id
group by c.name
order by orderCnt asc;



-- 세부적인 집계

select * from member_tbl_11;

select m_grade , m_point
from member_tbl_11
order by m_grade;

-- 고객 등급 별 포인트 합
select m_grade ,sum(m_point)
from member_tbl_11
where m_point is not null
group by m_grade
order by 1;

-- 포인트가 5000이상인 것만 조회하기
select m_grade, sum(m_point)
from member_tbl_11
where m_point is not null
group by m_grade
having sum(m_point) >= 5000
order by 1;


--EMP
DESC EMP;

--전체 SAL 의 합계
SELECT SUM(SAL) AS "TOTAL_SUM"
FROM EMP;

-- 직급별 SAL의 합계
SELECT JOB, SUM(SAL) "JOB_SUM"
FROM EMP
GROUP BY JOB;

-- 직급별 SAL의 합계 3000이상만 
SELECT JOB, SUM(SAL) "JOB_SUM"
FROM EMP
GROUP BY JOB
HAVING SUM(SAL) >= 3000;

-- 직급별 SAL의 합계 3000이상만 , 숫자 천단위 구분
SELECT JOB, TO_CHAR(SUM(SAL), '99,999') "JOB_SUM" 
FROM EMP
GROUP BY JOB
HAVING SUM(SAL) >= 3000
ORDER BY JOB_SUM DESC;




-- 교재 59p
-- 집합 연산자( 행 합치기 )
-- union , union all, intersect, minus
-- 두 테이블 행 합치기( 칼럼 수, 칼럼 타입 같아야)

-- 21-1. UNION 중복 제거 후 합집합, 정렬(실제로는 정렬 아님)
SELECT deptno FROM emp
UNION
SELECT deptno FROM professor;

select studno, name, 1
from student
where deptno1 = 101;

select profno, name, deptno1
from professor
where deptno = 101;

select studno, name, deptno1
from student
where deptno1 = 101
union
select profno, name, deptno
from professor
where deptno = 201;

-- UNION ALL 중복 제거 없이 모두 합침  union 보다 더 빠른 경우가 많다. 이유: 중복 제거 작업 x
SELECT deptno FROM emp
UNION ALL
SELECT deptno FROM professor;

select studno, name, deptno1
from student
where deptno1 = 101
union all
select profno, name, deptno
from professor
where deptno = 201;

-- INTERSECT 교집합
SELECT deptno FROM emp
INTERSECT
SELECT deptno FROM professor;

select studno, name
from student
where deptno1 = 101
INTERSECT
select studno, name
from student
where deptno2 = 201;

-- MINUS (Oracle) / EXCEPT (MySQL) 차집합 (A MINUS B) == (A-B)
SELECT deptno FROM EMP;

SELECT DEPTNO FROM PROFESSOR;

SELECT deptno FROM emp
MINUS
SELECT deptno FROM professor;


desc TBL_TEST_goods;
desc tbl_test_order;
desc tbl_test_customer;

--3) 고객별상품별 주문수량의 합계 구하기

select c.id "고객", o.pcode "상품" , SUM(o.sale_cnt) "주문수량 합계"
from  tbl_test_customer c
inner join tbl_test_order o
on o.id = c.id
group by c.id, o.pcode;

--4) 고객별상품별 주문금액의 합계 구하기
select c.id "고객", o.pcode "상품" , SUM(o.sale_cnt * g.price) "주문금액 합계" 
from  tbl_test_customer c
inner join tbl_test_order o
on o.id = c.id
inner join TBL_TEST_goods g
on o.pcode = g.pcode
group by c.id, o.pcode;

-- 교재) 233 페이지   사용예2
desc student;
desc professor;

select s.name "학생이름", p.name "교수이름"
from student s
inner join professor p
on s.profno = p.profno;

-- 교재) 234 페이지   사용예3
desc department;
select s.name "학생이름",d.dname "학과이름", p.name "교수이름"
from  professor p
inner join student s
on s.profno = p.profno
inner join department d
on s.deptno1 = d.deptno;

select s.name "학생이름",d.dname "학과이름", p.name "교수이름"
from  professor p
inner join student s
on s.profno = p.profno
inner join department d
on s.deptno1 = p.deptno or s.deptno2 = p.deptno and d.deptno = p.deptno;

-- 교재) 254 페이지   연습문제 1번만
select s.name "학생이름",s.deptno1 "학과번호", d.dname "학과이름"
from student s
inner join department d
on s.deptno1 = d.deptno;

--decode() :if 문 [case when 보다 간단]
select m_grade , decode( m_grade , '01', 'vvip', '02', 'vip', '03', 'gold') as tier
from member_tbl_11;

-- 가로 집계

select job, decode(job, 'CLERK', 9)
FROM EMP;

select COUNT( decode(job, 'CLERK', 9)) // JOB에서 CLEAK 개수 반환, 9 는 0 이여도 상관 없음
FROM EMP; // CLEAK 인 건만 숫자로 변환 , 나머지는 NULL 그 결과로 집계

select count( decode(job, 'CLERK', 9)) "clerk", 
    count (DECODE(JOB,'SALESMAN', 9)) "salesman", 
    count (DECODE(JOB,'MANAGER', 9)) "manager",
    count (DECODE(JOB,'ANALYST', 9)) "analyst",
    count (DECODE(JOB,'PRESIDENT', 9)) "president"
FROM EMP;
