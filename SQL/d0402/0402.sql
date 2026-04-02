create table member_tbl_11(
m_id varchar2(5) not null primary key ,
m_pw varchar2(5) ,
m_name varchar2(10) ,
m_tel varchar2(13) ,
m_birthday date ,
m_point number(6) ,
m_grade varchar2(2) 
);
commit;
insert into member_tbl_11 values ('m100' , '1234' , '성기훈', '010-1111-2222' , '2004-01-01' , 100, '01');
insert into member_tbl_11 values ('m101' , '4444' , '김상우', '010-2222-3333' , '2004-01-01' , 1500, '01');
insert into member_tbl_11 values ('m102' , '5555' , '김일남', '010-3333-4444' , '2004-12-10' , 2000, '02');
insert into member_tbl_11 values ('m103' , '6666' , '이준호', '010-4444-5555' , '2004-04-10' , 1900, '02');
insert into member_tbl_11 values ('m104' , '7777' , '김새벽', '010-5555-6666' , '2004-09-12' , 3000, '03');
insert into member_tbl_11 values ('m105' , '8888' , '최덕수', '010-6666-7777' , '2004-08-10' , 4800, '03');
insert into member_tbl_11 values ('m106' , '9999' , '이알리', '010-7777-8888' , '2004-07-10' , 2900, '01');
insert into member_tbl_11 values ('m107' , '0101' , '김미녀', '010-8888-9999' , '2004-06-09' , 1200, '01');
insert into member_tbl_11 values ('m108' , '0404' , '이정재', '010-9999-8888' , '2004-05-19' , 3000, '03');
insert into member_tbl_11 ( m_id, m_pw, m_name , m_tel , m_birthday) 
values ('m109' , '0448' , '박해수', '010-7878-1111' , '2004-11-27' );
insert into member_tbl_11 ( m_id, m_pw, m_name , m_tel , m_birthday) 
values ('m110' , '4848' , '위하준', '010-8888-9090' , '2004-11-09');
commit;

select * from member_tbl_11;

create table  acorntbl  (
    id  varchar2(10) primary key,
    pw  varchar2(10) ,
    name varchar2(10),
    point number(6) , 
    birthday date    
);

-- database String ' ' use
-- data 추가 (insert) 변경(update), 삭제(delete) 시 commit 필요
insert into acorntbl(id, pw, name, point, birthday)  values('victoai', '1224', '우주연' ,100 , '1975-12-10'); 
insert into acorntbl values('sys', '1009', '손영석' ,100 , '2003-01-09');
insert into acorntbl(id, pw, name, point, birthday)  values('nice', '0624', '나해수' ,1000 , '2003-06-24');
insert into acorntbl(id, pw, name, point, birthday)  values('minjeong', '0604', '김민정' ,33333 , '2002-06-04');
insert into acorntbl(id, pw, name, point, birthday)  values('sein', '1234', '박세인' ,1000 , '2005-01-25'); 
insert into acorntbl(id, pw, name, point, birthday)  values('charlie', '1029', '이현겸' ,6700 , '2003-01-15');
insert into acorntbl(id, pw, name, poiint, birthday) values('wnckd', '123456', '송주창', 4324, '2001-11-21');
insert into acorntbl(id, pw, name, point, birthday) values('jaemin','0320','김재민',9000,'2002-03-20');
insert into acorntbl(id, pw, name, point, birthday) values('sone919', '1234', '황스일' ,100 , '2002-09-19');
insert  into  acorntbl(id, pw, name, point, birthday) values('jcj', '1234', '정철진' ,1000 , '2002-01-25');
insert into acorntbl(id, pw, name, point, birthday)  values('rjsgml350', '1224', '김건희' ,10000 , '2002-10-10');
insert into acorntbl(id, pw, name, point, birthday)  values('HIHI', '0401', '장해든' ,1004 , '2004-04-01');
commit;

-- 데이터 조회하기 select (read)
select * from acorntbl;

-- 데이터 조회하기 컬럼 지정
select id, name from acorntbl;

-- 데이터 조회하기 모든 컬럼 * 
select * from acorntbl;

-- table 명세 확인
DESC acorntbl;

-- 문자열 연결 연산자 사용 (컬럼 합치기)

select id || '-' || name AS IdAndName from ACORNTBL;


--조회하기 - 정렬하기
select *
from acorntbl
order by point ASC; -- ASC 안써도 오름차순 기본

SELECT ID, PW, NAME
FROM ACORNTBL
ORDER BY 3 DESC; -- 정렬 시에 순번 사용 가능

