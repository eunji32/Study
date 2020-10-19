-- * ����Ŭ - ���Ǿ�(Synonym)

-- [1] ���̺� ���� �� ��ü ���� �ο��ϱ�
SQL> sqlplus system/admin1234
SQL> create table table_systbl(
                ename  varchar2(20)
);
SQL> insert into table_systbl values('�̼���');
SQL> insert into table_systbl values('������');

-- scott �����(����)���� table_systbl �̶� ���̺� select�� ������ �ο��մϴ�.
SQL> grant select on table_systbl to scott;

SQL> conn scott/tiger
SQL> select * from table_systbl; -- ���̺��� �������� �ʴ´ٴ� ����
SQL> select * from system.table_systbl; -- ��� ��µ�.


-- [2] ���Ǿ� ���� �� �ǹ� �ľ��ϱ�
SQL> conn system/admin1234
SQL> grant create synonym to scott; -- ��ı���� ���Ǿ �����ϴ� ������ �ο�?
SQL> conn scott/tiger
SQL> create synonym systab for system.table_systbl;
-- ���Ǿ�� ����ϰ��� �� �̸��� ��Ű���� ���� ��ü �̸��� �ο�?
SQL> select * from systab;  -- ( = select * from system.table_systbl;)


-- [3] ����� ���Ǿ� ���� �� �ǹ�
--     ����� ���Ƿ��� ������ �Ŀ� ����� ���� �ѿ� connect, resource role�� 
--      create synonym���Ѱ� scott�������� emp���̺��dept���̺� ���� select ��ü ������ role�� �ο�.
SQL> conn system/admin1234
SQL> create role test_role; -- �� �̸��� ���� ���� ����
SQL> grant connect, resource, create synonym to test_role; -- ���� ������ �߰�
-- connect�ȿ� synonym���� ����? �� �ֱ⵵��
-- connect, resource, + synonym ���ѵ� ������?
SQL> grant select on scott.dept to test_role; -- dept�� select���� �߰�

-- ����� ����
SQL> create user tester10 identified by tiger;
SQL> create user tester11 identified by tiger;

-- ����ڿ��� �� �ο�
SQL> grant test_role to tester10;  -- �ѹ��� ������ �ο� ����
SQL> grant test_role to tester11;

SQL> conn scott/tiger
SQL> grant select on dept to tester10;  -- ���� �̷��� ��ı�� �����ؼ� ������ �ο�

SQL> select * from dept; -- ����
SQL> select * from scott.dept; -- �����


-- ����� tester10 ����� ���Ǿ� ����
-- ����ڿ� ���� ���Ǿ ������ ��  Ư�����Ǹ� ��������Ǿ��� ��?
SQL> conn tester10/tiger
SQL> create synonym dept for scott.dept; -- ���Ǿ� ����
SQL> select * from dept; -- �̷��� �ص� ���డ������
-- tester10���Ը� ����Ǵ� ����

SQL> conn tester11/tiger
SQL> select * from dept; -- �����߻� , ���������� ���� = �����


-- [4] �������Ǿ�
SQL> conn system/admin1234
SQL> create public synonym PubDept for scott.dept;

-- ����� ����
SQL> create user tester12 identified by tiger;


-- ����ڿ��� �� �ο�
SQL> grant test_role to tester12;

SQL> conn tester12/tiger
SQL> select * from PubDept;   -- �Ϲ� ������ ������ ȣ���ؼ� ����� �� ����.
-- ������ ����� �����ϱ� ������ ���� ���Ǿ��� ��.


-- [5] ����� ���Ǿ� ����
-- : ����� ���Ǿ��� dept�� ���Ǿ ������ ����ڷ� ������ �� �����ؾߵ�.
SQL> conn tester10/tiger
SQL> drop synonym dept;
SQL> select * from dept;  -- ���� , ���̻� ���̺��� �������� ����.



-- [6] ���� ���Ǿ� ����
SQL> conn system/admin1234
SQL> drop synonym PubDept;  -- ����� ���Ǿ ���� ���
SQL> drop public synonym PubDept;  -- ���� ���Ǿ ���� ���











































