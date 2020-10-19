-- ����Ŭ SQL�� : ��������(Sub-Query)

-- [���� �� ��������]
-- ex) scott�� �ٹ��ϴ� �μ���, ���� ���(���� �ٸ� ���̺� ������ ����)
-- ù��°���(�⺻)
select deptno from emp
where ename = 'SCOTT';  -- ��� 20

select dname, loc from dept
where deptno = 20;  -- ���� ����� ������ �˻�.

-- �ι�°���(���������̿�) (����!!! ������������ ����Ǿ��� ����, ��ȣ�� �����ִ� �� ����ϱ�.)
select dname, loc from dept
where deptno = (select deptno from emp
                        where ename = 'SCOTT');  



-- [����] scott�� ������ ����(job)�� ���� ����� ����ϴ� sql���� ���������� �̿��� �ۼ��ϱ�.
-- ù��°
select job
from emp
where ename = 'SCOTT';  -- analyst

select ename, job
from emp
where job = 'ANALYST';

-- �ι�°
select ename, job 
from emp
where job = (select job 
                    from emp
                    where ename = 'SCOTT');

-- [����] scott�� �޿��� �����ϰų� �� ���� �޴� ����̸��� �޿� ���.
select ename, sal 
from emp
where sal >= (select sal
                    from emp
                    where ename = 'SCOTT');

-- [�������� & �׷��Լ�]
-- [����] ��ü ��� ��� �޿����� �� ���� �޿��� �޴� ����� ���.
select avg(sal) from emp; -- ��� : 2073.~

select ename, sal
from emp
where sal >= (select avg(sal)
                    from emp);   -- avg()�� �Ѱ��� ���� ������ ������

select ename, sal, avg(sal)
from emp
where sal >= (select avg(sal)
                    from emp);   -- ����


-- [���� �� ��������]
-- [����] �޿��� 3000 �̻� �޴� ����� �ҼӵǾ��� �ִ� �μ��� ������ �μ����� �ٹ��ϰ� �ִ� ���.
select * from emp;

select deptno
from emp
where sal>=3000;

select ename,sal, deptno
from emp
where deptno in (select deptno
                        from emp
                        where sal >= 3000);


-- �񱳿������� ��� 1��1��  2���̻��� ����� ���Ұ�

-- 1) [in ������] : �ϳ��� ��ġ�ϸ� '��'
select ename,sal, deptno
from emp
where deptno in (select deptno
                        from emp
                        where sal >= 3000);

-- [����] in �����ڸ� �̿�, �μ����� ���� �޿��� ���� �޴� ����� ����(�����ȣ, �����, �޿�, �μ���ȣ)�� ����ϼ���.
select deptno, max(sal)
from emp
group by deptno;
------------
select empno, ename, sal, deptno
from emp
where sal in (select max(sal)
                    from emp
                    group by deptno);


-- 2) [all ������] : ��� ���� ��ġ�ϸ� '��' - �ִ�
-- ex) ~ > all �� ��� ���� ������ ���� �� �ִ񰪺��� ũ�� '��'�̵�.
-- [����] 30��(�μ���ȣ) �Ҽ� ����� �߿��� �޿��� ���� ���� ���� ������� �� ���� �޿��� �޴� ����� �̸��� �޿��� ���
-- ù��°(���� �� �������� & �׷��Լ�)
select max(sal)
from emp
where deptno = 30;

select ename, sal
from emp
where sal >  (select max(sal)
                    from emp
                    where deptno = 30);

 -- �ι�°(���� �� ��������)                  
select ename, sal
from emp
where sal > all (select sal
                       from emp
                       where deptno = 30);


-- [����] �������(salesman)�麸�� �޿��� ���� �޴� ������� �̸��� �޿��� ����ϵ�, ��������� ������� �ʰ� ��ɹ��� �ۼ�.
select max(sal)
from emp
where job = 'SALESMAN';
-----------------------------------
select ename, sal, job
from emp
where sal > all(select sal   -- >all ��ü�� �ϳ��� �����ڶ�� �����ϸ� ��.
                       from emp
                       where job = 'SALESMAN')
and job != 'SALESMAN'; -- �� ��ɹ��� ��� ���� �������� ��Ȯ�ϰ� ������ �ϱ� ���� �־���.



-- 3) [any ������] : �ϳ��̻� ��ġ�ϸ� '��' - �ּҰ�
-- [����] �μ���ȣ�� 30���� ������� �޿� �߿��� ���� ���� �޿����� ���� �޿��� �޴� ����� �̸�, �޿��� ���.
select min(sal)
from emp
where deptno = 30;
-- ���� ��
select ename, sal
from emp
where sal > (select min(sal)
                        from emp
                        where deptno = 30);
-- ���� ��
select ename, sal
from emp
where sal > any(select sal
                        from emp
                        where deptno = 30);
                        

-- [����] ����������� �ּ� �޿����� ���� �޴� ������� �̸��� �޿��� ������ ����ϵ� ��������� ������� �ʱ�.
select ename, sal, job
from emp
where sal > any(select sal
                        from emp
                        where job = 'SALESMAN')
and job != 'SALESMAN';









