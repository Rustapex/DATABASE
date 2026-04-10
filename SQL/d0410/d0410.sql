-- DDL - creater, alter, drop
-- 테이블 만들기, 테이블 수정하기, 테이블 삭제하게
 
-- && 한글 사용 시 3바이트 사용(ORACLE), 한글 자릿수 입력 시 byte 고려 필요 &&


-- 자료형

-- 문자 : char(자릿수) 고정길이 [공백 채움], varchar2(자릿수) 가변길이 [공백 채우지 않음]
-- 숫자 : number(자릿수), number(전체 자릿수, 소수자릿수) ex) number(6,2)
-- 날짜 : date, timestamp (시분초까지)


-- 회원 테이블 생성하기
-- table 생성

-- 테이블
-- 아이디, 비밀번호, 이름, 성별(남,여), 나이(1~999), 생일(년월일까지), 전화번호(char)
create table member_acorn(
    id varchar2(50) primary key,
    pwd varchar2(50),
    name varchar2(50),
    tel char(13)
);

-- 테이블 생성 시 PK 설정 필수

insert into member_acorn (id,name,tel)
values ('HONG', '홍길동', '0101231123');
INSERT INTO member_acorn (id,pwd, name,tel)
values ('victoai', '1234','우주연', '0101231123');
commit;

select * from member_acorn;

-- 테이블 변경(수정하기) alter

-- 칼럼 추가하기, 주소 컬럼 추가하기
alter table member_acorn add (address varchar2(50));

--칼럼 이름 변경( name -> username)
alter table member_acorn rename column name to username;
alter table member_acorn rename column pwd to pw;

--tel 컬럼 문자자료형의 길이 변경하기
alter table member_acorn modify tel varchar2(15);
alter table member_acorn modify id varchar2(7);

-- 칼럼 삭제하기 (address)
alter table member_acorn drop column address;

-- 테이블 삭제하기
drop table member_acorn;

-- 테이블 삭제하기 완전히 삭제
--drop table 테이블명; 완전히 삭제
--truncate table 테이블명; -> 저장공간 반납



--  참고사항
-- 테이블  drop시  참조하고 있는 테이블이 있는 경우 삭제가 안될 수 있다.
-- 테이블 drop시 강제 삭제 시킬 수 있다.
--drop table aaa_tbl  cascade constraints ;

-- 복합키를 주키로 설정하는 구문
--CREATE TABLE testTbl  (
--    column1 NUMBER,
--    column2 VARCHAR2(100),
--    column3 DATE,
--    CONSTRAINT  pk_test   PRIMARY KEY (column1, column2)
--);


desc member_acorn;

--슈퍼키(Super Key) : 릴레이션의 튜플을 유일하게 식별할 수 있는 속성 또는 속성 집합(유일성 만족, 최소성은 불필요)
--
--후보키(Candidate Key) : 슈퍼키 중에서 최소성을 만족하는 키
--
--기본키(Primary Key, PK, 주키) : 후보키 중에서 대표로 선택된 키. NULL 불가, 테이블당 1개만 지정 가능(복합 기본키 가능)
--
--대체키(Alternate Key) : 후보키 중 기본키로 선택되지 않은 키
--
--고유키(Unique Key) : 중복을 허용하지 않는 키. 실무에서는 UNIQUE 제약조건으로 구현
--
--외래키(Foreign Key, FK) : 다른 테이블의 기본키 또는 고유키를 참조하여 관계를 설정하는 키
--
--복합키(Composite Key) : 둘 이상의 칼럼을 묶어서 만든 키
--
--자연키(Natural Key) : 업무적으로 의미가 있는 실제 데이터 기반 키
--
--대리키(Surrogate Key) : 시스템이 인위적으로 만든 키




-- 키의 종류

-- super key (슈퍼키) : 유일성 만족
-- 후보키  : PK가 될 수 있는 훕(유일성, 최소성)
-- 주키   : 후보키 중에 선택된 키
-- 대체키 : 후보키 중에 나머지 키
-- FK(외래키)   : 다른 테이블의 주키로써 관계성 설정을 위해서 가지고 있는 키


