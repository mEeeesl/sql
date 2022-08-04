-- 9�� DML ( Data manipulation Language ) ���������۾��
-- drop table ���̺��; - ���̺� ���� ��ɾ� 
drop table emp; -- drop, create �� �ڵ� commit
drop table dept;

-- crate table ���̺��; - ���̺� ���� ��ɾ�
create table emp( -- drop, create �� �ڵ� commit
employee_id number(6),
first_name varchar2(20),
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8),
commission_pct number(2, 2),
manager_id number(6),
department_id number(4));

create table dept(
department_id number(4),
department_name varchar2(30),
manager_id number(6),
location_id number(4));

-- �ʵ���� ���ְ� ������ �°� ����� ���� ( �ʵ���� ������ġ�� ����� )
insert into dept(department_id, department_name, manager_id, location_id)
values (300, 'Public Relation', 100, 1700);

insert into dept(department_id, department_name)
values (310, 'Purchasing');

-- �ڡڡ� commit = ���� �ڡڡ�
commit; -- transaction (insert into ~ commit)

--����] row 2���� insert �����ƴ��� Ȯ��
select *
from dept;

insert into emp(employee_id, first_name, last_name,
                email, phone_number, hire_date,
                job_id, salary, commission_pct,
                manager_id, department_id)
values (300, 'Louis', 'Pop',
        'Pop@gmail.com', '010-378-1278',
        sysdate, 'AC_ACCOUNT', 6900, null,
        205, 110);
        
insert into emp -- ���̺� ���� ���鶧�� �μ�Ʈ �Ҷ� �ʵ���� ���� �����ϸ� �̰Ű���
values(310, 'Jark', 'Klein', 'Klein@gmail.com',
        '010-753-4635', to_date('2022/06/15', 'YYYY/MM/DD'),
        'IT_PROG', 8000, null, 120, 190);
 
insert into emp
values(320, 'Terry', 'Benard',
        'Benard@gmail.com', '010-632-0972', '2022/07/20',
        'AD_PRES', 5000, .2, 100, 30); -- .2 = 20%
        
commit;

select *
from emp;

drop table sa_reps; -- drop, create �� �ڵ� commit

create table sa_reps(
id number(6),
name varchar2(25),
salary number(8, 2),
commission_pct number(2, 2));

-- insert�� subquery ���� ( ���� ���� Ÿ�� ���� ��ġ����ߴ� )
insert into sa_reps(id, name, salary, commission_pct)
    select employee_id, last_name, salary, commission_pct
    from employees
    where job_id like '%REP%';
commit;

select *
from sa_reps;

-- declare ~ begin ~ end; ���ο� ������ n�� insert �ϱ�
-- �׽�Ʈ�� �����͸� �̸� �غ��� �� ����
declare
    base number(6) := 400; -- �ʱⰪ
begin
    for i in 1..10 loop
        insert into sa_reps(id, name, salary, commission_pct)
        values(base + i, 'n' || (base + i), base * i, i * 0.01);
    end loop;
end;
/   -- ���ν���

select * from sa_reps;

-- ����] procedure�� insert�� row ��ȸ
select *
from sa_reps
where id > 400;

---------------------------------------
-- update ~ set ~- �Ϻ� record ����

select employee_id, salary, job_id
from emp
where employee_id = 300;

update emp
set salary = 9000, job_id = null
where employee_id = 300;

commit;

update emp
set job_id = (select job_id
                from employees
                where employee_id = 205),
    salary = (select salary
                from employees
                where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback; -- transaction ���

select job_id, salary
from emp
where employee_id = 300;

-- �̰͵� ����
update emp
set(job_id, salary) = (
    select job_id, salary
    from employees
    where employee_id = 205)
where employee_id = 300;

commit;

-------------------------------
-- delete

delete dept
where department_id = 300;

select *
from dept;

rollback;

select *
from dept;

delete emp
where department_id = (
    select department_id
    from departments
    where department_name = 'Contracting');
    
select *
from emp;

rollback;

select *
from emp;

commit;