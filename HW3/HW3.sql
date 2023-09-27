 --  1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами
 select employee_name, s.month_salary 
 from 	employees e
 join 	employee_salary es 
 on 	e.id = es.employee_id 
 join 	salary s 
 on 	es.salary_id = s.id 
 
--  2. Вывести всех работников у которых ЗП меньше 2000.
 select e.employee_name, s.month_salary 
 from 	employees e
 join 	employee_salary es 
 on 	e.id = es.employee_id 
 join 	salary s 
 on 	es.salary_id = s.id
 where 	s.month_salary < 2000
 
-- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
 select * 
 from 	salary s   
 where 	id not in (select salary_id  from employee_salary es)
 
-- 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
 select * 
 from 	salary s   
 where 	id not in (select salary_id  from employee_salary es) and s.month_salary < 2000
 
-- 5. Найти всех работников кому не начислена ЗП.
 select * 
 from 	employees e   
 where 	id not in (select employee_id  from employee_salary es)
 
-- 6. Вывести всех работников с названиями их должности.
 select e.employee_name, r.role_name 
 from 	employees e 
 left join roles_employee re 
 on 	e.id = re.employee_id 
 join 	roles r 
 on 	re.role_id = r.id 
 
--  7. Вывести имена и должность только Java разработчиков.
 select e.employee_name, r.role_name 
 from 	employees e 
 left join roles_employee re 
 on 	e.id = re.employee_id 
 join 	roles r
 on 	re.role_id = r.id 
 where 	r.role_name like '%Java developer'
 
-- 8. Вывести имена и должность только Python разработчиков.
 select e.employee_name, r.role_name 
 from 	employees e 
 left join roles_employee re 
 on 	e.id = re.employee_id 
 join 	roles r
 on 	re.role_id = r.id 
 where 	r.role_name like '%Python developer' 
 
-- 9. Вывести имена и должность всех QA инженеров.
 select e.employee_name, r.role_name 
 from 	employees e 
 left join roles_employee re 
 on 	e.id = re.employee_id 
 join 	roles r
 on 	re.role_id = r.id 
 where 	r.role_name like '%QA engineer'  
 
--  10. Вывести имена и должность ручных QA инженеров.
 select e.employee_name, r.role_name 
 from 	employees e 
 left join roles_employee re 
 on 	e.id = re.employee_id 
 join 	roles r
 on 	re.role_id = r.id 
 where 	r.role_name like '%Manual QA%'  
 
-- 11. Вывести имена и должность автоматизаторов QA
 select e.employee_name, r.role_name 
 from 	employees e 
 left join roles_employee re 
 on 	e.id = re.employee_id 
 join 	roles r
 on 	re.role_id = r.id 
 where 	r.role_name like '%Automation QA%'  
 
-- 12. Вывести имена и зарплаты Junior специалистов
 create table employees_olap as
 select e.employee_name, 
 		r.role_name as employee_role, 
 		s.month_salary  
 from 	employees e 
 left join roles_employee re 
 on 	e.id = re.employee_id 
 join 	roles r
 on 	re.role_id = r.id
 join 	employee_salary es 
 on 	e.id = es.employee_id 
 join	salary s 
 on 	es.salary_id = s.id 
 
truncate TABLE employees_olap ;
ALTER SEQUENCE employee_salary_id_seq RESTART with 1;

 select *
 from employees_olap
 
 select employee_name, month_salary  
 from 	employees_olap
 where 	employee_role  like '%Junior%' 
 
-- 13. Вывести имена и зарплаты Middle специалистов
 select employee_name, month_salary  
 from 	employees_olap
 where 	employee_role  like '%Middle%' 

-- 14. Вывести имена и зарплаты Senior специалистов
 select employee_name, month_salary  
 from 	employees_olap
 where 	employee_role  like '%Senior%' 
 
-- 15. Вывести зарплаты Java разработчиков
 select month_salary  
 from 	employees_olap
 where 	employee_role  like '%Java developer%' 
 
 -- 16. Вывести зарплаты Python разработчиков
 select month_salary  
 from 	employees_olap
 where 	employee_role  like '%Python developer%' 
 
--  17. Вывести имена и зарплаты Junior Python разработчиков
 select employee_name, month_salary 
 from 	employees_olap
 where 	employee_role  like '%Junior Python%' 
 
-- 18. Вывести имена и зарплаты Middle JS разработчиков
 select employee_name, month_salary 
 from 	employees_olap
 where 	employee_role  like '%Middle JavaScript%' 
 
-- 19. Вывести имена и зарплаты Senior Java разработчиков
 select employee_name, month_salary 
 from 	employees_olap
 where 	employee_role  like '%Senior Java%' 
 
--  20. Вывести зарплаты Junior QA инженеров
 select month_salary 
 from 	employees_olap
 where 	employee_role  like '%Junior%QA%' 
 
--  21. Вывести среднюю зарплату всех Junior специалистов
 select round(avg(month_salary), 2) as avg_monthly_salary
 from 	employees_olap
 where 	employee_role  like '%Junior%QA%' 
 
-- 22. Вывести сумму зарплат JS разработчиков
 select sum(month_salary) monthly_salary_sum
 from 	employees_olap
 where 	employee_role  like '%JavaScript developer%'  
 
-- 23. Вывести минимальную ЗП QA инженеров
 select min(month_salary) as min_qa_monthly_salary
 from 	employees_olap
 where 	employee_role  like '%QA%' 
 
-- 24. Вывести максимальную ЗП QA инженеров
 select max(month_salary) as max_qa_monthly_salary
 from 	employees_olap
 where 	employee_role  like '%QA%' 
 
-- 25. Вывести количество QA инженеров
 select count(*) as qa_number
 from 	employees_olap
 where 	employee_role  like '%QA%'  
 
-- 26. Вывести количество Middle специалистов.
 select count(*) as middle_number
 from 	employees_olap
 where 	employee_role  like '%Middle%'  
 
-- 27. Вывести количество разработчиков
 select count(*) as developers_number
 from 	employees_olap
 where 	employee_role  like '%developer%'   
 
-- 28. Вывести фонд (сумму) зарплаты разработчиков..
 select sum(month_salary) as montly_salary_sum
 from 	employees_olap
 where 	employee_role  like '%developer%'   
 
-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
 select *
 from 	employees_olap
 order by month_salary 
 
-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
 select *
 from 	employees_olap
 where month_salary between 1700 and 2300
 order by month_salary 
 
-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
 select *
 from 	employees_olap
 where month_salary < 2300
 order by month_salary 
 
-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
 select *
 from 	employees_olap
 where month_salary in (1100, 1500, 2000)
 order by month_salary 
