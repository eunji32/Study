-- * 오라클 : PL/SQL

-- [1] 'Hello World' 출력
SQL>set serveroutput on -- default는 off이기때문에 on으로 해줘야함.
-- on 되어졌을 때 DBMS_OUTPUT.PUT_LINE 이 동작되어짐.
SQL>begin
		DBMS_OUTPUT.PUT_LINE('Hello World');
		end;
		/ -- 모든 명령의 끝 선언.
-- 프로그램이 수행하는 환경을 제공?
-- 출력관련부분.
		
		
--[2] 변수 사용하기
SQL>
declare
	vempno number(4); -- 스칼라 변수 선언
	vename varchar2(20);
begin
	vempno := 7788;
	-- DB에서 = 는 같다 라는 의미
	-- := 이 대입의 의미. 
	vename := 'SCOTT';
	DBMS_OUTPUT.PUT_LINE('사번 / 이름');
	DBMS_OUTPUT.PUT_LINE('-------------------------');
	DBMS_OUTPUT.PUT_LINE(vempno|| '/' ||vename);
	-- || 는 자바에서 +와 같은 기능.
end;
/
		
SQL>
declare
	vempno  emp.empno%type; -- 레퍼런스 변수 선언
	-- emp테이블안에 empno컬럼의 type과 동일하게 지정하겠다는 의미.
	vename  emp.ename%type;
begin
	DBMS_OUTPUT.PUT_LINE('사번 / 이름');
	DBMS_OUTPUT.PUT_LINE('-------------------------');
	
	select empno, ename into vempno, vename
	-- select한 변수를 into한 변수에 담아줌.
	from emp
	where ename = 'SCOTT';
	
	DBMS_OUTPUT.PUT_LINE(vempno|| '/' ||vename);
end;
/		
-- emp테이블에서 가져온 데이터들..


-- [3] record type 사용
--     . emp 테이블에서 scott사원의 정보를 출력.
SQL>
declare
	-- 레코드 타입을 정의
	type emp_record_type
	is record(
		v_empno  emp.empno%type,-- 변수선언
		v_ename  emp.ename%type,
		v_job       emp.job%type,
		v_deptno  emp.deptno%type -- ; 넣지않도록 주의!
	); 
	-- 자바에서 class와 비슷. 
	
	emp_record emp_record_type;
	-- 변수명(emp_record) 자료형(emp_record_type)
begin
	select empno, ename, job, deptno into emp_record
	from emp
	where ename ='SCOTT';
	
	DBMS_OUTPUT.PUT_LINE('사원번호 : '||TO_CHAR(emp_record.v_empno)); 
	-- TO_CHAR 문자열로 변환 / '.'을 통해 변수에 접근
	DBMS_OUTPUT.PUT_LINE('사원이름 : '||TO_CHAR(emp_record.v_ename)); 
	DBMS_OUTPUT.PUT_LINE('담당업무 : '||TO_CHAR(emp_record.v_job)); 
	DBMS_OUTPUT.PUT_LINE('부서번호 : '||TO_CHAR(emp_record.v_deptno)); 
end;
/	
		
-- [4] 조건문
--     . 사원번호가 7788인 사원의 부서 번호를 얻어와서 부서 번호에 따른 부서명을 구하세요.
SQL>
declare
	vempno  number(4); -- 스칼라 변수
	vename  varchar2(20); 
	vdeptno  emp.deptno%type;
	vdname  varchar2(20) := null; --초기화
begin
	select empno, ename, deptno
	into vempno, vename, vdeptno
	from emp
	where empno = 7788;
	
	if(vdeptno = 10) then --if는 then과 한쌍!
		vdname := 'ACCOUNTING';
	elsif(vdeptno = 20) then
		vdname := 'RESEARCH';
	elsif(vdeptno = 30) then
		vdname := 'SALES';
	elsif(vdeptno = 40) then
		vdname := 'OEPRATIONS';
	-- else는 생략. (원래 마지막은 else로 끝남.)
	end if; -- DB는 이것으로 IF문 종료.	
	
	DBMS_OUTPUT.PUT_LINE('사번/이름/부서명');
	DBMS_OUTPUT.PUT_LINE('--------------------------');
	DBMS_OUTPUT.PUT_LINE(vempno||'/'|| vename||'/'|| vdname);
	
end;
/		

--[5] 반복문
--    1) basic loop문
declare
	n  number := 1;
	
begin
	LOOP
		DBMS_OUTPUT.PUT_LINE(n);
		n := n + 1; 
		
		if(5 < n) then
			exit; -- 반복탈출~!
		end if;
		
	END LOOP;
	
end;
/ 
		
--    2) for loop문		
SQL>
declare
begin
	for n in 1..5 LOOP
		DBMS_OUTPUT.PUT_LINE(n);
	END LOOP;
end;
/
		
		
--    3) while loop문			
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
		
		
		
		
		
		
		
		
