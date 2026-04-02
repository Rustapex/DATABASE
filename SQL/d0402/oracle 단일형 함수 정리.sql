desc members;
-- 문자함수
-- 1) upper
select upper(member_name) as nametoupper
  from members; // 근데 이름이 한글이라 의미 없음, 영문이면 대문자로ACORNTBL

-- 2) lower
select lower(email) as emailtolower
  from members; // 이메일이 소문자로 바뀜

--3) initcap (oracle만)
desc Products;
select initcap(brand_name) as upperbrandname
  from products; // 단어의 첫 글자만 대문자로 바뀜

--4)length
select length(login_id) as length_loginid
  from members; // 로그인 아이디의 길이가 나옴

--5) lengthb (oracle만)
select lengthb(product_name)
  from products; // 바이트 단위로 문자열의 길이를 반환, 한글은 주의 필요ACORNTBL

--6) concat (mysql 스타일)
select concat(
   member_name,
   city
) as nameandcity
  from members; // 회원 이름과 도시를 합쳐서 보여줌

--6-2) || 연산자 (orcale, mysql 모두 지원)
select member_name
       || ' - '
       || city as nameandcity2
  from members; // 회원 이름과 도시를 합쳐서 보여줌

--7) substr
desc members;
select substr(
   phone,
   1,
   3
) as "전화번호 앞 세자리"
  from members; // 전화번호의 앞 세자리만 보여줌

--8) substrb (oracle만)
select substrb(
   phone,
   1,
   3
) as "전화번호 앞 세자리 바이트"
  from members; // 전화번호의 앞 세자리만 보여줌, 한글은 주의 필요

--9) instr
select email,
       instr(
          email,
          '@'
       ) as atpositionemail
  from members; // 이메일에서 @의 위치를 반환

--10) instrb (oracle만)
select email,
       instrb(
          email,
          '@'
       ) as atpositionemailbyte
  from members; // 이메일에서 @의 위치를 반환, 한글은 주의 필요

--11) lpad
select stock_qty,
       lpad(
          stock_qty,
          10,
          '0'
       ) as "10자리, 좌 0으로 채움"
  from products;

--12) rpad
select member_name,
       rpad(
          member_name,
          10,
          '*'
       ) as "10자리, 우 *로 채움"
  from members;

--13) ltrim
select ' SQL' as original,
       ltrim(' SQL') as ltrimmed
  from dual; // 문자열의 왼쪽 공백 제거 

--14) rtrim
select 'SQL ' as original,
       rtrim('SQL ') as rtrimmed
  from dual; // 문자열의 오른쪽 공백 제거

--15) trim
select '###Oracle###' as original,
       trim('#' from '###Oracle###') as trimmed
  from dual; // 문자열의 양쪽에서 특정 문자 제거

select ' io studio italiano, e tu? ' as original,
       trim(' ' from ' io studio italiano, e tu? ') as trimmed
  from dual; // 문자열의 양쪽에서 공백 제거

---16) replace 특정 문자 제거 또는 패턴을 찾아서 다른 문자로 대체
select phone, replace(phone, '-', '') as "Not - " 
from members;

-- ^: 문자열 시작 ('^A': A로 시작)
-- $: 문자열 끝 ('A$': A로 끝)
-- [0-9]: 숫자
-- [^0-9]: 숫자가 아닌 것
-- [a-z]: 영문 소문자 

--17) regexp_replace 특정 문자 제거 또는 패턴을 찾아서 제거
select phone, regexp_replace(phone, '-', '') as "Not - "
from members;

--18) regexp_instr 특정 패턴이 문자열에서 처음으로 나타나는 위치를 반환
select email, regexp_instr(email, '@') as "@ 위치 인덱스(1시작, 바이트)"
from members;

--19) regexp_substr 바이트 단위 문자열 추출
select regexp_substr(email, '[^@]+') as "이메일 아이디 부분",
       regexp_substr(email, '[^@]+', 1, 2) as "이메일 도메인 부분"
    from members;

--20) regexp_like 특정 패턴이 문자열에 존재하는지 여부를 반환



