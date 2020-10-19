-- * 오라클 명령어 : 내장함수

-- [1] 임시 데이터 출력
select 1234 * 1234 from emp;  -- 각 레코드 개수만큼 출력이 됨.

select 1234 * 1234 from dual;  -- 샘플테이블. 특정테이블에서 가져오는 것이 아니라 select문을 하기 위해서 만들어진 임시 테이블.

-- [2] 샘플 테이블인 dual 테이블
select * from dual;  -- dummy 


-- *** 문자열 처리 관련 함수 ***
-- [3]  lower() : 모든 문자를 소문자로 변환
select lower('Hong Kil Dong') as "소문자" from dual;  
-- 특정테이블에서 가져온 데이터가 아닌 select문을 하기 위한 임시 테이블을 생성함.

-- [4] upper() : 모든 문자를 대문자로 변환
select upper('Hong Kil Dong') as "대문자" from dual;  

-- [5] initcap () : 첫글자만 대문자로 변환
select initcap('hong kil dong') as "첫글자만 대문자" from dual;  

-- [6] concat() : 문자열 연결
select concat('더조은', '컴퓨터학원') from dual;  -- concat 은 2개의 단어만 가능.


-- [7] length() : 문자열의 길이
select length('더조은 컴퓨터 학원') , length('The Joeun Computer')  from dual;   -- 여백포함 글자길이


-- [8] substr() : 문자열 추출 (데이터 , 인덱스 (1), 카운트 )
select substr('홍길동 만세', 2, 4) from dual;  -- 결과: '길동 만'
--데이터의  두번째 위치에 있는 문자부터 4개의 값. 여백도 카운트에 포함.
-- 특정위치의 문자를  추출할 수 있음.


-- [9] instr() :  문자열 시작 위치
select instr('홍길동 만세', '동') from dual;
-- 데이터에서 검출하고 싶은 값의 위치정보를 알려줌.
select instr('seven', 'e') from dual;  -- e가 두개. 처음 찾은 값위치만 알려줌.


-- [10] lpad(), rpad() : 자리 채우기
select lpad('Oracle', 20, '#') from dual;
-- # 같이 하나는 문자, oracle같이 하나이상의 문자면 문자열
-- 왼쪽에 #으로 채워서 문자의 길이를 20으로 만드는 것.

select rpad('Oracle', 20, '*') from dual;
-- 오른쪽에 *으로 채워서 문자의 길이를 20으로 만드는 것.


-- [11] trim() : 컬럼이나 대상 문자열에서 특정 문자가 첫번째 글자이거나 마지막 글자이면 잘라내고 남은 문자열만 반환 .
-- 활용도가 높음. 정확히 알기!!
select trim('a' from 'aaaOracleaaaaaaaaa') from dual;  -- 처음과 마지막에 위치한 a를 필터링하여 잘라냄.

select trim(' ' from '   Oracle    ')  from dual;    -- 이런 경우가 있어서 많이 사용됨.


-- *** 수식 처리 관련 함수 ***
-- [12] round() : 반올림 (음수 : 소숫점 이상 자리 )
select round(12.34567, 3) from dual;  -- 결과 : 12.345  
-- 12.34567은 컴퓨터상 실수.  두번째에 넣은 3의 의미는 '세번째 자리'까지 보여주고 넷째자리에서 반올림.

select deptno, sal, round(sal, -3) from emp
where deptno = 30;   -- sal은 정수값으로 입력되어 있음. 따라서 round는 실수값만 받아주는 것은 아님. 정수도 가능.
-- 1600의 -3자리는 6이므로 반올림하면 2000이 됨.

-- [13] abs() : 절대값 (양수든 음수든 크기만을 반환)
select abs(10) from dual;
select abs(-10) from dual;


-- [14] floor() : 소수자리 버리기 , round의 기능과 유사하지만 실수의 소수점이하는 모두 버려짐. 정수부분만.  
select floor(12.34567) from dual;  -- 결과 : 12
select floor(-12.34567) from dual; -- 결과 : -13


-- 특정위치에서의 값만 버리고 싶을때
-- [15] trunc() : 특정 자리 자르기(특정 자릿수에서 잘라냄.)
 select trunc(12.34567, 3) from dual;    -- 결과 : 12.345  
 
-- [16] mod() : 나머지
select mod(8, 5) from dual;   -- 8/5  = 몫 1, 나머지 3


-- [17] sysdate : 날짜
select sysdate from dual;


-- [18] months_between() : 개월 수 구하기
select ename, hiredate, months_between(sysdate, hiredate) "근무 개월 수" , deptno
from emp
where deptno = 10;


-- [19] add_months() : 개월 수 더하기
select add_months(sysdate, 200) from dual;  -- 현재 날짜에서 200개월 뒤
select add_months(sysdate, -200) from dual;  -- 200개월 전

select ename, hiredate, add_months(hiredate, 2), deptno
from emp
where deptno = 10;

select add_months(20/01/01, 2) from dual; -- 오류
select add_months('20/01/01', 2) from dual;  -- 결과 출력됨.


-- [20] next_day() : 다가올 요일에 해당하는 날짜
select next_day(sysdate, '일요일') from dual;

-- [21] last_day() : 해당 달의 마지막 일 수
select last_day(sysdate) from dual;


-- [22] to_char() : 문자열로 반환
select to_char(sysdate, 'yyyy/mm/dd') from dual; -- yyyy는 yy도 가능.

-- [23] to_date() : 날짜형(date) 으로 변환
select to_date('2009/12/31','yyyy/mm/dd') from dual;  -- to_date(문자열 정보, 날짜형으로)

-- [24] nvl() : null인 데이터를 다른 데이터로 변경
select ename,comm, nvl(comm, 0) from emp;


-- [25] decode() : switch문과 같은 기능
select ename, deptno, decode(deptno,
                                            10, 'Acc',
                                            20, 'Res',
                                            30, 'Sal',
                                            40, 'Op') as"부서약자"   --  ','주의
from emp;


-- [26] case : if ~ else if ~  - decode()연관해서 생각하기
select ename, deptno, case
                                    when deptno = 10 then 'ACCOUNT' 
                                    when deptno = 20 then 'RESEARCH'
                                    when deptno = 30 then 'SALES'
                                    when deptno = 40 then 'OPERATIONS'
                                end as "부서"  -- as생략가능.
from emp;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 



