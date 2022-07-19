-- 7장 subquery
-- main & sub & outer & inner - query종류
-- sub가 값추출 -> main이 그 값을 이용

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel')
order by salary desc;

select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');
                
--과제] Kochhar 에게 보고하는 사원들의 이름 직업 부서번호
select last_name, job_id ,department_id
from employees
where manager_id in (select employee_id
                    from employees
                    where last_name = 'Kochhar');                
                
--과제] IT 부서에서 일하는 사원들의 부서번호 이름 직업
select department_id, last_name, job_id
from employees
where department_id in (select department_id
                  from departments
                  where department_name like '%IT%');

select department_id, last_name, job_id
from employees
where department_id = (select department_id
                  from departments
                  where department_name = 'IT');


--과제] Abel과 같은 부서에서 일하는 동료이름 입사일
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'                        
order by 1;

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'King');
        -- subquery 리턴값이랑 비교값이랑 같아야함
        -- 'King' 임마 동명이인이라서 값 2개 나옴
        
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees 
                        where department_id = 50);

-- 과제] 회사 평균 월급 이상 버는 사원들의 사번 이름 월급
--      월급 오름차순 정렬
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by 3;

---------------------------

select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id);
     -- error more than one row -> row = recode
                
select employee_id, last_name, salary
from employees
where salary in (select min(salary)
                    from employees
                    group by department_id);


select employee_id, last_name
from employees
where salary = any (select min(salary)
                from employees
                group by department_id);

select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
-- where절 = salary < 9000,6000,4800,4800,4200
-- any -> 하나라도 true면 true = 9000 미만이면 true 
-- all -> 모두 true여야 true = 4200 미만이면 true

-- 과제] 60번 부서의 일부(any) 사원보다 급여가 많은 사원이름

select last_name, salary
from employees
where salary > any (select salary
                    from employees
                    where department_id = 60)
order by 2 desc;

-- 과제] 이름에 u가 포함된 사원이 있는 부서에서 일하는
-- 사원의 이름 사번

select last_name, employee_id
from employees
where department_id in (select department_id
                    from employees 
                    where last_name like '%u%');
                    
-- 과제] 1700번 지역에 위치한 부서에서 일하는 
--  이름 직업 부서번호 조회
select last_name, job_id, department_id
from employees join departments
using (department_id)
where department_id in (select department_id
                        from departments join locations
                        using (location_id)
                        where location_id =1700);
                        
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);
                        
-- 과제] 회사 평균(avg) 월급보다, 그리고 모든(all) 프로그래머보다 월급을 더 받는
-- 사원들의 이름 직업 월급

select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary > all (select salary
                from employees
                where job_id = 'IT_PROG'); 
                
-----------------------------
-- no row -- 서브쿼리 row가 없으니 메인쿼리 row도 없음

select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1);
                
select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT');
                
-- null

select last_name
from employees
where employee_id in (select manager_id
                        from employees);
-- in - 하나라도 일치하는게 있으면 그 값 사용
-- not in = 하나라도 사용하지 않겠다 ->  != all
                    
select last_name
from employees
where employee_id not in (select manager_id
                        from employees);

-- 과제] 위 문장으로 all 연산자로 refactoring 하라.
select last_name
from employees
where employee_id <> all (select manager_id
                        from employees);

---------------------------------
-- exists - 존재하는것만 뽑아냄?

select count(*)
from departments;

select count(*) 
from departments d  -- 주문 Table / 회원 Table
where exists (select *
                from employees e    -- 재고 Table? 반품 Table? / 등급 Table? 
                where e.department_id = d.department_id);
                
select count(*) 
from departments d
where not exists (select *
                from employees e
                where e.department_id = d.department_id);

-- 과제] 직업을 바꾼 적이 있는 사원들의 사번, 이름 ,직업
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id)
order by employee_id;

select *
from job_history
order by employee_id;

