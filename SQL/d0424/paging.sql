select * from member_tbl_11
fetch first 4 rows only;
-- 1 페이지 , 4개씩


--select * 
--from member_tbl_11
--where rownum between 5 and 8;     --rownum이 select 로 조회결과가 만들어질 때 부여됨, where 에서 사용 불가
-- 2 페이지, 4개씩


-- 서브쿼리 이용 (2페이지)

select *
from 
    (select rownum NUM, m_id, m_name, m_pw, m_tel, m_birthday, m_point, m_grade from member_tbl_11)
where NUM between 5 and 8 ;