-- 학생 테이블
-- 학번   이름  학년  반   번호

-- 슈퍼키 판별
-- 학번, 이름, 학년, 반, 번호 -> 유일성 만족 (슈퍼키 가능)
-- 학번, 반, 번호 -> 유일성 만족, 최소성 o  (후보키)
-- 학번 -> (후보키)


-- 1) 유일성 : 키의 조합으로 유일하게 하나의 레코드를 식별가능 여부
-- 2) 최소성 : 키의 조합이 최소한 존재해야지만 키로 사용하는 것이 가능한가?


-- 후보키
-- 학년, 반, 번호 -> 유일성, 최소성    [대체키]
-- 학번 -> 유일성, 최소성 만족        [주키]


create table test_2021 (
    id varchar(7) not null,
    email varchar2(50) null,
    phone char(13) not null,
    pwd varchar2(7) default '1111'
);

select * from test_2021;

-- 데이터 추가하기
insert into test_2021(id, phone) values ('test', '01001231234');
commit;

-- not null 테스트하기
-- 필수 입력 사항들은 not null
insert into test_2021(id) values ('test');
commit;


--CHECK 제약 조건 
CREATE  TABLE TEST_2021_2(
   ID VARCHAR2(50)  , 
   PHONE VARCHAR2(20) CHECK ( PHONE  LIKE  '010-%-____') NOT NULL,
   EMAIL VARCHAR2(50)  NULL
);

insert into test_2021_2(id,phone)
values ('test', '010-59874-1234');

select * from test_2021_2;

insert into test_2021_2(id,phone)
values ('test', '010-59874-12314');


CREATE  TABLE TEST_2021_22(
   ID VARCHAR2(50)  , 
   PHONE VARCHAR2(20) CHECK ( PHONE  LIKE  '010-%-____') NOT NULL,
   EMAIL VARCHAR2(50)  NULL,
   GRADE CHAR(2) CHECK( GRADE IN ('01','02','03'))
);

insert into test_2021_22(id,phone, grade)
values ('test', '010-5987-2314', '01');

insert into test_2021_22(id,phone, grade)
values ('test', '010-5987-2314', '07'); -- check 제약 조건 위배




-- 교재 327p ~ 339p
create table new_emp1 (
   no number(4) 
   constraint emp1_no_pk primary key,
   name varchar2(20) 
   constraint emp1_name_nn not null,
   jumin varchar2(13)
   constraint emp1_jumin_nn  not null 
   constraint emp1_jumin_uk  unique,
   loc_code number(1) 
   constraint emp1_area_ck check( loc_code  <5 ) ,
   deptno varchar2(6)
   constraint emp1_deptno_fk references dept2(dcode)
);
--
-- 
--
--
--create table new_emp2(
--    no number(4) primary key,
--    name varchar2(20) not null ,
--    jumin varchar2(13) not null unique,
--    loc_code number(1) check( loc_code <5),
--    deptno varchar2(6) references dept2(dcode )
--);




--2) 엔티티 제약조건 ( table 조건) : 테이블 안에서 갖는 제약 조건
-- primary key (not null, unique)
-- unique (중복 허용 x)


CREATE TABLE TEST_2021_3(

  ID  VARCHAR2(7)   NOT NULL  PRIMARY KEY,
  EMAIL VARCHAR2(50),
  PHONE CHAR(13)  UNIQUE ,
  PWD  VARCHAR2(10)
);


insert into test_2021_3(id, phone)
values ('qwe', '010');
commit;

select * from test_2021_3;

insert into test_2021_3(id, phone)
values ('wer', '010');
commit;
-- phone unique 무결성 제약 조건 위배

insert into test_2021_3(id, phone)
values ('qwe', '234');
commit;
-- id, pk 무결성 제약조건 위배



-- 3) 관계 제약조건 (테이블간 제약조건)

