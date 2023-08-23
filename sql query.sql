***(create table)***
CREATE TABLE demo (
	id serial PRIMARY KEY,
	name VARCHAR ( 50 ) NOT NULL,
	salary INT NOT NULL
);

create table employees (id int primary key not null,name text (50) not null,salary int not null);
select * from employees; 










***(insert)***
insert into students (id,fname,lname,age)
insert into students values(5,'ram','lakhan',23);

***(select)***
select * from students;
select id,fname from students;

***(where clause)***
select * from students where age=20;

***(update)***
update students set lname='sharma' where id=4;
update students set lname='patel' where age=19;
update students set fname='abc',lname='xyz' where age=19;

***(delete)***
delete from students where id=5;

***(order by clause)***
select * from students order by id;
select * from students order by age asc;
select * from students order by age desc;
select * from students order by id asc;
select * from students order by id desc;
select * from students order by fname asc;
select * from students order by fname,lname asc;
select * from students order by fname asc, lname desc;

***(group by clause)***
select * from teachers;
select name,sum(salary) from teachers group by name;

***(having clause)***
select name from teachers group by name having count(name) > 2;
select name from teachers group by name having count(name) > 1;
select name from teachers group by name having count(name) < 2;

***(operators and,or,not conditions)***
select * from students where lname='sharma' AND age > 15;
select * from students where lname='sharma' AND age > 20;
select * from students where lname='sharma' or age > 20;
select * from students where (lname='sharma'or lname='mark') AND age > 20;
select * from students where (lname='sharma'or lname='mark') AND age > 15;
select * from students where lname is not null;

***(like,in,not in,between)***
select * from students where fname like 'j%';
select * from students where fname like 'ja%';
select * from students where fname like '%n';
select * from students where age in(12,21,22);
select * from students where age in(19,21,22);
select * from students where age not in(19,21,22);
select * from students where age between 15 and 21;

***(view)***
create view new_students as select fname,age from students; 
select * from new_students;
create view new_studs as select lname,age from students;
drop view new_studs;

***(inner join (simple))***
select students.fname,students.lname,teachers.name from students inner join teachers on students.id = teachers.id;
select teachers.name,students.lname,students.lname from students inner join teachers on students.id = teachers.id;

***(left join & right join)***
select students.fname,students.age,teachers.name from students left join teachers on students.id = teachers.id;
select students.fname,students.age,teachers.name from students right join teachers on students.id = teachers.id;

***(full outer join)***
select students.fname,students.age,teachers.name from students full outer join teachers
on students.id = teachers.id;
select students.fname,students.age,teachers.name from students full outer join teachers 
on students.id = teachers.id order by teachers.name;

***(cross join)***
select fname,name from students cross join teachers;
select name,fname from teachers cross join students;

***(Aggregate function)***
select * from students;
select max(age) from students;
select max(age) as max_age from students;
select min(age) as min_age from students;
select avg(age) as avg_age from students;
select round(avg(age),2) as avg_age from students;

select * from teachers;
select sum (salary) as total_salary from teachers;
select count(*) from teachers;


***(user defined function)***
create or replace function total_students()
returns integer as $total$
declare total integer;
begin
select count(*) into total from students;
return total;
end;
$total$ language plpgsql;
select total_students();

create function sum (var1 integer,var2 integer)
returns integer as $sum$
begin
return var1 + var2;
end;
$sum$ language plpgsql;
select sum(2,5);



***(Triggers on insert event)***
create or replace function audit_log() returns trigger as $xyz$
begin
insert into audit(id,name,entry_date) values(new.id,new.name,current_timestamp);
return new;
end;
$xyz$ language plpgsql;

create trigger audit_trigger after insert on employees
for each row execute procedure audit_log();
insert into employees values (1,'Hemant',35000);
insert into employees values (2,'Ashok',25000);

select * from audit;
select * from employees;



***(Alias in PostgreSQL)***
select max(age) as max_age from students;
select s.fname,t.name from students as s, teachers as t where s.id = t.id



***(index in PostgreSQL)***
select * from test;
select * from test where first_name='Ahmed';
explain select * from test where first_name='Ahmed';
create index emp_index on test("first_name");
drop index emp_index;


***(Array in PostgreSQL)***
create table employ(id int not null primary key, name text not null, 
salary integer[], work_hours text[][]);

insert into employ values(1,'jhon','{25000,30000}',
'{{"morning","two"}}')

insert into employ values(2,'rahul','{20000,25000}',
'{{"morning","three"},{"Evening","four"}}')

select * from employ;
select salary[1] from employ;
select work_hours[1][1] from employ;
select work_hours[1][2] from employ;
select * from employ where work_hours[1][2]= 'two';



***(Enumeration in PostgreSQL)***
create type mood as enum('sad', 'ok', 'happy'); 
create table person(name text, current_mood mood)

insert into person values('rahul', 'sad')
insert into person values('Ashok', 'happy')
insert into person values('neha', 'ok')

insert into person values('hemant', 'good')

select * from person;
select 	min(current_mood) from person;
select 	max(current_mood) from person;
select * from person where current_mood > 'sad';
select * from person where current_mood > 'ok';



***(check constraint)***
create table pupils(roll_no integer check(roll_no > 1000), name text not null);

insert into pupils values(900,'Rahul');
insert into pupils values(1001,'Rahul');
insert into pupils values(1002, null);
select * from pupils;




***(string function)***
select 'hello ' || 'world';
select concat('hello ','world',' hii');

select length('hello');
select char_length('hello');

select lower('HELLO');
select upper('hello');

select substr('hello',2,3);
select substr('hello',0,4);

select position('e' in 'hello'); 
select position('ell' in 'hello'); 

select ascii('A');
select ascii('a');

select reverse('hemant');
select repeat('hii ',3);



***(Sub Query in PostgreSQL)***
select * from teachers;
select * from teachers where salary > (select avg(salary) from teachers);
select * from teachers where salary in(select salary from teachers where salary>20000);   












