create or replace function cal_bonus(vempno in emp.empno%type)  
-- DB�� �Լ�/JAVA�� �޼���
-- �Լ��� ������ ����
-- �޼���� (object�� ���ѵ�)Ư�� �ڷ����ȿ��� ����
    return number
is 
    vsal  number(7, 2); -- �Ǽ�
begin
    select sal into vsal -- sal�� vsal�� �־���
    from emp
    where empno = vempno;

    return (vsal*200);  -- ������ ��� ���� ����
end;
/