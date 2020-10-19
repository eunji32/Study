-- * ����Ŭ SQL�� ���̺� ����/ ����/ ���� (=DDL)
-- [1] ���̺� ���� : create table�� 
create table exam01(
    exno          number(4), 
    exname      varchar2(20),
    exsal          number(7,2)
);  -- ��, ���ڰ� ���� ���� �ȵ� /  �÷�����



select * from tab;
select * from exam01;



-- [2] ���� ���̺�� �����ϰ� ���̺� ����� 
create table exam30
as
select * from dept;   -- ���ٷ� �ۼ��ص� ��. �������� ���� �̷��� ������....
-- emp�����͸� exam02�� �����ϰ� ����(�÷�&������, ����Ȱ�.)

create table exam03
as
select * from dept;   -- ���� ������ ����.


select * from tab;
select * from exam02;


-- [3] ���� ���̺��� ���ο� �÷� �߰� : alter��(�ʵ��߰�)
alter table exam01 
add(
    exjob     varchar2(10)    
);

select * from exam01;

desc exam01;



-- [4] ���̺� ���� ���� : �ʵ� ���� 
alter table exam01
modify(
    exjob    varchar2(20)
);

desc exam01;


-- [5] ���̺� ���� ���� : �ʵ� ���� 
alter table exam01
drop  column exjob;

select * from exam01;



-- [6] ���̺� ���� : �̸� ���� 
alter table exam01 rename to test01;    -- ù��° ���

rename test01 to exam01;   -- �ι�° ���

select * from tab;
select * from test01;
select * from exam01;



-- [7] ���̺� ���� 
drop table exam30;

select * from tab;  -- Ȯ�� ��� �̻��� ���̺��� ����. 
-- �ӽú����� ���ϰ� �����ϰ� �����ϴ� ����� ���� ���� ����. (ó������ �������� ����)
drop table exam30 purge;
-- �ӽ����̺��� �����ϰ� �ʹٸ�.....
purge recyclebin;

 
-- ����Ŭ 10���� ���ʹ� drop table~;�ϸ� �ӽ� �������°� �Ǽ� �ٽ� ���� �� �� ����.
-- �ٽ� �����Ϸ��� rename to �� �ؼ� �ٲٸ� ��.??????????????  - flashback table ~ to before drop;�� ��.
alter table BIN$GT8fjNlJTZG17RQ74jEKxQ==$0 rename to exam03;  -- ����
rename BIN$GT8fjNlJTZG17RQ74jEKxQ==$0 to exam03;  -- ����
flashback table exam01 to before drop;  -- ������

-- ����
-- recyclebin�ȿ� �ִ� ~�÷����� �˻�. (����Ŭ�� ��������) 
select object_name, original_name, type, createtime from recyclebin
order by createtime; -- ������������ ����. �ӽú����� �����͸� ������.
flashback table exam30 to before drop; -- original_name�� flashback�� ��.
flashback table exam03 to before drop rename to exam30; -- �����ϸ鼭 �ٸ� �̸����� �ٲٰ� ���� ��
flashback table "BIN$RjoS6HYmSKqJzPoieKunsQ==$0" to before drop rename to exam0;  -- ���� �̸��� ���̺��� ���� ��, �����ؼ� �����ϴ� ���.
-- �ӽ����ϸ��� Ư�����ڰ� ���� ������ �ݵ��, ""���� �����ֱ�

flashback table "BIN$RjoS6HYmSKqJzPoieKunsQ==$0" to before drop; -- ������ ���غ�. �̰��� �����Ѱ�??


-- [8] ���̺� ���� ��� ������(���ڵ�) ����
select * from exam03;
truncate table exam02;





