-- * 오라클 명령어 : Group 함수

-- [1] sum() : 합계 - 수치형데이터
select sum(sal) "총급여" from emp;

-- [2] count() :  카운트
select count(*) "총레코드"  from emp; -- 총레코드의 개수

select count(empno) from emp;

-- [3] avg() :  평균
select avg(sal) "월평균 급여" from emp;

-- [4 ] max() : 최대값
select max(sal) "최고 급여 수령자"  from emp;

-- [5 ] min() : 최소값
select min(sal) "최저 급여 수령자" from emp;

-- [6 ] Group by 절 : 직업별 급여 평균
select job, avg(sal) from emp;  -- 오류발생 , 결과의 개수가 다르기 때문( job의 레코드개수는 14개 , 함수사용값은 1개)

select job, avg(sal) from emp
group by job;   -- job별로 그룹을 만들어 결과도출. 
-- 추가로 group by함수를 사용하여 그룹함수와 컬럼이 같이 사용됨.


-- [7 ] Having 절 : 직업별 급여 평균 (단, 급여 평균 2000 이상 직업 ) (group by + 조건추가)
select job, avg(sal) from emp
group by job
having avg(sal) >=2000;




