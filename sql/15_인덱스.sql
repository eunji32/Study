-- * 오라클 : 인덱스(Index)
-- * 삽입동작이 느리다 = 중복데이터에 대한 검색이 느리다 라는 뜻
-- 조회(검색)을 빠르게 하기 위해, 삽입을 빠르게 하기위해 생성하는 오라클 객체.
-- 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킨다. 
-- 기본 키나 유일 키는 데이터 무결성을 확인하기 위해서 수시로 데이터를 검색하기 때문에 
-- 빠른 조회를 목적으로 오라클에서 내부적으로 해당 컬럼에 인덱스를 자동으로 생성하는 것임. 

-- [1] 인덱스 정보 조회
select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP','DEPT');
-- pk_dept (primary key)가 유니크속성이 있기 때문에 인덱스기능이 자동으로 되어 생성됨.


-- [2] 조회 속도 비교하기
-- 사원 테이블 복사
drop table emp01 purge;

create table emp01
as
select * from emp;

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP', 'EMP01');  
-- 주의)  테이블의 복사는 테이블 구조와 내용만 복사될 뿐, 무결성 제약조건까지 복사 되지 않기 때문에 emp01은 검색 되지 않음.


-- 데이터 삽입 
insert into emp01 select * from emp01;  -- 28개가 됨 또다시 실행하면 56개 이런식으로...

insert into emp01(empno, ename) values(8010, 'ANGEL');
insert into emp01(empno, ename) values(8011, 'ANGEL1');
set timing on

select distinct empno, ename
from emp01
where ename = 'ANGEL';  -- 0.902 (index 연결x)


-- [3] 인덱스 생성
--  : 기본키나 유일키가 아닌 컬럼에 대해서 인덱스를 지정하려면 create index명령어를 사용.
create index idx_emp01_ename
on emp01(ename);  -- ename 컬럼에다가 index를 연결하겠다는 의미

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP','EMP01');  -- ename에 대한 인덱스가 만들어짐

select distinct empno, ename
from emp01
where ename = 'ANGEL';  -- 0.081만에 찾아짐(index연결o)

-- 인덱스가 있을 때 빠른 검색이됨을 알 수 있는 실습.


-- [4] 인덱스 제거
drop index idx_emp01_ename;

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP01');  -- 인덱스가 제거되서 결과가 없음.

drop table emp01 purge;
