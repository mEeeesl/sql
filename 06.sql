-- 6�� Join - n���� ���̺� - record ����
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- location_id �� departments�� locations ���ʿ� �� �ִ�.

-- equi join ( �� natural join )
select department_id, department_name, location_id, city
from departments natural join locations;

-- natural join - �� ���̺� ������ ���� column�� ã��
-- ���� recode���� join ��Ŵ
-- Data Type�� ���ƾ���
-- departments - location_id = �ܺ� ���̺��� ���� fall in key
-- locations - location_id = praimary key

-- ���� join �ĺ��� ����� �̸� ��󳻰������ where
select department_id, department_name, location_id, city
from departments natural join locations
where department_id in(20, 50);
-- department_id �� locations�� ����

-- ����� Į���� ã�ƾ��ϴ� ������ �ʹ� ũ��..?
-- �׷��� ���� ����?

-- from ~ join ~ using ~

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);
-- department_id�� ���� �ֵ鳢�� ������ �ߴٴ°� �� �� ����


--����] ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments;

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;
-- from ������ ���� ��밡��
-- ����ϸ� select���� from ���� ���밡��

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400;
-- ERROR using ���� ���λ縦 ���� �� ����.

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400;
-- ERROR using column���� ���λ縦 ���� �� ����.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100;
-- ERROR manager_id�� ����Į��������, using���� �ƴϱ⿡ ?
-- �ָ��ؼ� ������, e �Ҽ����� d �Ҽ����� �ָ��ؼ� ����

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where e.manager_id = 100;
-- �ٵ� ����Į���� ���λ縦 ���̸� ����
-- using column���� ���λ縦 ���� �� ������,
-- using���̾ƴ� ����Į���� ������ ���λ縦 �ٿ��߸� �Ѵ�.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100;
--------------------------------------

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);
--e.department_id = d.department_id �� �ֵ鳢�� join�϶� 
-- on + ���ǹ�

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- ����] �� ������, using���� refactoring �϶�.
select e.employee_id, city, d.department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

-- where ��� and�� �ᵵ ��
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149;


--����] Toronto �� ��ġ�� �μ����� ���ϴ� �������
--      �̸�, ����, �μ���ȣ, �μ���, ���ø� ��ȸ�϶�.

select e.last_name, e.job_id,
    e.department_id, d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

select e.last_name, e.job_id,
    department_id, d.department_name, l.city
from employees e join departments d
using (department_id)
join locations l
using (location_id)
where l.city = 'Toronto';

-----------------------------------------
-- non-equi join  =  ' = ' �Ⱦ��� non equi
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

------------------------------------------
-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = employee_id;
-- Error self join���� select��, on�� ��� ���λ� �����ߴ�

--����] ���� �μ����� ���ϴ� ������� �̸�, �μ���ȣ, �����̸� ��ȸ

-- �����Ѱ�
select worker.last_name worker,
    worker.department_id dpt,
    partner.last_name partner
from employees worker join employees partner 
on worker.department_id = partner.department_id
and worker.employee_id != partner.employee_id;

-- ����Բ� / !=  ==  <>  �Ѵ� ���� ��
select e.department_id, e.last_name employee , c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

--����] Davies���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�
-- �����Ѱ�
select e.last_name, c.last_name, c.hire_date
from employees e join employees c
on c.hire_date between e.hire_date and sysdate
and e.last_name = 'Davies'
and c.last_name != 'Davies'
order by 3;

-- ����Բ�
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date;

-- ����] �Ŵ������� ���� �Ի��� �������
-- �̸�, �Ի���, �Ŵ�����, �Ŵ����Ի����� ��ȸ�϶�
select e.last_name, e.hire_date, m.last_name, m.hire_date
from employees e join employees m
on e.manager_id = m.employee_id
and e.hire_date < m.hire_date;

--------------- �� inner join
--------------- �� outer join

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;
-- 1�� ��������. �̶� ����ϴ°�

-- outer join
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;
-- employees�� Grant�� join�� �ȵǾ����� ����

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;
-- departments d �� ������ �ֵ� �� ȣ�� 

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;
-- employees, departments�� join �ȵǾ��� �ֵ� �� ��ȣ��

-- ����] ������� �̸�, ���, �Ŵ�����, �Ŵ����ǻ���� ��ȸ�϶�
--      King ���嵵 ���̺� �����Ѵ�.

select w.last_name, w.employee_id, m.last_name, m.manager_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;

-------------------------------------------------------------
-- 6�� 2��


select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
-- inner join�� ���� �̰� �����ؼ� ������
-- outer join�����ϸ� �������� ������ �ٵ� outer join�� �� �ȽἭ ������

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
-- (+) = right outer join  ��
-- (+) = left outer join   ��
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-- self �������� ���

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;
