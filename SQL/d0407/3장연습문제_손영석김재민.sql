-- 210~213 연습문제 이거 오후에 실습


-- 1. emp 테이블을 사용해 sal, comm을 합친 금액이 
--가장 많은 경우와, 가장 적은 경우, 평균 금액을 구하세요.
--단 COMM이 없을 경우는 보너스를 0으로 계산하고, 출력금액소수점 첫째자리
SELECT * FROM EMP;
desc emp;

-- COMM 이 없을 경우
-- DECODE(COMM, NULL, 0 , COMM))  COMM이 NULL이면 0 , IS NOT NULL이면 COMM

select
    max( sal + decode(comm, null, 0, comm)) MAX,
    MIN( sal + decode(comm, null, 0, comm)) MIN,
    TRUNC(AVG( sal + decode(comm, null, 0, comm)) ,1) AVG
FROM EMP;    



-- 2. STUDENT TABLE의 BIRTHDAY 칼럼을 참조해서 아래와 같이 월별로 생일자 수를 출력하세요.

DESC STUDENT;

-- 월별로 분해하기 
-- PIVOT 안쓰고 풀기
SELECT
    COUNT(days) || 'EA' AS TOTAL,
    COUNT(DECODE(days, '01', '01')) || 'EA' AS JAN,
    COUNT(DECODE(days, '02', '02')) || 'EA' AS FEB,
    COUNT(DECODE(days, '03', '03')) || 'EA' AS MAR,
    COUNT(DECODE(days, '04', '04')) || 'EA' AS APR,
    COUNT(DECODE(days, '05', '05')) || 'EA' AS MAY,
    COUNT(DECODE(days, '06', '06')) || 'EA' AS JUN,
    COUNT(DECODE(days, '07', '07')) || 'EA' AS JUL,
    COUNT(DECODE(days, '08', '08')) || 'EA' AS AUG,
    COUNT(DECODE(days, '09', '09')) || 'EA' AS SEP,
    COUNT(DECODE(days, '10', '10')) || 'EA' AS OCT,
    COUNT(DECODE(days, '11', '11')) || 'EA' AS NOV,
    COUNT(DECODE(days, '12', '12')) || 'EA' AS DEC
FROM (
    SELECT TO_CHAR(BIRTHDAY, 'MM') AS days
    FROM STUDENT
);

-- PIVOT
--SELECT *
--FROM (
--    SELECT 기준행컬럼, 피벗기준컬럼, 값컬럼
--    FROM 테이블
--)
--PIVOT (
--    집계함수(값컬럼)
--    FOR 피벗기준컬럼 IN ('값1' AS 별칭1, '값2' AS 별칭2)
--);


     
SELECT JAN+FEB+MAR+APR+MAY+JUN+ JUL+AUG+SEP+OCT+NOV+DEC AS TOTAL,
 JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC
FROM (
    SELECT TO_CHAR(BIRTHDAY, 'MM') AS days
    FROM STUDENT
)
PIVOT (
    COUNT(*)
    FOR days IN (
        '01' AS JAN,
        '02' AS FEB,
        '03' AS MAR,
        '04' AS APR,
        '05' AS MAY,
        '06' AS JUN,
        '07' AS JUL,
        '08' AS AUG,
        '09' AS SEP,
        '10' AS OCT,
        '11' AS NOV,
        '12' AS DEC
    )
);


--3. 지역별 인원수

desc student;
select tel from student;

-- 지역별 분리 서브쿼리
select substr(tel, 1, instr(tel, ')')-1) 
from student;


select SEOUL +GYEONGGI +BUSAN +ULSAN +DAEGU +GYEONGNAM AS TOTAL,
    SEOUL, GYEONGGI, BUSAN, ULSAN, DAEGU, GYEONGNAM
FROM (
    select substr(tel, 1, instr(tel, ')')-1)  as reg
    from student
)
PIVOT (
    COUNT(*)
    FOR reg IN (
        '02' AS SEOUL,
        '031' AS GYEONGGI,
        '051' AS BUSAN,
        '052' AS ULSAN,
        '053' AS DAEGU,
        '055' AS GYEONGNAM
    )
);