-- foregin KEY 외래키 설정
-- 외래키를 가져오기 위해서 필요함

CREATE TABLE MEM_TBL(
   ID VARCHAR2(5)  NOT NULL PRIMARY KEY,
   NAME VARCHAR2(10) NOT NULL ,
   ADDR VARCHAR2(10)
 
 );

create table ord_tbl (
no varchar2(5) not null primary key ,
qty number(4) , 
cus_no varchar2(5) 
);

insert into mem_tbl values( 'a1' , '홍길동' , '서울') ;
insert into mem_tbl values( 'a2' , '홍길순', '부산');

insert into ord_tbl values( 'j01' , 3, 'a1' );
insert into ord_tbl values( 'j02' , 1, 'a1' );
insert into ord_tbl values( 'j03' , 7, 'a2' );

COMMIT;

select * from ord_tbl;
select * from mem_tbl;

-- 주문 테이블에 a3 고객의 주문을 추가해보기
-- insert 가능  -> 문제 발생 (무결성 위배) 
-- => 막기 위해서 제약 조건 추가 해야 외래키 제약 조건

insert into ord_tbl values( 'j04' , 7, 'a3' );
commit;


create table mem_tbl_2 (
id varchar2(5) not null primary key , name varchar2(10) not null , addr varchar2(10)
);
insert into mem_tbl_2 values( 'a1' , '홍길동' , '서울') ;
insert into mem_tbl_2 values( 'a2' , '홍길순', '부산');
commit;



--주문테이블 생성하기
CREATE TABLE  ORD_TBL_2(
   NO VARCHAR2(5) PRIMARY KEY,
   QTY NUMBER(4) NOT NULL,
   CUS_NO VARCHAR2(5)   REFERENCES mem_tbl_2( ID)
);

-- ORA-02291: 무결성 제약조건(SCOTT.SYS_C007647)이 위배되었습니다- 부모 키가 없습니다
insert into ord_tbl_2 values( 'j04' , 7, 'a3' ); -- 실패, 부모 키에 없습
commit;

--------------------------------------------------------------------------------------------------------------------------



// 외래키 설정시    Delete constraint  , update constraint  
//기본제약조건이  Restricted  //참조하고 있으면 삭제못함                 ==> 별도의 설정이 필요없음 기본값
//            cascade    // 참조하고 있는 모든 것이 삭제됨                    ==>  on delete cascade
//            nullify    // 참조하고 있는 것이   null로 채워짐                  ==>  on delete set null 


create table ctbl ( id varchar2(10) primary key , name varchar2(10) )  ;
create table otbl ( code varchar2(10) primary key,  iid  varchar2(10) references ctbl (id) on delete cascade );


insert into ctbl values( 't1' ,  'kim');
insert into ctbl values( 't2'  , 'choi');
insert into otbl values( 'o1', 't1');
insert into otbl values( 'o2', 't1');
commit;

delete  from ctbl where id  ='t1';   //  t1고객 삭제시   t1을 참조하는 주문정보가 모두 삭제가 됨
select * from  otbl; //  주문정보가 모두 삭제된것을 확인 할 수 있다.

select * from ctbl;




create table ctbl2 ( id varchar2(10) primary key , name varchar2(10) )  ;
create table otbl2 ( code varchar2(10) primary key,  iid  varchar2(10) references ctbl2 (id) on delete set null );


insert into ctbl2 values( 't1' ,  'kim');
insert into ctbl2 values( 't2'  , 'choi');
insert into otbl2 values( 'o1', 't1');
insert into otbl2 values( 'o2', 't1');


commit;

delete  from ctbl2 where id  ='t1';   //  t1고객 삭제시   t1을 참조하는 주문정보가 모두 삭제가 됨
select * from  otbl2; //  주문정보가 모두 삭제된것을 확인 할 수 있다.
select * from ctbl2; -- 고객정보는 삭제


select * from tbl_test_order;
select * from tbl_test_customer;



-- 관계의 종류 cardinality(관계차수 설정)
-- 1: 1 / 1 : n / n : m


