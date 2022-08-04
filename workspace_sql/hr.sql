select * from departments;
--select columnName from TableName(������);

-- DEPARTMENT_ID �� LOCATION_ID�� ���������
select department_id, location_id
from departments;
-- select = ���� ���ϴ°�(column)�� request �ؼ� response �޴� ��

select location_id, department_id
from departments;

desc departments

-- ����] employees ������ Ȯ���϶�.
desc employees

-- ������ ���ο� Į���� ������
select last_name, salary,  salary + 300
from employees;

-- ����] ������� ����, ������ ��ȸ�϶�.

select employee_id, salary, salary*12
from employees;

select last_name, salary, 12 * salary + 100
from employees;
select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;

-- �ǿ����ڿ� null�� �ϳ��� ������ ���� null�� ���� ����
-- null�� �ȳ����� �����ؾ���
select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees;

-- column�� �����ϱ� as ��������
select last_name as name, commission_pct comm
from employees;

-- ���忡���� ����Ŭ�� �� �ҹ��ڷ� �ϰ��ֱ��� �ٵ� �̻ڰ��ϰ�ʹ�?
select last_name "Name", salary * 12 "Annual Salary"
from employees;

-- ����] ������� ���, �̸�, ����, �Ի���(STARTDATE)�� ��ȸ�϶�.
select employee_id, last_name, job_id, hire_date as startdate
from employees;

-- ����] ������� ���(Emp # < ����), �̸�(Name), ����(Job), �Ի���(Hire Date)�� ��ȸ�϶�.
select employee_id as "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

select last_name || job_id
from employees;
select last_name || ' is ' || job_id
from employees;
select last_name || ' is ' || job_id employee
from employees;
select last_name || null -- null - empty String
from employees;
select last_name || commission_pct -- ���� 1.4�� �ٲ�
from employees;
select last_name || salary -- ���� 24000�� ���ھƴ�
from employees;
select last_name || hire_date -- ������ ���ھƴ�
from employees;
select last_name || (salary * 12) -- ������� ������
from employees;
-- ����] ������� '�̸�, ����'(Emp & Title)�� ��ȸ�϶�.

select last_name|| ', ' || job_id "Emp & Title"
from employees;