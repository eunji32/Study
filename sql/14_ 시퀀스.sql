-- * ����Ŭ : ������(Sequence)

-- [1] �������̺� ����
create table memos(
        num    number(4) constraint memos_num_pk primary key,
        name  varchar2(20) constraint memos_name_nn not null,
        postDate Date  default(sysdate) -- ��¥�� default�� �Ϲ���.
);


-- [2] �ش� ���̺��� ������ ����
create sequence memos_seq;  -- �̷��� �����ص� ��

create sequence memos_seq
start with 1 increment by 1; -- ������ ���� 1���� 1�� �����ϵ��� ���� / with ù ���۰� increment by ������

-- increment by ���Ӱ��غ���!!!!!! ����??

-- �������� memos�� num�� ��Ī�����ְ� ������
-- [3] ������ �Է� : �Ϸù�ȣ ����
insert into memos(num, name) values(memos_seq.nextVal, 'ȫ�浿' ); -- �ð���default�̱� ������ 
insert into memos(num, name) values(memos_seq.nextVal, '�̼���' ); -- ��ȣ�� ������ �ʿ����
insert into memos(num, name) values(memos_seq.nextVal, '������' ); 
-- �˾Ƽ� ������ȣ�� �ڵ�ó��


select * from memos;

-- ���� �̸��ο� ��������
-- ���̺� ���� ���� drop : ������, ��, DDL
 
-- [4] ���� �������� ������ �����Ǿ��� �ִ��� Ȯ��.
select memos_seq.currVal from dual;  -- ��ҹ��� ���о��ص���. currVal��� �� ������ �׳� ������ ����
-- ������ ��ȣ


-- [5] ������ ���� : �ִ� �������� 4�������� ����.
alter sequence memos_seq maxValue 4;  -- ���̺��� �����̴ϱ� alter

insert into memos(num, name) values(memos_seq.nextval, '���߱�');
insert into memos(num, name) values(memos_seq.nextval, '��âȣ');  -- ����  : 4������ ���ѵǾ� �ֱ� ������


alter sequence memos_seq maxvalue 100;


-- [6] ������ ����
drop sequence memos_seq;


--[7] ������ ���� ���¿��� �ڵ� ������ ����?
select max(num) from memos;

insert into memos(num, name) 
values((select max(num)+1 from memos), '�������');


select * from  memos;

