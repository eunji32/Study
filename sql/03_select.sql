-- * ����Ŭ ��ɾ� : select ��(�˻�)

-- [1] scott ����ڰ� �����ϴ� ���̺� ���
--�� ��� ����
select * from tab;

-- [2] Ư�� ���̺��� ����(�ʵ� ����Ʈ/������ ����/��������)
desc dept; --desc��� ���

-- [3] Ư�� ���̺��� data ǥ��
select * from dept;
select * from emp;

-- [4] ��� �÷�(�ʵ��)�� �ƴ�, �ʿ��� �÷�(�ʵ��) ���븸 ��� 
select dname, loc from dept;

--[5] ������ �ʵ�� ��Ī�� �־ ��� : as ���� ���� 
select deptno  as �μ���ȣ, dname as �μ���, loc as ��ġ from dept;

--cf)
select deptno  as �μ� ��ȣ, dname as �� �� ��, loc as �� ġ from dept; --error
select deptno  as "�μ� ��ȣ", dname as "�� �� ��", loc as "�� ġ" from dept; 
select depno as '�μ� ��ȣ', dname as ' �� �� ��', loc as '�� ġ' from dept; --error (���� ����ǥ�� ����x)
select deptno  "�μ� ��ȣ", dname  "�� �� ��", loc "�� ġ" from dept; -- as ����


--[6] ������� �������� �ߺ� ���� �� ���
select * from emp;
select job from emp;
select distinct job from emp; -- �ߺ��� ���� �ѹ��� ���

--[7] �޿��� 3000 �̻��� ��� ���� ���
select empno, ename, sal from emp
where sal>=3000;


--[8] �̸��� scott ����� ���� ���
--    ��, data�� ���� ��ҹ��ڸ� ����!!!
select * from emp
where ename = 'scott'; -- ����� ������ ����. 

select * from emp
where ename = 'SCOTT'; 

--[9] 1985�⵵ ���ķ� �Ի��� ��� ����
select empno, ename, hiredate 
from emp
where hiredate >='1985/01/01';

-- [10] �μ���ȣ�� 10 �̰� , �׸��� ������ 'MANAGER' �� ��� ���
select ename, deptno, job
from emp
where deptno = 10 and job = 'MANAGER';

-- [11] �μ���ȣ�� 10 �̰ų� , ������ 'MANAGER' �� ��� ���
select ename, deptno, job
from emp
where deptno = 10 or job = 'MANAGER';

-- [12] �μ���ȣ�� 10 �� �ƴ� ���
select deptno, ename from emp
where not deptno = 10;

select deptno, ename from emp
where  deptno != 10;

-- [13] �޿��� 1000 ~ 3000 ������ ����� ���
select ename, sal from emp
where sal>= 1000 and sal <= 3000;

select ename, sal from emp
where (sal>= 1000) and (sal <= 3000);

select ename, sal from emp
where sal between 1000 and 3000;


-- [14] �޿��� 1300 �Ǵ� 1500 �Ǵ� 1600 �� ��� ���� ���
select ename, sal from emp
where sal=1300 or sal=1500 or sal=1600;

select ename, sal from emp
where sal in (1300, 1500, 1600);


-- [15] �̸���  'K'�� �����ϴ� ��� ���
select ename, empno from emp
where ename like 'K%';


-- [16] �̸���  'K'�� ������ ��� ���
select ename, empno from emp
where ename like '%K';


-- [17] �̸���  'K'�� ���ԵǾ� �ִ� ��� ���
select ename, empno from emp
where ename like '%K%';


-- [18] 2��° �ڸ��� 'A' �� �� �ִ� ��� ���
select ename, empno from emp
where ename like '_A%';  -- '_'�� ����ڵ� �ϳ��� �;ߵ�. % ����ڵ� �������.


-- [19] Ŀ�̼��� ���� �ʴ� ��� ���
select  * from emp
where comm = null or comm = 0;  -- ���ϴ� ���X 
-- null�� ���� �ǹ������� ����. �������� ��������.(�񱳿������� ó���ϸ� �ȵ�.)
-- �־����� ���� ���� ������ ������ �ϴ� ���� ���.

-- null�� Ŀ�̼��� ���� �ʴ� ������� üũ�ϰ� ������, (�������� �Ǵ����� �ǵ�� �ް� ������)
select * from emp
where comm is null or comm = 0;


-- [20] Ŀ�̼��� �޴� ��� ���
select * from emp
where comm <> null and comm <> 0;  -- ���ϴ� ���X

select * from emp
where comm is not null and comm <> 0;


-- [21] ���(empno)�� ���� (�������� )���� ���  -- asc���� ����(default)
select * from emp
order by empno asc;

select * from emp
order by empno;


-- [22] ����� ���� (�������� )���� ���
select * from emp
order by empno desc;


-- [23] ����� ���� ���
select ename, sal, sal * 12 from emp;

select *, sal*12 from emp; -- ���� , ��ü�� �������� ���� ���� ��� �÷��� �������� ��.

select ename, sal, sal * 12 as "����" from emp;

select ename, sal, sal * 12 "����" from emp; -- as����


-- [24] Ŀ�̼��� ������ ���� ���� ���
select ename, sal, sal * 12 + comm "����" from emp;   -- null�� ����.


-- [25] [24]�� ���� �ذ��
select ename, sal, comm, sal*12+comm, nvl(comm, 0), sal*12 + nvl(comm, 0) "����" 
from emp;  
-- null�� ��� null��. ����, nvl�̿��ؼ� 0���� ��� �ٲ� ����� ������.
-- select comm from emp;�� �ϸ� ������ null�� null





