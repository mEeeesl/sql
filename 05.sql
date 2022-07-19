-- 5장 group function 

-- ★count()★ 개수파악 - 많이씀
-- ※group function은 null 값을 무시함※
-- 파라미터 record n개 ( single은 1개 )
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

-- employee_id = primary key = null값 없음
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
-- 그룹이 갖고있는 필드중에 하나 쓰면댐 08783
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
-- Error] 조건문에 group이 들어가면 having 써야된다.
-- having = group을 골라내는 것이다.

select job_id, sum(salary) payroll
from employees
where job_id not like'%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

select department_id, avg(salary)
from employees
group by department_id
order by avg(salary) desc;

select max(avg(salary))
from employees
group by department_id;

-- 그룹바이해서 부서갯수만큼 n개 그룹만들어지고 
-- avg함수도 n번 실행
-- record n개가 만들어지고
-- 그게 그룹이되어 max함수의 값이 1개가 됨 19333.333333

select sum(max(avg(salary)))
from employees
group by department_id;
-- Error - 너무 깊이 들어감, 2차까진 ㅇㅋ 인데 3차이상은 못받음
-- 그룹바이는 2개 함수까지만 

select department_id, round(avg(salary))
from employees
group by department_id;
-- 라운드는 12번 실행 + 12번 리턴
-- 그룹 + 싱글 function

select department_id, round(avg(salary))
from employees;

-- Error
-- 그룹 + 싱글 할땐 group by 해조야댐
-- 그룹 + 그룹은 Ok, 그룹 + 그룹 + 그룹은 No

--과제] 매니저별 관리 직원들 중 최소 월급을 조회하라.
--  최소월급이 $6,000 초과여야 한다.

select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;

--과제] 2001년 2002년 2003년도별 입사자 수를 찾는다.
-- ★★★★★ 집계할때 현장에서 자주 씀 ★★★★★★

select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

--과제] 직업별, 부서별 월급합을 조회하라. ★ ★ ★ ★ ★
--      부서는 20, 50, 80 이다.

select job_id,
    sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;
    
    
select job_id,
    sum(case when department_id = 20 then salary else null end)"20",
    sum(case when department_id = 50 then salary else null end)"50",
    sum(case when department_id = 80 then salary else null end)"80"
from employees
group by job_id;
