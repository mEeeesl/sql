-- DDL (Data Definition Language) - ������ ����
drop table hire_dates; -- �����߾ �������뿡 �ִ� ����

create table hire_dates(
id number(8),
hire_date date default sysdate); -- �⺻�� default�� ��������

select tname
from tab; -- data dictoinary

-- ����] drop table ��, �� ������ ���� �������, ������(BIN)�� ���ϰ�, ��ȸ

select tname
from tab
where tname not like '%BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select *
from hire_dates;

--------------------------------------
-- DCL(data Control Language) - ������ ����
-- �ڵ� commit
-- Connection�� hr�� �ƴ�, system connection���� �����ؾ��Ѵ�.
-- system user
-- Connection�� ����� ������ ����
create user you identified by you;
grant connect, resource to you;

-- connection ���� -> you
-- you user
select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key, -- primary key ����
department_name varchar2(20));

desc user_constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key, -- not null + unique 2���� �Ӽ��� ����
emp_name varchar2(10) constraint emps_empname_nn not null, -- emp_name�� null�� ������ ���ϰ� ����
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000), -- ������ ���̸� �޾Ƶ鿩���� �ƴϸ� �����޽�������
department_id number(3),
constraint emps_email_uk unique(email), --unique - recode���� ������ �ʵ带 ��������
constraint emps_depid_fk foreign key(department_id) -- dept_id �� foreign key��.�ٵ� ��𼭿Գ�?
    references depts(department_id));            -- ���⼭ �Դ�

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100); -- 100 - foreign key
commit;

delete depts; -- Error integrity constraint (YOU.EMPS_DEPID_FK) violated - child record found
-- integrity ���Ἲ, ���� �����Ͱ� �ֵ��� �Ѵ�.
-- department_id�� depts , emps�� ����Ǿ��ִ»��ĵ�
-- depts �� department_id�� PK�ϱ� �갡 �θ��
-- emps �� �ڽ��� 
-- depts�� ���������� emps(�ڽ�)�� ������ ���ϱ� ������� Error (?)
-- �ذ���
-- 1. �ڽĻ������ִ� FK�������� ����� �θ� �����
-- 2. on delete cascade - �ڽĲ����ٰ� �̰� ������ߴ�( 139�� ���� ) 

insert into depts values(100, 'Marketing');
-- Error - unique constraint (YOU.DEPTS_DEPTID_PK) violated
-- 100�� �μ��� �̹� ���� 'Development'

insert into depts values(null, 'Marketing');
-- Error - cannot insert NULL into ("YOU"."DEPTS"."DEPARTMENT_ID")
-- nn not null�� �����ؼ� null ������

insert into emps values(501, null, 'good@gmail.com', 6000, 100);
-- Error - cannot insert NULL into ("YOU"."EMPS"."EMP_NAME")
-- emp_name�� nn not null�� �����س��� null ������ 

insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100);
-- Error - unique constraint (YOU.SYS_C007026) violated
-- �̹� musk@gmail.com �� ���� - unique�� �ߺ��ȵ�

insert into emps values(501, 'adel', 'good@mail.com', 6000, 200);
-- Error - parent key not found
-- �θ� 200�� department_id �� ��� ������..?

drop table emps cascade constraints; -- cascade ���޾� �Ͼ�� - �������� �� ����

select constraint_name, constraint_type, table_name
from user_constraints;

--------------------------------------

-- system user
grant all on hr.departments to you;

-- you user
drop table employees cascade constraints; -- �����Ҷ� �� ����� �ٽ� �������ϴ°�

create table employees( -- Ŀ�ؼ��� you�� �ߺ��ƴ�
employee_id number(6) constraint emp_empid_pk primary key, -- primary key�� �ϳ��� ����
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null --2�� ���ǳ��� �� ��
                    constraint emp_emai_pk unique,  --email�� pk�� �ƴ�
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
-- Error �ٸ� ��Ű��(���⼱ hr) �����Ҷ�
-- system user�� ���� �� grant all on hr.departments to you;
-- you �� ��� ������ �����

-------------------  ���̺� ����� ��  --------------------------------------

-- on delete --
drop table gu cascade constraints; --������ ���� ����������Ŵ.
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade); --�θ� �������ϸ� ���� �����ϰڴ�.

create table dong2(
dong_id number(4) primary key,
dong_name varchar(12) not null,
gu_id number(3) references gu(gu_id) on delete set null); -- �θ� �������ϸ� child�� ���� null�� ����

insert into gu values(100, '������');
insert into gu values(200, '�����');

insert into dong values(5000, '�б�����', null);
insert into dong values(5001, '�Ｚ��', 100);
insert into dong values(5002, '���ﵿ', 100);
insert into dong values(6000, '��赿', 200);
insert into dong values(6002, '�߰赿', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong; --cascade��� �Ｚ��, ���ﵿ �����.
select * from dong2; --gu_id�� null�� �ٲ�.

commit;
---------------------------

-- disable fk - �����Ҷ� fk�� ������, ���߳����� ������ߴ�

drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
insert into b values(32, 9); --Error �θ𿡴� fk(aid)�� 1�ۿ� ����
-- �̶� �����°�
alter table b disable constraint b_aid_fk;
insert into b values(32, 9); -- �����������̱��ѵ�, �ϴ� ������ ������
-- ���� ������ ���ڴ��� ������ߴ�
-- ���� ������ �� ����� �ٽ� �����ϴ°� ����
-- �����Ͱ� �ִ� ���¿��� �ϸ� ������, �� �� ��
alter table b enable constraint b_aid_fk; -- Error fk 9�� ������ �����ϱ�
-- ���ڴ��� �����
alter table b enable novalidate constraint b_aid_fk; -- fk�� ���

insert into b values(33, 8); --error - parent key not found
-----------------------------------
-- �������� �̿밡��

drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;

desc sub_departments;

select * from sub_departments;
-------------------------------------

-- ���̺� ������ �����ϴ� ��� - alter table
-- ���̺�� ���õȰͱ��� ����ϰ� �����
drop table users cascade constraints;

create table users(
user_id number(3));
desc users
                    --column(���̺�) �߰�
alter table users add(user_name varchar2(10));
desc users
                    --column(���̺�) ����
alter table users modify(user_name varchar2(7));
desc users
                    --column(���̺�) ����
alter table users drop column user_name;
desc users
--------------------------------------

-- ���̺� �б��������� �ٲٱ� (�ذ� �ٲ��� �۳Ⲩ ���ǵ帮��)

insert into users values(1); -- ���Ⱑ�� 

alter table users read only; -- �б��������� �ٲٱ�
insert into users values(2); -- Error ���� �Ұ���

alter table users read write; -- �б�& ���Ⱑ��
insert into users values(2);
select * from users;

commit;

-- 10�忡�� ����, �� �̷��� �־������� �����ϰ� �ʿ��Ҷ� ã�Ƽ� ���� ��
