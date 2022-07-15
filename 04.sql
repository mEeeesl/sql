-- 4장, DataType conversion

select hire_date
from employees
where hire_date = '2003/06/17'; --문자가 날짜로 변환
-- 날짜의 형식에 안맞춰주면 에러나옴 
-- hire_date는 날짜타입이니까 

select salary
from employees
where salary = '7000'; -- 문자가 숫자로 자동변환
-- 숫자 안쓰고 'qweqwe' 이렇게 문자로쓰면 에러나옴 
-- saraly는 숫자타입이니까 

select hire_date || ''
from employees;     -- 날짜가 문자로 바뀜

select salary || ''
from employees;     -- 숫자가 문자로 바뀜

--------------------------------------
-- 날짜를 문자로 + function (to_char)이용

select to_char(hire_date)
from employees;
                        --    ▼  fm form의 model 
select to_char(sysdate, 'yyyy//mm--dd') -- 날짜를 문자로 바꾸기
from dual;
                            --        ▼ sp 날짜를 문자로 표기
select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;
                    --   요일 index 목요일은 5
select to_char(sysdate, 'd')
from dual;

select last_name, hire_date, 
    to_char(hire_date, 'day'),
    to_char(hire_date,'d')
from employees;

--과제] 위 테이블을 월요일부터 입사일순 오름차순 정렬하라.

select last_name, hire_date,
    to_char(hire_date, 'day') day
    --to_char(hire_date, 'd')
from employees
order by to_char(hire_date -1, 'd'),
    to_char(hire_date);


select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

-- fill mode - 스페이스 여백 줄여주기
select to_char(hire_date, 'fmDD Month RR') 
from employees;

-- 과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사한 지 3개월 후 첫번째 월요일이다.
--      날짜는 YYYY.MM.DD로 표시한다.
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(
    next_day(
    add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;

-------------------------------------------
-- 숫자를 문자로 

select to_char(salary)
from employees;
                      -- 9 = 숫자가 올거야 라는 뜻 
select to_char(salary, '$99,999.99'), 
    to_char(salary, '$00,000.00')   -- 0을쓰면 이렇게 됨
from employees
where last_name = 'Ernst';

select 'ㅣ' || to_char(12.12, '9999.999') || 'ㅣ',
    'ㅣ' || to_char(12.12, '0000.000') || 'ㅣ'
from dual;

-- fill mode - 스페이스 공백 줄여주기 + 소수점 3번째 0이면 지워주기까지
select 'ㅣ' || to_char(12.12, 'fm9999.999') || 'ㅣ',
    'ㅣ' || to_char(12.12, 'fm0000.000') || 'ㅣ'
from dual;

-- 원화표시 하려면 L
select to_char(1237, 'L9999')
from dual;

-- 과제] <이름> earns <$,월급> monthly but wants <$,월급x3>.로 조회

select last_name || ' earns ' || 
    to_char(salary, 'fm$99,999')|| ' monthly but wants '|| 
    to_char(salary * 3, 'fm$99,999') || '.'
from employees;

--------------------------------------
-- 문자를 날짜로 to_date ( + fx )

select last_name, hire_date
from employees            -- to_date = 날짜형식을 내맛대로
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees            -- to_date = 날짜형식을 내맛대로
where hire_date = to_date('Sep 21, 2005', 'Mon dd yy');

select last_name, hire_date
from employees            -- format eXtract - 폼(형식)이 일치해야
where hire_date = to_date('Sep 21, 2005', 'fxMon dd, yyyy'); 

---------------------------------------------
-- 문자를 숫자로 to_number

select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; -- Error

select to_number('1,237.12', '99,999.999')
from dual;

----------------------------------------
-- null ★sysdata랑 ★nvl 많이씀, null을 다뤄서

-- 검사할 값이 null이면 설정값 0 
-- 검사할값과 기본값의 타입이 같아야함
-- 하나의 칼럼이기때문에 동일한 하나의 리턴 타입을 가져야한다

select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- 과제] 사원들의 이름, 직업, 연봉을 조회하라.

select last_name, job_id, salary,
    salary * (1 + (nvl(commission_pct, 0))) * 12 ann_sal
from employees
order by ann_sal desc;

-- 과제] 사원들의 이름, 커미션율을 조회하라.
--      커미션이 없으면, No Commission을 표시한다
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;
                                   --  ▼null 아니면 
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) incomo
from employees;            -- 문자 0 (null 이면) ▲ 


----------------------------------------------
--nullif 
-- first, last의 length가 같으면 null리턴
-- 같지않으면 length(first) 리턴
select first_name, last_name,
    nullif(length(first_name),length(last_name))
from employees;

select to_char(null), to_number(null), to_date(null)
from dual;

--------------------------------------------------
-- coalesce - 처음으로 null이 아닌값이 나오는 녀석을 리턴
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

--------------------------------------------------
-- decode = switch랑 비슷하다
-- 1번째 파라미터 - 기준값, 2 비교값, 3 리턴값, 4 기본값(생략가능)
select last_name, salary, 
    decode( trunc(salary / 2000),
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
            0.45) tax_rate    -- else 0.45 
from employees
where department_id = 80;

-- salary가 'a'와 같을수없음 기본값은 자동 null
select decode(salary, 'a', 1)
from employees;
--  1 기준값, 2 비교값, 3 리턴값, 4 기본값
-- 얘는 숫자를 문자로 바꿔서 비교
select decode(salary, 'a', 1, 0)
from employees;

-- 얘는 job_id를 숫자로 바꿀 수 없어서 에러
select decode(job_id, 1, 1)
from employees; -- error, invalid number

-- 얘는 hire_date를 문자로 바꾸기 시도
select decode(hire_date, 'a', 1)
from employees;

-- 얘는 hire_date를 숫자로 바꿀 수 없어서 에러
select decode(hire_date, 1, 1)
from employees;

-- 과제] 사원들의 직업, 직업별 등급(기본값 null)을 조회하라.

select job_id, 
    decode(job_id,
    'IT_PROG' , 'A',
    'AD_PRES' , 'B',
    'ST_MAN'  , 'C',
    'ST_CLERK', 'D') grade
from employees;

-- case ~ when ~ then ~ else ~ end = decode
-- 비교값 Type = when Type
-- then Type =  else(기본값) Type


select last_name, job_id, salary, 
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end "Revised_Salary"
from employees;
          -- 비교값 Type = when Type
          -- then Type =  else(기본값) Type
select case job_id when 'IT_PROG' then 1
                    when '2' then 2
                    else 0
        end grade
from employees;

select case salary when 24000 then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;

select case salary when '1'then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees; -- error

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0
        end grade
from employees; -- error

select case salary when 1 then 1
                    when 2 then '2'
                    else '0'
        end grade
from employees; -- error

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

--과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.

select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end;

--과제] 2005년 이전에 입사한 사원들에겐 100만원 상품권,
--      2005년 이후에 입사한 사원들에겐 10만원 상품권을 지급한다
--      사원들의 이름, 입사일, 수령한 상품권 금액을 조회하라

select last_name, hire_date,
    case when hire_date < '2005/01/01' then '100만원'
        else '10만원'
    end gift
from employees;


