-- * 데이터 무결성 제약 조건 
desc user_constraints; 

select owner, constraint_name, constraint_type from user_constraints; --cmd에서도 실행

column constraint_name format a15  -- 데이터의 크기를 줄임.

-- * 컬럼 레벨 제약 조건 지정.
-- [1] Not null/null 제약조건을 설정하지 않고 테이블 생성
drop table emp01 purge;

create table emp01(
    empno      number(4),
    ename      varchar2(20),
    job          varchar2(20),
    deptno      number(2)
);

-- [null 데이터 입력 연습]
insert into emp01 values(null, null, 'salesman',40);
select * from emp01;

-- [2] not null 제약 조건을 걸고 테이블 생성
create table emp02(
    empno      number(4) not null,
    ename      varchar2(20) not null,
    job          varchar2(20),   -- null로 제약조건이 있은 것.
    deptno      number(2)
);

insert into emp02 values(null, null, 'salesman',40);    -- 오류. null값은 삽입할 수 없다고 메세지뜸.
insert into emp02 values(null, '홍길동', 'salesman',40);   -- 오류
insert into emp02 values(1234, '홍길동', 'salesman',40);   -- 삽입됨.

insert into emp02 values(1235, '홍길도', null,40); -- 아직 실행 안함

select * from emp02;



insert into emp02 values(1234, '홍길서', '관리부',10); -- 실행됨. but 사원번호는 중복되면 안됨.
-- [3] Unique 제약 조건을 설정하여 테이블 생성
create table emp03(
    empno      number(4) unique,
    ename      varchar2(20) not null,
    job          varchar2(20),   
    deptno      number(2)
);

insert into emp03 values(1234, '홍길동', 'salesman',40);  
insert into emp03 values(1234, '홍길서', '관리부',10);   -- 오류메세지 : unique constraint (SCOTT.SYS_C007003) violated
-- 사원번호가 중복되기 때문에 오류발생.
-- 데이터가 많을수록 insert기능이 느리게 실행되지만, 그래도 빠름.. 검색 수행이 느릴 뿐, 삽입은 빠름.


-- [4] 레벨로 조건명 명시
create table emp04(
    empno      number(4) constraint emp04_empno_uk unique,
    ename      varchar2(20) constraint emp04_ename_nn not null,
    job          varchar2(20),  
    deptno      number(2)
);

insert into emp04 values(1234, '홍길동', 'salesman',40);  
insert into emp04 values(1234, '홍길서', '관리부',10);   -- 오류메세지  :  unique constraint (SCOTT.EMP04_EMPNO_UK) violated



-- [5] Primary key(기본키) 제약조건 설정 - unique + not null 두 조건 동시만족.
create table emp05(
    empno      number(4) constraint emp05_empno_pk primary key,
    ename      varchar2(20) constraint emp05_ename_nn not null,
    job          varchar2(20),  
    deptno      number(2)
);

insert into emp05 values(null, '홍길동', 'salesman',40);  -- 오류 : cannot insert NULL into ("SCOTT"."EMP05"."EMPNO")
insert into emp05 values(1234, '홍길서', '관리부',10);
insert into emp05 values(1234, '홍길동', 'salesman',40);  -- 오류 : unique constraint (SCOTT.EMP05_EMPNO_PK) violated


-- [6] 참조 무결성을 위한  Foreign key(외래키) 제약 조건
create table dept06(
    deptno   number(2) constraint dept06_deptno_pk primary key,
    dname   varchar2(20),
    loc        varchar2(20)
);

insert into dept06 values(10, '회계부', '종로구');
insert into dept06 values(20, '연구소', '서대문구');
insert into dept06 values(30, '영업부', '영등포구');

select * from dept06;

create table emp06(
    empno      number(4) constraint emp06_empno_pk primary key,
    ename      varchar2(20) constraint emp06_ename_nn not null,
    job          varchar2(20),  
    deptno      number(2) constraint emp06_deptno_fk 
                                   references dept06(deptno)  -- 이름은 foreign key지만, references라고 씀.
);


insert into emp06 values(1234, '홍길동','세일즈맨','30');
insert into emp06 values(1235, '홍길남', '점원', 40);  -- 오류 : integrity constraint (SCOTT.EMP06_DEPTNO_FK) violated - parent key not found
-- 부모 키가 되기 위한 컬럼은 반드시 부모 테이블(dept06)의 기본키(primary key)나 유일 키(unique key)로 설정되어 있어야 한다
-- why? 데이터의 중복성을 피하기 위해 



-- [7] Check 제약 조건 설정하기 : 특정한 값만 저장되는 필드 조건. 
--      .급여 컬럼을 생성하되 값은 500~5000사이의 값만 저장가능.
--      .성별 저장 컬럼으로 gender를 정의하고, 'M'/'F' 둘 중 하나의 값만 저장 가능.

create table emp07(
    empno      number(4) constraint emp07_empno_pk primary key,
    ename      varchar2(20) constraint emp07_ename_nn not null,
    sal          number(7, 2) constraint emp07_sal_ck check(sal between 500 and 5000),  -- 급여컬럼 생성됨. 단, 500~5000 사이의 값만.
    gender      varchar2(1) constraint emp07_gender_ck check(gender in ('M' , 'F'))
);

