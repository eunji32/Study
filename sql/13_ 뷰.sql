-- * 오라클 - 뷰(View)

-- [1] 뷰의 테스트용 테이블 생성
-- 1) DEPT 테이블을 복사한 DEPT_COPY 테이블 생성
create table dept_copy
as
select * from dept;

-- 2) EMP 테이블을 복사한 EMP_COPY 테이블 생성
create table emp_copy
as
select * from emp;



-- [2] 뷰(view) 정의하기
--     뷰를 생성하기 위해서는 create view로 시작함.
--     as 다음은 마치 서브쿼리문과 유사함.
--     서브쿼리는 우리가 지금까지 사용하였던 select문을 기술하면 됨.
--  테이블과 달리 저장공간을 가지지 않는다. / 테이블과 거의 동등하게 취급될 수 있는 논리적인 집합

-- ex) 만일 30번 부서에 소속된 사원들의 사번과 이름과 부서번호를 자주 검색한다고 하면
select empno, ename, deptno
from emp_copy
where deptno = 30;

-- 위와 같이 결과를 출력하기 위해서 매번 select문을 입력하기란 여간 번거로운 일이 아닐 수 없음.
-- 뷰는 이와같이 번거로운 select문을 매번 입력하는 대신 보다 쉽게 원하는 결과를 얻고자하는 바램에서 출발한 개념.
-- 원래 데이터로 부터 읽어오는 가상의 테이블 . 실제 데이터는 아님.
create view emp_view30
as 
select empno, ename, deptno
from emp_copy
where deptno = 30; -- 오류
-- 시스템계정에게 권한을 부여받아야 가능.

-- [View를 생성할 수 있는 권한 부여]
--  .dos command 창에서 sqlplus로 연결
sql> sqlplus system/admin1234
sql>show user
sql>grant create view to scott;  -- 권한 부여 명령어 grant  : scott계정에게 create view라는 권한을 부여 해 주겠다는 의미.

create view emp_view30
as 
select empno, ename, deptno
from emp_copy
where deptno = 30;  -- 권한 부여후 실행하면 생성됨.

-- 권한들을 부여 받아야만 db에서 가능해지는 것이 있음.

select * from emp_view30;  
-- 메모리 낭비 없음. 해당데이터 실시간 읽어와서 수행가능. 가상의 테이블을 만들어서 필요한 데이터를 가져옴.
-- 다른이가 접근 할 수 있는 데이터테이블. 접근범위를 제한적으로 할 수 있는 테이블

desc emp_view30;

--desc 널? not null이라고 되어있음 == 프라이머리키 설정된것.
-- 복사가 되어질 때 무결성제약조건까지 복사되지는 않음. / 데이터만!

desc emp;


-- [문제] 기본 테이블은 emp_copy로 함. 
--  20번 부서에 소속된 사원들의 사번과 이름, 부서번호, 상관의 사번을 출력하기 위한 select 문을 emp_view20 이라는 이름의 뷰로 정의.
create view emp_view20
as
select empno, ename, deptno, mgr
from emp_copy
where deptno = 20;

select * from emp_view20;
-------------------------------------
create or replace view emp_view20
as
select empno, ename, deptno, mgr
form emp_copy
where deptno = 20;


-- view는 별도로 정보를 관리
-- [3] 뷰의 내부구조와 user_views 데이터 딕셔너리
-- 데이터 무결성 제약조건에서 user_constraints 도 view
desc user_views;

select view_name, text 
from user_views;  -- 만들어 놓은 view의 정보를 보여줌.

-- [4] 뷰의 동작 원리
-- 1. 사용자가 뷰에 대해서 질의를 하면 user_views에서 뷰에 대한 정의를 조회.
-- 2. 기본테이블에 대한 뷰의 접근 권한을 살핀다.
-- 3. 뷰에 대한 질의를 기본테이블에 대한 질의로 변환.
-- 4. 기본테이블에 대한 질의를 통해 데이터를 검색.
-- 5. 검색된 결과를 출력한다.

-- 뷰의 생성법과 생성의의미를 파악!

-- [5] 뷰와 기본 테이블 관계 파악
--  1) 뷰를 통한 데이터 저장이 가능?
insert into emp_view30 values(8000, 'ANGEL',30);  -- 실행이 됨.

select * from emp_view30; -- 삽입됨.

select * from emp_copy; -- 이곳에도 삽입됨.

-- 단, view는 가상의 테이블이기 때문에 그 뷰가 참조하고 있는 기본테이블에도 데이터가 담기게 됨.
-- 만약 기본테이블에 한컬럼에  not null무결성제약 조건이 있고, view로 데이터를 삽입하다가 그 컬럼에 null이 된다면 삽입이 안됨.

-- [6] 뷰를 사용하는 이유? - pdf에 명시
-- 보안에 유리 ex) 인사과 뷰
create view emp_view  -- 급여등 민감한 정보 오픈은 안함
as
select empno, ename, job, hiredate, deptno -- 가릴 정보는 가리고 필요 정보만 보여줄수 있음.
from emp_copy;

-- [7] 뷰의 특징
-- 1) 단순 뷰에 대한 데이터 조작
insert into emp_view30
values(8010, 'CHEOLSOO', 30 );  -- 복사는 무결성 조건이 없기에 데이터는 막 삽입됨.

select * from emp_view30;

select * from emp_copy; 
-- 원칙적으로 얼마든지 삽입가능


-- 2) 단순 뷰의 컬럼에 별칭 부여하기
create view emp_view_copy(사원번호, 사원명, 급여, 부서번호)  -- 따옴표X
as
select empno, ename, sal,deptno
from emp_copy; 

select * from emp_view_copy;

select * from emp_view_copy
where deptno = 30; -- 오류발생
-- 별칭을 부여했기때문에 원래 컬럼이름으로 접근 불가
-- deptno가 아니라 부서번호라는 컬럼이름으로 변경됨
select * from emp_view_copy
where 부서번호 = 30;  -- 실행됨.


-- 3) 그룹함수를 사용한 단순 뷰
create view view_sal
as
select deptno, sum(sal), avg(sal)
from emp_copy
group by deptno;  -- 오류 : sum같은 경우에는 원본테이블의 컬럼이름이 아니라 결과로 만든 컬럼이기 때문에


create view view_sal
as
select deptno, sum(sal) as "급여합", avg(sal) as "급여 평균"
from emp_copy
group by deptno; -- 생성됨. 

select * from view_sal;


-- 주의) 
create view view_sal_year
as
select ename, sal*12 "연봉"
from emp_copy;  --연산에 의해 만든 컬럼항목이기 때문에 따로 별칭을 부여해서 만들어야함.

select * from view_sal_year;

insert into view_sal_year
values('miae', 12000);  -- 오류
--  기본테이블(emp_copy)에는 연봉이라는 테이블이 없기 때문에 데이터가 추가되지는 않음.



-- 4) 복합뷰 (emp + dept)
select empno, ename, sal, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno  -- equi join
order by empno desc;
-------------------------------
create view emp_view_dept
as
select empno, ename, sal, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno  
order by empno desc;


select * from emp_view_dept; 


-- [8] 뷰 삭제
drop view emp_view_dept; -- 완전한 삭제

select * from tab;


-- [9] 뷰 생성에 사용되는 다양한 옵션(or replace) :  존재하지 않는 뷰이면 새로운 뷰를 생성하고, 기존에 존재하는 뷰이면  전에 내용은 없애고 새로 view생성한다. 
select view_name, text 
from user_views; -- veiw 정보
--------------------------
create or replace view emp_view40
as
select empno, ename, comm, deptno
from emp_copy
where deptno = 30;
-- 기존에 없는 view이면 일반적인 view생성과 같음 / 단, 같은 이름의 뷰가 있을 경우 오류 발생
-- 그러나 기존에 있는 view이면 수정됨
select * from emp_view30;  


-- [10] 뷰 생성에 사용되는 다양한 옵션(force / noforce)
-- force : 기본테이블이 존재하지 않을 때도 뷰를 생성해야 하는 경우 사용하는 옵션. 
-- noforce : 기본테이블이 존재하는 경우만 뷰가 생성(default). 
desc emplyees; -- 기존 테이블이 없기 때문에 오류

select * from emplyees; -- 기존테이블이 없기 때문에 오류

create or replace view employees_view
as
select empno, ename, deptno
from employees
where deptno = 30;   -- 기존테이블이 없기 때문에 오류

create or replace force view employees_view  --force
as
select empno, ename, deptno
from employees
where deptno = 30;  -- 컴파일 오류와 함께 뷰가 생성됨./ 기본테이블이 없더라도 임시테이블로 생김.

select view_name, text
from user_views;  -- employees_view 테이블이 생성되어있음을 확인할 수 있음. 
-- 임시적으로 사용할 수 있는 뷰가 생김.

insert into employees_view
values(8020, '이순신', 30);  -- 오류 , 실제로 존재하는 것이 아니기 때문에 (임시테이블임)

-- force를 만들 상황은 거의 없음. 에러없이 이런 테이블이 존재한다는 가상의 개념에서 임시적으로 처리하고자 할때
-- 이런 테이블에 데이터를 삽입하고 하면 복잡. 그래서 임시적으로???
-- 왜 force를 붙였을까?의 의미를 알아야함.

--  dual 과 view의 차이점은????
-- dual 테이블은 사용자가 함수(계산)를 실행할 때 임시로 사용하는데 적합하다.
-- 함수에 대한 쓰임을 알고 싶을때 특정 테이블을 생성할 필요없이 dual 테이블을 이용하여 함수의 값을 리턴(return)받을 수 있다.
-- 뷰를 사용하는 일반적인 목적은 다음과 같이 분류할 수 있다.
--(1). 보안 관리을 목적으로 활용 ( 보안성 ) : 인사고과에 대한 정보를 감추기 위해서
--(2). 사용상의 편의를 목적으로 활용 ( 편의성 ) : 여러 개의 테이블로 구성된 뷰를 생성함으로써 데이터에 대한 복잡성을 숨길 수 있다.
--(3). 수행속도의 향상을 목적으로 활용 ( 속도 향상 ) : 특정 집합이 먼저 처리되도록 하거나 튜닝된 뷰를 생성하여 수행속도를 향상시킬 목적으로 사용
--(4). 융통성을 향상시킬 목적으로 활용 ( 융통성 ) : 비록 데이터 모델이나 오브젝트의 정의가 변경되더라도 애플리케이션에는 영향을 미치지 않도록 할 수 있다.
--(5) 임시적인 작업을 위해 활용한다. ( 임시성 ) : 특정한 경우의 데이터 보정 작업이나, 개발시에 견본 데이터를 생성하거나, 
--    애플리케이션 작성 전에 처리과정을 시험해 보기 위해 활용할 수 있다.


-- [11] 뷰 생성에 사용되는 다양한 옵션(with check option )
-- : 뷰를 생성할 때 조건 제시에 사용된 컬럼 값을 변경 못하도록 하는 기능
-- : 뷰를 설정할 때 조건으로 설정한 컬럼 이외의 다른 컬럼의 내용은 변경할 수 있음. 
create or replace view emp_view30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno = 30;

select * from emp_view30;

-- 예시) 30번 부서에 소속된 사원 중에 급여가 1200이상인 사원은 20번 부서로 이동시키기.
update emp_view30 -- 데이터 수정이기 때문에 update
set deptno = 20  -- 어차피 이 뷰는 모두 30번 사원이니까
where sal >= 1200;  -- 조건에 맞는 데이터는 20번으로 바꼈기 때문에 30번인 것만 출력됨.
-- 아무런 조건이 없기때문에 바로 수정이 됨.
-- 이런 경우, 기본테이블이 변경되기 때문에, 여러 사람이 공유하는 경우에는 문제 발생
select * from emp_copy;

create or replace view view_chk30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno = 30 with check option;
-- 

select * from view_chk30;

update view_chk30
set deptno = 20
where sal >= 900;  -- 오류 , with check option때문에 
-- view는 검색, 삽입이나 수정, 삭제 수행이 가능한데, 이 옵션을 걸면 수정은 안되고 검색만 가능.
-- with check option지정이 된 컬럼만 수정불가

-- [12] 뷰 생성에 사용되는 다양한 옵션(with read only ) :기본 테이블의 어떤 컬럼에 대해서도 뷰를 통한 내용 수정을 불가능하게 만드는 옵션.
create table emp_copy03
as
select * from emp;

create or replace view view_check30
as
select empno, ename, sal, comm, deptno
from emp_copy03
where deptno = 30;

update view_check30
set comm = 1000;  -- 수정이됨.

select * from view_check30;
select * from emp_copy03;  -- 원본(기본)테이블에도 다 수정이됨.


create or replace view view_read30
as
select empno, ename, sal, comm, deptno
from emp_copy03
where deptno = 30 with read only;

select * from view_read30;

update view_read30
set comm = 2000;  -- 오류 : read-only view 옵션이 적용됬기 때문에 수정불가.

