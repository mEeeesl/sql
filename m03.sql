select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

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
where lower(last_name) = 'higgins';

select last_name
from employees
where last_name = initcap('higgins');

select concat('Hello', 'World')
from dual;


select substr('HelloWorld', 1, 5), substr('HelloWorld',-5,5)
from dual;

select instr('Hello', 'l')
from dual;

select lpad(salary, 5, '*'), rpad(salary, 5, '*'), 
    rpad('**[{', 5, '*')
from employees;

select replace('JACK', 'J', 'BL')
from dual;

select trim('    Hello     ')
from dual;

select round(45.923, 0), trunc(45.923), round(45.9235, 3)
from dual;

select last_name, salary, salary - mod(salary,1000)
from employees;

select last_name, salary,
    round(salary * 1.155) "new salary",
    round(salary * 1.155) - salary increase
from employees;

select sysdate -1, sysdate, sysdate + 1 , sysdate - sysdate
from dual;

select last_name, trunc((sysdate - hire_date)/365)
from employees;

select months_between('2022/12/31', '2020/12/31')
from dual;

select next_day('2022/07/14', 1)
from dual;

select next_day('2022/07/15', 'mon')
from dual;

select last_day('2022/07/16')
from dual;

select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;

select employee_id, rpad('*', trunc(salary/1000), '*')
from employees
order by salary desc;