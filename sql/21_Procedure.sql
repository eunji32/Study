-- * ����Ŭ - ���� ���ν���(procedure)

drop table emp01 purge; -- ���̺� ����

create table emp01
as
select * from emp;

SQL> ed proc01 -- ���ν��� ���� �ڵ� �۾�

--������ �о���鼭 ��ɹ� �����Ͽ� 
SQL>@proc01  -- ���ν��� ����
SQL>execute del_all -- ���ν��� ����
-- �Լ� ȣ���ϵ��� ��밡��..
-- �ʿ��Ҷ����� �����ϰ� ȣ���Ͽ� ��밡��.
SQL>select * from emp01;

-- [1] �������ν��� ��ȸ�ϱ�
SQL>desc user_source;
SQL>select name, text from user_source;

-- [2] ���� ���ν����� �Ű�����
SQL>insert into emp01 select * from emp;
SQL>ed proc02
SQL>@proc02
SQL>execute del_ename('SCOTT')

-- [3] IN, OUT, INOUT �Ű�����
SQL>ed proc03
SQL>@proc03

SQL>variable var_ename varchar2(20);
--variable ��������
SQL>variable var_sal      number;
SQL>variable var_job     varchar2(10);

SQL>execute sel_empno(7788, :var_ename, :var_sal, :var_job);
-- ��¿� ������ ����.

SQL>print var_ename;
SQL>print var_sal;
SQL>print var_job;


-- [4] �����Լ�
SQL>ed proc04 
SQL>@proc04

SQL>variable var_result number;
SQL>execute :var_result := cal_bonus(7788);
-- cal_bonus(7788)�� var_result�ȿ� ����
-- :�� �ٿ��� var_result�� ��¿� ������ ����
SQL>print var_result;


-- [5] Cursor(Ŀ��)
SQL>select * from dept;

SQL>ed proc05
SQL>@proc05
SQL>set serveroutput on 
SQL>execute cursor_sample01;



