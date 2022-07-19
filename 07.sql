-- 7�� subquery
-- main & sub & outer & inner - query����
-- sub�� ������ -> main�� �� ���� �̿�

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel')
order by salary desc;

select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');
                
--����] Kochhar ���� �����ϴ� ������� �̸� ���� �μ���ȣ
select last_name, job_id ,department_id
from employees
where manager_id in (select employee_id
                    from employees
                    where last_name = 'Kochhar');                
                
--����] IT �μ����� ���ϴ� ������� �μ���ȣ �̸� ����
select department_id, last_name, job_id
from employees
where department_id in (select department_id
                  from departments
                  where department_name like '%IT%');

select department_id, last_name, job_id
from employees
where department_id = (select department_id
                  from departments
                  where department_name = 'IT');


--����] Abel�� ���� �μ����� ���ϴ� �����̸� �Ի���
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'                        
order by 1;

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'King');
        -- subquery ���ϰ��̶� �񱳰��̶� ���ƾ���
        -- 'King' �Ӹ� ���������̶� �� 2�� ����
        
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees 
                        where department_id = 50);

-- ����] ȸ�� ��� ���� �̻� ���� ������� ��� �̸� ����
--      ���� �������� ����
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by 3;

---------------------------

select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id);
     -- error more than one row -> row = recode
                
select employee_id, last_name, salary
from employees
where salary in (select min(salary)
                    from employees
                    group by department_id);


select employee_id, last_name
from employees
where salary = any (select min(salary)
                from employees
                group by department_id);

select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
-- where�� = salary < 9000,6000,4800,4800,4200
-- any -> �ϳ��� true�� true = 9000 �̸��̸� true 
-- all -> ��� true���� true = 4200 �̸��̸� true

-- ����] 60�� �μ��� �Ϻ�(any) ������� �޿��� ���� ����̸�

select last_name, salary
from employees
where salary > any (select salary
                    from employees
                    where department_id = 60)
order by 2 desc;

-- ����] �̸��� u�� ���Ե� ����� �ִ� �μ����� ���ϴ�
-- ����� �̸� ���

select last_name, employee_id
from employees
where department_id in (select department_id
                    from employees 
                    where last_name like '%u%');
                    
-- ����] 1700�� ������ ��ġ�� �μ����� ���ϴ� 
--  �̸� ���� �μ���ȣ ��ȸ
select last_name, job_id, department_id
from employees join departments
using (department_id)
where department_id in (select department_id
                        from departments join locations
                        using (location_id)
                        where location_id =1700);
                        
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);
                        
-- ����] ȸ�� ���(avg) ���޺���, �׸��� ���(all) ���α׷��Ӻ��� ������ �� �޴�
-- ������� �̸� ���� ����

select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary > all (select salary
                from employees
                where job_id = 'IT_PROG'); 
                
-----------------------------
-- no row -- �������� row�� ������ �������� row�� ����

select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1);
                
select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT');
                
-- null

select last_name
from employees
where employee_id in (select manager_id
                        from employees);
-- in - �ϳ��� ��ġ�ϴ°� ������ �� �� ���
-- not in = �ϳ��� ������� �ʰڴ� ->  != all
                    
select last_name
from employees
where employee_id not in (select manager_id
                        from employees);

-- ����] �� �������� all �����ڷ� refactoring �϶�.
select last_name
from employees
where employee_id <> all (select manager_id
                        from employees);

---------------------------------
-- exists - �����ϴ°͸� �̾Ƴ�?

select count(*)
from departments;

select count(*) 
from departments d  -- �ֹ� Table / ȸ�� Table
where exists (select *
                from employees e    -- ��� Table? ��ǰ Table? / ��� Table? 
                where e.department_id = d.department_id);
                
select count(*) 
from departments d
where not exists (select *
                from employees e
                where e.department_id = d.department_id);

-- ����] ������ �ٲ� ���� �ִ� ������� ���, �̸� ,����
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id)
order by employee_id;

select *
from job_history
order by employee_id;

