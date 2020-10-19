--*오라클 SQL문 : 데이터 입력/출력(select문)/수정/삭제  = DML (= C.R.U.D)
-- [1] 샘플 테이블 생성 
drop table exam01 purge;

create table exam01(
    deptno    number(2),
    dname    varchar2(14),
    loc         varchar2(14)
);

select * from tab;
select * from exam01;

-- [2] 데이터 입력(저장) : insert into ~ values() 
insert into exam01(deptno, dname, loc) values(10, '회계부','종로구');  -- 지정한 순서대로 해당되는 데이터를 삽입.
insert into exam01(loc, deptno, dname) values('중구', 20,'연구소');


-- [3] 데이터 입력 : 행 생략 
insert into exam01 values(30, '영업부', '용산구'); 
-- 필드명시 안하고 값을 넣을 수 있음. but 테이블 생성시의 순서대로 값을 넣어주면 됨. create table 참고!


-- [4] null 값 입력
insert into exam01 values(40, '관리부', null);    -- 입력 데이터가 없음에도 불구하고, error방지를 위해 null 삽입.


-- [5] 데이터 출력(검색) : select문 
-- >> 03_select.sql 실습 참조!!!!!!



-- [6] 필드의 데이터를 변경 : 부서번호 변경 
update exam01 set deptno = 30;   -- 모든 부서번호를 30으로

-- [7] 급여 10% 인상 금액 반영 
drop table exam02 purge;

create table exam02
as
select * from emp;

select * from exam02;

update exam02 set sal = sal*1.1 ;  -- 변수등장~! 원래 필드인 sal에 10%인상된 값을 다시 넣음.
-- 계속 실행하면 계속 수정되니까 주의하기!


-- [8] 부서번호가 10인 사원의 부서번호를 20으로 변경 
update exam02 set deptno = 20
where deptno = 10;  



-- [9] 급여가 3000 이상인 사원만 급여를 10% 인상 
update exam02 set sal = sal*1.1
where sal >=3000;



-- [10] 사원 이름이 scott인 자료의 부서번호를 10, 직급을 MANAGER로 변경 
update exam02 set deptno = 10, job = 'MANAGER'  -- and가 아닌 ','로 동시지정가능.
where ename = 'SCOTT';



-- [11] 30번 부서 사원을 삭제 
delete from exam02     -- where 안하면 데이터 전체 삭제됨.
where deptno = 30;


select * from exam02;

-- [12] 사원을 삭제
delete from exam02;  -- 모든 데이터 삭제됨. 































