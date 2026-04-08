create table tbl_course_300 (
        s_id varchar2(5) not null primary key,
        s_name varchar2(20)  ,
        s_grade number(6),
        teacher_id varchar2(10) ,
        weekday char(2) ,
        start_h number(4),
        end_h  number(4)
);

insert into tbl_course_300 values('1001',  '한식만들기' , 2, 1, 'M' , 0900, 1100 );
insert into tbl_course_300 values('1002',  '양식만들기' , 2, 2, 'TU' , 0900, 1200 );
insert into tbl_course_300 values('1003',  '제과제빵' , 3, 4, 'W' , 0900, 1200 );
insert into tbl_course_300 values('1004',  '중식만들기' , 3, 4, 'TH' , 0900, 1200 );
insert into tbl_course_300 values('1005',  '음료만들기' , 2, 5, 'M' , 1300, 1600 );
insert into tbl_course_300 values('1006',  '분식만들기' , 3, 5, 'TH' , 1500, 1800 );
insert into tbl_course_300 values('1007',  '전통주만들기' , 3, 5, 'W' , 1330, 1630 );
insert into tbl_course_300 values('1008',  '반찬만들기' , 2, 3, 'TH' , 1330, 1530 );
insert into tbl_course_300 values('1009',  '김치만들기' , 3, 3, 'F' , 0900, 1200 );
insert into tbl_course_300 values('1010',  '떡만들기' , 3, 2, 'F' , 1300, 1600 );
commit;


create table tbl_lecturer_300(
    t_id number(6) not null primary key,
    t_name varchar2(20)  ,
    major varchar2(20),
    field varchar2(20)
);

 

insert into tbl_lecturer_300 values( 1, '정국교수','한식,중식' ,'중식');
insert into tbl_lecturer_300 values( 2, '뷔교수','한식,중식' ,'중식');
insert into tbl_lecturer_300 values( 3, '지민교수','한식,양식' ,'양식');
insert into tbl_lecturer_300 values( 4, '제이홉교수','한식,양식' ,'한식');
insert into tbl_lecturer_300 values( 5, '슈가교수','제과제빵' ,'제과');
insert into tbl_lecturer_300 values( 6, '진교수','분식및음료' ,'분식');
insert into tbl_lecturer_300 values( 7, 'RM교수','분식및음료' ,'분식');
commit;

desc tbl_lecturer_300;
desc tbl_course_300;

-- 과목 코드 ,과목명, 학점, 담당강사, 요일, 시작시간, 종료시간
select c.s_id "과목코드", c.s_name "과목명", c.s_grade "학점", 
l.t_name "담당강사" , 
case when c.weekday = 'M' then '월'
when c.weekday = 'TU' then '화'
when c.weekday = 'W' then '수'
when c.weekday = 'TH' then '목'
when c.weekday = 'F' then '금'
END AS "요일", 
SUBSTR(LPAD(c.start_h, 4, '0'), 1, 2) || ':' || SUBSTR(LPAD(c.start_h, 4, '0'), 3, 2) AS "시작시간",
SUBSTR(TO_CHAR(c.end_h, 'FM0000'), 1, 2) || ':' || SUBSTR(TO_CHAR(c.end_h, 'FM0000'), 3) AS "종료시간"
from tbl_lecturer_300 l
inner join tbl_course_300 c
on l.t_id = c.teacher_id; 



------------------------------------------------------------------

create table tbl_court_202301(
court_no varchar2(4) not null primary key,
use char(1)
);
insert into tbl_court_202301 values('C001','N');
insert into tbl_court_202301 values('C002','N');
insert into tbl_court_202301 values('C003','N');
insert into tbl_court_202301 values('C004','N');
insert into tbl_court_202301 values('C005','N');
insert into tbl_court_202301 values('C006','N');
insert into tbl_court_202301 values('C007','N');
insert into tbl_court_202301 values('C008','N');
insert into tbl_court_202301 values('C009','N');
COMMIT;

create table tbl_resv_202301(
resv_no char(8) not null primary key,
resv_date char(8),
cust_no varchar2(4),
court_no varchar2(4)
);
insert into tbl_resv_202301 values('20230001','20230221','1001','C005');
insert into tbl_resv_202301 values('20230002','20230221','1002','C004');
insert into tbl_resv_202301 values('20230003','20230221','1003','C003');
insert into tbl_resv_202301 values('20230004','20230221','1004','C002');
insert into tbl_resv_202301 values('20230005','20230221','1005','C001');
insert into tbl_resv_202301 values('20230006','20230221','1005','C001');
insert into tbl_resv_202301 values('20230007','20230221','1005','C001');
COMMIT;
create table tbl_cust_202301(
cust_no varchar2(4) not null primary key,
cust_name varchar2(10),
tel varchar2(11)
);

