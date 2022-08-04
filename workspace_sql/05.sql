-- 5�� group function 

-- ��count()�� �����ľ� - ���̾�
-- ��group function�� null ���� �����ԡ�
-- �Ķ���� record n�� ( single�� 1�� )
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

-- employee_id = primary key = null�� ����
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
-- �׷��� �����ִ� �ʵ��߿� �ϳ� ����� 08783
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
-- Error] ���ǹ��� group�� ���� having ��ߵȴ�.
-- having = group�� ��󳻴� ���̴�.

select job_id, sum(salary) payroll
from employees
where job_id not like'%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

select department_id, avg(salary)
from employees
group by department_id
order by avg(salary) desc;

select max(avg(salary))
from employees
group by department_id;

-- �׷�����ؼ� �μ�������ŭ n�� �׷츸������� 
-- avg�Լ��� n�� ����
-- record n���� ���������
-- �װ� �׷��̵Ǿ� max�Լ��� ���� 1���� �� 19333.333333

select sum(max(avg(salary)))
from employees
group by department_id;
-- Error - �ʹ� ���� ��, 2������ ���� �ε� 3���̻��� ������
-- �׷���̴� 2�� �Լ������� 

select department_id, round(avg(salary))
from employees
group by department_id;
-- ����� 12�� ���� + 12�� ����
-- �׷� + �̱� function

select department_id, round(avg(salary))
from employees;

-- Error
-- �׷� + �̱� �Ҷ� group by �����ߴ�
-- �׷� + �׷��� Ok, �׷� + �׷� + �׷��� No

--����] �Ŵ����� ���� ������ �� �ּ� ������ ��ȸ�϶�.
--  �ּҿ����� $6,000 �ʰ����� �Ѵ�.

select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;

--����] 2001�� 2002�� 2003�⵵�� �Ի��� ���� ã�´�.
-- �ڡڡڡڡ� �����Ҷ� ���忡�� ���� �� �ڡڡڡڡڡ�

select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

--����] ������, �μ��� �������� ��ȸ�϶�. �� �� �� �� ��
--      �μ��� 20, 50, 80 �̴�.

select job_id,
    sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;
    
    
select job_id,
    sum(case when department_id = 20 then salary else null end)"20",
    sum(case when department_id = 50 then salary else null end)"50",
    sum(case when department_id = 80 then salary else null end)"80"
from employees
group by job_id;
