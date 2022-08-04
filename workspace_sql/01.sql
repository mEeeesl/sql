-- 1장 Select
-- 내가 원하는것(column)을 request 해서 table로 response 받는 것
select * from departments;  -- * = all column

--select columnName from TableNames(복수형);

select department_id, location_id
from departments;

select location_id, department_id
from departments;

-- desc = Table의 구조를 확인
desc departments

-- 과제] employees 구조를 확인하라.
desc employees

-- 나만의 새로운 칼럼을 만들어보자
select last_name, salary,  salary + 300
from employees;

-- 과제] 사원들의 월급, 연봉을 조회하라.

select employee_id, salary, salary*12
from employees;

select last_name, salary, 12 * salary + 100
from employees;
select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;

-- 피연산자에 null이 하나라도 있으면 값이 null이 나옴 ㄷㄷ
-- null이 안나오게 설계해야함
select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees;

-- column명 변경하기 as 생략가능
select last_name as name, commission_pct comm
from employees;

-- 현장에서도 오라클은 싹 소문자로 하고있긴함 근데 이쁘게하고싶다?
select last_name "Name", salary * 12 "Annual Salary"
from employees;

-- 과제] 사원들의 사번, 이름, 직업, 입사일(STARTDATE)을 조회하라.
select employee_id, last_name, job_id, hire_date as startdate
from employees;

-- 과제] 사원들의 사번(Emp # < 관례), 이름(Name), 직업(Job), 입사일(Hire Date)을 조회하라.
select employee_id as "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;


-- || 붙이기 연산자 = 문자로 변환한다.
select last_name || job_id
from employees;
select last_name || ' is ' || job_id
from employees;
select last_name || ' is ' || job_id employee
from employees;

-- 붙이기 연산자만 null 을 사용할 수 있다.
select last_name || null -- null - empty String 
from employees;
select last_name || commission_pct -- 문자 1.4로 바뀜
from employees;
select last_name || salary -- 문자 24000임 숫자아님
from employees;
select last_name || hire_date -- 문자임 숫자아님
from employees;
select last_name || (salary * 12) -- 결과값은 문자임
from employees;
-- 과제] 사원들의 '이름, 직업'(Emp & Title)을 조회하라.

select last_name|| ', ' || job_id "Emp & Title"
from employees;