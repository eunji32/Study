create or replace function cal_bonus(vempno in emp.empno%type)  
-- DB는 함수/JAVA는 메서드
-- 함수는 범용적 구현
-- 메서드는 (object에 제한된)특정 자료형안에서 구현
    return number
is 
    vsal  number(7, 2); -- 실수
begin
    select sal into vsal -- sal을 vsal에 넣어줌
    from emp
    where empno = vempno;

    return (vsal*200);  -- 변수에 담긴 값을 리턴
end;
/