insert into emp07 values(1234, '홍길동', 6000, 'M');  -- 오류 : 급여가 6000이라
insert into emp07 values(1234, '홍길동', 3500, 'M');  -- 제약이 없기에 삽입됨.
insert into emp07 values(1235, '홍길북', 3000, '남');  -- 오류 : value too large for column "SCOTT"."EMP07"."GENDER" (actual: 3, maximum: 1) , 한글은 크기가 큼.
insert into emp07 values(1235, '홍길북', 3000, 'A');   -- 오류 : check constraint (SCOTT.EMP07_GENDER_CK) violated
insert into emp07 values(1235, '홍길북', 3000, 'm');   -- 오류 : 데이터는 대소문자구분을 해야함..!!



-- [8] Default 제약조건 설정하기 : 기본값으로 특정 값이 저장되도록 설정하는 조건. 
--      . 지역명(loc)컬럼에 아무 값도 입력하지 않을 때, 디폴트 값인 'SEOUL'이 입력되도록 디폴드 제약조건 지정.

create table dept08(
    deptno   number(2) constraint dept08_deptno_pk primary key,
    dname   varchar2(20) constraint dept08_dname_nn not null,
    loc        varchar2(20) default 'SEOUL'
);

insert into dept08 values(10,'회계부');  -- 이렇게 쓰면 오류. 값이 충분하지 않음.
insert into dept08(deptno, dname) values(10, '회계부'); -- 두 값만 적고 싶다고 하면 실행됨./ SEOUL도 나옴.
insert into dept08 values(20, '연구소', '종로구');  -- 지역명이 전달되어 있으면 그 지역명으로 저장됨.

select * from dept08;


-- [9] 제약조건 명시 방법
--      1) 컬럼 레벨로 조건명 명시해서 제약 조건 설정.
create table dept09(
    deptno   number(2) constraint dept08_deptno_pk primary key,
    dname   varchar2(20) constraint dept08_dname_nn not null,
    loc        varchar2(20) default 'SEOUL'
);


--      2) 테이블 레벨 방식으로 제약 조건 설정.
--      * not null 조건은 테이블 레벨 방식으로 제약 조건을 지정할 수 없음.  
--      * default도!!!!
create table emp09(
    empno    number(4),
    ename    varchar2(20) constraint emp09_ename_nn not null,
    job        varchar2(20),
    deptno    number(2),
    constraint emp09_empno_pk primary key(empno),
    constraint emp09_job_uk  unique(job),
    constraint emp09_deptno_fk foreign key(deptno) 
                                            references dept06(deptno)
);


-- [10] 제약조건 추가하기
create table emp10(
    empno    number(4),
    ename    varchar2(20),
    job        varchar2(20),
    deptno    number(2)
);

alter table emp10
add constraint emp10_empno_pk primary key(empno);

alter table emp10
add constraint emp10_deptno_fk
foreign key(deptno)
references dept06(deptno);

-- [11] not null제외 조건 추가하기
alter table emp10
add constraint emp10_ename_nn not null(ename); -- 오류 

alter table emp10
modify ename constraint emp10_ename_nn not null;  -- 기본으로 null로 제약되어 있기 때문에....

-- [12] 제약 조건 제거하기
alter table emp10
drop primary key; 

-- alter table 테이블명 drop constraint 제약이름; 하면 각각의 테이블 제약조건 제거하는 방법

-- [13] 제약 조건(외래키) 컬럼 삭제
delete from dept06
where deptno= 30;  -- 오류. 자식테이블들에게 삽입되어져 있기 때문에. 모순발생

-- 삭제하려면 자식데이터먼저 삭제후, 부모데이터 삭제.
-- 아니면,
alter table emp06
disable constraint emp06_deptno_fk;  -- 제약조건을 일시적으로 비활성화

delete from dept06
where deptno= 30;  -- 자식테이블 비활성화 후 부모테이블 삭제함.  

select * from dept06;

alter table emp06
enable constraint emp06_deptno_fk; -- 오류. 활성화할 deptno = 30 의 데이터가 없음.

insert into dept06
values(30, '총무부','중구');  -- 수정할때도 비활성화후 삭제하고 넣어도 됨.

alter table emp06
enable constraint emp06_deptno_fk;  -- 실행됨.


-- * cascade 옵션 : 부모테이블을 비활성화하는 옵션.
-- 부모테이블의 제약조건을 삭제하면 자식테이블의 제약조건도 삭제됨.
-- 상호비활성화 옵션임.

alter table dept06  -- 부모테이블
disable primary key cascade;


select constraint_name, constraint_type, table_name, r_constraint_name, status
from user_constraints
where table_name in ('DEPT06','EMP06');  -- 상태를 보면 DISABLED됨을 확인할 수 있음

-- constraint_name, constraint_type, status 무결성 확인 컬럼


alter table dept06
drop primary key;   -- 오류. 


alter table dept06
drop primary key cascade;  -- cascade를 했으면 삭제할 때도 해야됨.
-- 제약조건이 삭제됨.  부모테이블과 자식테이블 둘 다.


alter table dept06
add constraint dept06_deptno_pk primary key(deptno);  -- 제약조건 다시 만듬.
-- dept06, 부모테이블이었던 것만 다시 생김. 자식테이블 했던것은 다시 조건을 만들어서 넣어줘야함.




