-- *** with check option과 with read only의 차이점
-- 뷰를 설정할 때 조건으로 설정한 컬럼이 아닌 컬럼에 대해서는 변경이 가능.
-- 전체 데이터냐? 아니면 지정 컬럼이냐?
update view_chk30 -- with check option
set comm = 1000;  -- comm 업데이트됨.  deptno가 옵션이 지정되어 있기 때문에 comm은 가능.

update view_read30
set deptno = 1000; -- 오류
-- with read  only는 전체 테이블 수정 불가


-- [13] Top쿼리
-- 오라클에서만 많이 사용되는 기능*** 

--  [rownum] 컬럼 값 출력
select rownum, empno, ename, hiredate
from emp; -- 데이터 삽입순서대로 번호를 부여해서 오름차순으로 보여짐. 
-- 고정. 불변의 값. 오라클데이터베이스가 붙여준 값.

select rownum, empno, ename, hiredate
from emp
order by hiredate; -- rownum의 값은 똑같지만, hiredate순서대로 정렬

create or replace view view_hire
as
select empno, ename, hiredate
from emp
order by hiredate;  -- 가상의 테이블이지만 새 뷰를 생성함.
-- 새롭게 만드는 순간 자동으로 rownum을 생성하면 그때 대입되는 순서대로 번호를 부여됨.

select * from view_hire;  -- 오름차순으로 hiredate이 정렬된 데이터가 출력됨.

-- hireview에 대한 rownum을 만들어줌
select rownum, empno, ename, hiredate
from view_hire;  -- rownum이 다시 생성됨. view_hire 순서대로.
-- 아까와 달리 새view_hire테이블의 생성 순서대로  재정렬된  rownum생성.


-- rownum 포함 전체 데이터 출력
select rownum, e.*
from emp e;


-- [1] rownum을 이용
select rownum, empno, ename, hiredate
from view_hire
where rownum between 1 and 5;

select rownum, empno, ename, hiredate
from view_hire
where rownum <= 5;


-- [2] inline view(인라인 뷰)를 이용.
-- FROM절에 오는 Subquery를 말함.
-- FROM절에서 원하는 데이터를 조회하여 가상의 집합을 만들어 조인을 수행하거나 가상의 집합을 다시 조회 할 때 사용한다.
-- Inlivew View 안에 또 다른 Inline View가 올 수 있다
select rownum, empno, ename, hiredate
from (select empno, ename, hiredate
         from emp
         order by hiredate)  -- 가상 테이블대신에 select문이 들어갈 수 있음.
where rownum <= 5;
-- 이런 명령문은 inline view라고 함.
-- 서브쿼리가 먼저 실행됨.


-- [문제] 입사일 기준으로 3번째 ~7번째 사이에 입사한 사원을 출력해보기
select rownum, empno, ename, hiredate
from (select  empno, ename, hiredate
      from emp
      order by hiredate)
where rownum between 3 and 7;  -- 결과가 안나옴
-- rownum은 조건에 사용하려면 반드시 1부터시작해서 연속적으로 값을 사용할 때만 조건으로 가능함.

select rnum, empno, ename, hiredate
from (select  rownum as rnum, empno, ename, hiredate
      from (select empno, ename, hiredate
            from emp
            order by hiredate))
where rnum between 3 and 7; 
-----------------------------------------------
select  rownum, empno, ename, hiredate
from view_hire;

select rnum, empno, ename, hiredate
from (select  rownum rnum, empno, ename, hiredate
         from view_hire)
where (rnum>=3) and (rnum <= 7) ;
-- rownum은 실제테이블의 컬럼이 아니기에 
-- inline안에 계속해서 rownum이 생기는데 같은 것이 아니기에 원하는 rownum의 값을 얻기위해 별칭을 부여해서 정확히함


-- [문제] 입사일을 기준으로 내림차순으로 정렬해서 5와 10사이의 존재하는 사원을 출력하기.
select rnum, empno, ename, hiredate
from (select rownum rnum, empno, ename, hiredate
         from (select  empno, ename, hiredate
                   from emp
                   order by hiredate desc))
where rnum between 5 and 10;

------------------------------------------------
create or replace view view_rnum10
as
select rownum rnum, empno, ename, hiredate
         from (select  empno, ename, hiredate
                   from emp
                   order by hiredate desc)
;
                   

select rnum, empno, ename, hiredate
from view_rnum10
where rnum between 5 and 10;


