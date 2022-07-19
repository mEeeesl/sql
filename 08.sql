-- 8장 set - 집합 ( 합집합 교집합 )
-- union 합집합
-- 칼럼의 숫자, 문자 순서가 같아야 집합이 가능하다.

select employee_id, job_id -- 숫자 , 문자
from employees; --  107개 recode

select employee_id, job_id  -- 숫자 , 문자
from job_history; -- 10개 recode

select employee_id, job_id -- 숫자 , 문자
from employees
union                      --▲▼ 테이블구조가 같은상황
select employee_id, job_id  -- 숫자 , 문자
from job_history;
-- ▲ 중복제거됨 2개 => 115개 recode

-- ▼ 중복제거없이 토탈 117개 recode
select employee_id, job_id 
from employees
union all
select employee_id, job_id
from job_history;

-- union은 중복을 제거 해준다,. union all은 싹다 합쳐준다
-- 과거의 직업을 현재 가지고있는 사람은 2명

--과제] 과거 직업을 현재 갖고 있는 사원들의 사번, 이름 직업조회
-- 내가한거
select employee_id, last_name, job_id
from employees e
where job_id in (select job_id
                from job_history j
                where e.employee_id = j.employee_id);

-- 강사
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

-- 교집합 intersect
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

-- 차집합 minus
select employee_id, job_id
from employees
minus
select employee_id, job_id
from job_history;

---------------------------------

select location_id, department_name
from departments
union
select location_id, state_province
from locations;
-- department_name인데 도쿄, 텍사스 등 도시명이 중간중간 나와버림
-- 칼럼의 숫자 문자 순서가 같아야 집합이 가능하다.
-- 퍼시스턴스 관점에서는 문제가 없지만,
-- 서비스 관점에서 부서명과 도시명이 섞여있다.


-- 과제] 위 문장을, service 관점에서 고쳐라.도시명 없애기

select location_id, department_name, null state
from departments
union
select location_id, null, state_province
from locations;

-------------------------------------

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history;
-- Error 첫번째 집합은 3개 두번째집합은 2개

--과제] 위 문장을 고쳐라.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, null -- or 0
from job_history
order by 3;
-- 퍼시스턴스 관점에서 보면 칼럼의 갯수가 일치해야하고
-- 데이타 타입도 일치해야한다.
