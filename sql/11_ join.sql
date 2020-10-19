-- * 오라클 SQL문 : 조인(join) : 2개 이상의 테이블. (단, 너무 많이 조인하면 힘들어짐)

-- [1]'SCOTT'이 근무하고 있는 부서명, 지역출력.
-- : 원하는 정보가 두 개 이상의 테이블에 나뉘어져 있을 때 결과 출력.
select deptno from emp
where ename = 'SCOTT';

select dname, loc from dept
where deptno = 20;

-- [2] join 
-- 1) cross join
select * from emp, dept;   -- 두개의 테이블을 연속 지정하여 join 되도록함. but (14*4)를 해서 56개의 데이터가 생성됨..
-- 공통되는 컬럼을 기준으로 해서.. 단순 결합.

-- 2) equi join
select * from emp, dept
where emp.deptno = dept.deptno;  -- ','이 아니라 '.'

-- 'scott'의 부서명, 지역 출력
select ename, dname, loc, emp.deptno
from emp,dept
where emp.deptno = dept.deptno
and ename = 'SCOTT';     

-- 정통방식은 emp.ename 이런식으로 각각에 설정해서 하는것
-- 컬럼명 앞에 테이블명을 기술하여 컬럼소속을 정확히함.
select emp.ename, dept.dname, dept.loc, emp.deptno
from emp,dept
where emp.deptno = dept.deptno
and emp.ename = 'SCOTT'; 

-- 테이블명이 길 경우, 
-- 테이블에 별칭을 줄 수 있으며, 별칭을 준 후 소속테이블을 지정할 경우 컬럼 앞에 별칭으로만!
select e.ename, d.dname, d.loc, e.deptno
from emp e ,dept d  -- 테이블명 옆에 별칭부여할 때는 as는 쓰지 않음/ 따옴표도 안됨.
where e.deptno = d.deptno
and e.ename = 'SCOTT'; 

-- 3) non- equi join
select * from tab;
select * from emp;
select * from salgrade; -- losal~hisal = 등급

-- 첫번째 방법
select ename, sal, grade
from emp, salgrade
where sal >= losal and sal <= hisal;

-- 두번째 방법
select ename, sal, grade
from emp, salgrade
where sal between losal and  hisal;

-- emp, dept, salgrade 3개의 테이블 join해서 결과 출력. 
select ename, sal, grade, dname
from emp, dept, salgrade
where emp.deptno = dept.deptno  -- equi join
and sal between losal and hisal;


-- 4) self join
select * from emp;

select employee.ename, employee.mgr, manager.ename "사수" 
from emp employee, emp manager
where employee.mgr = manager.empno;  


-- 5) outer join
select employee.ename, employee.mgr, manager.ename
from emp employee, emp manager
where employee.mgr = manager.empno(+); -- 데이터가 누락되었어도 출력해달라는 표시
-- 없는 쪽에 +를 붙여줘야함. (사수가 없을 수 있기에 사수에 붙이기)


-- 위의 join 오라클 사만! ANSI조인 표준.
--[3] ANSI join
-- 1) Ansi cross join
select * from emp 
cross join dept;  -- 56개의 레코드 

-- 2) Ansi inner join
select ename, dname, emp.deptno, dname
from emp inner join dept
on emp.deptno = dept.deptno; 

-- 동일한 이름이기 때문에 이런 방법도 가능. 
select ename, deptno, dname  -- 이곳에도 소속컬럼지정을 해줘서는 안됨. 공통컬럼이 되어지는 것을 밑에서 명령하기 때문에.
from emp inner join dept
using (deptno);  --공통이 되어지는 컬럼이름 ()안에 명시하여 결과출력가능. 

-- scott만 출력할 때
select ename, dname, emp.deptno, dname
from emp inner join dept
on emp.deptno = dept.deptno
where ename = 'SCOTT'; 


-- natural join : 별도로 지정해주지 않아도 공통의 컬럼을 자동으로 찾아서 바로 결과 출력
select ename, dname
from emp natural join dept;   


-- 3) Ansi outer join
create table dept10(
    deptno  number(2),
    dname   varchar2(14)
);

insert into dept10 values(10, '회계부');
insert into dept10 values(20, '연구소');

select * from dept10;

create table dept11(
    deptno  number(2),
    dname   varchar2(14)
);


insert into dept11 values(10, '회계부');
insert into dept11 values(30, '영업부');

select * from dept11;


-- 기존 오라클 방법
select * from dept10, dept11
where dept10.deptno = dept11.deptno;  -- 같은 데이터만 나옴.

select * from dept10, dept11
where dept10.deptno = dept11.deptno(+);   -- 공통된 데이터 와 dept10의 데이터만

select * from dept10, dept11
where dept10.deptno(+) = dept11.deptno;   --  공통된 데이터와 dept11의 데이터만  / +를 붙인것의 반대로 결과가 출력된다는 것 기억! 

-- 전부 출력하고 싶을 때
select * from dept10, dept11
where dept10.deptno(+) = dept11.deptno(+);  -- 오류. 둘다 +해주는 것은 안됨. 


-- Ansi join 방법
select * from dept10
left outer join dept11  -- =dept11(+) 
on dept10.deptno = dept11.deptno;

select * from dept10
right outer join dept11  -- =dept10(+)
on dept10.deptno = dept11.deptno;

select * from dept10
full outer join dept11  -- 전체 출력
on dept10.deptno = dept11.deptno;








