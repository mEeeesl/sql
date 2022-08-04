-- 8�� set - ���� ( ������ ������ ������ )
-- union ������
-- Į���� ����, ���� ������ ���ƾ� ������ �����ϴ�.

select employee_id, job_id -- ���� , ����
from employees; --  107�� recode

select employee_id, job_id  -- ���� , ����
from job_history; -- 10�� recode

select employee_id, job_id -- ���� , ����
from employees
union                      --��� ���̺����� ������Ȳ
select employee_id, job_id  -- ���� , ����
from job_history;
-- �� �ߺ����ŵ� 2�� => 115�� recode

-- �� �ߺ����ž��� ��Ż 117�� recode
select employee_id, job_id 
from employees
union all
select employee_id, job_id
from job_history;

-- union�� �ߺ��� ���� ���ش�,. union all�� �ϴ� �����ش�
-- ������ ������ ���� �������ִ� ����� 2��

--����] ���� ������ ���� ���� �ִ� ������� ���, �̸� ������ȸ
-- �����Ѱ�
select employee_id, last_name, job_id
from employees e
where job_id in (select job_id
                from job_history j
                where e.employee_id = j.employee_id);

-- ����
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

-- ������ intersect
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

-- ������ minus
select employee_id, job_id
from employees
minus
select employee_id, job_id
from job_history;

---------------------------------

select location_id, department_name
from departments
union
select location_id, state_province
from locations;
-- department_name�ε� ����, �ػ罺 �� ���ø��� �߰��߰� ���͹���
-- Į���� ���� ���� ������ ���ƾ� ������ �����ϴ�.
-- �۽ý��Ͻ� ���������� ������ ������,
-- ���� �������� �μ���� ���ø��� �����ִ�.


-- ����] �� ������, service �������� ���Ķ�.���ø� ���ֱ�

select location_id, department_name, null state
from departments
union
select location_id, null, state_province
from locations;

-------------------------------------

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history;
-- Error ù��° ������ 3�� �ι�°������ 2��

--����] �� ������ ���Ķ�.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, null -- or 0
from job_history
order by 3;
-- �۽ý��Ͻ� �������� ���� Į���� ������ ��ġ�ؾ��ϰ�
-- ����Ÿ Ÿ�Ե� ��ġ�ؾ��Ѵ�.
