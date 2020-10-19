-- * ����Ŭ - ��(View)

-- [1] ���� �׽�Ʈ�� ���̺� ����
-- 1) DEPT ���̺��� ������ DEPT_COPY ���̺� ����
create table dept_copy
as
select * from dept;

-- 2) EMP ���̺��� ������ EMP_COPY ���̺� ����
create table emp_copy
as
select * from emp;



-- [2] ��(view) �����ϱ�
--     �並 �����ϱ� ���ؼ��� create view�� ������.
--     as ������ ��ġ ������������ ������.
--     ���������� �츮�� ���ݱ��� ����Ͽ��� select���� ����ϸ� ��.
--  ���̺�� �޸� ��������� ������ �ʴ´�. / ���̺�� ���� �����ϰ� ��޵� �� �ִ� ������ ����

-- ex) ���� 30�� �μ��� �Ҽӵ� ������� ����� �̸��� �μ���ȣ�� ���� �˻��Ѵٰ� �ϸ�
select empno, ename, deptno
from emp_copy
where deptno = 30;

-- ���� ���� ����� ����ϱ� ���ؼ� �Ź� select���� �Է��ϱ�� ���� ���ŷο� ���� �ƴ� �� ����.
-- ��� �̿Ͱ��� ���ŷο� select���� �Ź� �Է��ϴ� ��� ���� ���� ���ϴ� ����� ������ϴ� �ٷ����� ����� ����.
-- ���� �����ͷ� ���� �о���� ������ ���̺� . ���� �����ʹ� �ƴ�.
create view emp_view30
as 
select empno, ename, deptno
from emp_copy
where deptno = 30; -- ����
-- �ý��۰������� ������ �ο��޾ƾ� ����.

-- [View�� ������ �� �ִ� ���� �ο�]
--  .dos command â���� sqlplus�� ����
sql> sqlplus system/admin1234
sql>show user
sql>grant create view to scott;  -- ���� �ο� ��ɾ� grant  : scott�������� create view��� ������ �ο� �� �ְڴٴ� �ǹ�.

create view emp_view30
as 
select empno, ename, deptno
from emp_copy
where deptno = 30;  -- ���� �ο��� �����ϸ� ������.

-- ���ѵ��� �ο� �޾ƾ߸� db���� ���������� ���� ����.

select * from emp_view30;  
-- �޸� ���� ����. �ش絥���� �ǽð� �о�ͼ� ���డ��. ������ ���̺��� ���� �ʿ��� �����͸� ������.
-- �ٸ��̰� ���� �� �� �ִ� ���������̺�. ���ٹ����� ���������� �� �� �ִ� ���̺�

desc emp_view30;

--desc ��? not null�̶�� �Ǿ����� == �����̸Ӹ�Ű �����Ȱ�.
-- ���簡 �Ǿ��� �� ���Ἲ�������Ǳ��� ��������� ����. / �����͸�!

desc emp;


-- [����] �⺻ ���̺��� emp_copy�� ��. 
--  20�� �μ��� �Ҽӵ� ������� ����� �̸�, �μ���ȣ, ����� ����� ����ϱ� ���� select ���� emp_view20 �̶�� �̸��� ��� ����.
create view emp_view20
as
select empno, ename, deptno, mgr
from emp_copy
where deptno = 20;

select * from emp_view20;
-------------------------------------
create or replace view emp_view20
as
select empno, ename, deptno, mgr
form emp_copy
where deptno = 20;


-- view�� ������ ������ ����
-- [3] ���� ���α����� user_views ������ ��ųʸ�
-- ������ ���Ἲ �������ǿ��� user_constraints �� view
desc user_views;

select view_name, text 
from user_views;  -- ����� ���� view�� ������ ������.

-- [4] ���� ���� ����
-- 1. ����ڰ� �信 ���ؼ� ���Ǹ� �ϸ� user_views���� �信 ���� ���Ǹ� ��ȸ.
-- 2. �⺻���̺� ���� ���� ���� ������ ���ɴ�.
-- 3. �信 ���� ���Ǹ� �⺻���̺� ���� ���Ƿ� ��ȯ.
-- 4. �⺻���̺� ���� ���Ǹ� ���� �����͸� �˻�.
-- 5. �˻��� ����� ����Ѵ�.

-- ���� �������� �������ǹ̸� �ľ�!

-- [5] ��� �⺻ ���̺� ���� �ľ�
--  1) �並 ���� ������ ������ ����?
insert into emp_view30 values(8000, 'ANGEL',30);  -- ������ ��.

select * from emp_view30; -- ���Ե�.

select * from emp_copy; -- �̰����� ���Ե�.

