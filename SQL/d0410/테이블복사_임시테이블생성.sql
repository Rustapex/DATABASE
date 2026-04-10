drop table t3;
create table t3(
    no number,
    name varchar2(10) ,
    deptno number 

);

create table  t4(
    deptno number ,
    dname varchar2(10)
);

insert into t3 values( 1,'AAA',100) ;
insert into t3 values( 2,'BBB',200) ;
insert into t3 values( 3,'CCC',300) ;


insert into t4 values( 100 ,'DDD') ;
insert into t4 values(  200,'EEE') ;
insert into t4 values(  300, 'FFF') ;

select t3.no , t3.name  , ( select dname from t4 where t3.deptno  =t4.deptno)
from t3;


select t3.no , t3.name  
from t3;

create  global TEMPORARY table  temp01(  no number , name varchar2(10) )   on commit delete rows;
insert into temp01 values( 1, 'dfdfd');
select * from temp01;
commit;

-- 임시테이블 (교재 264p )
-- 임시 작업용 데이터 저장하기 위해서 사용
-- 삭제되는 시점은 커밋(트랜잭션이 끝나거나 세션이 끝나면 자동으로 삭제)

create  global TEMPORARY table  temp01(  no number , name varchar2(10) )   on commit delete rows;
insert into temp01 values( 1, 'dfdfd');
select * from temp01;
commit;


-- ���̺� �����ϱ�
create table t33
as
select * from t3;

select * from t3333;


CREATE TABLE t3333 AS
SELECT  * FROM t3 WHERE 1=2;



