create or replace procedure cursor_sample01
is 
   vdept dept%rowtype; -- ���ڵ����
   cursor c1
   is
   select * from dept;
begin
	DBMS_OUTPUT.PUT_LINE('�μ���ȣ/�μ���/������');
	DBMS_OUTPUT.PUT_LINE('----------------------------');
	
	open c1; -- stream����
	
	LOOP
		fetch c1 into vdept.deptno, vdept.dname, vdept.loc; 
		-- c1���� ���ڵ� �����͸� �����ͼ� vdept.�����鿡 �־���.
		exit when c1%notfound; 
		-- �о�� c1�� ���� �ƹ��͵� �߰ߵ��������� ���ѷ����� ����������� �ǹ�.
		
		DBMS_OUTPUT.PUT_LINE(vdept.deptno||' '|| vdept.dname||' '|| vdept.loc);
	END LOOP;
	
	close c1; -- �޸𸮴�������.
	
end;
/