-- ��, view�� ������ ���̺��̱� ������ �� �䰡 �����ϰ� �ִ� �⺻���̺��� �����Ͱ� ���� ��.
-- ���� �⺻���̺� ���÷���  not null���Ἲ���� ������ �ְ�, view�� �����͸� �����ϴٰ� �� �÷��� null�� �ȴٸ� ������ �ȵ�.

-- [6] �並 ����ϴ� ����? - pdf�� ���
-- ���ȿ� ���� ex) �λ�� ��
create view emp_view  -- �޿��� �ΰ��� ���� ������ ����
as
select empno, ename, job, hiredate, deptno -- ���� ������ ������ �ʿ� ������ �����ټ� ����.
from emp_copy;

-- [7] ���� Ư¡
-- 1) �ܼ� �信 ���� ������ ����
insert into emp_view30
values(8010, 'CHEOLSOO', 30 );  -- ����� ���Ἲ ������ ���⿡ �����ʹ� �� ���Ե�.

select * from emp_view30;

select * from emp_copy; 
-- ��Ģ������ �󸶵��� ���԰���


-- 2) �ܼ� ���� �÷��� ��Ī �ο��ϱ�
create view emp_view_copy(�����ȣ, �����, �޿�, �μ���ȣ)  -- ����ǥX
as
select empno, ename, sal,deptno
from emp_copy; 

select * from emp_view_copy;

select * from emp_view_copy
where deptno = 30; -- �����߻�
-- ��Ī�� �ο��߱⶧���� ���� �÷��̸����� ���� �Ұ�
-- deptno�� �ƴ϶� �μ���ȣ��� �÷��̸����� �����
select * from emp_view_copy
where �μ���ȣ = 30;  -- �����.


-- 3) �׷��Լ��� ����� �ܼ� ��
create view view_sal
as
select deptno, sum(sal), avg(sal)
from emp_copy
group by deptno;  -- ���� : sum���� ��쿡�� �������̺��� �÷��̸��� �ƴ϶� ����� ���� �÷��̱� ������


create view view_sal
as
select deptno, sum(sal) as "�޿���", avg(sal) as "�޿� ���"
from emp_copy
group by deptno; -- ������. 

select * from view_sal;


-- ����) 
create view view_sal_year
as
select ename, sal*12 "����"
from emp_copy;  --���꿡 ���� ���� �÷��׸��̱� ������ ���� ��Ī�� �ο��ؼ� ��������.

select * from view_sal_year;

insert into view_sal_year
values('miae', 12000);  -- ����
--  �⺻���̺�(emp_copy)���� �����̶�� ���̺��� ���� ������ �����Ͱ� �߰������� ����.



-- 4) ���պ� (emp + dept)
select empno, ename, sal, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno  -- equi join
order by empno desc;
-------------------------------
create view emp_view_dept
as
select empno, ename, sal, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno  
order by empno desc;


select * from emp_view_dept; 


-- [8] �� ����
drop view emp_view_dept; -- ������ ����

select * from tab;


-- [9] �� ������ ���Ǵ� �پ��� �ɼ�(or replace) :  �������� �ʴ� ���̸� ���ο� �並 �����ϰ�, ������ �����ϴ� ���̸�  ���� ������ ���ְ� ���� view�����Ѵ�. 
select view_name, text 
from user_views; -- veiw ����
--------------------------
create or replace view emp_view40
as
select empno, ename, comm, deptno
from emp_copy
where deptno = 30;
-- ������ ���� view�̸� �Ϲ����� view������ ���� / ��, ���� �̸��� �䰡 ���� ��� ���� �߻�
-- �׷��� ������ �ִ� view�̸� ������
select * from emp_view30;  


-- [10] �� ������ ���Ǵ� �پ��� �ɼ�(force / noforce)
-- force : �⺻���̺��� �������� ���� ���� �並 �����ؾ� �ϴ� ��� ����ϴ� �ɼ�. 
-- noforce : �⺻���̺��� �����ϴ� ��츸 �䰡 ����(default). 
desc emplyees; -- ���� ���̺��� ���� ������ ����

select * from emplyees; -- �������̺��� ���� ������ ����

create or replace view employees_view
as
select empno, ename, deptno
from employees
where deptno = 30;   -- �������̺��� ���� ������ ����

create or replace force view employees_view  --force
as
select empno, ename, deptno
from employees
where deptno = 30;  -- ������ ������ �Բ� �䰡 ������./ �⺻���̺��� ������ �ӽ����̺�� ����.

select view_name, text
from user_views;  -- employees_view ���̺��� �����Ǿ������� Ȯ���� �� ����. 
-- �ӽ������� ����� �� �ִ� �䰡 ����.

