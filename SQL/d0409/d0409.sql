-- join 다양한 join( 220p)

-- 정규화( 테이블 쪼개기)

-- 테이블 합치기( 열 합치기)


-- join

-- join (=inner join) 기본값, 생략 가능
        -- 양쪽 모두 동 속성이 있어야 join 가능
        
-- eqaul(=equi) join       : 조인 조건이 같은 것 끼리
-- non-equal join   : 조인 조건이 범위를 만족하는 것

desc tbl_test_customer;

insert into tbl_test_customer(id, name, address, tel)
values ('pwe', 'sokodomo' ,'paris' , '032)032-0320');
commit;
desc tbl_test_goods;

delete from tbl_test_customer
where id = 'pwe';
commit;

insert into tbl_test_goods(pcode, pname, price)
values ('0234', '다르다팝콘', 9000);
commit;

desc tbl_test_order;
insert into tbl_test_order(ocode, odate, id, pcode, sale_cnt)
values ('j009', date '2021-01-10,', 'pwe', '0234', 3);
commit;

-- 고객 테이블에 자기 정보 넣기
-- 상품 테이블에 상품 하나 넣기

desc acorntbl;

insert into acorntbl(id, pw, name, point, birthday)
values ('qwe', '345', 'power', 300, date '2022-03-21');




-- 주문 현황 조회하기 (inner join equi join)

select *
from tbl_test_customer c
join tbl_test_order o 
    on o.id = c.id;
    

-- 주문하지 않은 고객은 조회되지 않는다. -> outer join
-- left outer join / right outer join / full outer join

select *
from tbl_test_customer c
left outer join tbl_test_order o
    on o.id = c.id;

select *
from tbl_test_order o
right outer join tbl_test_customer c
    on o.id = c.id;
    
select *
from tbl_test_order o
full outer join tbl_test_customer c
    on o.id = c.id; 

    
select *
from tbl_test_customer c
join tbl_test_order o 
    on o.id = c.id
join tbl_test_goods g
    on g.pcode = o.pcode;


select c.name "고객", nvl(sum(o.sale_cnt), 0) "주문수량"
from tbl_test_order o
right outer join tbl_test_customer c
    on o.id = c.id
group by c.name;



-- 조인 조건(on)
-- equi 
-- non equi

-- self join (join a to join a)

-- cross join (join 조건이 없음 product)



-- 237p 사용예 1 고객별 마일리지 포인트 조회, 마일리지 포인트로 받을 수 있는 상품 조회

desc customer;
desc gift;

select c.gname CUST_NAME, c.point AS POINT, g.gname GIFT_NAME
from customer c
join gift g
    on c.point between g.g_start and g_end;

select c.gname CUST_NAME, c.point AS POINT, g.gname GIFT_NAME
from customer c
join gift g
    on c.point >= g.g_start and c.point <= g_end;


-- 239p 사용예 2 학생들의 이름과 점수 학점을 출력
desc student;
desc score;
desc hakjum;

-- 학생의 이름과 점수 출력

select st.name, sc.total
from student st
join score sc
    on st.studno = sc.studno;
    
-- 점수별로 학점으로 바꾸기

select t.name stu_name, t.score as score , h.grade cre
from hakjum h
join (select st.name as name, sc.total as score
        from student st
        join score sc
            on st.studno = sc.studno) t
    on t.score >= min_point and t.score <= max_point
order by 2;



-- 241p 사용예 1 학생 이름, 지도교수 이름 출력 / 지도교수 미결정 학생 명단도 
desc student;
desc professor;

select s.name stu_name, nvl(p.name, '미정') as prof_name
from student s 
left outer join professor p
    on s.profno = p.profno;



-- 243p 사용예 2 학생이름과 지도교수 이름 출력 / 지도학생 미결정 명단도 함께

select s.name stu_name, p.name as prof_name
from student s 
right outer join professor p
    on s.profno = p.profno
order by s.name nulls last;

select nvl(s.name, '미정') stu_name, p.name as prof_name
from student s 
right outer join professor p
    on s.profno = p.profno;
    
    
-- 244p 사용 예 3 학생이름, 지도교수 이름 출력 / 결정 안된 사항들 전부 출력
select nvl(s.name, '미정') stu_name, nvl(p.name, '미정') as prof_name
from student s 
full outer join professor p
    on s.profno = p.profno;



-- 상품별 판매수량, 판매 금액 합계 구하기
select g.pname, o.sale_cnt, g.price
from tbl_test_order o
right outer join tbl_test_goods g
    on o.pcode = g.pcode;
    

-- 제품 별
select g.pname "상품", 
        to_char(nvl(sum(o.sale_cnt), 0) , '99,999') "판매수량", 
        to_char(nvl(sum(o.sale_cnt * g.price), 0) , 'L99,999') "판매량"
from tbl_test_order o
right outer join tbl_test_goods g
    on o.pcode = g.pcode
group by g.pname
order by 3 desc;




-- 250p self join

desc emp;
-- name 이 smith인 사람 mgr이 7902인 사람의 상사(상사 empno = 9002) 이름 (ename) 조회

select e1.empno "사번", 
        e1.ename "후임", 
        e1.mgr "관리자번호", 
        e2.empno "관리자사번", 
        e2.ename "관리자이름"  
from emp e1
join emp e2
    on e1.mgr = e2.empno
where e1.ename = 'SMITH';

-- 관리자가 없는 사원도 나오게

select e1.ename ENAME, nvl(e2.ename, '사수미정') MGR_ENAME
from emp e1
left outer join emp e2 
    on e1.mgr = e2.empno;



-- cross join

select *
from tbl_test_order o
join tbl_test_customer c
    on o.id = c.id;

select count(*) from tbl_test_order; -- 8
select count(*) from tbl_test_customer; --7
    
-- 8 * 7 행
select *
from tbl_test_order o
cross join tbl_test_customer c;




-- listAgg

CREATE TABLE drink_order (
    order_id NUMBER,
    drink_name VARCHAR2(20)
);
 
CREATE TABLE drink_order_option (
    order_id NUMBER,
    option_name VARCHAR2(20)
);
 
 
 -- 주문
INSERT INTO drink_order VALUES (1, '아메리카노');
INSERT INTO drink_order VALUES (2, '라떼');

-- 옵션
INSERT INTO drink_order_option VALUES (1, '샷 추가');
INSERT INTO drink_order_option VALUES (1, '얼음 적게');
INSERT INTO drink_order_option VALUES (1, '시럽 추가');

INSERT INTO drink_order_option VALUES (2, '우유 변경');
INSERT INTO drink_order_option VALUES (2, '휘핑 추가');

COMMIT;

desc drink_order;
desc drink_order_option;


select d.order_id "순번", 
    d.drink_name "음료", 
    listagg(o.option_name, ',')
    within group (order by o.option_name) as "listagg"
from drink_order d
join drink_order_option o
    on d.order_id = o.order_id
group by d.order_id, d.drink_name;