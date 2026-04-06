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