insert into employees_view
values(8020, '�̼���', 30);  -- ���� , ������ �����ϴ� ���� �ƴϱ� ������ (�ӽ����̺���)

-- force�� ���� ��Ȳ�� ���� ����. �������� �̷� ���̺��� �����Ѵٴ� ������ ���信�� �ӽ������� ó���ϰ��� �Ҷ�
-- �̷� ���̺� �����͸� �����ϰ� �ϸ� ����. �׷��� �ӽ�������???
-- �� force�� �ٿ�����?�� �ǹ̸� �˾ƾ���.

--  dual �� view�� ��������????
-- dual ���̺��� ����ڰ� �Լ�(���)�� ������ �� �ӽ÷� ����ϴµ� �����ϴ�.
-- �Լ��� ���� ������ �˰� ������ Ư�� ���̺��� ������ �ʿ���� dual ���̺��� �̿��Ͽ� �Լ��� ���� ����(return)���� �� �ִ�.
-- �並 ����ϴ� �Ϲ����� ������ ������ ���� �з��� �� �ִ�.
--(1). ���� ������ �������� Ȱ�� ( ���ȼ� ) : �λ����� ���� ������ ���߱� ���ؼ�
--(2). ������ ���Ǹ� �������� Ȱ�� ( ���Ǽ� ) : ���� ���� ���̺�� ������ �並 ���������ν� �����Ϳ� ���� ���⼺�� ���� �� �ִ�.
--(3). ����ӵ��� ����� �������� Ȱ�� ( �ӵ� ��� ) : Ư�� ������ ���� ó���ǵ��� �ϰų� Ʃ�׵� �並 �����Ͽ� ����ӵ��� ����ų �������� ���
--(4). ���뼺�� ����ų �������� Ȱ�� ( ���뼺 ) : ��� ������ ���̳� ������Ʈ�� ���ǰ� ����Ǵ��� ���ø����̼ǿ��� ������ ��ġ�� �ʵ��� �� �� �ִ�.
--(5) �ӽ����� �۾��� ���� Ȱ���Ѵ�. ( �ӽü� ) : Ư���� ����� ������ ���� �۾��̳�, ���߽ÿ� �ߺ� �����͸� �����ϰų�, 
--    ���ø����̼� �ۼ� ���� ó�������� ������ ���� ���� Ȱ���� �� �ִ�.


-- [11] �� ������ ���Ǵ� �پ��� �ɼ�(with check option )
-- : �並 ������ �� ���� ���ÿ� ���� �÷� ���� ���� ���ϵ��� �ϴ� ���
-- : �並 ������ �� �������� ������ �÷� �̿��� �ٸ� �÷��� ������ ������ �� ����. 
create or replace view emp_view30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno = 30;

select * from emp_view30;

-- ����) 30�� �μ��� �Ҽӵ� ��� �߿� �޿��� 1200�̻��� ����� 20�� �μ��� �̵���Ű��.
update emp_view30 -- ������ �����̱� ������ update
set deptno = 20  -- ������ �� ��� ��� 30�� ����̴ϱ�
where sal >= 1200;  -- ���ǿ� �´� �����ʹ� 20������ �ٲ��� ������ 30���� �͸� ��µ�.
-- �ƹ��� ������ ���⶧���� �ٷ� ������ ��.
-- �̷� ���, �⺻���̺��� ����Ǳ� ������, ���� ����� �����ϴ� ��쿡�� ���� �߻�
select * from emp_copy;

create or replace view view_chk30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno = 30 with check option;
-- 

select * from view_chk30;

update view_chk30
set deptno = 20
where sal >= 900;  -- ���� , with check option������ 
-- view�� �˻�, �����̳� ����, ���� ������ �����ѵ�, �� �ɼ��� �ɸ� ������ �ȵǰ� �˻��� ����.
-- with check option������ �� �÷��� �����Ұ�

-- [12] �� ������ ���Ǵ� �پ��� �ɼ�(with read only ) :�⺻ ���̺��� � �÷��� ���ؼ��� �並 ���� ���� ������ �Ұ����ϰ� ����� �ɼ�.
create table emp_copy03
as
select * from emp;

create or replace view view_check30
as
select empno, ename, sal, comm, deptno
from emp_copy03
where deptno = 30;

update view_check30
set comm = 1000;  -- �����̵�.

select * from view_check30;
select * from emp_copy03;  -- ����(�⺻)���̺��� �� �����̵�.


create or replace view view_read30
as
select empno, ename, sal, comm, deptno
from emp_copy03
where deptno = 30 with read only;

select * from view_read30;

update view_read30
set comm = 2000;  -- ���� : read-only view �ɼ��� ������ ������ �����Ұ�.

