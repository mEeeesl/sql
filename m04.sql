select hire_date
from employees
where hire_date = '2003/06/17';

select hire_date || ''
from employees;

select salary || ''
from employees;

select to_char(hire_date, 'yyY,mm,dd')
from employees;

select to_char(hire_date, 'fxYYYY-MM-DD')
from employees;

select to_char(hire_date, 'fmYear Month Ddsp Day(dy)')
from employees;

select to_char(hire_date, 'd'), to_char(hire_date, 'day')
from employees;

select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1, 'd'),
    to_char(hire_date);

select to_char('hh24 :: mi // ss am'),
    to_char(hire_date, 'DD " ooff " month')
from employees;

select last_name, to_char(hire_date, 'YYYY.MM..DD?') hire_date,
    to_char(
    next_day(
    add_months(hire_date, 3), 'mon'), 'YYYY.MM..Dd?') reiview_date
from employees;
    
select to_char(salary)
from employees;

select to_char(salary, '$999,999.999'), to_char(salary, '$000,000.000')
from employees;

select to_char(12.12, '$999.999'), to_char(12.12, '$000.000'),
    to_char(12.12, 'fm$9999.9999'), to_char(12.12, 'fm$0000.0000')
from dual;

select to_char(1237, 'L9999')
from dual;

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxmon Dd, YYYY');

select to_number('1,237.89', '999,999.999'),
    to_number('1,237.89', '0,000.00000')
from dual;

select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

select last_name, job_id, salary,
    salary * (1 + (nvl(commission_pct, 0))) * 12 ann_sal
from employees
order by salary desc;

select last_name, nvl(to_char(commission_pct), 'No commission') oo
from employees;

select first_name, last_name,
    nullif(length(first_name), length(last_name))
from employees;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

select last_name, salary,
    decode(trunc(salary / 2000),
    0, 0.00,
    1, 0.09,
    2, 0.20,
    3, 0.30,
    4, 0.40,
    5, 0.42,
    6, 0.44,
        0.45) tax_rate
from employees
where department_id = 80;

select decode(salary, 'a', 1)
from employees;

select decode(salary, 'a', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees;

select decode(hire_date,'a', 1)
from employees;

select decode(hire_date, 1, 1)
from demployees;

select job_id,
    decode(job_id,
    'IT_PORG' , 'A',
    'AD_PRES' , 'B') grade
from employees;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when 'IT_PROG' then 1
                    when '2' then 2
                    else 0
        end grade
from employees;

select case salary when 24000 then '1'
                    when 2 then '2'
                    else '3'
        end grade
from employees;

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'Good'
    end grade
from employees;

select last_name, hire_date, to_char(hire_date, 'day'),
    case to_char(hire_date, 'fmday')
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
        end day
from employees
order by day;

select last_name, hire_date, 
    case when hire_date < '2005/01/01' then '100만원'
        else '10만원'
    end gift
from employees;
