-- * 트랜잭션
-- [1] 테이블 생성
create table dept01
as
select * from dept;

-- [2] command 창에서 실습 진행
delete from dept01;  -- 모든 데이터 삭제


commit;    -- 명령문을 실행하면 최종 반영.



-- [3] 되돌리기
drop table dept01 purge;

create table dept01
as
select * from dept;

delete from dept01

select * from dept01; -- 삭제됨이 보임.

rollback;  -- 다시 복구