insert into tbl_cust_202301 values('1001','김선수','01011112222');
insert into tbl_cust_202301 values('1002','이선수','01011113333');
insert into tbl_cust_202301 values('1003','박선수','01011114444');
insert into tbl_cust_202301 values('1004','한선수','01011115555');
insert into tbl_cust_202301 values('1005','채선수','01011116666');
COMMIT;

DESC tbl_court_202301;
DESC tbl_resv_202301;
DESC tbl_cust_202301;


------------------------------------------------------------------------------


-- HY 라운드(LOUD) 오디션프로그램 


create table tbl_join_200(
  join_id varchar2(4)  not null primary key ,
  join_nm varchar2(20)  ,
  birth  char(8),
  gender char(1),
  specialty varchar2(1),
  charm varchar2(30)
);

insert into tbl_join_200 values( 'A001' , '케이쥬',  '20050102' , 'M', 'D', '깜찍댄스');
insert into tbl_join_200 values( 'A002' , '고키',  '20090102' , 'M', 'D', '동전마술');
insert into tbl_join_200 values( 'A003' , '나윤서',  '20070102' , 'M', 'D', '창작댄스');
insert into tbl_join_200 values( 'A004' , '장현수',  '20030103' , 'M', 'R', '보컬');
insert into tbl_join_200 values( 'A005' , '윤민',  '20020205' , 'M', 'V', '자작곡');
COMMIT;


-- 멘토테이블 

create table tbl_mentor_200(
    mentor_id varchar2(4) not null primary key ,
    mentor_nm varchar2(20)
);

insert into tbl_mentor_200 values( 'J001', '박진영');
insert into tbl_mentor_200 values( 'J002', '박재상');
insert into tbl_mentor_200 values( 'J003', '보아');
COMMIT;


create table tbl_score_200(
  score_no  number(6) not null ,
  artistid varchar2(4) not null,
  mentorid varchar2(4) not null,
  score number(3),
  primary key( score_no, artistid, mentorid)
);

insert into tbl_score_200 values( 110001, 'A001', 'J001' , 80);
insert into tbl_score_200 values( 110002, 'A001', 'J002' , 90);
insert into tbl_score_200 values( 110003, 'A001', 'J003' , 70);
insert into tbl_score_200 values( 110004, 'A002', 'J001' , 60);
insert into tbl_score_200 values( 110005, 'A002', 'J002' , 50);
insert into tbl_score_200 values( 110006, 'A002', 'J003' , 70);
insert into tbl_score_200 values( 110007, 'A003', 'J001' , 80);
insert into tbl_score_200 values( 110008, 'A003', 'J002' , 60);
insert into tbl_score_200 values( 110009, 'A003', 'J003' , 70);
insert into tbl_score_200 values( 110010, 'A004', 'J001' , 80);
insert into tbl_score_200 values( 110011, 'A004', 'J002' , 78);
insert into tbl_score_200 values( 110012, 'A004', 'J003' , 89);
insert into tbl_score_200 values( 110013, 'A005', 'J001' , 62);
insert into tbl_score_200 values( 110014, 'A005', 'J002' , 91);
insert into tbl_score_200 values( 110015, 'A005', 'J003' , 67);
COMMIT;
 
SELECT * FROM tbl_join_200;
SELECT * FROM tbl_score_200;
SELECT * FROM tbl_mentor_200;
 
 -- 참가자 점수 조회 ( 채점번호, 참가자 ID, 참가자 이름, 생년월일, 점수 ,등급, 멘토이름)
SELECT s.score_no "채점번호", s.artistid "참가자 ID", j.join_nm "참가자 이름", 
    substr(j.birth,1,4) || '년' || substr(j.birth, 5,2) || '월' || substr(j.birth, 7) || '일'  "생년월일", 
    s.score "점수" ,
    case when s.score >= 90 then 'A'
        when s.score >= 80 then 'B'
        when s.score >= 70 then 'C'
        when s.score >= 60 then 'D'
        else 'F'
    end as "등급",
    m.mentor_nm "멘토이름"
 FROM tbl_join_200 j
 INNER JOIN tbl_score_200 s
    ON j.join_id = s.artistid
 inner join tbl_mentor_200 m
    on s.mentorid = m.mentor_id;
    
