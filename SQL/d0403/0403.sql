-- 복습
-- initcap(char) 첫글자만 대문자, lower(char), upper(char)
-- char ||char only oracle , concat(char , char) mysql, oracle
--  char substr(char, start_index, length) 음수 인덱스 가능  / 인덱스 시작 1 2 3 4
-- integer instr(char1, char2) char1에서 char2 가 언제 처음 나오냐? index 반환
-- dual 수식 계산, 표현식 계산시 더미 테이블

--78p 사용 예1
select name, tel, instr(tel, ')')
from student
where deptno1 = 201;

-- 79P 사용 예2
SELECT name, tel, instr(tel,'3')
from student
where deptno1 = 101;

-- 79p substr/instr quiz
desc student;

select name, tel, substr(tel, 1, (instr(tel, ')')-1)) as "AREA CODE"
from student
where deptno1 = 201;

-- 채우기 함수
-- 80p LPAD(char, length [, pad_string]) / 의미: 왼쪽을 채워서 길이 맞춤 / 형식: LPAD(문자열, 전체길이, 채울문자)
-- RPAD(char, length [, pad_string]) 의미: 오른쪽을 채워서 길이 맞춤
select name, id, lpad(name, 10, '*') as nameToStar
from student;

-- 공백/문자 제거: LTRIM, RTRIM, TRIM
-- LTRIM(char [, set]) 의미: 왼쪽에서 제거
-- RTRIM(char [, set]) 의미: 오른쪽에서 제거
-- TRIM([LEADING|TRAILING|BOTH] 제거문자 FROM 문자열) 의미: 양쪽 또는 한쪽 제거

select '        a' as "공백제거 전" , ltrim('        a', ' ') as "공백제거 후"
from dual;
SELECT 'AASQLAA' AS "여기서", TRIM('A' FROM 'AASQLAA') AS "A 양쪽 제거" FROM dual;


-- 치환: REPLACE, REGEXP_REPLACE
-- REPLACE(char, search_string [, replacement_string]) / 의미: 특정 문자열 치환 / 형식: REPLACE(문자열, 찾을값, 바꿀값)
-- REGEXP_REPLACE(source_char, pattern [, replace_string ...]) / 의미: 정규표현식 기반 치환

-- 이름 첫글자만 별로
SELECT ENAME, REPLACE(ENAME,SUBSTR(ENAME, 1,1), '*') AS "첫글자만 별"
FROM EMP;


-- 80P 사용 예
DESC STUDENT;
SELECT LPAD(ID, 10, '*')
FROM STUDENT
WHERE DEPTNO1 = 201;

-- 84P 퀴즈 1
DESC EMP;
SELECT ENAME, REPLACE(ENAME, SUBSTR(ENAME, 2,2), '--') AS "REPLACE" 
FROM EMP
WHERE DEPTNO = 20;

-- 84P 퀴즈 2
SELECT NAME, JUMIN, REPLACE(JUMIN, SUBSTR(JUMIN,8,7) , '-/-/-/-') "REPLACE"
FROM STUDENT
WHERE DEPTNO1 = 101;

-- 85P 퀴즈 3
-- 1. ) 까지 INSTR 길이 구하기, -까지 길이 구하기 , 빼기 SUBSTR 하기
-- 2. LPAD와 INSTR로 "*" 개수 맞추기
-- 3. REPLACE 하기 전체 , 1 만큼, 2로 바꾸기
-- 4. WHERE 붙히기

-- 1 2 3 4 5 6 7 8 9 10 11
-- 0 2 )  3 0 1 - 1 5 7   4

select  name, 
        tel, 
	    replace ( 
            tel, 
		    SUBSTR(
                tel,  
                INSTR(TEL, ')') +1,   			--  3+1 =4 부터
		        INSTR(TEL, '-') - INSTR(TEL, ')') -1 -- 7 - 3 - 1 = 3 길이만큼
            ),  		
		    LPAD('*' , INSTR(TEL, '-') - INSTR(TEL, ')' ) -1 , '*' ) -- 7 - 3 - 1 = 3 만큼 * 추가
	    ) AS REPLACE
from student
where deptno1 = 102;

-- replace 사용 x 버전
select name, 
       tel,
       substr(tel, instr(tel, ')') )
       || rpad('*' , instr(tel, '-') - instr(tel, ')') -1 , '*')
       || substr(tel, instr(tel, '-')) as "REPLACE"
