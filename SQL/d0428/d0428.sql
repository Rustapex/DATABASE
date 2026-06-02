-- oracle 기준

CREATE SEQUENCE seq_order_id
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 시퀀스 조회
select   seq_order_id.nextval  from dual;


create table test0428(
    id varchar2(10) primary key,
    name varchar2(10)
    );

insert into test0428 (id, name) values(seq_order_id.nextval, 'hong');
commit;

select * from test0428;



-- 계층 쿼리

create table acorn(
    id number(3) primary key,
    name varchar(10) ,
    manager_id number(3) 
);

insert into acorn values(1, '우주연', null);
insert into acorn values(2, '송주창', 4);
insert into acorn values(3, '이용찬', 4);
insert into acorn values(4, '김재민', 1);
insert into acorn values(5, '장해든', 4);
insert into acorn values(6, '박세인', 4);
insert into acorn values(7, '여도현', 10);
insert into acorn values(8, '고지연', 10);
insert into acorn values(9, '김민경', 10);
insert into acorn values(10, '장윤성', 1);
insert into acorn values(11, '김민정', 10);
insert into acorn values(12, '이정하', 1);
insert into acorn values(13, '손영석', 12);
insert into acorn values(14, '조아진', 12);
insert into acorn values(15, '김태준', 12);
insert into acorn values(16, '나해수', 12);
insert into acorn values(17, '정철진', 20);
insert into acorn values(18, '엄진희', 20);
insert into acorn values(19, '김건희', 20);
insert into acorn values(20, '황스일', 1);
insert into acorn values(21, '이현겸', 20);

commit;

select * from acorn;

select  name,id ,   level,  lpad( '  ' ,  5 *( level -1) )  ||  name    levelname
from acorn
start  with     manager_id is  null
connect by prior  id  =  manager_id
order by level;

SELECT name,
       id,
       LEVEL,
       LPAD(' ', 5 * (LEVEL - 1)) || name AS levelname
FROM acorn
START WITH manager_id IS NULL
CONNECT BY PRIOR id = manager_id
ORDER SIBLINGS BY id;

--

select name, id, manager_id, level, lpad(' ',5*(level-1)) || name AS "NAMES"
from acorn
start with manager_id is null
connect by prior id = manager_id
order by level;

select name, id, manager_id, level, lpad(' ',5*(level-1)) || name AS "NAMES"
from acorn
start with manager_id is null
connect by prior id = manager_id
order siblings by id;



-- 계층
-- 댓글

select * from user_indexes;

SELECT *  
FROM  user_indexes
WHERE table_name = 'ACORNTBL';

SELECT * 
FROM user_ind_columns;


SELECT * 
FROM user_ind_columns
WHERE table_name ='ACORNTBL';
 
 
DROP TABLE customertbl;

CREATE TABLE customertbl
	( customer_id number NOT NULL PRIMARY KEY,
		first_name varchar2(10) NOT NULL,
		last_name varchar2(10) NOT NULL,
		email varchar2(10),
		phone_number varchar2(20),
		regist_date date
);


INSERT INTO customertbl
VALUES (1, 'Suan', 'Lee', 'suan', '010-1234-1234', '21/01/01');

INSERT INTO customertbl
VALUES (2, 'Elon', 'Musk', 'elon', '010-1111-2222', '21/05/01');

INSERT INTO customertbl
VALUES (3, 'Steve', 'Jobs', 'steve', '010-3333-4444', '21/10/01');

INSERT INTO customertbl
VALUES (4, 'Bill', 'Gates', 'bill', '010-5555-6666', '21/11/01');

INSERT INTO customertbl
VALUES (5, 'Mark', 'Zuckerberg', 'mark', '010-7777-8888', 
'21/12/01');

commit;

--
SELECT *  FROM customertbl;

--
SELECT *
FROM user_indexes
WHERE table_name = 'CUSTOMERTBL';


