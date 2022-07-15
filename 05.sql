-- group function 

-- ★count()★ 개수파악 - 많이씀
-- ※group function은 null 값을 무시함※
-- 파라미터 record 메소드가 n개 ( single은 1개 )
-- 싱글에서 from employees 조지면 값이 개많이 나와야 되는데
-- group function 에서 from employees 조지면 
-- 얘네가 그룹이되서 값이 1개만 나옴

-- max & min & avg & sum 
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

-- min & max 날짜
-- min 오래된 날짜 , max 최신 날짜
-- 마지막 방문일, 비밀번호 변경한지 90일, 휴면계정, 복귀유저
select min(hire_date), max(hire_date)
from employees;

--과제] 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;

-- ★ count() ★ 많이씀
-- * == 모든 column ( null이고 뭐고 다 포함 )
select count(*)    -- 총 사원수 
from employees;

--과제] 70번 부서원이 몇명인 지 조회하라.

select count(*)
from employees
where department_id = 70;

-- employee_id = primary key
select count(employee_id) 
from employees; -- 107

select count(manager_id)
from employees; -- 106 King = null 

-- 영업직의 commission임 null인 애들은 배제하고 계산됨
select avg(commission_pct)
from employees; 

-- 과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct,0))
from employees;

--------------------------------------------

select avg(salary)
from employees;

-- all 
select avg(all salary)
from employees;

-- distinct 중복제거 ( 5000이 2개 있으면 5000은 1번만 넣음 )
select avg(distinct salary)
from employees;

-- 과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

--과제] 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;

----------------------------------------
-- group by

-- select 절에 있는 테이블을 group by에 쓸수있음
-- 아래에선 employee_id를 쓴게 아니라
-- group function count를 쓴거임
-- 그게있어야 어느 부서에 몇명인지 파악하지
-- 원래 count는 null은 무시해주는데,
-- 12번의 null은 group by로 인해 생긴 그룹임
-- 여기서 department_id는 label 이라고 부른다.

select department_id, count(employee_id)
from employees
group by department_id -- 같은 부서를 그룹으로 묶음
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id
order by department_id; 
-- Error] job_id 가 select 절에 없어서 
-- + 여기서 job_id가 필요가 없자나 
-- 부서당 몇명의 사원이 있는지 조회하는건데 

-- 과제] 직업별(label)(group) 사원수(count)를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id;

-----------------------------------
-- having   = group을 골라냄 ( where 이랑 비슷

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;
-- 그룹이 갖고있는 필드중에 하나 쓰면댐 
-- 여기선 department,max 2개

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000;
-- Error] having 에서는 별명 못씀

select department_id, max(salary)
from employees
where department_id > 50
group by department_id;
-- 레코드를 먼저 골라내고 그거가지고 그룹을 만든거임

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; 
-- Error] 조건문에 group by 들어가면 having 써야된다.
-- having = group을 골라내는 것이다.