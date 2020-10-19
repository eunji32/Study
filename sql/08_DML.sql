--*����Ŭ SQL�� : ������ �Է�/���(select��)/����/����  = DML (= C.R.U.D)
-- [1] ���� ���̺� ���� 
drop table exam01 purge;

create table exam01(
    deptno    number(2),
    dname    varchar2(14),
    loc         varchar2(14)
);

select * from tab;
select * from exam01;

-- [2] ������ �Է�(����) : insert into ~ values() 
insert into exam01(deptno, dname, loc) values(10, 'ȸ���','���α�');  -- ������ ������� �ش�Ǵ� �����͸� ����.
insert into exam01(loc, deptno, dname) values('�߱�', 20,'������');


-- [3] ������ �Է� : �� ���� 
insert into exam01 values(30, '������', '��걸'); 
-- �ʵ��� ���ϰ� ���� ���� �� ����. but ���̺� �������� ������� ���� �־��ָ� ��. create table ����!


-- [4] null �� �Է�
insert into exam01 values(40, '������', null);    -- �Է� �����Ͱ� �������� �ұ��ϰ�, error������ ���� null ����.


-- [5] ������ ���(�˻�) : select�� 
-- >> 03_select.sql �ǽ� ����!!!!!!



-- [6] �ʵ��� �����͸� ���� : �μ���ȣ ���� 
update exam01 set deptno = 30;   -- ��� �μ���ȣ�� 30����

-- [7] �޿� 10% �λ� �ݾ� �ݿ� 
drop table exam02 purge;

create table exam02
as
select * from emp;

select * from exam02;

update exam02 set sal = sal*1.1 ;  -- ��������~! ���� �ʵ��� sal�� 10%�λ�� ���� �ٽ� ����.
-- ��� �����ϸ� ��� �����Ǵϱ� �����ϱ�!


-- [8] �μ���ȣ�� 10�� ����� �μ���ȣ�� 20���� ���� 
update exam02 set deptno = 20
where deptno = 10;  



-- [9] �޿��� 3000 �̻��� ����� �޿��� 10% �λ� 
update exam02 set sal = sal*1.1
where sal >=3000;



-- [10] ��� �̸��� scott�� �ڷ��� �μ���ȣ�� 10, ������ MANAGER�� ���� 
update exam02 set deptno = 10, job = 'MANAGER'  -- and�� �ƴ� ','�� ������������.
where ename = 'SCOTT';



-- [11] 30�� �μ� ����� ���� 
delete from exam02     -- where ���ϸ� ������ ��ü ������.
where deptno = 30;


select * from exam02;

-- [12] ����� ����
delete from exam02;  -- ��� ������ ������. 