--인덱스 생성
CREATE INDEX regist_date_idx
ON customertbl (regist_date);

SELECT index_name
FROM user_indexes
WHERE table_name = 'CUSTOMERTBL';

--
SELECT *
FROM customertbl
WHERE regist_date = '21/01/01';

CREATE INDEX name_idx
ON customertbl  (first_name, last_name);

SELECT *
FROM user_indexes
WHERE table_name = 'CUSTOMERTBL';


--사용예
SELECT * 
FROM customertbl
WHERE first_name = 'John'
  AND last_name = 'Doe';
  
  
-- 테이블명 ( 칼럼, 칼럼2)

-- 인덱스 조회에 효과적
-- 삭제, 변경, 삭제 빈번한 데이터는 인덱스 사용 비용 많이 듬


SELECT *
FROM user_indexes
WHERE table_name = 'CUSTOMERTBL';


DROP INDEX regist_date_idx;
DROP INDEX email_idx;
DROP INDEX name_idx;
DROP INDEX phone_idx;


SELECT index_name
FROM user_indexes
WHERE table_name = 'CUSTOMERTBL';



-- 프로시저 생성

-- 모듈 

-- 프로시저 : 특정 기능을 수행하는 거, 반환이 없는 거
-- 함수 - 반환이 있는 거

-- visual basic : 프로시저, 함수 

--테스트 테이블

DROP TABLE CUST_INFO;

CREATE TABLE CUST_INFO(
 ID VARCHAR2(13) NOT NULL PRIMARY KEY , 
 FIRST_NM VARCHAR2(10) , 
 LAST_NM VARCHAR2(10) ,
 ANNL_PERF NUMBER(10,2) ,
 SALARY  NUMBER(6) 
);
 
 
INSERT INTO CUST_INFO VALUES ('100' , '김' , '건희', 330.08 ,5000);
INSERT INTO CUST_INFO VALUES ('200' , '고' , '지연', 857.61,5500);
INSERT INTO CUST_INFO VALUES ('110' , '김' , '태준', 76.77,5800);
INSERT INTO CUST_INFO VALUES ('220' , '황' , '스일', 468.54,5900);
INSERT INTO CUST_INFO VALUES ('400' , '김' , '민정', 890,5700);
INSERT INTO CUST_INFO VALUES ('300' , '이' , '현겸', 47.44,5500);

COMMIT;

-- 서버출력 허용 
SET SERVEROUTPUT ON;
 

CREATE OR REPLACE PROCEDURE rowtype_emp ( 
    emp_id IN CUST_INFO.ID%TYPE
) AS
    cust_row CUST_INFO%ROWTYPE;
BEGIN
    SELECT ID, FIRST_NM, LAST_NM, ANNL_PERF, SALARY  
    INTO cust_row.ID, cust_row.FIRST_NM, cust_row.LAST_NM, cust_row.ANNL_PERF, cust_row.SALARY
    FROM CUST_INFO
    WHERE id = emp_id;

    DBMS_OUTPUT.PUT_LINE(cust_row.first_nm || ' | ' || cust_row.last_nm || ' | ' || cust_row.id);
END;
/



--프로시저 실행하기

execute rowtype_emp (100);

 
-- 서버출력 허용 
SET SERVEROUTPUT ON;
 

CREATE OR REPLACE PROCEDURE rowtype_emp ( 
    emp_id IN CUST_INFO.ID%TYPE
) AS
    cust_row CUST_INFO%ROWTYPE;
BEGIN
    SELECT ID, FIRST_NM, LAST_NM, ANNL_PERF, SALARY  
    INTO cust_row.ID, cust_row.FIRST_NM, cust_row.LAST_NM, cust_row.ANNL_PERF, cust_row.SALARY
    FROM CUST_INFO
    WHERE id = emp_id;

    DBMS_OUTPUT.PUT_LINE(cust_row.first_nm || ' | ' || cust_row.last_nm || ' | ' || cust_row.id);