-- 조건절 추가하기(where)
-- >= , > , < , <= 
select *
from acorntbl
where point >= 2000;

-- 같다 = , 다르다 != , <>
select * 
from acorntbl
where name = '장해든';

--bewteen a and b : a <= x <= b

select *
from acorntbl
where point between 5000 and 10000;

select * from member_tbl_11;

select *
from member_tbl_11
where m_grade = '01' and m_point >= 1500;

select *
from member_tbl_11
where m_grade = '01' or m_point >= 1500;


-- in(a,b,c)

select * 
from member_tbl_11
where m_grade in('01', '02');

-- not in(a,b,c)

select * 
from member_tbl_11
where m_grade not in('02');

-- null의 의미는 아직 값이 결정되지 않은 상태(미정의 값)

-- is null
select * 
from member_tbl_11
where m_point is null;

-- is not null


-- 기존에 있는 m_point에 100을 더해서 연산한 결과를 출력

select m_id, m_name, m_point+100
from member_tbl_11;

-- null + 100 = null
-- null 처리하기( null과 = 연산자 사용 불가, 그래서 is null, is not null 만 사용 가능)

-- m_point 가 null인 사람 조회하기
select m_id, m_name, m_point
from member_tbl_11
where m_point is null;


-- null + 100 => null 확인
select m_id, m_name, m_point+100 as nullIsNull
from member_tbl_11
where m_point is null;

-- 조회시 컬럼 별칭(alias) 사용하기 , 컬럼 명 뒤에 as 사용, 사용 시 공백 소문자 표기 시 "" 안에 작성
select m_id as id,
    m_pw pw, m_name  "pw a"
from member_tbl_11;

-- distinct keyword / 고객 등급 조회하기

select distinct m_grade
from member_tbl_11;

-- 생일이 2004년 /4/10 이후 출생자 조회
-- date data ' ' 사용 , < > <= >= 사용 가능
select *
from member_tbl_11
where m_birthday > '2004-04-10'
order by m_birthday asc;

-- 데이터 조회하기 select
-- select 컬럼명 
-- form tableNAme
-- where 조건
-- order by 컬럼명, 순서 , asc ,desc

-- sql 첫번째

-- 1. 모든 정보조회 (* : 모든컬럼
select * from member_tbl_11;

-- 2. 모든 고객의 이름과 생일 정보 조회하시오
select m_name "이름", m_birthday "생일"
from member_tbl_11;

-- 3. 이름이 박해수인 고객아이디, 생일, 포인트 정보 조회하시
select m_id, m_birthday, m_point
from member_tbl_11
where m_name = '박해수';

-- 4.
select m_name, m_tel
from member_tbl_11
where m_point >= 2000;

-- 5
select m_name, m_tel
from member_tbl_11
where m_point between 2000 and 3000;

--6
select m_name, m_tel, m_point
from member_tbl_11
where m_grade = '01';

--7
select m_name, m_tel
from member_tbl_11
where m_birthday > DATE '2004-06-01';

--8
select m_name, m_birthday
from member_tbl_11
where m_birthday < DATE '2004-05-01';

--9
select m_name, m_tel, m_grade
from member_tbl_11
where m_grade <> '01';

--10
select m_id, m_name, m_tel
from member_tbl_11
where m_grade = '02';

--11
select m_name, m_tel
from member_tbl_11
where m_point <1500;

--12 
select *
from member_tbl_11
where m_point is null;

--13 
select *
from member_tbl_11
where m_point is not null;

desc member_tbl_11;

--14
select distinct m_grade 
from member_tbl_11;



-- sql 두번째

--1
select m_id, m_name
from member_tbl_11
where m_grade ='01' and m_point >= 2000;

--2
select m_id, m_name
from member_tbl_11
where m_grade = '01' or m_point >= 2000;

--3 
select m_id, m_name, m_grade
from member_tbl_11
where m_name like '김%';

--4
desc member_tbl_11;

select m_id, m_name, m_grade
from member_tbl_11
where m_name like '%수';

--5
select m_id, m_name, m_grade
from member_tbl_11
where m_grade in ('01' , '03');

--6 
select m_id, m_name, m_grade
from member_tbl_11
where m_grade not in ('01' , '02');

--7
select m_id, m_name, m_grade
from member_tbl_11
where m_grade = '02' or m_name like '이%';

--8 
select m_id, m_name, m_birthday
from member_tbl_11
where m_birthday < date '2004-05-01' or m_grade = '03';