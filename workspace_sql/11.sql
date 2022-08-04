-- 11장 
-- view - 쿼리에 별명을 붙인것,
-- view 에는 데이터가 없다. 단지 쿼리의 별명이다. (면접질문)
-- sequence 

-- hr user로 실습하자 
drop view empvu80; --80번 부서에서 일하는 사원들

create view empvu80 as
    select employee_id, last_name, department_id --쿼리
    from employees
    where department_id = 80;
    
desc empvu80 --select 절의 칼럼이 view의 구조가 됨

select * from empvu80; -- view가 있으니 이렇게 하면댐

select * from ( -- view가 없었으면 이렇게 해야함
    select employee_id, last_name, department_id --쿼리
    from employees
    where department_id = 80);
    
-- view 교체 - create or replace
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;
    
desc empvu80
select * from empvu80;

--과제] 50번 부서원들의 사번, 이름, 부서번호로 만든 
--  DEPT50 view를 만들어라.
--  view 구조는 EMPNO, EMPLOYEE, DEPTNO이다.
--  view 를 통해서 50번 부서 사원들이 다른 부서로 배치되지 않도록

drop view dept50;

create or replace view dept50 (empno, employee, depno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ck; -- 수정 및 업데이트 되는걸 막아줌

--과제] DEPT50 view의 구조를 조회
desc dept50
--과제] DEPT50 view의 data를 조회
select * from dept50;


-----------------------------------------
-- with check option
drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from departments;
    
create view team50 as
    select *
    from teams
    where team_id = 50;

select * from team50;

select count(*) from teams;
insert into team50 
values(300, 'Marketing');
select count(*) from teams; -- view(team50)에 insert했지만 teams에 추가되는격

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; -- 제약조건

insert into team50 values(50, 'IT Support');
select count(*) from teams; -- 
insert into team50 values(301, 'IT support'); --Error check option
                            -- view의 부서id 301은 50과 같은지 보고, 틀리니까 에러
-- with read only + view를 사용하면 read only를 사용해라                         
create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; -- view를 읽기전용으로

insert into empvu10(501, 'abel', 'Sales'); -- 추가불가

----------------------------------------------
---- sequence  ( 얘 많이 씀 )

drop sequence team_teamid_seq;

create sequence team_teamid_seq; -- 시작값 1 증가값 1

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3;

drop sequence x_xid_seq;
create sequence x_xid_seq
    start with 10 -- 시작값
    increment by 5 -- 증분
    maxvalue 20 -- 최대값
    nocache -- cache 캐시없음
    nocycle;    -- 주기없음

select x_xid_seq.nextval from dual; -- nocycle 효과 경험

-- 과제] DEPT 테이블의 DEPTID 칼럼의 field value로 사용할
-- sequence를 만들어라.
-- 400 시작, 1000 이하, 10 증분.

drop sequence dept_deptid_seq;
create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;

-- 과제] 위 sequence 로,
-- DEPT 테이블에서, Education 부서를 insert 하라.
desc dept
select * from dept;

insert into dept (department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');
commit;

-------------------------------------------
-- index

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABK';

select index_name, index_type, table_owner, table_name
from user_indexes;

-- 과제] DETP 테이블의 DEPARTMENT_NAME 에 대해 index를 만들자

create index dept_departmentname_idx
on dept(department_name);

select department_name, rowid
from dept;

-----------------------------------------
-- synonym 별명 for 테이블: 테이블 (DB객체)에 별명을 붙이는 것

drop synonym team;

create synonym team
for departments;

desc team;
desc departments;
select * from team;
select * from departments;

-- 과제] EMPLOYEES 테이블에 EMPS synonym 을 만들어라.

drop synonym emps;

create synonym emps
for employees;

desc emps;
desc employees;
select * from emps;
select * from employees;