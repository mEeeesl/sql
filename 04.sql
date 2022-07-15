-- 4��, DataType conversion

select hire_date
from employees
where hire_date = '2003/06/17'; --���ڰ� ��¥�� ��ȯ
-- ��¥�� ���Ŀ� �ȸ����ָ� �������� 
-- hire_date�� ��¥Ÿ���̴ϱ� 

select salary
from employees
where salary = '7000'; -- ���ڰ� ���ڷ� �ڵ���ȯ
-- ���� �Ⱦ��� 'qweqwe' �̷��� ���ڷξ��� �������� 
-- saraly�� ����Ÿ���̴ϱ� 

select hire_date || ''
from employees;     -- ��¥�� ���ڷ� �ٲ�

select salary || ''
from employees;     -- ���ڰ� ���ڷ� �ٲ�

--------------------------------------
-- ��¥�� ���ڷ� + function (to_char)�̿�

select to_char(hire_date)
from employees;
                        --    ��  fm form�� model 
select to_char(sysdate, 'yyyy//mm--dd') -- ��¥�� ���ڷ� �ٲٱ�
from dual;
                            --        �� sp ��¥�� ���ڷ� ǥ��
select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;
                    --   ���� index ������� 5
select to_char(sysdate, 'd')
from dual;

select last_name, hire_date, 
    to_char(hire_date, 'day'),
    to_char(hire_date,'d')
from employees;

--����] �� ���̺��� �����Ϻ��� �Ի��ϼ� �������� �����϶�.

select last_name, hire_date,
    to_char(hire_date, 'day') day
    --to_char(hire_date, 'd')
from employees
order by to_char(hire_date -1, 'd'),
    to_char(hire_date);


select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

-- fill mode - �����̽� ���� �ٿ��ֱ�
select to_char(hire_date, 'fmDD Month RR') 
from employees;

-- ����] ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--      �λ������� �Ի��� �� 3���� �� ù��° �������̴�.
--      ��¥�� YYYY.MM.DD�� ǥ���Ѵ�.
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(
    next_day(
    add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;

-------------------------------------------
-- ���ڸ� ���ڷ� 

select to_char(salary)
from employees;
                      -- 9 = ���ڰ� �ðž� ��� �� 
select to_char(salary, '$99,999.99'), 
    to_char(salary, '$00,000.00')   -- 0������ �̷��� ��
from employees
where last_name = 'Ernst';

select '��' || to_char(12.12, '9999.999') || '��',
    '��' || to_char(12.12, '0000.000') || '��'
from dual;

-- fill mode - �����̽� ���� �ٿ��ֱ� + �Ҽ��� 3��° 0�̸� �����ֱ����
select '��' || to_char(12.12, 'fm9999.999') || '��',
    '��' || to_char(12.12, 'fm0000.000') || '��'
from dual;

-- ��ȭǥ�� �Ϸ��� L
select to_char(1237, 'L9999')
from dual;

-- ����] <�̸�> earns <$,����> monthly but wants <$,����x3>.�� ��ȸ

select last_name || ' earns ' || 
    to_char(salary, 'fm$99,999')|| ' monthly but wants '|| 
    to_char(salary * 3, 'fm$99,999') || '.'
from employees;

--------------------------------------
-- ���ڸ� ��¥�� to_date ( + fx )

select last_name, hire_date
from employees            -- to_date = ��¥������ �������
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees            -- to_date = ��¥������ �������
where hire_date = to_date('Sep 21, 2005', 'Mon dd yy');

select last_name, hire_date
from employees            -- format eXtract - ��(����)�� ��ġ�ؾ�
where hire_date = to_date('Sep 21, 2005', 'fxMon dd, yyyy'); 

---------------------------------------------
-- ���ڸ� ���ڷ� to_number

select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; -- Error

select to_number('1,237.12', '99,999.999')
from dual;

----------------------------------------
-- null ��sysdata�� ��nvl ���̾�, null�� �ٷＭ

-- �˻��� ���� null�̸� ������ 0 
-- �˻��Ұ��� �⺻���� Ÿ���� ���ƾ���
-- �ϳ��� Į���̱⶧���� ������ �ϳ��� ���� Ÿ���� �������Ѵ�

select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- ����] ������� �̸�, ����, ������ ��ȸ�϶�.

select last_name, job_id, salary,
    salary * (1 + (nvl(commission_pct, 0))) * 12 ann_sal
from employees
order by ann_sal desc;

-- ����] ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--      Ŀ�̼��� ������, No Commission�� ǥ���Ѵ�
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;
                                   --  ��null �ƴϸ� 
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) incomo
from employees;            -- ���� 0 (null �̸�) �� 


----------------------------------------------
--nullif 
-- first, last�� length�� ������ null����
-- ���������� length(first) ����
select first_name, last_name,
    nullif(length(first_name),length(last_name))
from employees;

select to_char(null), to_number(null), to_date(null)
from dual;

--------------------------------------------------
-- coalesce - ó������ null�� �ƴѰ��� ������ �༮�� ����
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

--------------------------------------------------
-- decode = switch�� ����ϴ�
-- 1��° �Ķ���� - ���ذ�, 2 �񱳰�, 3 ���ϰ�, 4 �⺻��(��������)
select last_name, salary, 
    decode( trunc(salary / 2000),
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
            0.45) tax_rate    -- else 0.45 
from employees
where department_id = 80;

-- salary�� 'a'�� ���������� �⺻���� �ڵ� null
select decode(salary, 'a', 1)
from employees;
--  1 ���ذ�, 2 �񱳰�, 3 ���ϰ�, 4 �⺻��
-- ��� ���ڸ� ���ڷ� �ٲ㼭 ��
select decode(salary, 'a', 1, 0)
from employees;

-- ��� job_id�� ���ڷ� �ٲ� �� ��� ����
select decode(job_id, 1, 1)
from employees; -- error, invalid number

-- ��� hire_date�� ���ڷ� �ٲٱ� �õ�
select decode(hire_date, 'a', 1)
from employees;

-- ��� hire_date�� ���ڷ� �ٲ� �� ��� ����
select decode(hire_date, 1, 1)
from employees;

-- ����] ������� ����, ������ ���(�⺻�� null)�� ��ȸ�϶�.

select job_id, 
    decode(job_id,
    'IT_PROG' , 'A',
    'AD_PRES' , 'B',
    'ST_MAN'  , 'C',
    'ST_CLERK', 'D') grade
from employees;

-- case ~ when ~ then ~ else ~ end = decode
-- �񱳰� Type = when Type
-- then Type =  else(�⺻��) Type


select last_name, job_id, salary, 
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end "Revised_Salary"
from employees;
          -- �񱳰� Type = when Type
          -- then Type =  else(�⺻��) Type
select case job_id when 'IT_PROG' then 1
                    when '2' then 2
                    else 0
        end grade
from employees;

select case salary when 24000 then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;

select case salary when '1'then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees; -- error

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0
        end grade
from employees; -- error

select case salary when 1 then 1
                    when 2 then '2'
                    else '0'
        end grade
from employees; -- error

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

--����] �̸�, �Ի���, ������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.

select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end;

--����] 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--      2005�� ���Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�
--      ������� �̸�, �Ի���, ������ ��ǰ�� �ݾ��� ��ȸ�϶�

select last_name, hire_date,
    case when hire_date < '2005/01/01' then '100����'
        else '10����'
    end gift
from employees;


