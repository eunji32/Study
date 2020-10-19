-- * 오라클 : 사용자(User) 권한(Role)
-- 마스터가 가지고 있는/사용할 수 있는 명령어들. = DCL(Data Control Language)
-- 회사 입사시 DB에서 관리할 때 접근할 수 있는 권한을 부여받을 때 마스터가 어떤식으로 부여해줄 수 있는지에 대한 것을 알아보는 것.
-- 권한 : 사용자가 특정 테이블을 접근할 수 있도록 하거나 해당 테이블에 SQL(SELECT/INSERT/UPDATE/DELETE) 문을 사용할 수 있도록 제한을 두는 것

-- [1] thomas 계정 생성
-- 계정 생성은 마스터 계정만이 가능.
-- 따라서 system으로 접속하는 환경을 만들어야함.
-- 접속계정 만들어서 접속.  이름 master 사용자이름과 비밀번호에 system으로 

create user thomas identified by tiger;  -- 계정생성과 함께 비밀번호 부여

-- command창에 sqlplus(접속)했을때, 오류  lacks CREATE SESSION라고 뜸. : 접속오류
-- 접속의 권한도 부여 받아야 됨.

-- [2] 데이터베이스 접속 권한 부여 -CREATE SESSION
grant create session to thomas;  -- grant성공 >> command창에서 접속됨.
-- 단계가 많은 이유 : 보안강화를 위해 (여러인증을 통한)

SQL>sqlplus thomas/tiger -- 이렇게 표시하면 command창에서 명령하는 것으로 표시
SQL>create table emp01(
            empno    number(2),
            ename    varchar2(10),
            job        varchar2(10),
            deptno    number(2)
); 
-- 위의 데이터를 실행하면 system에서 실행하는 것. 절대!! 마스터계정에서 하면 안됨.
-- command창에서 thomas로 접속해서 위의 명령을 실행 했을 때 오류 발생. -- 테이블생성에 대한 권한을 부여받아야됨.


-- [3] 테이블 생성 권한  
grant create table to thomas; -- 여기서 실행

SQL>create table emp01(
            empno    number(2),
            ename    varchar2(10),
            job        varchar2(10),
            deptno    number(2)
);  -- command창 
-- 또 오류 : no privileges on tablespace 'SYSTEM'
-- : no privileges on tablespace 'SYSTEM' :  테이블을 만들기 위한 저장소할당 권한부여 받으라는 의미
-- 보안과 효율적 데이터베이스 관리를 위해 이렇게 복잡...


-- [4] 테이블 스페이스 확인 
-- : 테이블 스페이스(table space)는 디스크 공간을 소비하는 테이블과 뷰 그리고 그 밖의 다른 데이터베이스 객체들이 저장되는 장소.
-- cf) 오라클 xe 버전의 경우 메모리 영역은 system으로 할당.
--      오라클 full버전의 경우 메모리 영역은 users으로 할당.  
alter user thomas quota 2m on system;  -- xe버전
alter user thomas quota 2m on users;  -- full버전

SQL>create table emp01(
            empno    number(2),
            ename    varchar2(10),
            job        varchar2(10),
            deptno    number(2)
);  -- command창 
-- 실행해보면 생성됨.

SQL> select * from tab; -- command 확인


-- * 계정 생성 및 테이블 생성까지의 권한 부여 정리
SQL>sqlplus system/admin1234 --마스터계정에서
create user thomas identified by tiger; -- 계정생성
grant create session to thomas;  -- 계정접속권한부여
grant create table to thomas; -- 테이블 생성권한 부여
alter user thomas quota 2m on system;  -- 스페이스 할당
-- 후에 해당 계정 접속과 테이블을 생성할 수 있음.



-- [5] with admin option
-- : 사용자는 데이터베이스 관리자가 아닌데도 불구하고 부여 받은 시스템 권한을 다른 사용자에게 부여할 수 있는 권한도 함께 부여 받게 됨.
-- 마스터 뿐만아니라 다른 사람도 DB를 관리할 수 있음.

