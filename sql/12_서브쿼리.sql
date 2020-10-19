-- 오라클 SQL문 : 서브쿼리(Sub-Query)

-- [단일 행 서브쿼리]
-- ex) scott이 근무하는 부서명, 지역 출력(서로 다른 테이블에 데이터 존재)
-- 첫번째방법(기본)
select deptno from emp
where ename = 'SCOTT';  -- 결과 20

select dname, loc from dept
where deptno = 20;  -- 위의 결과를 가지고 검색.

-- 두번째방법(서브쿼리이용) (주의!!! 서브쿼리먼저 실행되야함 따라서, 괄호로 묶어주는 것 기억하기.)
select dname, loc from dept
where deptno = (select deptno from emp
                        where ename = 'SCOTT');  



-- [예제] scott와 동일한 직급(job)을 가진 사원을 출력하는 sql문을 서브쿼리를 이용해 작성하기.
-- 첫번째
select job
from emp
where ename = 'SCOTT';  -- analyst

select ename, job
from emp
where job = 'ANALYST';

-- 두번째
select ename, job 
from emp
where job = (select job 
                    from emp
                    where ename = 'SCOTT');

-- [예제] scott의 급여와 동일하거나 더 많이 받는 사원이름과 급여 출력.
select ename, sal 
from emp
where sal >= (select sal
                    from emp
                    where ename = 'SCOTT');

-- [서브쿼리 & 그룹함수]
-- [예제] 전체 사원 평균 급여보다 더 많은 급여를 받는 사원을 출력.
select avg(sal) from emp; -- 평균 : 2073.~

select ename, sal
from emp
where sal >= (select avg(sal)
                    from emp);   -- avg()는 한개의 값만 가지기 때문에

select ename, sal, avg(sal)
from emp
where sal >= (select avg(sal)
                    from emp);   -- 오류


-- [다중 행 서브쿼리]
-- [예제] 급여를 3000 이상 받는 사원이 소속되어져 있는 부서와 동일한 부서에서 근무하고 있는 사원.
select * from emp;

select deptno
from emp
where sal>=3000;

select ename,sal, deptno
from emp
where deptno in (select deptno
                        from emp
                        where sal >= 3000);


-- 비교연산자의 경우 1대1로  2개이상의 결과는 사용불가

-- 1) [in 연산자] : 하나라도 일치하면 '참'
select ename,sal, deptno
from emp
where deptno in (select deptno
                        from emp
                        where sal >= 3000);

-- [문제] in 연산자를 이용, 부서별로 가장 급여를 많이 받는 사원의 정보(사원번호, 사원명, 급여, 부서번호)를 출력하세요.
select deptno, max(sal)
from emp
group by deptno;
------------
select empno, ename, sal, deptno
from emp
where sal in (select max(sal)
                    from emp
                    group by deptno);


-- 2) [all 연산자] : 모든 값과 일치하면 '참' - 최대
-- ex) ~ > all 의 경우 서브 쿼리의 값들 중 최댓값보다 크면 '참'이됨.
-- [예제] 30번(부서번호) 소속 사원들 중에서 급여를 가장 많이 맏는 사원보다 더 많은 급여를 받는 사원의 이름과 급여를 출력
-- 첫번째(단일 행 서브쿼리 & 그룹함수)
select max(sal)
from emp
where deptno = 30;

select ename, sal
from emp
where sal >  (select max(sal)
                    from emp
                    where deptno = 30);

 -- 두번째(다중 행 서브쿼리)                  
select ename, sal
from emp
where sal > all (select sal
                       from emp
                       where deptno = 30);


-- [문제] 영업사원(salesman)들보다 급여를 많이 받는 사원들의 이름과 급여를 출력하되, 영업사원은 출력하지 않게 명령문을 작성.
select max(sal)
from emp
where job = 'SALESMAN';
-----------------------------------
select ename, sal, job
from emp
where sal > all(select sal   -- >all 자체가 하나의 연산자라고 생각하면 됨.
                       from emp
                       where job = 'SALESMAN')
and job != 'SALESMAN'; -- 이 명령문이 없어도 답은 나오지만 정확하게 문제를 하기 위해 넣어줌.



-- 3) [any 연산자] : 하나이상만 일치하면 '참' - 최소값
-- [예제] 부서번호가 30번인 사원들의 급여 중에서 가장 낮은 급여보다 높은 급여를 받는 사원의 이름, 급여를 출력.
select min(sal)
from emp
where deptno = 30;
-- 단일 행
select ename, sal
from emp
where sal > (select min(sal)
                        from emp
                        where deptno = 30);
-- 다중 행
select ename, sal
from emp
where sal > any(select sal
                        from emp
                        where deptno = 30);
                        

-- [문제] 영업사원들의 최소 급여보다 많이 받는 사원들의 이름과 급여와 직급을 출력하되 영업사원은 출력하지 않기.
select ename, sal, job
from emp
where sal > any(select sal
                        from emp
                        where job = 'SALESMAN')
and job != 'SALESMAN';









