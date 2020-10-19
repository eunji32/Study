-- * ������ ���Ἲ ���� ���� 
desc user_constraints; 

select owner, constraint_name, constraint_type from user_constraints; --cmd������ ����

column constraint_name format a15  -- �������� ũ�⸦ ����.

-- * �÷� ���� ���� ���� ����.
-- [1] Not null/null ���������� �������� �ʰ� ���̺� ����
drop table emp01 purge;

create table emp01(
    empno      number(4),
    ename      varchar2(20),
    job          varchar2(20),
    deptno      number(2)
);

-- [null ������ �Է� ����]
insert into emp01 values(null, null, 'salesman',40);
select * from emp01;

-- [2] not null ���� ������ �ɰ� ���̺� ����
create table emp02(
    empno      number(4) not null,
    ename      varchar2(20) not null,
    job          varchar2(20),   -- null�� ���������� ���� ��.
    deptno      number(2)
);

insert into emp02 values(null, null, 'salesman',40);    -- ����. null���� ������ �� ���ٰ� �޼�����.
insert into emp02 values(null, 'ȫ�浿', 'salesman',40);   -- ����
insert into emp02 values(1234, 'ȫ�浿', 'salesman',40);   -- ���Ե�.

insert into emp02 values(1235, 'ȫ�浵', null,40); -- ���� ���� ����

select * from emp02;



insert into emp02 values(1234, 'ȫ�漭', '������',10); -- �����. but �����ȣ�� �ߺ��Ǹ� �ȵ�.
-- [3] Unique ���� ������ �����Ͽ� ���̺� ����
create table emp03(
    empno      number(4) unique,
    ename      varchar2(20) not null,
    job          varchar2(20),   
    deptno      number(2)
);

insert into emp03 values(1234, 'ȫ�浿', 'salesman',40);  
insert into emp03 values(1234, 'ȫ�漭', '������',10);   -- �����޼��� : unique constraint (SCOTT.SYS_C007003) violated
-- �����ȣ�� �ߺ��Ǳ� ������ �����߻�.
-- �����Ͱ� �������� insert����� ������ ���������, �׷��� ����.. �˻� ������ ���� ��, ������ ����.


-- [4] ������ ���Ǹ� ���
create table emp04(
    empno      number(4) constraint emp04_empno_uk unique,
    ename      varchar2(20) constraint emp04_ename_nn not null,
    job          varchar2(20),  
    deptno      number(2)
);

insert into emp04 values(1234, 'ȫ�浿', 'salesman',40);  
insert into emp04 values(1234, 'ȫ�漭', '������',10);   -- �����޼���  :  unique constraint (SCOTT.EMP04_EMPNO_UK) violated



-- [5] Primary key(�⺻Ű) �������� ���� - unique + not null �� ���� ���ø���.
create table emp05(
    empno      number(4) constraint emp05_empno_pk primary key,
    ename      varchar2(20) constraint emp05_ename_nn not null,
    job          varchar2(20),  
    deptno      number(2)
);

insert into emp05 values(null, 'ȫ�浿', 'salesman',40);  -- ���� : cannot insert NULL into ("SCOTT"."EMP05"."EMPNO")
insert into emp05 values(1234, 'ȫ�漭', '������',10);
insert into emp05 values(1234, 'ȫ�浿', 'salesman',40);  -- ���� : unique constraint (SCOTT.EMP05_EMPNO_PK) violated


-- [6] ���� ���Ἲ�� ����  Foreign key(�ܷ�Ű) ���� ����
create table dept06(
    deptno   number(2) constraint dept06_deptno_pk primary key,
    dname   varchar2(20),
    loc        varchar2(20)
);

insert into dept06 values(10, 'ȸ���', '���α�');
insert into dept06 values(20, '������', '���빮��');
insert into dept06 values(30, '������', '��������');

select * from dept06;

create table emp06(
    empno      number(4) constraint emp06_empno_pk primary key,
    ename      varchar2(20) constraint emp06_ename_nn not null,
    job          varchar2(20),  
    deptno      number(2) constraint emp06_deptno_fk 
                                   references dept06(deptno)  -- �̸��� foreign key����, references��� ��.
);


insert into emp06 values(1234, 'ȫ�浿','�������','30');
insert into emp06 values(1235, 'ȫ�泲', '����', 40);  -- ���� : integrity constraint (SCOTT.EMP06_DEPTNO_FK) violated - parent key not found
-- �θ� Ű�� �Ǳ� ���� �÷��� �ݵ�� �θ� ���̺�(dept06)�� �⺻Ű(primary key)�� ���� Ű(unique key)�� �����Ǿ� �־�� �Ѵ�
-- why? �������� �ߺ����� ���ϱ� ���� 



-- [7] Check ���� ���� �����ϱ� : Ư���� ���� ����Ǵ� �ʵ� ����. 
--      .�޿� �÷��� �����ϵ� ���� 500~5000������ ���� ���尡��.
--      .���� ���� �÷����� gender�� �����ϰ�, 'M'/'F' �� �� �ϳ��� ���� ���� ����.

