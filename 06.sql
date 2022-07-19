-- 6장 Join - n개의 테이블 - record 결합
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- location_id 는 departments와 locations 양쪽에 다 있다.

-- equi join ( 中 natural join )
select department_id, department_name, location_id, city
from departments natural join locations;

-- natural join - 두 테이블 사이의 공통 column을 찾고
-- 같은 recode끼리 join 시킴
-- Data Type은 같아야함
-- departments - location_id = 외부 테이블에서 들어온 fall in key
-- locations - location_id = praimary key

-- 내가 join 후보를 대상을 미리 골라내고싶을땐 where
select department_id, department_name, location_id, city
from departments natural join locations
where department_id in(20, 50);
-- department_id 는 locations엔 없음

-- 공통된 칼럼을 찾아야하는 단점이 너무 크다..?
-- 그래서 나온 것이?

-- from ~ join ~ using ~

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);
-- department_id가 같은 애들끼리 조인을 했다는걸 알 수 있음


--과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments;

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;
-- from 절에서 별명 사용가능
-- 사용하면 select에도 from 별명 적용가능

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400;
-- ERROR using 절의 접두사를 붙일 수 없다.

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400;
-- ERROR using column에는 접두사를 붙일 수 없다.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100;
-- ERROR manager_id는 공통칼럼이지만, using절이 아니기에 ?
-- 애매해서 에러임, e 소속인지 d 소속인지 애매해서 에러

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where e.manager_id = 100;
-- 근데 공통칼럼에 접두사를 붙이면 정상
-- using column에는 접두사를 붙일 수 없지만,
-- using절이아닌 공통칼럼을 쓸때는 접두사를 붙여야만 한다.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100;
--------------------------------------

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);
--e.department_id = d.department_id 인 애들끼리 join하라 
-- on + 조건문

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 과제] 위 문장을, using으로 refactoring 하라.
select e.employee_id, city, d.department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

-- where 대신 and를 써도 됨
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149;


--과제] Toronto 에 위치한 부서에서 일하는 사원들의
--      이름, 직업, 부서번호, 부서명, 도시를 조회하라.

select e.last_name, e.job_id,
    e.department_id, d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

select e.last_name, e.job_id,
    department_id, d.department_name, l.city
from employees e join departments d
using (department_id)
join locations l
using (location_id)
where l.city = 'Toronto';

-----------------------------------------
-- non-equi join  =  ' = ' 안쓰면 non equi
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

------------------------------------------
-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = employee_id;
-- Error self join에는 select절, on절 모두 접두사 써조야댐

--과제] 같은 부서에서 일하는 사람들의 이름, 부서번호, 동료이름 조회

-- 내가한거
select worker.last_name worker,
    worker.department_id dpt,
    partner.last_name partner
from employees worker join employees partner 
on worker.department_id = partner.department_id
and worker.employee_id != partner.employee_id;

-- 강사님꺼 / !=  ==  <>  둘다 같은 뜻
select e.department_id, e.last_name employee , c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

--과제] Davies보다 후에 입사한 사원들의 이름, 입사일을 조회하라
-- 내가한거
select e.last_name, c.last_name, c.hire_date
from employees e join employees c
on c.hire_date between e.hire_date and sysdate
and e.last_name = 'Davies'
and c.last_name != 'Davies'
order by 3;

-- 강사님꺼
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date;

-- 과제] 매니저보다 먼저 입사한 사원들의
-- 이름, 입사일, 매니저명, 매니저입사일을 조회하라
select e.last_name, e.hire_date, m.last_name, m.hire_date
from employees e join employees m
on e.manager_id = m.employee_id
and e.hire_date < m.hire_date;

--------------- ▲ inner join
--------------- ▼ outer join

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;
-- 1명 빠져있음. 이때 사용하는게

-- outer join
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;
-- employees에 Grant는 join이 안되었더라도 나옴

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;
-- departments d 에 빠졌던 애들 다 호출 

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;
-- employees, departments에 join 안되었던 애들 싹 다호출

-- 과제] 사원들의 이름, 사번, 매니저명, 매니저의사번을 조회하라
--      King 사장도 테이블에 포함한다.

select w.last_name, w.employee_id, m.last_name, m.manager_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;

-------------------------------------------------------------
-- 6장 2부


select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
-- inner join을 쓸땐 이게 간결해서 좋은데
-- outer join으로하면 가독성이 떨어짐 근데 outer join을 잘 안써서 ㄱㅊ대

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
-- (+) = right outer join  ▲
-- (+) = left outer join   ▼
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-- self 절에서의 사용

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;
