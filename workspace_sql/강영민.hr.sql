--drop user, create user, grant, 
--create table, create sequence
drop user hr2 cascade;

create user hr2 identified by hr2 default tablespace users;

grant connect, resource to hr2;

create table hr2.laborers(
laborer_id number(10) primary key,
laborer_name varchar2(15) constraint laborers_laborername_nn not null,
hire_date date constraint laborers_hiredate_nn not null);

create sequence hr2.laborers_laborerid_seq
    start with 1
    increment by 1;

commit;
