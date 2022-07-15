-- 3�� Single Function 
-- �Ķ���� ���ڵ� �޼ҵ尡 n��
--SQL(Structed Query Language)
--Function�� PL/SQL ( Procedure Language / SQL )�� �ۼ�������
--API ������ �����ŷ�

-- Single Function 
-- �Ķ���� = ���ڵ� / ���ϰ� = ���ڵ� / �� 1��������

desc dual
select * from dual;

-- lower �ҹ��ڷ� �ٲ���.
select lower('SQL Course')
from dual;

-- upper �빮�ڷ� �ٲ�
select upper('SQL Course')
from dual;

-- initcap �ܾ��� ù ���ڸ� �빮�ڷ� �ٲ�
select initcap('SQL course')
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins'; -- ���ڵ尡 �� ���ִ� �����̱��� 107�� lower �۾���

select last_name
from employees
where last_name = initcap ('higgins');

-- concat
select concat('Hello', 'World')
from dual;

-- substr - SQL�� 1���� ���� / 2������ �����ؼ� 5�� ��������
select substr('HelloWorld', 2, 5)
from dual;

select substr('Hello', -2, 2)
from dual;

-- length ���� �� �ľ�
select length('Hello')
from dual;

-- instr ���ڰ� �ִ��� �ľ� + ó�� �߰��� l�� index�� �����ϰ� ����
-- SQL�� Index�� 1���� ����
select instr('Hello', 'l')
from dual;
select instr('Hello', 'w')
from dual;

-- lpad  ������ ���� �Ⱦ�����, �ʺ� �԰ݿ� �°� ������ ����
select lpad(salary, 5, '*') -- �� 5�� �ް�, ������ ���ŷ� ä��
from employees;

-- rpad ��� ���������� ä��
select rpad(salary, 5, '*')
from employees;

-- replace ���� ��ü
select replace('JACK and JUE', 'J', 'BL')
from dual;

-- trim �Ӹ��� ������ ������
select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello')
from dual;
select trim('H' from 'HelHloH')
from dual;
select trim(' ' from ' Hello ')
from dual;
--����] �� ���忡�� ' '�� trim ������ ������ Ȯ���� �� �ְ� ��ȸ
select '��' || trim(' ' from ' Hello ') || '��'
from dual;

-- trim�� ������ �̷��� ���� �� 
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

--����] �� ���忡��, where ���� like�� refactoring �϶�.

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG%';

-- ����] �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ
-- �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����Ѵ�.

select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';

---------------------------------------
-- round �ݿø� trunc �ݳ��� mod ������ --

select round(45.926, 2)
from dual;

select trunc(45.926, 2)
from dual;

select mod(1700, 300)
from dual;

select round(45.923, 0), round(45.923)
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;
select round(45.923), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 1000)
from employees;

-- ����] ������� �̸�, ����,
-- 15.5% �λ�� ����(New Salary, ������ǥ��), �λ���� ��ȸ

select last_name, salary,
    round(salary * 1.155) "New Salary",
    round(salary * 1.155) - salary "Increase"
from employees;


-----------------------------------
-- ��¥ sysdate - ���糯¥+�ð�

select sysdate 
from dual;
select sysdate + 1
from dual;
select sysdate - 1
from dual;
select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- ����] �Ʒ� ������ ���ļ�, �̸�, �ټӳ���� ��ȸ
select last_name, trunc((sysdate - hire_date)/365)
from employees
where department_id = 90;

------ months_between �� ��� -----
select months_between('2022/12/31', '2021/12/31')
from dual;
select add_months('2022/07/14', 1)
from dual;

-- �Ͽ��� = 1 ����� = 7
-- 7/14 ���� 7(�����) = 2022/07/16 
select next_day('2022/07/14', 7) 
from dual;

select next_day('2022/07/14','thursday')
from dual;

select next_day('2022/07/14','thu')
from dual;

-- �ش���� ���� - 2022/07/31
select last_day('2022/07/14')
from dual;

-- ����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�
-- ������ �ſ� ���Ͽ� �����Ѵ�.
select employee_id, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;
--where sysdate - hire_date >= 365*20;

-- ����] ������� �̸�, ���ޱ׷����� ��ȸ�϶�.
-- �׷����� $1000�� * �ϳ��� ǥ���Ѵ�.

select employee_id, rpad('*', trunc(salary/1000), '*')
from employees;

select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

-- ����] �� �׷����� ���� ���� �������� �����϶�.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by salary desc;