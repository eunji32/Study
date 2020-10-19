-- * ����Ŭ : PL/SQL

-- [1] 'Hello World' ���
SQL>set serveroutput on -- default�� off�̱⶧���� on���� �������.
-- on �Ǿ����� �� DBMS_OUTPUT.PUT_LINE �� ���۵Ǿ���.
SQL>begin
		DBMS_OUTPUT.PUT_LINE('Hello World');
		end;
		/ -- ��� ����� �� ����.
-- ���α׷��� �����ϴ� ȯ���� ����?
-- ��°��úκ�.
		
		
--[2] ���� ����ϱ�
SQL>
declare
	vempno number(4); -- ��Į�� ���� ����
	vename varchar2(20);
begin
	vempno := 7788;
	-- DB���� = �� ���� ��� �ǹ�
	-- := �� ������ �ǹ�. 
	vename := 'SCOTT';
	DBMS_OUTPUT.PUT_LINE('��� / �̸�');
	DBMS_OUTPUT.PUT_LINE('-------------------------');
	DBMS_OUTPUT.PUT_LINE(vempno|| '/' ||vename);
	-- || �� �ڹٿ��� +�� ���� ���.
end;
/
		
SQL>
declare
	vempno  emp.empno%type; -- ���۷��� ���� ����
	-- emp���̺�ȿ� empno�÷��� type�� �����ϰ� �����ϰڴٴ� �ǹ�.
	vename  emp.ename%type;
begin
	DBMS_OUTPUT.PUT_LINE('��� / �̸�');
	DBMS_OUTPUT.PUT_LINE('-------------------------');
	
	select empno, ename into vempno, vename
	-- select�� ������ into�� ������ �����.
	from emp
	where ename = 'SCOTT';
	
	DBMS_OUTPUT.PUT_LINE(vempno|| '/' ||vename);
end;
/		
-- emp���̺��� ������ �����͵�..


-- [3] record type ���
--     . emp ���̺��� scott����� ������ ���.
SQL>
declare
	-- ���ڵ� Ÿ���� ����
	type emp_record_type
	is record(
		v_empno  emp.empno%type,-- ��������
		v_ename  emp.ename%type,
		v_job       emp.job%type,
		v_deptno  emp.deptno%type -- ; �����ʵ��� ����!
	); 
	-- �ڹٿ��� class�� ���. 
	
	emp_record emp_record_type;
	-- ������(emp_record) �ڷ���(emp_record_type)
begin
	select empno, ename, job, deptno into emp_record
	from emp
	where ename ='SCOTT';
	
	DBMS_OUTPUT.PUT_LINE('�����ȣ : '||TO_CHAR(emp_record.v_empno)); 
	-- TO_CHAR ���ڿ��� ��ȯ / '.'�� ���� ������ ����
	DBMS_OUTPUT.PUT_LINE('����̸� : '||TO_CHAR(emp_record.v_ename)); 
	DBMS_OUTPUT.PUT_LINE('������ : '||TO_CHAR(emp_record.v_job)); 
	DBMS_OUTPUT.PUT_LINE('�μ���ȣ : '||TO_CHAR(emp_record.v_deptno)); 
end;
/	
		
-- [4] ���ǹ�
--     . �����ȣ�� 7788�� ����� �μ� ��ȣ�� ���ͼ� �μ� ��ȣ�� ���� �μ����� ���ϼ���.
SQL>
declare
	vempno  number(4); -- ��Į�� ����
	vename  varchar2(20); 
	vdeptno  emp.deptno%type;
	vdname  varchar2(20) := null; --�ʱ�ȭ
begin
	select empno, ename, deptno
	into vempno, vename, vdeptno
	from emp
	where empno = 7788;
	
	if(vdeptno = 10) then --if�� then�� �ѽ�!
		vdname := 'ACCOUNTING';
	elsif(vdeptno = 20) then
		vdname := 'RESEARCH';
	elsif(vdeptno = 30) then
		vdname := 'SALES';
	elsif(vdeptno = 40) then
		vdname := 'OEPRATIONS';
	-- else�� ����. (���� �������� else�� ����.)
	end if; -- DB�� �̰����� IF�� ����.	
	
	DBMS_OUTPUT.PUT_LINE('���/�̸�/�μ���');
	DBMS_OUTPUT.PUT_LINE('--------------------------');
	DBMS_OUTPUT.PUT_LINE(vempno||'/'|| vename||'/'|| vdname);
	
end;
/		

--[5] �ݺ���
--    1) basic loop��
declare
	n  number := 1;
	
begin
	LOOP
		DBMS_OUTPUT.PUT_LINE(n);
		n := n + 1; 
		
		if(5 < n) then
			exit; -- �ݺ�Ż��~!
		end if;
		
	END LOOP;
	
end;
/ 
		
--    2) for loop��		
SQL>
declare
begin
	for n in 1..5 LOOP
		DBMS_OUTPUT.PUT_LINE(n);
	END LOOP;
end;
/
		
		
--    3) while loop��			
SQL>
declare
	n  number := 1;
begin
	while( n<=5) LOOP
		DBMS_OUTPUT.PUT_LINE(n);
		n := n +1;
	END LOOP;
end;
/		
		
		
		
		
		
		
		
		
