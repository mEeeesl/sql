-- group function 

-- ��count()�� �����ľ� - ���̾�
-- ��group function�� null ���� �����ԡ�
-- �Ķ���� record �޼ҵ尡 n�� ( single�� 1�� )
-- �̱ۿ��� from employees ������ ���� ������ ���;� �Ǵµ�
-- group function ���� from employees ������ 
-- ��װ� �׷��̵Ǽ� ���� 1���� ����

-- max & min & avg & sum 
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

-- min & max ��¥
-- min ������ ��¥ , max �ֽ� ��¥
-- ������ �湮��, ��й�ȣ �������� 90��, �޸����, ��������
select min(hire_date), max(hire_date)
from employees;

--����] �ְ���ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;

-- �� count() �� ���̾�
-- * == ��� column ( null�̰� ���� �� ���� )
select count(*)    -- �� ����� 
from employees;

--����] 70�� �μ����� ����� �� ��ȸ�϶�.

select count(*)
from employees
where department_id = 70;

-- employee_id = primary key
select count(employee_id) 
from employees; -- 107

select count(manager_id)
from employees; -- 106 King = null 

-- �������� commission�� null�� �ֵ��� �����ϰ� ����
select avg(commission_pct)
from employees; 

-- ����] ������ ��� Ŀ�̼����� ��ȸ�϶�.
select avg(nvl(commission_pct,0))
from employees;

--------------------------------------------

select avg(salary)
from employees;

-- all 
select avg(all salary)
from employees;

-- distinct �ߺ����� ( 5000�� 2�� ������ 5000�� 1���� ���� )
select avg(distinct salary)
from employees;

-- ����] ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

--����] �Ŵ��� ���� ��ȸ�϶�.
select count(distinct manager_id)
from employees;

----------------------------------------
-- group by

-- select ���� �ִ� ���̺��� group by�� ��������
-- �Ʒ����� employee_id�� ���� �ƴ϶�
-- group function count�� ������
-- �װ��־�� ��� �μ��� ������� �ľ�����
-- ���� count�� null�� �������ִµ�,
-- 12���� null�� group by�� ���� ���� �׷���
-- ���⼭ department_id�� label �̶�� �θ���.

select department_id, count(employee_id)
from employees
group by department_id -- ���� �μ��� �׷����� ����
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id
order by department_id; 
-- Error] job_id �� select ���� ��� 
-- + ���⼭ job_id�� �ʿ䰡 ���ڳ� 
-- �μ��� ����� ����� �ִ��� ��ȸ�ϴ°ǵ� 

-- ����] ������(label)(group) �����(count)�� ��ȸ�϶�.
select job_id, count(employee_id)
from employees
group by job_id;

-----------------------------------
-- having   = group�� ��� ( where �̶� ���

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;
-- �׷��� �����ִ� �ʵ��߿� �ϳ� ����� 
-- ���⼱ department,max 2��

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000;
-- Error] having ������ ���� ����

select department_id, max(salary)
from employees
where department_id > 50
group by department_id;
-- ���ڵ带 ���� ��󳻰� �װŰ����� �׷��� �������

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; 
-- Error] ���ǹ��� group by ���� having ��ߵȴ�.
-- having = group�� ��󳻴� ���̴�.