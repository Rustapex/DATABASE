-- 1. new_emp 생성

create table new_emp(
    no number(5),
    name varchar(20),
    hiredate date,
    bonus number(6,2)
);

desc new_emp;

-- 2.
create table new_emp2 as
select no, name, hiredate
from new_emp;

desc new_emp2;

-- 3. 
create table new_emp3 as
select * from new_emp2
where 1=0;

desc new_emp3;

drop table new_emp3;


--4. 
desc new_emp2;

alter table new_emp2 
add birthday DATE default sysdate;

insert into new_emp2(no, name, hiredate)
values (1,'power', to_date('2022-02-02', 'yyyy-mm-dd'));
commit;

select * from new_emp2;


-- 5.

alter table new_emp2 
rename column birthday to birth;

desc new_emp2;

-- 6.

alter table new_emp2
modify no number(7);

desc new_emp2;

-- 7.

alter table new_emp2
drop column birth;

desc new_emp2;

--8. 
truncate table new_emp2;

select * from new_emp2;

-- 9.
drop table new_emp2;



