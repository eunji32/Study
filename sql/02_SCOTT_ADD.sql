-- * scott ���� Ȱ��ȭ
c:\>sqlplus system/admin1234

SQL>@c:\scott.sql
SQL>alter user scott identified by tiger; -- ��й�ȣ ����
SQL>conn scott/tiger -- scott �������� ��ȯ
SQL>show user; 
SQL>select * from tab; -- scott ���� ���̺� ���
SQL>select * from dept;
SQL>quit; -- ���� 