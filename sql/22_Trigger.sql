-- * ����Ŭ - Ʈ����(Trigger)

SQL>ed trig01
SQL>@trig01
SQL>select * from emp02;
-- create table emp02
-- as
-- select * from emp;

SQL>insert into emp02 values(8010, '������', 'clerk', 20);
-- emp02�� tig�� �����ϰ� ����.
SQL>insert into emp02 values(8020, '�̼���', 'salesman', 30);

-- * Ʈ���� ����
SQL>drop trigger trg_01;
