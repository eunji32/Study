-- * 오라클 : 시퀀스(Sequence)

-- [1] 샘플테이블 생성
create table memos(
        num    number(4) constraint memos_num_pk primary key,
        name  varchar2(20) constraint memos_name_nn not null,
        postDate Date  default(sysdate) -- 날짜는 default가 일반적.
);


-- [2] 해당 테이블의 시퀀스 생성
create sequence memos_seq;  -- 이렇게 실행해도 됨

create sequence memos_seq
start with 1 increment by 1; -- 시작의 값을 1부터 1씩 증가하도록 설정 / with 첫 시작값 increment by 증가값

-- increment by 새롭게해보기!!!!!! 실행??

-- 시퀀스를 memos의 num과 매칭시켜주고 싶을때
-- [3] 데이터 입력 : 일련번호 포함
insert into memos(num, name) values(memos_seq.nextVal, '홍길동' ); -- 시간은default이기 때문에 
insert into memos(num, name) values(memos_seq.nextVal, '이순신' ); -- 번호는 관리할 필요없음
insert into memos(num, name) values(memos_seq.nextVal, '강감찬' ); 
-- 알아서 다음번호로 자동처리


select * from memos;

-- 고유 이름부여 잊지말기
-- 테이블 관련 삭제 drop : 시퀀스, 뷰, DDL
 
-- [4] 현재 스퀀스가 어디까지 증가되어져 있는지 확인.
select memos_seq.currVal from dual;  -- 대소문자 구분안해도됨. currVal라고 한 이유는 그냥 구변을 위해
-- 마지막 번호


-- [5] 시퀀스 수정 : 최대 증가값을 4번까지로 제한.
alter sequence memos_seq maxValue 4;  -- 테이블값의 제한이니까 alter

insert into memos(num, name) values(memos_seq.nextval, '안중근');
insert into memos(num, name) values(memos_seq.nextval, '안창호');  -- 오류  : 4까지로 제한되어 있기 때문에


alter sequence memos_seq maxvalue 100;


-- [6] 시퀀스 삭제
drop sequence memos_seq;


--[7] 시퀀스 없는 상태에서 자동 증가값 구현?
select max(num) from memos;

insert into memos(num, name) 
values((select max(num)+1 from memos), '세종대왕');


select * from  memos;

