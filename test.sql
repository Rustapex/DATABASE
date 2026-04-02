/* select sysdate from dual;
select user from dual; */
-- select * from tab;

create table test_member (
    id number PRIMARY KEY,
    name varchar2(30)
);

insert into test_member(id, name) values (1, '아이유');
insert into test_member(id, name) values (2, '허각');



update test_member
set name = '황치열'
where id=2;

insert into test_member(id, name)
values (3,'소수빈');

delete from test_member
where id = 2;


commit;
select * from test_member;