FROM STUDENTWHERE 
WHERE DEPTNO1 = 102;

-- 85P 퀴즈 4
select name, tel, 
replace(tel, substr(tel, instr(tel, '-')+1 ,4) , '****') as "REPLACE"
from student
where deptno1 = 101;

--숫자 관련 함수
-- ROUND / 의미: 반올림 /  형식: ROUND(number [, decimal_places]) 
-- TRUNC / 의미: 버림 / 형식: TRUNC(number [, decimal_places])

select round(1234.5678, 0) from dual;
select trunc(1234.5678, -1) from dual;

-- MOD / 의미: 나머지 / 형식: MOD(a, b)
select mod (11,3) from dual;

-- CEIL / 의미: 올림(주어진 수에서 가까운 큰 정수 3.56 -> 4)
select ceil(3.56) from dual;

-- floor / 의미 : 주어진 숫에서 가까운 작은 정수 3.56 -> 3 
select floor(-3.46) from dual;


--  날짜 관련 함수(89p)

-- 현재 날짜 구하기
select sysdate from dual;

-- 날짜 - 날짜 = 수(일 수) / 날짜 + 3 -> 이후 날짜 / 날짜 -3 -> 이전 날짜

-- double months_between(이후, 이전날짜)
select months_between(sysdate, '2026-01-22') from dual; 

-- last_day() 함수
-- 정해진 날짜가 포함된ㄴ 달의 마지막 날 구하기
select sysdate from dual;
select las_day(sysdate) from dual;

-- next_day()
select sysdate , next_day(sysdate, '월') from dual;

--날짜 , 년 ,월, 일 가져오기 

SELECT  SYSDATE FROM DUAL;

SELECT  
    SYSDATE,
    EXTRACT( YEAR FROM SYSDATE) ,
     EXTRACT( MONTH FROM SYSDATE) ,
      EXTRACT( DAY FROM SYSDATE)     
FROM DUAL;



-- 형변환

-- 문자 : VARCHAR2, CHAR 
-- 숫자 : NUMBER
-- 날짜 : DATE

-- 수- > 문 (천단위, 통화단위)
-- 날 -> 문 (원하는 표시형식으로 지정하고 싶을 때)
-- 문 -> 수
-- 문 -> 날

-- to_number()
-- to_char()
-- to_date()


-- 명시적 형변환 -- 묵시적 형변환
select 2+ '2' from dual;

select 2 + to_number('2') from dual;

--TO_CHAR()  : 숫자, 날짜를 문자로 형변환 하는 것
SELECT  SYSDATE  FROM DUAL;
SELECT  TO_CHAR(SYSDATE ,  'YYYY-MM-DD' )  FROM DUAL;
SELECT  TO_CHAR(SYSDATE , 'YYYY/MM/DD')  FROM DUAL;
SELECT  TO_CHAR(SYSDATE , 'YYYY')  FROM DUAL;
SELECT  TO_CHAR(SYSDATE , 'MM')  FROM DUAL;
SELECT  TO_CHAR(SYSDATE , 'DD')  FROM DUAL;
SELECT  TO_CHAR(SYSDATE , 'DAY')  FROM DUAL;
SELECT  TO_CHAR(SYSDATE , 'DY')  FROM DUAL;

-- 시 분초

select to_char(sysdate, 'yyyy-mm-dd : hh24:mi:ss') from dual;

-- 숫자를 문자로

select * from acorntbl;

select name, to_char(point, '999,999') from acorntbl;
select name, to_char(point, 'L999,999') from acorntbl;
select name, to_char(point, '$999,999') from acorntbl;
select name, to_char(point, 'L099,999') from acorntbl;


select sysdate from dual;
select to_char(sysdate, 'yyyy-mm-dd') from dual;

-- 형변환 주의사항 같은 형끼리는 당연히 변환 안돼

--105p 형변환 퀴즈 1
DESC STUDENT;
SELECT STUDNO, NAME, BIRTHDAY
FROM STUDENT
WHERE TO_CHAR(BIRTHDAY, 'MM') = '01';

-- 106P 형변환 퀴즈 2 
DESC EMP;
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') IN ('01','02','03');

