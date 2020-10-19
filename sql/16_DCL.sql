-- * ����Ŭ : �����(User) ����(Role)
-- �����Ͱ� ������ �ִ�/����� �� �ִ� ��ɾ��. = DCL(Data Control Language)
-- ȸ�� �Ի�� DB���� ������ �� ������ �� �ִ� ������ �ο����� �� �����Ͱ� ������� �ο����� �� �ִ����� ���� ���� �˾ƺ��� ��.
-- ���� : ����ڰ� Ư�� ���̺��� ������ �� �ֵ��� �ϰų� �ش� ���̺� SQL(SELECT/INSERT/UPDATE/DELETE) ���� ����� �� �ֵ��� ������ �δ� ��

-- [1] thomas ���� ����
-- ���� ������ ������ �������� ����.
-- ���� system���� �����ϴ� ȯ���� ��������.
-- ���Ӱ��� ���� ����.  �̸� master ������̸��� ��й�ȣ�� system���� 

create user thomas identified by tiger;  -- ���������� �Բ� ��й�ȣ �ο�

-- commandâ�� sqlplus(����)������, ����  lacks CREATE SESSION��� ��. : ���ӿ���
-- ������ ���ѵ� �ο� �޾ƾ� ��.

-- [2] �����ͺ��̽� ���� ���� �ο� -CREATE SESSION
grant create session to thomas;  -- grant���� >> commandâ���� ���ӵ�.
-- �ܰ谡 ���� ���� : ���Ȱ�ȭ�� ���� (���������� ����)

SQL>sqlplus thomas/tiger -- �̷��� ǥ���ϸ� commandâ���� ����ϴ� ������ ǥ��
SQL>create table emp01(
            empno    number(2),
            ename    varchar2(10),
            job        varchar2(10),
            deptno    number(2)
); 
-- ���� �����͸� �����ϸ� system���� �����ϴ� ��. ����!! �����Ͱ������� �ϸ� �ȵ�.
-- commandâ���� thomas�� �����ؼ� ���� ����� ���� ���� �� ���� �߻�. -- ���̺������ ���� ������ �ο��޾ƾߵ�.


-- [3] ���̺� ���� ����  
grant create table to thomas; -- ���⼭ ����

SQL>create table emp01(
            empno    number(2),
            ename    varchar2(10),
            job        varchar2(10),
            deptno    number(2)
);  -- commandâ 
-- �� ���� : no privileges on tablespace 'SYSTEM'
-- : no privileges on tablespace 'SYSTEM' :  ���̺��� ����� ���� ������Ҵ� ���Ѻο� ������� �ǹ�
-- ���Ȱ� ȿ���� �����ͺ��̽� ������ ���� �̷��� ����...


-- [4] ���̺� �����̽� Ȯ�� 
-- : ���̺� �����̽�(table space)�� ��ũ ������ �Һ��ϴ� ���̺�� �� �׸��� �� ���� �ٸ� �����ͺ��̽� ��ü���� ����Ǵ� ���.
-- cf) ����Ŭ xe ������ ��� �޸� ������ system���� �Ҵ�.
--      ����Ŭ full������ ��� �޸� ������ users���� �Ҵ�.  
alter user thomas quota 2m on system;  -- xe����
alter user thomas quota 2m on users;  -- full����

SQL>create table emp01(
            empno    number(2),
            ename    varchar2(10),
            job        varchar2(10),
            deptno    number(2)
);  -- commandâ 
-- �����غ��� ������.

SQL> select * from tab; -- command Ȯ��


-- * ���� ���� �� ���̺� ���������� ���� �ο� ����
SQL>sqlplus system/admin1234 --�����Ͱ�������
create user thomas identified by tiger; -- ��������
grant create session to thomas;  -- �������ӱ��Ѻο�
grant create table to thomas; -- ���̺� �������� �ο�
alter user thomas quota 2m on system;  -- �����̽� �Ҵ�
-- �Ŀ� �ش� ���� ���Ӱ� ���̺��� ������ �� ����.



-- [5] with admin option
-- : ����ڴ� �����ͺ��̽� �����ڰ� �ƴѵ��� �ұ��ϰ� �ο� ���� �ý��� ������ �ٸ� ����ڿ��� �ο��� �� �ִ� ���ѵ� �Բ� �ο� �ް� ��.
-- ������ �Ӹ��ƴ϶� �ٸ� ����� DB�� ������ �� ����.

