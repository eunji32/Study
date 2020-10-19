create or replace procedure cursor_sample01
is 
   vdept dept%rowtype; -- 레코드단위
   cursor c1
   is
   select * from dept;
begin
	DBMS_OUTPUT.PUT_LINE('부서번호/부서명/지역명');
	DBMS_OUTPUT.PUT_LINE('----------------------------');
	
	open c1; -- stream연결
	
	LOOP
		fetch c1 into vdept.deptno, vdept.dname, vdept.loc; 
		-- c1에서 레코드 데이터를 꺼내와서 vdept.변수들에 넣어줌.
		exit when c1%notfound; 
		-- 읽어온 c1에 값이 아무것도 발견되지않으면 무한루프를 빠져나오라는 의미.
		
		DBMS_OUTPUT.PUT_LINE(vdept.deptno||' '|| vdept.dname||' '|| vdept.loc);
	END LOOP;
	
	close c1; -- 메모리누수방지.
	
end;
/