SELECT EMPNO, HIREDATE
FROM EMP
ORDER BY TO_NUMBER(TO_CHAR(HIREDATE,'MM'));


-- 107p 사용 예 1
desc emp;
select empno, ename, sal,comm, to_char(sal*12+comm, '999,999') as "연봉" 
from emp
where ename = 'ALLEN';

-- 107p 사용예 2
select name, pay, bonus BONUS, to_char(pay*12+bonus) as "연봉"
from professor
where deptno = 201;

-- 108p 형변환 퀴즈 3
DESC EMP;
SELECT EMPNO, ENAME, 
TO_DATE(HIREDATE, 'YYYY-MM-DD') AS HIREDATE, 
TO_CHAR(SAL*12+COMM, '$99,999') AS SAL, 
TO_CHAR((SAL*12 + COMM)*1.15, '$99,999') AS "15% UP"
FROM EMP
WHERE COMM IS NOT NULL;


--nvl nvl2 

-- 112P NVL 함수 퀴즈
DESC PROFESSOR;
SELECT PROFNO, NAME, PAY, BONUS, (PAY * 12 + NVL(BONUS,0)) AS TOTAL
FROM PROFESSOR
WHERE DEPTNO = 201;

-- 113P NVL2 함수 퀴즈
DESC EMP;
SELECT EMPNO, ENAME, COMM, NVL2(COMM, 'Exist', 'NULL') AS "NVL2"
FROM EMP
WHERE DEPTNO = 30;

-- case when
-- 123p case문 퀴즈
desc emp;
select empno, ename, sal, 
    case when sal >= 1 and sal <= 1000 then 'LEVEL 1'
        when sal <= 2000 then 'LEVEL 2'
        when sal <= 3000 then 'LEVEL 3'
        when sal <= 4000 then 'LEVEL 4'
        when sal >= 4001 then 'Level 5'    
    end as "LEVEL"
from emp;


-- decode()
-- IF문 (조건이 같은 것만 사용 가능)
SELECT * FROM MEMBER_TBL_11;

SELECT M_NAME, M_GRADE ,
    DECODE (M_GRADE, '01', 'VVIP', '02', 'VIP', '03', 'GOLD', '해당사항없음')
FROM MEMBER_TBL_11;

SELECT DEPTNO, NAME, DECODE(DEPTNO, 101, DECODE(NAME, 'Audie Murphy', 'BEST!!!', 'GOOD')) FROM PROFESSOR;

SELECT * FROM PROFESSOR;

-- 복수행 함수
-- 전체 합계, 전체 평균, 전체 개수 : 집계 함수는 null을 제외하고 집계함
-- sum(), avg(), max(), min()


-- 156P 복수행 함수
-- 전체 합계, 전체 평균

SELECT SUM(SAL) sumAllSal, count(sal) countSal FROM EMP;
-- 집계함수는 null 제외시킨다.

select sum(sal), avg(sal), count(sal), count(comm), max(sal), count(*) from emp;


-- group by

-- 1. 그룹별 집계 내기 전 단계 만들기
-- 2. 데이터를 보면서 눈으로 집계 내보기
-- 3. 그룹별 집계 ()

SELECT SUM(M_POINT) FROM MEMBER_TBL_11;

SELECT M_GRADE, M_POINT
FROM MEMBER_TBL_11
ORDER BY 1;

SELECT M_GRADE, SUM(M_POINT) --3
FROM MEMBER_TBL_11 --1
GROUP BY M_GRADE; --2

-- 등급별 포인트 합 구하기
-- 등급별 포인트 합이 5000이상인 것만 조회되도록 하시오 / 작성 순서 2개는 바꿔도 상관 없다.
SELECT M_GRADE, SUM(M_POINT) AS TOTAL
FROM MEMBER_TBL_11
GROUP BY M_GRADE
HAVING SUM(M_POINT) >= 5000
order by total; -- order by 에서는 select alias 사용 가능


-- 등급별 합계 구하기
SELECT M_GRADE, SUM(M_POINT)
FROM MEMBER_TBL_11
GROUP BY M_GRADE;

-- 등급 별 합계에서 5000이상인 것만 조회
SELECT M_GRADE, SUM(M_POINT)
FROM MEMBER_TBL_11
GROUP BY M_GRADE
HAVING SUM(M_POINT) >= 5000;

