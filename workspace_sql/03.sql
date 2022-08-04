-- 3장 Single Function 
-- 파라미터 레코드 개수 1개
--SQL(Structed Query Language)
--Function은 PL/SQL ( Procedure Language / SQL )로 작성되있음
--API 사용법만 읽힐거래

-- Single Function 
-- 파라미터 = 레코드 / 리턴값 = 레코드 / 각 1개만있음

desc dual
select * from dual;

-- lower 소문자로 바꿔줌.
select lower('SQL Course')
from dual;

-- upper 대문자로 바꿈
select upper('SQL Course')
from dual;

-- initcap 단어의 첫 글자만 대문자로 바꿈
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
where lower(last_name) = 'higgins'; -- 레코드가 다 들어가있는 상태이긴함 107번 lower 작업함

select last_name
from employees
where last_name = initcap ('higgins');

-- concat
select concat('Hello', 'World')
from dual;

-- substr - SQL은 1부터 시작 / 2번부터 시작해서 5개 가져오기
select substr('HelloWorld', 2, 5)
from dual;

select substr('Hello', -2, 2)
from dual;

-- length 글자 수 파악
select length('Hello')
from dual;

-- instr 문자가 있는지 파악 + 처음 발견한 l의 index를 리턴하고 종료
-- SQL의 Index는 1부터 시작
select instr('Hello', 'l')
from dual;
select instr('Hello', 'w')
from dual;

-- lpad  지금은 딱히 안쓴다함, 너비를 규격에 맞게 설정후 리턴
select lpad(salary, 5, '*') -- 값 5개 받고, 없으면 저거로 채움
from employees;

-- rpad 얘는 오른쪽으로 채움
select rpad(salary, 5, '*')
from employees;

-- replace 값을 교체
select replace('JACK and JUE', 'J', 'BL')
from dual;

-- trim 머리나 꼬리를 뜯어내버림
select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello')
from dual;
select trim('H' from 'HelHloH')
from dual;
select trim(' ' from ' Hello ')
from dual;
--과제] 위 문장에서 ' '가 trim 됐음을 눈으로 확인할 수 있게 조회
select 'ㅣ' || trim(' ' from ' Hello ') || 'ㅣ'
from dual;

-- trim은 앞으로 이렇게 쓰면 됨 
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

--과제] 위 문장에서, where 절을 like로 refactoring 하라.

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG%';

-- 과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회
-- 이름의 첫글자는 대문자, 나머지는 소문자로 출력한다.

select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';

---------------------------------------
-- round 반올림 trunc 반내림 mod 나머지 --

select round(45.926, 2)
from dual;

select trunc(45.926, 2)
from dual;

select mod(1700, 300)
from dual;

select round(45.923, 0), round(45.923)
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;
select round(45.923), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 1000)
from employees;

-- 과제] 사원들의 이름, 월급,
-- 15.5% 인상된 월급(New Salary, 정수로표현), 인상액을 조회

select last_name, salary,
    round(salary * 1.155) "New Salary",
    round(salary * 1.155) - salary "Increase"
from employees;


-----------------------------------
-- 날짜 sysdate - 현재날짜+시간

select sysdate 
from dual;
select sysdate + 1
from dual;
select sysdate - 1
from dual;
select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- 과제] 아래 문장을 고쳐서, 이름, 근속년수를 조회
select last_name, trunc((sysdate - hire_date)/365)
from employees
where department_id = 90;

------ months_between 월 계산 -----
select months_between('2022/12/31', '2021/12/31')
from dual;
select add_months('2022/07/14', 1)
from dual;

-- 일요일 = 1 토요일 = 7
-- 7/14 이후 7(토요일) = 2022/07/16 
select next_day('2022/07/14', 7) 
from dual;

select next_day('2022/07/14','thursday')
from dual;

select next_day('2022/07/14','thu')
from dual;

-- 해당월의 말일 - 2022/07/31
select last_day('2022/07/14')
from dual;

-- 과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라
-- 월급은 매월 말일에 지급한다.
select employee_id, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;
--where sysdate - hire_date >= 365*20;

-- 과제] 사원들의 이름, 월급그래프를 조회하라.
-- 그래프는 $1000당 * 하나를 표시한다.

select employee_id, rpad('*', trunc(salary/1000), '*')
from employees;

select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

-- 과제] 위 그래프를 월급 기준 내림차순 정렬하라.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by salary desc;