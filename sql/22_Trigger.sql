-- * 오라클 - 트리거(Trigger)

SQL>ed trig01
SQL>@trig01
SQL>select * from emp02;
-- create table emp02
-- as
-- select * from emp;

SQL>insert into emp02 values(8010, '강감찬', 'clerk', 20);
-- emp02에 tig를 연결하고 있음.
SQL>insert into emp02 values(8020, '이순신', 'salesman', 30);

-- * 트리거 삭제
SQL>drop trigger trg_01;
