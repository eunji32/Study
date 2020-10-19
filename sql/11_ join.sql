-- * ����Ŭ SQL�� : ����(join) : 2�� �̻��� ���̺�. (��, �ʹ� ���� �����ϸ� �������)

-- [1]'SCOTT'�� �ٹ��ϰ� �ִ� �μ���, �������.
-- : ���ϴ� ������ �� �� �̻��� ���̺� �������� ���� �� ��� ���.
select deptno from emp
where ename = 'SCOTT';

select dname, loc from dept
where deptno = 20;

-- [2] join 
-- 1) cross join
select * from emp, dept;   -- �ΰ��� ���̺��� ���� �����Ͽ� join �ǵ�����. but (14*4)�� �ؼ� 56���� �����Ͱ� ������..
-- ����Ǵ� �÷��� �������� �ؼ�.. �ܼ� ����.

-- 2) equi join
select * from emp, dept
where emp.deptno = dept.deptno;  -- ','�� �ƴ϶� '.'

-- 'scott'�� �μ���, ���� ���
select ename, dname, loc, emp.deptno
from emp,dept
where emp.deptno = dept.deptno
and ename = 'SCOTT';     

-- �������� emp.ename �̷������� ������ �����ؼ� �ϴ°�
-- �÷��� �տ� ���̺���� ����Ͽ� �÷��Ҽ��� ��Ȯ����.
select emp.ename, dept.dname, dept.loc, emp.deptno
from emp,dept
where emp.deptno = dept.deptno
and emp.ename = 'SCOTT'; 

-- ���̺���� �� ���, 
-- ���̺� ��Ī�� �� �� ������, ��Ī�� �� �� �Ҽ����̺��� ������ ��� �÷� �տ� ��Ī���θ�!
select e.ename, d.dname, d.loc, e.deptno
from emp e ,dept d  -- ���̺�� ���� ��Ī�ο��� ���� as�� ���� ����/ ����ǥ�� �ȵ�.
where e.deptno = d.deptno
and e.ename = 'SCOTT'; 

-- 3) non- equi join
select * from tab;
select * from emp;
select * from salgrade; -- losal~hisal = ���

-- ù��° ���
select ename, sal, grade
from emp, salgrade
where sal >= losal and sal <= hisal;

-- �ι�° ���
select ename, sal, grade
from emp, salgrade
where sal between losal and  hisal;

-- emp, dept, salgrade 3���� ���̺� join�ؼ� ��� ���. 
select ename, sal, grade, dname
from emp, dept, salgrade
where emp.deptno = dept.deptno  -- equi join
and sal between losal and hisal;


-- 4) self join
select * from emp;

select employee.ename, employee.mgr, manager.ename "���" 
from emp employee, emp manager
where employee.mgr = manager.empno;  


-- 5) outer join
select employee.ename, employee.mgr, manager.ename
from emp employee, emp manager
where employee.mgr = manager.empno(+); -- �����Ͱ� �����Ǿ�� ����ش޶�� ǥ��
-- ���� �ʿ� +�� �ٿ������. (����� ���� �� �ֱ⿡ ����� ���̱�)


-- ���� join ����Ŭ �縸! ANSI���� ǥ��.
--[3] ANSI join
-- 1) Ansi cross join
select * from emp 
cross join dept;  -- 56���� ���ڵ� 

-- 2) Ansi inner join
select ename, dname, emp.deptno, dname
from emp inner join dept
on emp.deptno = dept.deptno; 

-- ������ �̸��̱� ������ �̷� ����� ����. 
select ename, deptno, dname  -- �̰����� �Ҽ��÷������� ���༭�� �ȵ�. �����÷��� �Ǿ����� ���� �ؿ��� ����ϱ� ������.
from emp inner join dept
using (deptno);  --������ �Ǿ����� �÷��̸� ()�ȿ� ����Ͽ� �����°���. 

-- scott�� ����� ��
select ename, dname, emp.deptno, dname
from emp inner join dept
on emp.deptno = dept.deptno
where ename = 'SCOTT'; 


-- natural join : ������ ���������� �ʾƵ� ������ �÷��� �ڵ����� ã�Ƽ� �ٷ� ��� ���
select ename, dname
from emp natural join dept;   


-- 3) Ansi outer join
create table dept10(
    deptno  number(2),
    dname   varchar2(14)
);

insert into dept10 values(10, 'ȸ���');
insert into dept10 values(20, '������');

select * from dept10;

create table dept11(
    deptno  number(2),
    dname   varchar2(14)
);


insert into dept11 values(10, 'ȸ���');
insert into dept11 values(30, '������');

select * from dept11;


-- ���� ����Ŭ ���
select * from dept10, dept11
where dept10.deptno = dept11.deptno;  -- ���� �����͸� ����.

select * from dept10, dept11
where dept10.deptno = dept11.deptno(+);   -- ����� ������ �� dept10�� �����͸�

select * from dept10, dept11
where dept10.deptno(+) = dept11.deptno;   --  ����� �����Ϳ� dept11�� �����͸�  / +�� ���ΰ��� �ݴ�� ����� ��µȴٴ� �� ���! 

-- ���� ����ϰ� ���� ��
select * from dept10, dept11
where dept10.deptno(+) = dept11.deptno(+);  -- ����. �Ѵ� +���ִ� ���� �ȵ�. 


-- Ansi join ���
select * from dept10
left outer join dept11  -- =dept11(+) 
on dept10.deptno = dept11.deptno;

select * from dept10
right outer join dept11  -- =dept10(+)
on dept10.deptno = dept11.deptno;

select * from dept10
full outer join dept11  -- ��ü ���
on dept10.deptno = dept11.deptno;








