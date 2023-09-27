--Создать таблицу employees
--- id. serial,  primary key,
--- employee_name. Varchar(50), not null

create table if not exists employees (
	id serial primary key,
	employee_name varchar(50) not null
)

truncate TABLE employees;
ALTER SEQUENCE employees_id_seq RESTART with 1;

--===========================================================
--Создать таблицу salary
--- id. Serial  primary key,
--- monthly_salary. Int, not null

create table if not exists salary (
	id serial primary key,
	month_salary integer not null
)

truncate TABLE salary ;
ALTER SEQUENCE salary_id_seq RESTART with 1;

--===========================================================
--Создать таблицу employee_salary
--- id. Serial  primary key,
--- employee_id. Int, not null, unique
--- salary_id. Int, not null

create table if not exists employee_salary (
	id serial primary key,
	employee_id integer not null unique,
	salary_id integer not null
)

truncate TABLE employee_salary ;
ALTER SEQUENCE employee_salary_id_seq RESTART with 1;

--===========================================================
--Создать таблицу roles
--- id. Serial  primary key,
--- role_name. int, not null, unique
--Поменять тип столба role_name с int на varchar(30)
--Наполнить таблицу roles 20 строками:

create table if not exists roles (
	id serial primary key,
	role_name integer not null unique
)
alter table roles alter column role_name SET DATA TYPE varchar(50);

truncate TABLE roles ;
ALTER SEQUENCE roles_id_seq RESTART with 1;

insert into roles (role_name)
values ('Junior Python developer'),
('Middle Python developer'),
('Senior Python developer'),
('Junior Java developer'),
('Middle Java developer'),
('Senior Java developer'),
('Junior JavaScript developer'),
('Middle JavaScript developer'),
('Senior JavaScript developer'),
('Junior Manual QA engineer'),
('Middle Manual QA engineer'),
('Senior Manual QA engineer'),
('Project Manager'),
('Designer'),
('HR'),
('CEO'),
('Sales manager'),
('Junior Automation QA engineer'),
('Middle Automation QA engineer'),
('Senior Automation QA engineer');



--===========================================================
--Создать таблицу roles_employee
--- id. Serial  primary key,
--- employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)
--- role_id. Int, not null (внешний ключ для таблицы roles, поле id)

create table if not exists roles_employee (
	id serial primary key,
	employee_id integer not null unique,
	role_id integer not null,
	CONSTRAINT fk_employee
      FOREIGN KEY(employee_id) 
	  REFERENCES employees(id),
	CONSTRAINT fk_role
      FOREIGN KEY(role_id) 
	  REFERENCES roles(id)
)

truncate TABLE employee_salary ;
ALTER SEQUENCE employee_salary_id_seq RESTART with 1;

--===========================================================