desc emp;

-- 4. 
insert into emp (empno,deptno, ename, sal)
values(1000, 10, 'Tiger', 3600);
insert into emp (empno, deptno, ename, sal)
values (2000, 10, 'Cat', 3000);
commit;

select empno, ename, job, sal
from emp;

-- group by 부서별 급여 합계
select deptno, sum(sal)
from emp
group by deptno
order by deptno;

-- decode 사용
select nvl(to_char(deptno), 'TOTAL') AS deptno, 
    sum(decode(job, 'CLERK', sal, 0)) AS CLERK,
    sum(decode(job, 'MANAGER', sal, 0)) AS MANAGER,
    sum(decode(job, 'PRESIDENT', sal, 0)) AS PRESIDENT,
    sum(decode(job, 'ANALYST', sal, 0)) AS ANALYST,
    sum(decode(job, 'SALESMAN', sal, 0)) AS SALESMAN,
    sum(sal) as total
from emp
group by rollup(deptno)
order by deptno;


-- pivot (total 부분은 고민 필요)
SELECT NVL(TO_CHAR(deptno), 'TOTAL') AS deptno,
       NVL(clerk, 0) AS clerk,
       NVL(manager, 0) AS manager,
       NVL(president, 0) AS president,
       NVL(analyst, 0) AS analyst,
       NVL(salesman, 0) AS salesman,
       NVL(clerk, 0) + NVL(manager, 0) + NVL(president, 0) 
       + NVL(analyst, 0) + NVL(salesman, 0) AS total
FROM (
    SELECT deptno, job, sal
    FROM emp
)
PIVOT (
    SUM(sal)
    FOR job IN (
        'CLERK' AS clerk,
        'MANAGER' AS manager,
        'PRESIDENT' AS president,
        'ANALYST' AS analyst,
        'SALESMAN' AS salesman
    )
)
ORDER BY deptno;
        

-- 5. emp 테이블 ,직원 전체 급여, 누적 급여 금액 / 급여 오름차순 정렬

desc emp;
select deptno, ename, sal, 
    sum(sal) over(
    order by sal asc) as total
from emp;


-- 7.
select 
    TOTAL || 'EA (' || ROUND(TOTAL / TOTAL * 100, 1) || '%)' AS TOTAL,
    SEOUL || 'EA (' || ROUND(SEOUL / TOTAL * 100, 1) || '%)' AS SEOUL,
    GYEONGGI || 'EA (' || ROUND(GYEONGGI / TOTAL * 100, 1) || '%)' AS GYEONGGI,
    BUSAN || 'EA (' || ROUND(BUSAN / TOTAL * 100, 1) || '%)' AS BUSAN,
    ULSAN || 'EA (' || ROUND(ULSAN / TOTAL * 100, 1) || '%)' AS ULSAN,
    DAEGU || 'EA (' || ROUND(DAEGU / TOTAL * 100, 1) || '%)' AS DAEGU,
    GYEONGNAM || 'EA (' || ROUND(GYEONGNAM / TOTAL * 100, 1) || '%)' AS GYEONGNAM
    
from(select SEOUL +GYEONGGI +BUSAN +ULSAN +DAEGU +GYEONGNAM AS TOTAL,
    SEOUL, GYEONGGI, BUSAN, ULSAN, DAEGU, GYEONGNAM
FROM (
    select substr(tel, 1, instr(tel, ')')-1)  as reg
    from student
)
PIVOT (
    COUNT(*)
    FOR reg IN (
        '02' AS SEOUL,
        '031' AS GYEONGGI,
        '051' AS BUSAN,
        '052' AS ULSAN,
        '053' AS DAEGU,
        '055' AS GYEONGNAM
    )
));


-- 8. 
select deptno, ename, sal, 
    sum(sal) over(
    partition by deptno
    order by sal asc) as total
from emp
order by deptno asc;

-- 9.
select deptno, ename, sal, total_sal, round(sal/total_sal * 100, 2) as "%"
from (select deptno, ename,
    sum(sal) over() as total_sal, sal
    from emp)
order by "%" desc;
    
