-- * 오라클 - 동의어(Synonym)

-- [1] 테이블 생성 후 객체 권한 부여하기
SQL> sqlplus system/admin1234
SQL> create table table_systbl(
                ename  varchar2(20)
);
SQL> insert into table_systbl values('이순신');
SQL> insert into table_systbl values('강감찬');

-- scott 사용자(계정)에게 table_systbl 이란 테이블에 select할 권한을 부여합니다.
SQL> grant select on table_systbl to scott;

SQL> conn scott/tiger
SQL> select * from table_systbl; -- 테이블이 존재하지 않는다는 오류
SQL> select * from system.table_systbl; -- 결과 출력됨.


-- [2] 동의어 생성 및 의미 파악하기
SQL> conn system/admin1234
SQL> grant create synonym to scott; -- 스캇에게 동의어를 생성하는 권한을 부여?
SQL> conn scott/tiger
SQL> create synonym systab for system.table_systbl;
-- 동의어로 사용하고자 할 이름에 스키마에 대한 전체 이름을 부여?
SQL> select * from systab;  -- ( = select * from system.table_systbl;)


-- [3] 비공개 동의어 생성 및 의미
--     사용자 정의롤을 생성한 후에 사용자 정의 롤에 connect, resource role과 
--      create synonym권한과 scott소유자의 emp테이블과dept테이블에 대한 select 객체 권한을 role에 부여.
SQL> conn system/admin1234
SQL> create role test_role; -- 이 이름을 가진 권한 생성
SQL> grant connect, resource, create synonym to test_role; -- 여러 권한을 추가
-- connect안에 synonym이의 권한? 이 있기도함
-- connect, resource, + synonym 권한도 가지는?
SQL> grant select on scott.dept to test_role; -- dept의 select권한 추가

-- 사용자 생성
SQL> create user tester10 identified by tiger;
SQL> create user tester11 identified by tiger;

-- 사용자에게 롤 부여
SQL> grant test_role to tester10;  -- 한번에 권한을 부여 가능
SQL> grant test_role to tester11;

SQL> conn scott/tiger
SQL> grant select on dept to tester10;  -- 원래 이렇게 스캇에 접속해서 권한을 부여

SQL> select * from dept; -- 오류
SQL> select * from scott.dept; -- 실행됨


-- 사용자 tester10 비공개 동의어 생성
-- 사용자에 의한 동의어를 생성할 때  특정동의를 비공개동의어라고 함?
SQL> conn tester10/tiger
SQL> create synonym dept for scott.dept; -- 동의어 지정
SQL> select * from dept; -- 이렇게 해도 실행가능해짐
-- tester10에게만 적용되는 개념

SQL> conn tester11/tiger
SQL> select * from dept; -- 오류발생 , 범용적이지 않음 = 비공개


-- [4] 공개동의어
SQL> conn system/admin1234
SQL> create public synonym PubDept for scott.dept;

-- 사용자 생성
SQL> create user tester12 identified by tiger;


-- 사용자에게 롤 부여
SQL> grant test_role to tester12;

SQL> conn tester12/tiger
SQL> select * from PubDept;   -- 일반 유저도 언제든 호출해서 사용할 수 있음.
-- 범용적 사용이 가능하기 때문에 공개 동의어라고 함.


-- [5] 비공개 동의어 제거
-- : 비공개 동의어인 dept는 동의어를 소유한 사용자로 접속한 후 제거해야됨.
SQL> conn tester10/tiger
SQL> drop synonym dept;
SQL> select * from dept;  -- 오류 , 더이상 테이블이 존재하지 않음.



-- [6] 공개 동의어 제거
SQL> conn system/admin1234
SQL> drop synonym PubDept;  -- 비공개 동의어에 대한 명령
SQL> drop public synonym PubDept;  -- 공개 동의어에 대한 명령











