-- tester1 ���� ���� �� ���� �ο�
create user tester1 identified by tiger; -- ��������
grant create session to tester1;  -- �������ӱ��Ѻο�
grant create table to tester1; -- ���̺� �������� �ο�
alter user tester1 quota 2m on system; -- �����̽� �Ҵ�

-- command â���� tester1�� �����ؼ�
SQL>sqlplus tester1/tiger
SQL> grant create session to thomas; -- tester1���Դ� ������ ���� ������ ����

-- �ɼ��� ����ؼ� �κ��� ���� �ο� : �������� ����
-- tester3 ���� ���� �� ���� �ο�
create user tester3 identified by tiger; -- ��������
grant create session to tester3 with admin option;  -- �������ӱ��Ѻο�
grant create table to tester3; -- ���̺� �������� �ο�
alter user tester3 quota 2m on system; -- �����̽� �Ҵ�

-- command â���� tester3�� �����ؼ�
SQL>sqlplus tester3/tiger
SQL> grant create session to thomas; --Grant succeeded. ���ӵ�.



-- [6] ���̺� ��ü�� ���� select ���� �ο�(scott/emp -> thomas)
SQL> sqlplus scott/tiger
SQL> conn scott/tiger
SQL> grant select on emp to thomas; --������ �ο���. thomas�� emp�� �о�ü� ����.
SQL> select * from emp;-- ������ �޾Ҵµ�, ����� ���̺��� �������� �ʴ´ٰ� ������


-- ** �ݵ�� üũ!! 
--[7] ��Ű��(SCHEMA) :  ��ü�� ������ ����ڸ��� �ǹ�.
SQL>select * from scott.emp;  -- ��ü�� �������� �̸��� �Բ� / ���̺��� �о��.


-- [8] ����ڿ��� �ο��� ���� ��ȸ : thomas�������� ���ӽ�
-- user_tab_privs_made : ���� ����ڰ� �ٸ� ����ڿ��� �ο��� ���� ������ �˷���.
SQL> select * from user_tab_privs_made;  -- ��ı�� �ο����� ���̱� ������ �丶�� ������ ����?
-- user_tab_privs_recd  :  �ڽſ��� �ο��� ����� ������ �˰� ���� ��.
SQL> select * from user_tab_privs_recd;  -- ��ı���� emp���̺��� select�� ������ �ο� ����??

-- �ݴ�� scott���� ���ӽ�
SQL> select * from user_tab_privs_made;  --�丶������ �� ���� ������
SQL> select * from user_tab_privs_recd; -- �̰��� ���� �ȳ���.

-- [9] ��й�ȣ �����
-- �����Ͱ����� ������Ѱ���
alter user thomas identified by thomas;


-- [10] ��ü ���� �����ϱ�
SQL>sqlplus scott/tiger
SQL>revoke select on emp from thomas; -- emp�� ������ �� �ִ� ������ �丶���� ���� ����
-- �丶���������� emp�� ������ �� �� ����.


-- [11] with grant option
-- ��ü������ �ٸ� ����ڿ��� �ο��ϴ� ������ �ο� �޴� ��.   <> with admin option�� �ý��۱����� �޴°�
SQL>sqlplus scott/tiger
SQL>grant select on emp to tester1 with grant option;  -- emp�� ���� select�� ������ �ο�.
--emp�� ��ı��ü�� ������ ��ı���Ը� �־��µ� tester1���� emp������ �ο������鼭 �ο��ϴ� ���ѵ� �ο�����.
SQL> conn tester1/tiger
SQL> select * from scott.emp; -- ����
SQL> grant select on scott.emp to tester2;  -- ����ؼ� ������ �ο� �� �� ����.
SQL> conn tester2/tiger
SQL> select * from scott.emp; -- ���⼭�� ����


-- [12] ����� ���� ����
-- ���̻� �������� ���ϰ� ����
drop user tester3;
drop user tester2;  --command â���� ����� ���¸� ������ �ȵ�.


-- [13] ����(Role)
-- Role�� ���� ������ ������� ��.
create user tester3 identified by tiger;
grant connect, resource to tester3;  -- �� ������� ���� ������ �ο� ����. (DCL)

SQL> conn tester3/tiger
SQL> select * from dict
          where table_name like '%ROLE%';



















