-- DDL (Data Definition Language) - 데이터 정의
drop table hire_dates; -- 삭제했어도 쓰레기통에 있는 상태

create table hire_dates(
id number(8),
hire_date date default sysdate); -- 기본값 default로 지정가능

select tname
from tab; -- data dictoinary

-- 과제] drop table 후, 위 문장의 실행 결과에서, 쓰레기(BIN)는 제하고, 조회

select tname
from tab
where tname not like '%BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select *
from hire_dates;

--------------------------------------
-- DCL(data Control Language) - 데이터 관리
-- 자동 commit
-- Connection을 hr이 아닌, system connection으로 변경해야한다.
-- system user
-- Connection을 만드는 정보를 조작
create user you identified by you;
grant connect, resource to you;

-- connection 변경 -> you
-- you user
select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key, -- primary key 선언
department_name varchar2(20));

desc user_constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key, -- not null + unique 2개의 속성을 갖음
emp_name varchar2(10) constraint emps_empname_nn not null, -- emp_name에 null이 들어오지 못하게 막음
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000), -- 조건이 참이면 받아들여지고 아니면 에러메시지나옴
department_id number(3),
constraint emps_email_uk unique(email), --unique - recode별로 유일한 필드를 가지도록
constraint emps_depid_fk foreign key(department_id) -- dept_id 가 foreign key다.근데 어디서왔냐?
    references depts(department_id));            -- 여기서 왔다

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100); -- 100 - foreign key
commit;

delete depts; -- Error integrity constraint (YOU.EMPS_DEPID_FK) violated - child record found
-- integrity 무결성, 참된 데이터가 있도록 한다.
-- department_id로 depts , emps가 연결되어있는상탠데
-- depts 에 department_id가 PK니까 얘가 부모고
-- emps 는 자식임 
-- depts를 지워버리면 emps(자식)도 문제가 가니까 못지우게 Error (?)
-- 해결방법
-- 1. 자식새끼에있는 FK들을먼저 지우고 부모꺼 지우기
-- 2. on delete cascade - 자식꺼에다가 이거 적어놔야댐( 139열 참고 ) 

insert into depts values(100, 'Marketing');
-- Error - unique constraint (YOU.DEPTS_DEPTID_PK) violated
-- 100번 부서가 이미 있음 'Development'

insert into depts values(null, 'Marketing');
-- Error - cannot insert NULL into ("YOU"."DEPTS"."DEPARTMENT_ID")
-- nn not null로 지정해서 null 못들어옴

insert into emps values(501, null, 'good@gmail.com', 6000, 100);
-- Error - cannot insert NULL into ("YOU"."EMPS"."EMP_NAME")
-- emp_name을 nn not null로 지정해놔서 null 못들어옴 

insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100);
-- Error - unique constraint (YOU.SYS_C007026) violated
-- 이미 musk@gmail.com 이 있음 - unique라 중복안됨

insert into emps values(501, 'adel', 'good@mail.com', 6000, 200);
-- Error - parent key not found
-- 부모에 200번 department_id 가 없어서 에러다..?

drop table emps cascade constraints; -- cascade 연달아 일어나는 - 관련정보 싹 삭제

select constraint_name, constraint_type, table_name
from user_constraints;

--------------------------------------

-- system user
grant all on hr.departments to you;

-- you user
drop table employees cascade constraints; -- 복습할땐 싹 지우고 다시 만들어야하는거

create table employees( -- 커넥션이 you라서 중복아님
employee_id number(6) constraint emp_empid_pk primary key, -- primary key는 하나만 존재
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null --2개 조건넣을 수 있
                    constraint emp_emai_pk unique,  --email은 pk는 아님
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
-- Error 다른 스키마(여기선 hr) 접근할땐
-- system user로 변경 후 grant all on hr.departments to you;
-- you 에 모든 권한을 줘야함

-------------------  테이블 만들기 끝  --------------------------------------

-- on delete --
drop table gu cascade constraints; --복습을 위해 삭제먼저시킴.
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade); --부모가 삭제당하면 나도 삭제하겠다.

create table dong2(
dong_id number(4) primary key,
dong_name varchar(12) not null,
gu_id number(3) references gu(gu_id) on delete set null); -- 부모가 삭제당하면 child의 값은 null로 밖임

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6000, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong; --cascade였어서 삼성동, 역삼동 사라짐.
select * from dong2; --gu_id가 null로 바뀜.

commit;
---------------------------

-- disable fk - 개발할때 fk를 잠재우기, 개발끝나면 깨워줘야댐

drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
insert into b values(32, 9); --Error 부모에는 fk(aid)가 1밖에 없음
-- 이때 잠재우는거
alter table b disable constraint b_aid_fk;
insert into b values(32, 9); -- 거짓데이터이긴한데, 일단 개발은 가능함
-- 개발 끝나면 잠자던거 깨워줘야댐
-- 제일 좋은건 싹 지우고 다시 실행하는게 좋데
-- 데이터가 있는 상태에서 하면 안좋데, 그 예 ▼
alter table b enable constraint b_aid_fk; -- Error fk 9는 아직도 없으니까
-- 잠자던거 깨우기
alter table b enable novalidate constraint b_aid_fk; -- fk는 깨어남

insert into b values(33, 8); --error - parent key not found
-----------------------------------
-- 서브쿼리 이용가능

drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;

desc sub_departments;

select * from sub_departments;
-------------------------------------

-- 테이블 구조를 수정하는 방법 - alter table
-- 테이블과 관련된것까지 깔끔하게 지우기
drop table users cascade constraints;

create table users(
user_id number(3));
desc users
                    --column(테이블) 추가
alter table users add(user_name varchar2(10));
desc users
                    --column(테이블) 수정
alter table users modify(user_name varchar2(7));
desc users
                    --column(테이블) 삭제
alter table users drop column user_name;
desc users
--------------------------------------

-- 테이블 읽기전용으로 바꾸기 (해가 바껴서 작년꺼 못건드리게)

insert into users values(1); -- 쓰기가능 

alter table users read only; -- 읽기전용으로 바꾸기
insert into users values(2); -- Error 쓰기 불가능

alter table users read write; -- 읽기& 쓰기가능
insert into users values(2);
select * from users;

commit;

-- 10장에서 배운건, 아 이런게 있었다정도 생각하고 필요할때 찾아서 쓰면 됨
