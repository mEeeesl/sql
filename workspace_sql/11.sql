-- 11�� 
-- view - ������ ������ ���ΰ�,
-- view ���� �����Ͱ� ����. ���� ������ �����̴�. (��������)
-- sequence 

-- hr user�� �ǽ����� 
drop view empvu80; --80�� �μ����� ���ϴ� �����

create view empvu80 as
    select employee_id, last_name, department_id --����
    from employees
    where department_id = 80;
    
desc empvu80 --select ���� Į���� view�� ������ ��

select * from empvu80; -- view�� ������ �̷��� �ϸ��

select * from ( -- view�� �������� �̷��� �ؾ���
    select employee_id, last_name, department_id --����
    from employees
    where department_id = 80);
    
-- view ��ü - create or replace
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;
    
desc empvu80
select * from empvu80;

--����] 50�� �μ������� ���, �̸�, �μ���ȣ�� ���� 
--  DEPT50 view�� ������.
--  view ������ EMPNO, EMPLOYEE, DEPTNO�̴�.
--  view �� ���ؼ� 50�� �μ� ������� �ٸ� �μ��� ��ġ���� �ʵ���

drop view dept50;

create or replace view dept50 (empno, employee, depno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ck; -- ���� �� ������Ʈ �Ǵ°� ������

--����] DEPT50 view�� ������ ��ȸ
desc dept50
--����] DEPT50 view�� data�� ��ȸ
select * from dept50;


-----------------------------------------
-- with check option
drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from departments;
    
create view team50 as
    select *
    from teams
    where team_id = 50;

select * from team50;

select count(*) from teams;
insert into team50 
values(300, 'Marketing');
select count(*) from teams; -- view(team50)�� insert������ teams�� �߰��Ǵ°�

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; -- ��������

insert into team50 values(50, 'IT Support');
select count(*) from teams; -- 
insert into team50 values(301, 'IT support'); --Error check option
                            -- view�� �μ�id 301�� 50�� ������ ����, Ʋ���ϱ� ����
-- with read only + view�� ����ϸ� read only�� ����ض�                         
create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; -- view�� �б���������

insert into empvu10(501, 'abel', 'Sales'); -- �߰��Ұ�

----------------------------------------------
---- sequence  ( �� ���� �� )

drop sequence team_teamid_seq;

create sequence team_teamid_seq; -- ���۰� 1 ������ 1

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3;

drop sequence x_xid_seq;
create sequence x_xid_seq
    start with 10 -- ���۰�
    increment by 5 -- ����
    maxvalue 20 -- �ִ밪
    nocache -- cache ĳ�þ���
    nocycle;    -- �ֱ����

select x_xid_seq.nextval from dual; -- nocycle ȿ�� ����

-- ����] DEPT ���̺��� DEPTID Į���� field value�� �����
-- sequence�� ������.
-- 400 ����, 1000 ����, 10 ����.

drop sequence dept_deptid_seq;
create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;

-- ����] �� sequence ��,
-- DEPT ���̺���, Education �μ��� insert �϶�.
desc dept
select * from dept;

insert into dept (department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');
commit;

-------------------------------------------
-- index

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABK';

select index_name, index_type, table_owner, table_name
from user_indexes;

-- ����] DETP ���̺��� DEPARTMENT_NAME �� ���� index�� ������

create index dept_departmentname_idx
on dept(department_name);

select department_name, rowid
from dept;

-----------------------------------------
-- synonym ���� for ���̺�: ���̺� (DB��ü)�� ������ ���̴� ��

drop synonym team;

create synonym team
for departments;

desc team;
desc departments;
select * from team;
select * from departments;

-- ����] EMPLOYEES ���̺� EMPS synonym �� ������.

drop synonym emps;

create synonym emps
for employees;

desc emps;
desc employees;
select * from emps;
select * from employees;