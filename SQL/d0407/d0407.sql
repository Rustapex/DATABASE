-- 교재 165p
-- roll up()

-- Oracle은 ROLLUP을 GROUP BY의 확장으로 설명하고, 상세 그룹 → 상위 소계 → 총계 를 한 번에 만든다고 해. 세 컬럼이면 n+1개의 그룹이 생긴다고 되어 있어.

--가장 중요한 정의는 이거야:
--
-- ROLLUP(a, b, c)
-- GROUPING SETS ((a,b,c), (a,b), (a), ())
--
--즉, 오른쪽 컬럼부터 하나씩 벗겨지면서 소계가 만들어진다

desc tbl_test_order;
desc tbl_test_goods;
desc tbl_test_customer;

select c.name, sum(o.sale_cnt* g.price)
from tbl_test_customer c
join tbl_test_order o
    on o.id = c.id
join tbl_test_goods g
    on o.pcode = g.pcode
group by c.name;

-- rollup
select nvl(c.name, 'total') as name, sum(o.sale_cnt* g.price) as SUM
from tbl_test_customer c
join tbl_test_order o
    on o.id = c.id
join tbl_test_goods g
    on o.pcode = g.pcode
group by rollup(c.name);

-- group by
SELECT c.NAME "고객", g.pname "상품", sum(o.sale_cnt* g.price) as SUM
from tbl_test_customer c
join tbl_test_order o
    on o.id = c.id
join tbl_test_goods g
    on o.pcode = g.pcode
GROUP BY c.NAME, g.PNAME;
-- 고객, 상품 별 판매금액 (GROUP BY +  ROLLUP() )
SELECT nvl(c.NAME, 'TOTAL') "고객", 
        nvl(g.pname, 'SUBTOTAL') "상품", 
        sum(o.sale_cnt* g.price) as SUM
from tbl_test_customer c
join tbl_test_order o
    on o.id = c.id
join tbl_test_goods g
    on o.pcode = g.pcode
GROUP BY rollup(c.NAME, g.PNAME);
-- 상품 , 고객별 소계 (GROUP BY + ROLLUP() )
SELECT nvl(c.NAME, 'subtotal') "고객", 
        nvl(g.pname, 'total') "상품", 
        sum(o.sale_cnt* g.price) as SUM
from tbl_test_customer c
join tbl_test_order o
    on o.id = c.id
join tbl_test_goods g
    on o.pcode = g.pcode
GROUP BY rollup(g.PNAME, c.name);


-- 교재 167p

-- 부서별, 직업별 평균 급여 및 사원 수
-- 부서별 평균 급여와 사원 수
-- 전체 사원의 평균 급여와 사원 수

desc emp;
select deptno, job, avg(sal), count(*)
from emp
group by deptno, job;

select nvl(to_char(deptno), 'total') as 부서번호, nvl(job, 'subtotal') 직업, round(avg(sal),1) 평균, count(*) 사원수
from emp
group by rollup(deptno, job)
order by 1,2;

-- over() 형식
--함수명(대상컬럼) OVER (
--    PARTITION BY 그룹기준
--    ORDER BY 정렬기준
--    ROWS 또는 RANGE ...
--)


-- 205p

-- sum( p_total) over (order by p_total)
-- sum(p_total ) over -- p_total 전체합계
-- sum() over()
 --[partiton  by]
 --[order by]
 --[range, rows]) , range 는 기존 값이 같으면 하나로 인식해서 누적
select p_date, 
    p_total, 
    sum(p_total) over()
from panmae;

-- 전체 합계 빈 매개변수
select p_date, p_total, sum(p_total) over() 
from panmae;

-- p_total 누적
select p_date, p_total, sum(p_total) over( order by p_total) 
from panmae;

-- p_date 누적
select p_date, p_total, sum(p_total) over( order by p_date)  
from panmae;

-- rows 변경
select p_date, p_total, sum(p_total) over( order by p_date)  
from panmae;

-- 한 행씩 누적
select p_date, p_total, 
    sum(p_total) over(
        order by p_total
        rows between unbounded preceding and current row 
   ) as over
from panmae;

-- 파티션 나누기
select p_date, p_total, 
    sum(p_total) over(
        partition by p_store
        order by p_total
        rows between unbounded preceding and current row 
   ) as over
from panmae;

-- sum(누적 할 값이 있는 칼럼명) 
--    over(
--        [partitioni by 칼럼명]
--        [order by 기준 컬럼명]
--        [range(기본값) || rows ] between unbounded preceding and current row)

-- emp table
-- 직급별, sal 누적액 구하기
desc emp;

select job, sal,
    sum(sal) over(
        partition by job
        order by sal
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  as sum
from emp;


-- sal 누적액 구하기

select ename, sal, 
    sum(sal) over(
    order by ename
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  as sum
from emp;

-- range, rows 변경하기

-- 205p 사용예1
desc panmae;
select p_date, p_code, p_qty,  p_total, 
    sum(p_total) 
        over(order by p_date) "total"
from panmae
where p_store = '1000';

--205p 사용예 2
select p_date, p_code, p_qty,  p_total, 
    sum(p_total) 
        over(
        partition by p_code
        order by p_date) total
from panmae
where p_store = '1000';

-- 206p 사용예 3
select p_code, p_store, p_date, p_qty,  p_total, 
    sum(p_total) 
        over(
        partition by p_store
        order by p_date) total
from panmae;

-- rank 순위 구하기







-- decode()사용해서 열 집계 만들기
-- 교재 196

-- rank() over( order by 칼럼명)
--RANK() OVER (ORDER BY 컬럼 DESC)
--RANK() OVER (PARTITION BY 칼럼명 ORDER BY 칼럼명 DESC)

desc acorntbl;
select name, point
from acorntbl
order by point desc;

--RANK	                동점 허용, 순위 건너뜀 (1,1,3)
select name, point, 
    rank() over( order by point desc) as 등수
from acorntbl;

select job, ename, sal,
    rank() 
        over(
            order by sal desc) as "월급 등수" 
from emp;


--DENSE_RANK	동점 허용, 안 건너뜀 (1,1,2)
select name, point, 
    dense_rank() over( order by point desc) as 등수
from acorntbl;

desc emp;

select job, ename, sal,
    dense_rank() 
        over(
            partition by job
            order by sal desc) as "월급 등수" 
from emp;



select name, point,
    rank() over(
        order by point desc) as rank,
    dense_rank() over(
        order by point desc) as rankDense,
    row_number() over(
        order by point desc) as rankRow
from acorntbl;

-- 194p 
--lag(출력할 컬럼명, offset(몇번째 이전), 기본 출력값) over(partition ~ , order by ~) :  이전행 
--/ lead(칼럼명, 몇번째 이후, 기본값) : 다음행

desc emp;
select ename, sal,
    lag(sal, 2,0) over(order by sal) as lag
from emp;

select ename, sal,
    lead(sal,1,0) over (order by sal) lead
from emp;


-- 전체에 대해서 비율 구하기
desc acorntbl;

select name, point,
    round(point / sum(point) over() * 100 , 1) as "포인트 비율"
from acorntbl
order by "포인트 비율" desc;


-- ratio_to_report
select name, point,
    trunc(ratio_to_report(point) over(), 3) * 100 as "비율"
from acorntbl
order by "비율" desc;

desc emp;


--ROW_NUMBER	무조건 고유 순위 (1,2,3)











-- 210~213 연습문제 이거 오후에 실습