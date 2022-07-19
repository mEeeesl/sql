-- 2장 where 실행시, true인 값만 인출
select employee_id, last_name, department_id
from employees
where department_id = 90; 
-- where = 조건문 = 리턴값이 boolean Type
-- departmeint_id 가 90인 record 가 response 됨

-- 과제] 176번 사원의 사번, 이름, 부서번호를 조회하라

select employee_id, last_name, department_id
from employees
where employee_id = 176;

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen'; 

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';  -- 환경설정 - nls 검색

-- query = request, 질문, 
select last_name, salary
from employees
where salary <= 3000;

-- 과제] $12,000 이상 버는 사원들의 이름, 월급을 조회하라.
select last_name, salary
from employees
where salary >= 12000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';

---------------------------------
-- where ~ between -- 
-- 범위조건문, 범위가 참이면 true 하는 조건문 

select last_name, salary
from employees
where salary between 2500 and 3500; -- 이상 ~ 이하

select last_name
from employees
where last_name between 'King' and 'Smith';

-- 과제] 'King' 사원의 first name, last name, 직업, 월급조회

select first_name, last_name, job_id, salary
from employees
where last_name = 'King'; -- data는 대/소문자 구분함

select last_name, hire_date
from employees
where hire_date between '2002-01-01' and '2002-12-31'; -- 실선

----------------------------
-- where ~ in --

select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201); -- 점선

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
-- ★★ where ~ like ~ ★★--  특정값이 들어간 녀석 찾기
-- 검색할때 주로 사용한다.

select first_name
from employees
where first_name like 'S%'; -- S로 시작하는 녀석 찾기

select first_name
from employees
where first_name like '%r'; -- r로 끝나는 녀석 찾기

-- 과제] first_name에 s가 포함된 사원들의 first_name을 조회하라.

select first_name
from employees
where first_name like '%s%' and
    first_name like '%r%';
    
-- 과제] 2005년에 입사한 사원들의 이름, 입사일을 조회하라

select last_name, hire_date
from employees
where hire_date like '2005%';

-- 글자수를 정하고싶을 때 '_' underBar 1개가 임의의 1글자를 받음 --

select last_name
from employees
where last_name like 'K___';

-- 과제] 이름의 2번째 글자가 'o'인 사원의 이름을 조회하라.

select last_name
from employees
where last_name like '_o%';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\'; -- escape 문자 - 특수문자를 일반문자로

select last_name, job_id
from employees
where job_id like 'I_[_%' escape '['; -- escape 문자 - 내가 원하는거 지정가능

--과제] 직업에 _R이 포함이 된 사원들의 이름, 직업을 조회하라

select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';

------------------------------
-- is null -- null을 위해 만들어진 연산자 

select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null ; 
-- 붙이기 연산자 || 를 제외하면 피연산자에 null이 들어가면 안댐

select last_name, manager_id
from employees
where manager_id is null ;

-----------------------------
-- 논리연산자 || && --

select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';

-----------------------------
-- Not 연산자 -- ( 단독 사용은 불가 )

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

-- 과제] 월급을 20000달러 이상 받는 사장 외 사원들의 이름, 월급조회

select last_name, salary
from employees
where not (salary >= 20000 and manager_id is null);
    
-- 과제] 월급이 $5000 이상 %12000이하이다. 그리고,
--      20번이나 50번 부서에서 일하는 사원들의 이름, 부서번호조회

select last_name, department_id, salary
from employees
where (salary between 5000 and 12000) and
    department_id in (20, 50);
    
-- 과제] 이름에 a와 e가 포함된 사원들의 이름을 조회하라

select last_name
from employees
where last_name like '%a%e%' or
    last_name like'%e%a%';

select last_name
from employees
where last_name like '%a%' and
    last_name like '%e%';
    
-- 과제] 직업이 영업이다. 그리고, 월급이 $2500, $3500이 아니다.
--      위 사원들의 이름, 직업, 월급을 조회하라.

desc employees
select employee_id, job_id, salary
from employees
where job_id like 'SA%' and
    salary not in(2500, 3500);
    
-----------------------------------
-- order by = 오름차순 순서정렬하기 + null은 가장 마지막배치--

select last_name, department_id
from employees
order by department_id;

-- order by ~ desc = 내림차순 순서정렬 + null은 가장 위에배치
select last_name, department_id
from employees
order by department_id desc; 

select last_name, department_id dept_id
from employees
order by dept_id desc;

-- 내가 만든 Table에 없는 Column으로도 정렬을 할 수 있다.
select last_name
from employees
where department_id = 100
order by hire_date;


-- order by index desc = index 가지고 내림차순 사용가능
select last_name, department_id
from employees
order by 2 desc;

-- order by ~ asc(오름차순), ~ desc(내림차순)
select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc;