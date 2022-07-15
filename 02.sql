-- 2�� where �����, true�� ���� ����
select employee_id, last_name, department_id
from employees
where department_id = 90; 
-- where = ���ǹ� = ���ϰ��� boolean Type
-- departmeint_id �� 90�� record �� response ��

-- ����] 176�� ����� ���, �̸�, �μ���ȣ�� ��ȸ�϶�

select employee_id, last_name, department_id
from employees
where employee_id = 176;

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen'; 

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';  -- ȯ�漳�� - nls �˻�

-- query = request, ����, 
select last_name, salary
from employees
where salary <= 3000;

-- ����] $12,000 �̻� ���� ������� �̸�, ������ ��ȸ�϶�.
select last_name, salary
from employees
where salary >= 12000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';

---------------------------------
-- where ~ between -- 
-- �������ǹ�, ������ ���̸� true �ϴ� ���ǹ� 

select last_name, salary
from employees
where salary between 2500 and 3500; -- �̻� ~ ����

select last_name
from employees
where last_name between 'King' and 'Smith';

-- ����] 'King' ����� first name, last name, ����, ������ȸ

select first_name, last_name, job_id, salary
from employees
where last_name = 'King'; -- data�� ��/�ҹ��� ������

select last_name, hire_date
from employees
where hire_date between '2002-01-01' and '2002-12-31'; -- �Ǽ�

----------------------------
-- where ~ in --

select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201); -- ����

select employee_id, last_name, manager_id
from employees
where manager_id in 100 or 
    manager_id in 101 or
    manager_id in 201;
    
select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargas', 'King');

select last_name, hire_date
from employees
where hire_date in ('2003-06-17', '2005-09-21');

------------------------------
-- �ڡ� where ~ like ~ �ڡ�--  Ư������ �� �༮ ã��
-- �˻��Ҷ� �ַ� ����Ѵ�.

select first_name
from employees
where first_name like 'S%'; -- S�� �����ϴ� �༮ ã��

select first_name
from employees
where first_name like '%r'; -- r�� ������ �༮ ã��

-- ����] first_name�� s�� ���Ե� ������� first_name�� ��ȸ�϶�.

select first_name
from employees
where first_name like '%s%' and
    first_name like '%r%';
    
-- ����] 2005�⿡ �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�

select last_name, hire_date
from employees
where hire_date like '2005%';

-- ���ڼ��� ���ϰ���� �� '_' underBar 1���� ������ 1���ڸ� ���� --

select last_name
from employees
where last_name like 'K___';

-- ����] �̸��� 2��° ���ڰ� 'o'�� ����� �̸��� ��ȸ�϶�.

select last_name
from employees
where last_name like '_o%';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\'; -- escape ���� - Ư�����ڸ� �Ϲݹ��ڷ�

select last_name, job_id
from employees
where job_id like 'I_[_%' escape '['; -- escape ���� - ���� ���ϴ°� ��������

--����] ������ _R�� ������ �� ������� �̸�, ������ ��ȸ�϶�

select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';

------------------------------
-- is null -- null�� ���� ������� ������ 

select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null ; 
-- ���̱� ������ || �� �����ϸ� �ǿ����ڿ� null�� ���� �ȴ�

select last_name, manager_id
from employees
where manager_id is null ;

-----------------------------
-- �������� || && --

select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';

-----------------------------
-- Not ������ -- ( �ܵ� ����� �Ұ� )

select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP');

select last_name, salary
from employees
where salary not between 10000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

select last_name, job_id
from employees
where commission_pct is not null;

-- ����] ������ 20000�޷� �̻� �޴� ���� �� ������� �̸�, ������ȸ

select last_name, salary
from employees
where not (salary >= 20000 and manager_id is null);
    
-- ����] ������ $5000 �̻� %12000�����̴�. �׸���,
--      20���̳� 50�� �μ����� ���ϴ� ������� �̸�, �μ���ȣ��ȸ

select last_name, department_id, salary
from employees
where (salary between 5000 and 12000) and
    department_id in (20, 50);
    
-- ����] �̸��� a�� e�� ���Ե� ������� �̸��� ��ȸ�϶�

select last_name
from employees
where last_name like '%a%e%' or
    last_name like'%e%a%';

select last_name
from employees
where last_name like '%a%' and
    last_name like '%e%';
    
-- ����] ������ �����̴�. �׸���, ������ $2500, $3500�� �ƴϴ�.
--      �� ������� �̸�, ����, ������ ��ȸ�϶�.

desc employees
select employee_id, job_id, salary
from employees
where job_id like 'SA%' and
    salary not in(2500, 3500);
    
-----------------------------------
-- order by = �������� ���������ϱ� + null�� ���� ��������ġ--

select last_name, department_id
from employees
order by department_id;

-- order by ~ desc = �������� �������� + null�� ���� ������ġ
select last_name, department_id
from employees
order by department_id desc; 

select last_name, department_id dept_id
from employees
order by dept_id desc;

-- ���� ���� Table�� ���� Column���ε� ������ �� �� �ִ�.
select last_name
from employees
where department_id = 100
order by hire_date;


-- order by index desc = index ������ �������� ��밡��
select last_name, department_id
from employees
order by 2 desc;

-- order by ~ asc(��������), ~ desc(��������)
select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc;