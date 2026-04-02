-- 단일행 함수 교재 68p, 단일행 함수 , 여러 건의 데이터를 한 번에 하나씩 처리하는 함수
-- 각 행에 대해서 함수가 실행된다.

-- id 대문자로 조회하기
select upper(id) , pw, name
from acorntbl;

-- id 소문자로 조회하기
select lower(id), pw, name
from acorntbl;

-- 문자 함수
-- DB에서는 문자는 문자, 문자열을 구분하지 않는다.  / '' 감싼다.  '을 문자로 사용하고 싶으면 '' 두번 작성

-- DB에서는 1번부터 INDEX 시작
--SUBSTR
SELECT SUBSTR(ID, 1, 2) AS ID2 -- 1번 부터 시작해 길이 2로 잘라서 가공해 출력
FROM ACORNTBL;

--SUBSTRB
SELECT SUBSTRB(ID, -3,3) "ID-3" , '''hiyo' "'buogiorno'" -- 음수 인덱스 가능, 그리고 바이트 기준으로 문자열 잘라냄
FROM ACORNTBL;

-- 소문자변경(lower)
select lower(id) , name
from acorntbl;
-- 대문자 변경(upper)
select upper(id), name
from acorntbl;
-- 첫글자만 대문자 변경
select initcap(id), name
from acorntbl;

--CONCAT(char1, char2)
-- 의미: 두 문자열 연결
-- 형식: CONCAT(문자열1, 문자열2)
select concat(id, name) 
from student;

select id || ' and ' || name "id And Name"
from student;

-- instr(문자열 내에서 특정 문자의 위치를 반환)
select tel , instr(tel, ')') 
from student;

-- NSTR(char, substring [, position [, occurrence]])
-- 의미: 특정 문자열이 시작하는 위치 반환
-- 형식: INSTR(대상문자열, 찾을문자열, 시작위치, 몇번째발생)
select tel, instrb(tel, ')')
from student;

-- length(문자열의 문자 수)
select length(name), name
from student;

-- replace ( 문자열 내에서 특정 문자를 원하는 문자로 변경하기)
select replace(tel, ')', '&'), tel
from student;


-- 숫자 함수

-- ROUND(number [, decimal_places]) 반올림
-- TRUNC(number [, decimal_places]) 버림

select ename, round(sal,-3), sal -- 음수를 넣어 실수 반올림 뿐 아니라 정수 반올림도 가능
from student;
select round(10/3,1), 10/3 
from dual; 

select trunc(10/3, 0), 10/3, 233, trunc(233,-1) 
from dual;



-- 날짜 함수
-- Oracle: SYSDATE 의미: 현재 날짜와 시간
select sysdate from dual;


-- NVL 함수
-- NVL(expr1, expr2) 의미: expr1이 NULL이면 expr2 반환
-- NVL2(expr1, expr2, expr3) 의미: expr1이 NULL이 아니면 expr2, NULL이면 expr3

select m_name, nvl(m_point, 0)+ 100
from member_tbl_11;

select m_name, nvl2(m_point, m_point+1000, 100) as plusPoint
from member_tbl_11;

-- CASE WHEN (조건문 처리)
-- tabe에서 

select name, point,
case when point >= 3000 then 'A'
when point >= 1000 then 'B'
else 'C'
end as GRADE
from acorntbl;