create table emp07(
    empno      number(4) constraint emp07_empno_pk primary key,
    ename      varchar2(20) constraint emp07_ename_nn not null,
    sal          number(7, 2) constraint emp07_sal_ck check(sal between 500 and 5000),  -- �޿��÷� ������. ��, 500~5000 ������ ����.
    gender      varchar2(1) constraint emp07_gender_ck check(gender in ('M' , 'F'))
);

insert into emp07 values(1234, 'ȫ�浿', 6000, 'M');  -- ���� : �޿��� 6000�̶�
insert into emp07 values(1234, 'ȫ�浿', 3500, 'M');  -- ������ ���⿡ ���Ե�.
insert into emp07 values(1235, 'ȫ���', 3000, '��');  -- ���� : value too large for column "SCOTT"."EMP07"."GENDER" (actual: 3, maximum: 1) , �ѱ��� ũ�Ⱑ ŭ.
insert into emp07 values(1235, 'ȫ���', 3000, 'A');   -- ���� : check constraint (SCOTT.EMP07_GENDER_CK) violated
insert into emp07 values(1235, 'ȫ���', 3000, 'm');   -- ���� : �����ʹ� ��ҹ��ڱ����� �ؾ���..!!



-- [8] Default �������� �����ϱ� : �⺻������ Ư�� ���� ����ǵ��� �����ϴ� ����. 
--      . ������(loc)�÷��� �ƹ� ���� �Է����� ���� ��, ����Ʈ ���� 'SEOUL'�� �Էµǵ��� ������ �������� ����.

create table dept08(
    deptno   number(2) constraint dept08_deptno_pk primary key,
    dname   varchar2(20) constraint dept08_dname_nn not null,
    loc        varchar2(20) default 'SEOUL'
);

insert into dept08 values(10,'ȸ���');  -- �̷��� ���� ����. ���� ������� ����.
insert into dept08(deptno, dname) values(10, 'ȸ���'); -- �� ���� ���� �ʹٰ� �ϸ� �����./ SEOUL�� ����.
insert into dept08 values(20, '������', '���α�');  -- �������� ���޵Ǿ� ������ �� ���������� �����.

select * from dept08;


-- [9] �������� ��� ���
--      1) �÷� ������ ���Ǹ� ����ؼ� ���� ���� ����.
create table dept09(
    deptno   number(2) constraint dept08_deptno_pk primary key,
    dname   varchar2(20) constraint dept08_dname_nn not null,
    loc        varchar2(20) default 'SEOUL'
);


--      2) ���̺� ���� ������� ���� ���� ����.
--      * not null ������ ���̺� ���� ������� ���� ������ ������ �� ����.  
--      * default��!!!!
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


-- [10] �������� �߰��ϱ�
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

-- [11] not null���� ���� �߰��ϱ�
alter table emp10
add constraint emp10_ename_nn not null(ename); -- ���� 

alter table emp10
modify ename constraint emp10_ename_nn not null;  -- �⺻���� null�� ����Ǿ� �ֱ� ������....

-- [12] ���� ���� �����ϱ�
alter table emp10
drop primary key; 

-- alter table ���̺�� drop constraint �����̸�; �ϸ� ������ ���̺� �������� �����ϴ� ���

-- [13] ���� ����(�ܷ�Ű) �÷� ����
delete from dept06
where deptno= 30;  -- ����. �ڽ����̺�鿡�� ���ԵǾ��� �ֱ� ������. ����߻�

-- �����Ϸ��� �ڽĵ����͸��� ������, �θ����� ����.
-- �ƴϸ�,
alter table emp06
disable constraint emp06_deptno_fk;  -- ���������� �Ͻ������� ��Ȱ��ȭ

delete from dept06
where deptno= 30;  -- �ڽ����̺� ��Ȱ��ȭ �� �θ����̺� ������.  

select * from dept06;

alter table emp06
enable constraint emp06_deptno_fk; -- ����. Ȱ��ȭ�� deptno = 30 �� �����Ͱ� ����.

insert into dept06
values(30, '�ѹ���','�߱�');  -- �����Ҷ��� ��Ȱ��ȭ�� �����ϰ� �־ ��.

alter table emp06
enable constraint emp06_deptno_fk;  -- �����.


-- * cascade �ɼ� : �θ����̺��� ��Ȱ��ȭ�ϴ� �ɼ�.
-- �θ����̺��� ���������� �����ϸ� �ڽ����̺��� �������ǵ� ������.
-- ��ȣ��Ȱ��ȭ �ɼ���.

alter table dept06  -- �θ����̺�
disable primary key cascade;


select constraint_name, constraint_type, table_name, r_constraint_name, status
from user_constraints
where table_name in ('DEPT06','EMP06');  -- ���¸� ���� DISABLED���� Ȯ���� �� ����

-- constraint_name, constraint_type, status ���Ἲ Ȯ�� �÷�


alter table dept06
drop primary key;   -- ����. 


alter table dept06
drop primary key cascade;  -- cascade�� ������ ������ ���� �ؾߵ�.
-- ���������� ������.  �θ����̺�� �ڽ����̺� �� ��.


alter table dept06
add constraint dept06_deptno_pk primary key(deptno);  -- �������� �ٽ� ����.
-- dept06, �θ����̺��̾��� �͸� �ٽ� ����. �ڽ����̺� �ߴ����� �ٽ� ������ ���� �־������.




















