-- * ����Ŭ ��ɾ� : Group �Լ�

-- [1] sum() : �հ� - ��ġ��������
select sum(sal) "�ѱ޿�" from emp;

-- [2] count() :  ī��Ʈ
select count(*) "�ѷ��ڵ�"  from emp; -- �ѷ��ڵ��� ����

select count(empno) from emp;

-- [3] avg() :  ���
select avg(sal) "����� �޿�" from emp;

-- [4 ] max() : �ִ밪
select max(sal) "�ְ� �޿� ������"  from emp;

-- [5 ] min() : �ּҰ�
select min(sal) "���� �޿� ������" from emp;

-- [6 ] Group by �� : ������ �޿� ���
select job, avg(sal) from emp;  -- �����߻� , ����� ������ �ٸ��� ����( job�� ���ڵ尳���� 14�� , �Լ���밪�� 1��)

select job, avg(sal) from emp
group by job;   -- job���� �׷��� ����� �������. 
-- �߰��� group by�Լ��� ����Ͽ� �׷��Լ��� �÷��� ���� ����.


-- [7 ] Having �� : ������ �޿� ��� (��, �޿� ��� 2000 �̻� ���� ) (group by + �����߰�)
select job, avg(sal) from emp
group by job
having avg(sal) >=2000;




