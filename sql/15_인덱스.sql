-- * ����Ŭ : �ε���(Index)
-- * ���Ե����� ������ = �ߺ������Ϳ� ���� �˻��� ������ ��� ��
-- ��ȸ(�˻�)�� ������ �ϱ� ����, ������ ������ �ϱ����� �����ϴ� ����Ŭ ��ü.
-- �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü ������ ����Ų��. 
-- �⺻ Ű�� ���� Ű�� ������ ���Ἲ�� Ȯ���ϱ� ���ؼ� ���÷� �����͸� �˻��ϱ� ������ 
-- ���� ��ȸ�� �������� ����Ŭ���� ���������� �ش� �÷��� �ε����� �ڵ����� �����ϴ� ����. 

-- [1] �ε��� ���� ��ȸ
select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP','DEPT');
-- pk_dept (primary key)�� ����ũ�Ӽ��� �ֱ� ������ �ε�������� �ڵ����� �Ǿ� ������.


-- [2] ��ȸ �ӵ� ���ϱ�
-- ��� ���̺� ����
drop table emp01 purge;

create table emp01
as
select * from emp;

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP', 'EMP01');  
-- ����)  ���̺��� ����� ���̺� ������ ���븸 ����� ��, ���Ἲ �������Ǳ��� ���� ���� �ʱ� ������ emp01�� �˻� ���� ����.


-- ������ ���� 
insert into emp01 select * from emp01;  -- 28���� �� �Ǵٽ� �����ϸ� 56�� �̷�������...

insert into emp01(empno, ename) values(8010, 'ANGEL');
insert into emp01(empno, ename) values(8011, 'ANGEL1');
set timing on

select distinct empno, ename
from emp01
where ename = 'ANGEL';  -- 0.902 (index ����x)


-- [3] �ε��� ����
--  : �⺻Ű�� ����Ű�� �ƴ� �÷��� ���ؼ� �ε����� �����Ϸ��� create index��ɾ ���.
create index idx_emp01_ename
on emp01(ename);  -- ename �÷����ٰ� index�� �����ϰڴٴ� �ǹ�

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP','EMP01');  -- ename�� ���� �ε����� �������

select distinct empno, ename
from emp01
where ename = 'ANGEL';  -- 0.081���� ã����(index����o)

-- �ε����� ���� �� ���� �˻��̵��� �� �� �ִ� �ǽ�.


-- [4] �ε��� ����
drop index idx_emp01_ename;

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP01');  -- �ε����� ���ŵǼ� ����� ����.

drop table emp01 purge;
