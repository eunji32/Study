-- * 오라클 명령어 : select 문(검색)

-- [1] scott 사용자가 관리하는 테이블 목록
--블럭 잡고 실행
select * from tab;

-- [2] 특정 테이블의 구조(필드 리스트/데이터 형식/제약조건)
desc dept; --desc라는 명령

-- [3] 특정 테이블의 data 표시
select * from dept;
select * from emp;

-- [4] 모든 컬럼(필드명)이 아닌, 필요한 컬럼(필드명) 내용만 출력 
select dname, loc from dept;

--[5] 각각의 필드명에 별칭을 주어서 출력 : as 생략 가능 
select deptno  as 부서번호, dname as 부서명, loc as 위치 from dept;

--cf)
select deptno  as 부서 번호, dname as 부 서 명, loc as 위 치 from dept; --error
select deptno  as "부서 번호", dname as "부 서 명", loc as "위 치" from dept; 
select depno as '부서 번호', dname as ' 부 서 명', loc as '위 치' from dept; --error (작은 따옴표는 지원x)
select deptno  "부서 번호", dname  "부 서 명", loc "위 치" from dept; -- as 생략


--[6] 사원들의 직업명을 중복 제거 후 출력
select * from emp;
select job from emp;
select distinct job from emp; -- 중복된 것은 한번만 출력

--[7] 급여가 3000 이상인 사원 정보 출력
select empno, ename, sal from emp
where sal>=3000;


--[8] 이름이 scott 사원의 정보 출력
--    단, data의 경우는 대소문자를 구별!!!
select * from emp
where ename = 'scott'; -- 결과가 나오지 않음. 

select * from emp
where ename = 'SCOTT'; 

--[9] 1985년도 이후로 입사한 사원 정보
select empno, ename, hiredate 
from emp
where hiredate >='1985/01/01';

-- [10] 부서번호가 10 이고 , 그리고 직업이 'MANAGER' 인 사원 출력
select ename, deptno, job
from emp
where deptno = 10 and job = 'MANAGER';

-- [11] 부서번호가 10 이거나 , 직업이 'MANAGER' 인 사원 출력
select ename, deptno, job
from emp
where deptno = 10 or job = 'MANAGER';

-- [12] 부서번호가 10 이 아닌 사원
select deptno, ename from emp
where not deptno = 10;

select deptno, ename from emp
where  deptno != 10;

-- [13] 급여가 1000 ~ 3000 사이인 사원을 출력
select ename, sal from emp
where sal>= 1000 and sal <= 3000;

select ename, sal from emp
where (sal>= 1000) and (sal <= 3000);

select ename, sal from emp
where sal between 1000 and 3000;


-- [14] 급여가 1300 또는 1500 또는 1600 인 사원 정보 출력
select ename, sal from emp
where sal=1300 or sal=1500 or sal=1600;

select ename, sal from emp
where sal in (1300, 1500, 1600);


-- [15] 이름이  'K'로 시작하는 사원 출력
select ename, empno from emp
where ename like 'K%';


-- [16] 이름이  'K'로 끝나는 사원 출력
select ename, empno from emp
where ename like '%K';


-- [17] 이름에  'K'가 포함되어 있는 사원 출력
select ename, empno from emp
where ename like '%K%';


-- [18] 2번째 자리에 'A' 가 들어가 있는 사원 출력
select ename, empno from emp
where ename like '_A%';  -- '_'는 어떤문자든 하나는 와야됨. % 어떤문자든 상관없음.


-- [19] 커미션을 받지 않는 사원 출력
select  * from emp
where comm = null or comm = 0;  -- 원하는 결과X 
-- null은 값을 의미하지는 않음. 비교차제가 되지않음.(비교연산으로 처리하면 안됨.)
-- 넣어주지 않은 값을 가지고 연산을 하는 것은 모순.

-- null도 커미션을 받지 않는 사원으로 체크하고 싶을때, (개인적인 판단으로 피드백 받고 싶을때)
select * from emp
where comm is null or comm = 0;


-- [20] 커미션을 받는 사원 출력
select * from emp
where comm <> null and comm <> 0;  -- 원하는 결과X

select * from emp
where comm is not null and comm <> 0;


-- [21] 사번(empno)의 정렬 (오름차순 )으로 출력  -- asc생략 가능(default)
select * from emp
order by empno asc;

select * from emp
order by empno;


-- [22] 사번의 정렬 (내림차순 )으로 출력
select * from emp
order by empno desc;


-- [23] 사원의 연봉 출력
select ename, sal, sal * 12 from emp;

select *, sal*12 from emp; -- 오류 , 전체를 가져오고 싶을 때는 모든 컬럼을 명시해줘야 함.

select ename, sal, sal * 12 as "연봉" from emp;

select ename, sal, sal * 12 "연봉" from emp; -- as생략


-- [24] 커미션을 포함한 최종 연봉 출력
select ename, sal, sal * 12 + comm "연봉" from emp;   -- null이 생김.


-- [25] [24]의 오류 해결법
select ename, sal, comm, sal*12+comm, nvl(comm, 0), sal*12 + nvl(comm, 0) "연봉" 
from emp;  
-- null은 계속 null임. 단지, nvl이용해서 0으로 잠시 바꿔 결과를 얻은것.
-- select comm from emp;를 하면 여전히 null은 null