-- *** with check option�� with read only�� ������
-- �並 ������ �� �������� ������ �÷��� �ƴ� �÷��� ���ؼ��� ������ ����.
-- ��ü �����ͳ�? �ƴϸ� ���� �÷��̳�?
update view_chk30 -- with check option
set comm = 1000;  -- comm ������Ʈ��.  deptno�� �ɼ��� �����Ǿ� �ֱ� ������ comm�� ����.

update view_read30
set deptno = 1000; -- ����
-- with read  only�� ��ü ���̺� ���� �Ұ�


-- [13] Top����
-- ����Ŭ������ ���� ���Ǵ� ���*** 

--  [rownum] �÷� �� ���
select rownum, empno, ename, hiredate
from emp; -- ������ ���Լ������ ��ȣ�� �ο��ؼ� ������������ ������. 
-- ����. �Һ��� ��. ����Ŭ�����ͺ��̽��� �ٿ��� ��.

select rownum, empno, ename, hiredate
from emp
order by hiredate; -- rownum�� ���� �Ȱ�����, hiredate������� ����

create or replace view view_hire
as
select empno, ename, hiredate
from emp
order by hiredate;  -- ������ ���̺������� �� �並 ������.
-- ���Ӱ� ����� ���� �ڵ����� rownum�� �����ϸ� �׶� ���ԵǴ� ������� ��ȣ�� �ο���.

select * from view_hire;  -- ������������ hiredate�� ���ĵ� �����Ͱ� ��µ�.

-- hireview�� ���� rownum�� �������
select rownum, empno, ename, hiredate
from view_hire;  -- rownum�� �ٽ� ������. view_hire �������.
-- �Ʊ�� �޸� ��view_hire���̺��� ���� �������  �����ĵ�  rownum����.


-- rownum ���� ��ü ������ ���
select rownum, e.*
from emp e;


-- [1] rownum�� �̿�
select rownum, empno, ename, hiredate
from view_hire
where rownum between 1 and 5;

select rownum, empno, ename, hiredate
from view_hire
where rownum <= 5;


-- [2] inline view(�ζ��� ��)�� �̿�.
-- FROM���� ���� Subquery�� ����.
-- FROM������ ���ϴ� �����͸� ��ȸ�Ͽ� ������ ������ ����� ������ �����ϰų� ������ ������ �ٽ� ��ȸ �� �� ����Ѵ�.
-- Inlivew View �ȿ� �� �ٸ� Inline View�� �� �� �ִ�
select rownum, empno, ename, hiredate
from (select empno, ename, hiredate
         from emp
         order by hiredate)  -- ���� ���̺��ſ� select���� �� �� ����.
where rownum <= 5;
-- �̷� ��ɹ��� inline view��� ��.
-- ���������� ���� �����.


-- [����] �Ի��� �������� 3��° ~7��° ���̿� �Ի��� ����� ����غ���
select rownum, empno, ename, hiredate
from (select  empno, ename, hiredate
      from emp
      order by hiredate)
where rownum between 3 and 7;  -- ����� �ȳ���
-- rownum�� ���ǿ� ����Ϸ��� �ݵ�� 1���ͽ����ؼ� ���������� ���� ����� ���� �������� ������.

select rnum, empno, ename, hiredate
from (select  rownum as rnum, empno, ename, hiredate
      from (select empno, ename, hiredate
            from emp
            order by hiredate))
where rnum between 3 and 7; 
-----------------------------------------------
select  rownum, empno, ename, hiredate
from view_hire;

select rnum, empno, ename, hiredate
from (select  rownum rnum, empno, ename, hiredate
         from view_hire)
where (rnum>=3) and (rnum <= 7) ;
-- rownum�� �������̺��� �÷��� �ƴϱ⿡ 
-- inline�ȿ� ����ؼ� rownum�� ����µ� ���� ���� �ƴϱ⿡ ���ϴ� rownum�� ���� ������� ��Ī�� �ο��ؼ� ��Ȯ����


-- [����] �Ի����� �������� ������������ �����ؼ� 5�� 10������ �����ϴ� ����� ����ϱ�.
select rnum, empno, ename, hiredate
from (select rownum rnum, empno, ename, hiredate
         from (select  empno, ename, hiredate
                   from emp
                   order by hiredate desc))
where rnum between 5 and 10;

------------------------------------------------
create or replace view view_rnum10
as
select rownum rnum, empno, ename, hiredate
         from (select  empno, ename, hiredate
                   from emp
                   order by hiredate desc)
;
                   

select rnum, empno, ename, hiredate
from view_rnum10
where rnum between 5 and 10;