-- tester1 계정 생성 및 권한 부여
create user tester1 identified by tiger; -- 계정생성
grant create session to tester1;  -- 계정접속권한부여
grant create table to tester1; -- 테이블 생성권한 부여
alter user tester1 quota 2m on system; -- 스페이스 할당

-- command 창에서 tester1로 접속해서
SQL>sqlplus tester1/tiger
SQL> grant create session to thomas; -- tester1에게는 권한이 없기 때문에 오류

-- 옵션을 사용해서 부분적 권한 부여 : 계정접속 권한
-- tester3 계정 생성 및 권한 부여
create user tester3 identified by tiger; -- 계정생성
grant create session to tester3 with admin option;  -- 계정접속권한부여
grant create table to tester3; -- 테이블 생성권한 부여
alter user tester3 quota 2m on system; -- 스페이스 할당

-- command 창에서 tester3로 접속해서
SQL>sqlplus tester3/tiger
SQL> grant create session to thomas; --Grant succeeded. 접속됨.



-- [6] 테이블 객체에 대한 select 권한 부여(scott/emp -> thomas)
SQL> sqlplus scott/tiger
SQL> conn scott/tiger
SQL> grant select on emp to thomas; --권한이 부여됨. thomas가 emp를 읽어올수 있음.
SQL> select * from emp;-- 권한을 받았는데, 실행시 테이블이 존재하지 않는다고 오류남


-- ** 반드시 체크!! 
--[7] 스키마(SCHEMA) :  객체를 소유한 사용자명을 의미.
SQL>select * from scott.emp;  -- 객체의 소유계정 이름과 함께 / 테이블을 읽어옴.


-- [8] 사용자에게 부여된 권한 조회 : thomas계정으로 접속시
-- user_tab_privs_made : 현재 사용자가 다른 사용자에게 부여한 권한 정보를 알려줌.
SQL> select * from user_tab_privs_made;  -- 스캇이 부여해준 값이기 때문에 토마스 내용이 없음?
-- user_tab_privs_recd  :  자신에게 부여된 사용자 권한을 알고 싶을 때.
SQL> select * from user_tab_privs_recd;  -- 스캇에게 emp테이블의 select의 권한을 부여 받음??

-- 반대로 scott계정 접속시
SQL> select * from user_tab_privs_made;  --토마스에게 준 값이 보여짐
SQL> select * from user_tab_privs_recd; -- 이것은 값이 안나옴.

-- [9] 비밀번호 변경시
-- 마스터계정만 변경권한가능
alter user thomas identified by thomas;


-- [10] 객체 권한 제거하기
SQL>sqlplus scott/tiger
SQL>revoke select on emp from thomas; -- emp에 접근할 수 있는 권한을 토마스로 부터 제거
-- 토마스계정으로 emp를 이제는 볼 수 없음.


-- [11] with grant option
-- 객체권한을 다름 사용자에게 부여하는 권한을 부여 받는 것.   <> with admin option은 시스템권한을 받는거
SQL>sqlplus scott/tiger
SQL>grant select on emp to tester1 with grant option;  -- emp에 대한 select의 권한을 부여.
--emp는 스캇객체라 권한이 스캇에게만 있었는데 tester1에게 emp권한을 부여받으면서 부여하는 권한도 부여받음.
SQL> conn tester1/tiger
SQL> select * from scott.emp; -- 가능
SQL> grant select on scott.emp to tester2;  -- 계속해서 권한을 부여 할 수 있음.
SQL> conn tester2/tiger
SQL> select * from scott.emp; -- 여기서도 가능


-- [12] 사용자 계정 제거
-- 더이상 접근하지 못하게 계정
drop user tester3;
drop user tester2;  --command 창에서 연결된 상태면 삭제가 안됨.


-- [13] 권한(Role)
-- Role은 여러 권한을 묶어놓은 것.
create user tester3 identified by tiger;
grant connect, resource to tester3;  -- 이 명령으로 여러 권한을 부여 받음. (DCL)

SQL> conn tester3/tiger
SQL> select * from dict
          where table_name like '%ROLE%';



















