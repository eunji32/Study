create or replace procedure del_ename(vename emp01.ename%type) -- �Ű�����
is
begin
   delete from emp01
   where ename = vename;
end;
/