END;


-- 직원 출력 프로시저
CREATE OR REPLACE PROCEDURE print_emp_name AS
	emp_name VARCHAR2(20);
BEGIN
	SELECT first_nm || ' ' || last_nm INTO emp_name
	FROM CUST_INFO WHERE ID =  '200' ;
	DBMS_OUTPUT.PUT_LINE(emp_name);
END;
/


--서버 출력 허용
SET SERVEROUTPUT ON;
-- 프로시저 실행
EXECUTE print_emp_name();


--평균수익율 구하는 프로시저

CREATE OR REPLACE PROCEDURE emp_avg_ANNL_PERF (
	avg_salary OUT NUMBER
) AS
BEGIN
	SELECT AVG(ANNL_PERF) INTO avg_salary
	FROM CUST_INFO ;
END ;
/



--프로시저 실행하기
DECLARE
	avg_ANNL_PERF NUMBER;
BEGIN
	emp_avg_ANNL_PERF (avg_ANNL_PERF );
	DBMS_OUTPUT.PUT_LINE(avg_ANNL_PERF );
END;


CREATE OR REPLACE PROCEDURE if_salary (
	salary IN NUMBER
) AS 
	avg_salary NUMBER;
BEGIN
	SELECT AVG(salary) INTO avg_salary FROM cust_info;
	IF salary >= avg_salary THEN
		DBMS_OUTPUT.PUT_LINE('평균 이상');
	ELSE
		DBMS_OUTPUT.PUT_LINE('평균 미만');
	END IF; 
END;
/

 
 
 --IN, OUT 변수선언하기, 생략하면 IN , IN OUT 같이 사용할 수 있다
 -- 프로시저 실행
 EXECUTE if_salary(300);
 
 
 




-----------------------

--함수만들기
CREATE OR REPLACE FUNCTION to_yyyymmdd( date Date) 
	RETURN VARCHAR2
IS
	char_date VARCHAR2(20);
BEGIN
	char_date := TO_CHAR(date, 'YYYYMMDD' );
RETURN  char_date ;
END;
/


ㄴ


--함수만들기
CREATE OR REPLACE FUNCTION get_age(date Date)
	RETURN NUMBER
IS 
	age NUMBER;
BEGIN 
	age := TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), to_yyyymmdd(date))/ 12);
RETURN age;
END; 
/


SELECT get_age('20090101') FROM dual;
 

--함수만들기
--응원메시지를 반환하는 함수

CREATE OR REPLACE FUNCTION getMessage  
	RETURN VARCHAR2
IS
	char_date VARCHAR2(50);
BEGIN
	char_date :=  '^^마지막까지 아자아자 퐈이팅' ;
RETURN  char_date ;
END;
/

select getMessage() from dual;

select get_age('2003-01-09') from dual;


-------------------------------------------




--트리거
CREATE TABLE employees (
    employee_id NUMBER(10) PRIMARY KEY,
    first_name  VARCHAR2(50),
    last_name   VARCHAR2(50),
    salary      NUMBER(10, 2)
);


CREATE TABLE salary_history (
    history_id      NUMBER(10) PRIMARY KEY,
    employee_id     NUMBER(10) NOT NULL,
    salary          NUMBER(10, 2) NOT NULL,
    effective_date  DATE DEFAULT SYSDATE
);

select * from employees;
select * from salary_history;
desc salary_history;


--트리거 생성 

create or replace  trigger  triggerex
after insert  on employees
for each row
begin 
      insert into salary_history (     history_id   , employee_id  ,salary, effective_date) 
      values( 1, :NEW.employee_id   ,  :NEW.salary , sysdate);
end;
/

insert  INTO employees (employee_id, first_name, last_name, salary) VALUES (101, 'John', 'Doe', 5000);  
commit;


select * from employees;
select * from salary_history;
 

 
 