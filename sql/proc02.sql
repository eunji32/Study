create or replace procedure del_ename(vename emp01.ename%type) -- 매개변수
is
begin
   delete from emp01
   where ename = vename;
end;
/
