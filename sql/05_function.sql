-- * ����Ŭ ��ɾ� : �����Լ�

-- [1] �ӽ� ������ ���
select 1234 * 1234 from emp;  -- �� ���ڵ� ������ŭ ����� ��.

select 1234 * 1234 from dual;  -- �������̺�. Ư�����̺��� �������� ���� �ƴ϶� select���� �ϱ� ���ؼ� ������� �ӽ� ���̺�.

-- [2] ���� ���̺��� dual ���̺�
select * from dual;  -- dummy 


-- *** ���ڿ� ó�� ���� �Լ� ***
-- [3]  lower() : ��� ���ڸ� �ҹ��ڷ� ��ȯ
select lower('Hong Kil Dong') as "�ҹ���" from dual;  
-- Ư�����̺��� ������ �����Ͱ� �ƴ� select���� �ϱ� ���� �ӽ� ���̺��� ������.

-- [4] upper() : ��� ���ڸ� �빮�ڷ� ��ȯ
select upper('Hong Kil Dong') as "�빮��" from dual;  

-- [5] initcap () : ù���ڸ� �빮�ڷ� ��ȯ
select initcap('hong kil dong') as "ù���ڸ� �빮��" from dual;  

-- [6] concat() : ���ڿ� ����
select concat('������', '��ǻ���п�') from dual;  -- concat �� 2���� �ܾ ����.


-- [7] length() : ���ڿ��� ����
select length('������ ��ǻ�� �п�') , length('The Joeun Computer')  from dual;   -- �������� ���ڱ���


-- [8] substr() : ���ڿ� ���� (������ , �ε��� (1), ī��Ʈ )
select substr('ȫ�浿 ����', 2, 4) from dual;  -- ���: '�浿 ��'
--��������  �ι�° ��ġ�� �ִ� ���ں��� 4���� ��. ���鵵 ī��Ʈ�� ����.
-- Ư����ġ�� ���ڸ�  ������ �� ����.


-- [9] instr() :  ���ڿ� ���� ��ġ
select instr('ȫ�浿 ����', '��') from dual;
-- �����Ϳ��� �����ϰ� ���� ���� ��ġ������ �˷���.
select instr('seven', 'e') from dual;  -- e�� �ΰ�. ó�� ã�� ����ġ�� �˷���.


-- [10] lpad(), rpad() : �ڸ� ä���
select lpad('Oracle', 20, '#') from dual;
-- # ���� �ϳ��� ����, oracle���� �ϳ��̻��� ���ڸ� ���ڿ�
-- ���ʿ� #���� ä���� ������ ���̸� 20���� ����� ��.

select rpad('Oracle', 20, '*') from dual;
-- �����ʿ� *���� ä���� ������ ���̸� 20���� ����� ��.


-- [11] trim() : �÷��̳� ��� ���ڿ����� Ư�� ���ڰ� ù��° �����̰ų� ������ �����̸� �߶󳻰� ���� ���ڿ��� ��ȯ .
-- Ȱ�뵵�� ����. ��Ȯ�� �˱�!!
select trim('a' from 'aaaOracleaaaaaaaaa') from dual;  -- ó���� �������� ��ġ�� a�� ���͸��Ͽ� �߶�.

select trim(' ' from '   Oracle    ')  from dual;    -- �̷� ��찡 �־ ���� ����.


-- *** ���� ó�� ���� �Լ� ***
-- [12] round() : �ݿø� (���� : �Ҽ��� �̻� �ڸ� )
select round(12.34567, 3) from dual;  -- ��� : 12.345  
-- 12.34567�� ��ǻ�ͻ� �Ǽ�.  �ι�°�� ���� 3�� �ǹ̴� '����° �ڸ�'���� �����ְ� ��°�ڸ����� �ݿø�.

select deptno, sal, round(sal, -3) from emp
where deptno = 30;   -- sal�� ���������� �ԷµǾ� ����. ���� round�� �Ǽ����� �޾��ִ� ���� �ƴ�. ������ ����.
-- 1600�� -3�ڸ��� 6�̹Ƿ� �ݿø��ϸ� 2000�� ��.

-- [13] abs() : ���밪 (����� ������ ũ�⸸�� ��ȯ)
select abs(10) from dual;
select abs(-10) from dual;


-- [14] floor() : �Ҽ��ڸ� ������ , round�� ��ɰ� ���������� �Ǽ��� �Ҽ������ϴ� ��� ������. �����κи�.  
select floor(12.34567) from dual;  -- ��� : 12
select floor(-12.34567) from dual; -- ��� : -13


-- Ư����ġ������ ���� ������ ������
-- [15] trunc() : Ư�� �ڸ� �ڸ���(Ư�� �ڸ������� �߶�.)
 select trunc(12.34567, 3) from dual;    -- ��� : 12.345  
 
-- [16] mod() : ������
select mod(8, 5) from dual;   -- 8/5  = �� 1, ������ 3


-- [17] sysdate : ��¥
select sysdate from dual;


-- [18] months_between() : ���� �� ���ϱ�
select ename, hiredate, months_between(sysdate, hiredate) "�ٹ� ���� ��" , deptno
from emp
where deptno = 10;


-- [19] add_months() : ���� �� ���ϱ�
select add_months(sysdate, 200) from dual;  -- ���� ��¥���� 200���� ��
select add_months(sysdate, -200) from dual;  -- 200���� ��

select ename, hiredate, add_months(hiredate, 2), deptno
from emp
where deptno = 10;

select add_months(20/01/01, 2) from dual; -- ����
select add_months('20/01/01', 2) from dual;  -- ��� ��µ�.


-- [20] next_day() : �ٰ��� ���Ͽ� �ش��ϴ� ��¥
select next_day(sysdate, '�Ͽ���') from dual;

-- [21] last_day() : �ش� ���� ������ �� ��
select last_day(sysdate) from dual;


-- [22] to_char() : ���ڿ��� ��ȯ
select to_char(sysdate, 'yyyy/mm/dd') from dual; -- yyyy�� yy�� ����.

-- [23] to_date() : ��¥��(date) ���� ��ȯ
select to_date('2009/12/31','yyyy/mm/dd') from dual;  -- to_date(���ڿ� ����, ��¥������)

-- [24] nvl() : null�� �����͸� �ٸ� �����ͷ� ����
select ename,comm, nvl(comm, 0) from emp;


-- [25] decode() : switch���� ���� ���
select ename, deptno, decode(deptno,
                                            10, 'Acc',
                                            20, 'Res',
                                            30, 'Sal',
                                            40, 'Op') as"�μ�����"   --  ','����
from emp;


-- [26] case : if ~ else if ~  - decode()�����ؼ� �����ϱ�
select ename, deptno, case
                                    when deptno = 10 then 'ACCOUNT' 
                                    when deptno = 20 then 'RESEARCH'
                                    when deptno = 30 then 'SALES'
                                    when deptno = 40 then 'OPERATIONS'
                                end as "�μ�"  -- as��������.
from emp;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 



