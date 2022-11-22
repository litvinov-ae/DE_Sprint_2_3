create type grade_type as enum ('junior','middle','senior');
create type score_type as enum ('A','B','C','D','E');

create table if not exists employees (
id int generated always as identity primary key,
full_name varchar (255) not null,
birthday date not null,
job_start date not null,
position varchar (255)not null,
grade grade_type not null,
salary int,
department_id int,
driver_license boolean,
FOREIGN KEY (department_id) references departments(id)	on delete cascade
);

create table if not exists departments(
id int generated always as identity primary key,
name varchar (255) not null,
full_name_head varchar (255),
count_employees int
);

create table if not exists scores (
id int generated always as identity primary key,
employee_id int,
q1 score_type,
q2 score_type,
q3 score_type,
q4 score_type,
FOREIGN KEY (employee_id) references employees(id)	on delete cascade
);

insert into departments (name, full_name_head, count_employees) 
values ('bid_data', 'Ivan Ivanovich Ivanov', 2),
	   ('data analyst', 'Petr Petrovich Petrov', 3),
	   ('tech','Ivan Ivanovich Ivanov', 1);

insert into employees (full_name, birthday, job_start, position, grade, salary, department_id, driver_license)
values ('Ivan Petrovich Podnebesniy','1990-12-13', '2022-01-01', 'data engineer','junior', 105000, 1, false),
	   ('Petr Ivanovich Derzkiy', '1994-11-01', '2020-09-01','programmer','junior', 110000, 1, true),
	   ('Petr Ivanovich Modniy','1991-08-11', '2002-06-11','analyst', 'middle', 150000, 2, true),
	   ('Ivan Ivanovich Bessmertniy','1990-07-19', '2012-11-01','data engineer','middle', 155000, 2, false),
	   ('Petr Ivanovich Mirniy','1981-05-23', '2018-07-01','programmer','senior', 180000, 2, true),
	   ('Petr Petrovich Otbitiy','1999-12-03', '2021-01-01','analyst','senior', 170000, 3, true);
	  
insert into scores (employee_id, q1, q2, q3, q4)	  
	 values ( 1, 'D', 'E', 'A', 'A'),
	 		( 2, 'B', 'B', 'B', 'B'),
	 		( 3, 'E', 'B', 'A', 'B'),
	 		( 4, 'C', 'E', 'C', 'C'),
	 		( 5, 'A', 'B', 'C', 'D'),
	 		( 6, 'A', 'D', 'C', 'B');

select id, full_name, date_part('year',age(current_date, job_start)) as "стаж лет" from employees;
select id, full_name, date_part('year',age(current_date, job_start)) as "стаж лет" from employees order by id limit 3;
select id from employees where driver_license = true;
select id from scores where q1 in ('D','E');
select max(salary) from employees;

select name from departments where count_employees = (select max(count_employees) from departments);

select id from employees e order by job_start;

select grade, avg(salary) from employees group by grade;