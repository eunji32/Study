-- * 오라클 SQL문 테이블 생성/ 수정/ 삭제 (=DDL)
-- [1] 테이블 생성 : create table문 
create table exam01(
    exno          number(4), 
    exname      varchar2(20),
    exsal          number(7,2)
);  -- 단, 숫자가 먼저 오면 안됨 /  컬럼지정



select * from tab;
select * from exam01;



-- [2] 기존 테이블과 동일하게 테이블 만들기 
create table exam30
as
select * from dept;   -- 한줄로 작성해도 됨. 가독성을 위해 이렇게 했을뿐....
-- emp데이터를 exam02에 동일하게 저장(컬럼&데이터, 복사된것.)

create table exam03
as
select * from dept;   -- 아직 실행은 안함.


select * from tab;
select * from exam02;


-- [3] 기존 테이블에서 새로운 컬럼 추가 : alter문(필드추가)
alter table exam01 
add(
    exjob     varchar2(10)    
);

select * from exam01;

desc exam01;



-- [4] 테이블 구조 수정 : 필드 수정 
alter table exam01
modify(
    exjob    varchar2(20)
);

desc exam01;


-- [5] 테이블 구조 수정 : 필드 삭제 
alter table exam01
drop  column exjob;

select * from exam01;



-- [6] 테이블 수정 : 이름 변경 
alter table exam01 rename to test01;    -- 첫번째 방법

rename test01 to exam01;   -- 두번째 방법

select * from tab;
select * from test01;
select * from exam01;



-- [7] 테이블 삭제 
drop table exam30;

select * from tab;  -- 확인 결과 이상한 테이블이 생김. 
-- 임시보관도 못하게 깨끗하게 삭제하는 명령을 내릴 수도 있음. (처음부터 흔적없이 삭제)
drop table exam30 purge;
-- 임시테이블을 삭제하고 싶다면.....
purge recyclebin;

 
-- 오라클 10버전 부터는 drop table~;하면 임시 보관상태가 되서 다시 복원 할 수 있음.
-- 다시 복원하려면 rename to 로 해서 바꾸면 됨.??????????????  - flashback table ~ to before drop;은 됨.
alter table BIN$GT8fjNlJTZG17RQ74jEKxQ==$0 rename to exam03;  -- 오류
rename BIN$GT8fjNlJTZG17RQ74jEKxQ==$0 to exam03;  -- 오류
flashback table exam01 to before drop;  -- 복원됨

-- 복원
-- recyclebin안에 있는 ~컬럼들을 검색. (오라클이 정보관리) 
select object_name, original_name, type, createtime from recyclebin
order by createtime; -- 오름차순으로 정렬. 임시보관된 데이터를 보여줌.
flashback table exam30 to before drop; -- original_name을 flashback을 됨.
flashback table exam03 to before drop rename to exam30; -- 복원하면서 다른 이름으로 바꾸고 싶을 때
flashback table "BIN$RjoS6HYmSKqJzPoieKunsQ==$0" to before drop rename to exam0;  -- 같은 이름의 테이블이 있을 시, 선택해서 복원하는 방법.
-- 임시파일명은 특수문자가 들어가기 때문에 반드시, ""으로 감싸주기

flashback table "BIN$RjoS6HYmSKqJzPoieKunsQ==$0" to before drop; -- 실행은 안해봄. 이것은 가능한가??


-- [8] 테이블 내의 모든 데이터(레코드) 삭제
select * from exam03;
truncate table exam02;