-- 참가자 등수 조회(참가자 id, 참가자 이름, 종합 점수, 평균 점수)

select j.join_id "참가자 아이디", j.join_nm "참가자 이름", 
sum(s.score) "종합점수", trunc(avg(s.score), 2) "평균점수"   
 FROM tbl_join_200 j
 INNER JOIN tbl_score_200 s
    ON j.join_id = s.artistid
 inner join tbl_mentor_200 m
    on s.mentorid = m.mentor_id
    group by j.join_id, j.join_nm
    order by "평균점수" desc;
    
    
-----------------------------------------------------------------------


create table goods_tbl_500(
goods_cd varchar2(6) not null primary key, 
goods_nm varchar2(30), 
goods_price number(8), 
cost number(8), in_date date
); 


insert into goods_tbl_500 values('110001','육계장사발면',1050,750,'20190302');
insert into goods_tbl_500 values('110002','단팥빵',1300,800,'20190302'); 
insert into goods_tbl_500 values('110003','사브로',2000,1700,'20190302');
insert into goods_tbl_500 values('110004','칠성사이다',900,750,'20190302'); 
insert into goods_tbl_500 values('110005','콜라',750,300,'20190302'); 
insert into goods_tbl_500 values('110006','아몬드초콜릿',1500,1300,'20190302'); 
insert into goods_tbl_500 values('110007','초코몽',850,600,'20190302');
commit;

 create table store_tbl_500(
 store_cd varchar2(5) not null primary key,
 store_nm varchar2(20), 
 store_fg varchar2(1)
);

 insert into store_tbl_500 values('A001','노원점','0');
 insert into store_tbl_500 values('A002','마포점','0'); 
insert into store_tbl_500 values('A003','석계점','0'); 
insert into store_tbl_500 values('B001','하계점','1');
 insert into store_tbl_500 values('C001','상계점','1'); 
insert into store_tbl_500 values('D001','중계점','0');
 insert into store_tbl_500 values('D002','태릉입구점','1'); 
insert into store_tbl_500 values('E001','화랑대점','0');


 create table sale_tbl_500(
 sale_no varchar2(4) not null primary key, 
 sale_ymd date not null,
 sale_fg varchar2(1) not null, 
 store_cd varchar2(5)  ,         
 goods_cd varchar2(6) ,
 sale_cnt number(3),
 pay_type varchar2(2),
 constraint  fk1 foreign key (store_cd)  references store_tbl_500(store_cd),
 constraint  fk2  foreign key (goods_cd) references goods_tbl_500(goods_cd)
); 

insert into sale_tbl_500 values('0001','20190325','1','A001','110001',2,'02'); 
insert into sale_tbl_500 values('0002','20190325','1','B001','110003',2,'02');
 insert into sale_tbl_500 values('0003','20190325','1','D001','110003',1,'01'); 
insert into sale_tbl_500 values('0004','20190325','1','A001','110006',5,'02'); 
insert into sale_tbl_500 values('0005','20190325','1','C001','110003',2,'02'); 
insert into sale_tbl_500 values('0006','20190325','2','C001','110003',2,'02');
 insert into sale_tbl_500 values('0007','20190325','1','A002','110005',4,'02');
 insert into sale_tbl_500 values('0008','20190325','1','A003','110004',4,'02');
 insert into sale_tbl_500 values('0009','20190325','1','B001','110001',2,'01');
 insert into sale_tbl_500 values('0010','20190325','1','A002','110006',1,'02');
commit;
 
-- pay_type 01 현금, 02 카드
-- 점포 별 매출현황(점포명, 현금매출, 카드매출, 총매출)
select  st.store_nm 점포명 , 
    sum(case when sa.pay_type = '01' then sa.sale_cnt * g.goods_price else 0  end) 
    as 현금매출, 
    sum(case when sa.pay_type = '02' then sa.sale_cnt * g.goods_price else 0 end) 
    as 카드매출,
    sum(sa.sale_cnt * g.goods_price) 총매출
from sale_tbl_500 sa
join store_tbl_500 st
    on sa.store_cd = st.store_cd
join goods_tbl_500 g
    on sa.goods_cd = g.goods_cd
    group by st.store_nm;
 







