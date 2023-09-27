import psycopg2
import random

conn = psycopg2.connect(
        host="159.69.151.133",
        port="5056",
        database="qa_ddl_36_41",
        user="qa_36_gr_user_41",
        password="123")

# Наполнить таблицу employee 70 строками.
def insert_employees(rows_number):
    cursor = conn.cursor()
    names = ['Bob', 'Johny', 'Steve', 'Ivan', 'Horhe', 'Maria', 'Laura', 'Olga', 'Sveta', 'Lily']
    surnames = ['Black', 'Johnson', 'Stevenson', 'Huares', 'White', 'Perkinson', 'Jagger', 'Tailor']

    for i in range(rows_number):  
        cursor.execute(f"INSERT INTO employees (employee_name) VALUES ('{''.join(random.choice(names) + '_' + random.choice(surnames))}');")
    conn.commit()
    conn.close()

# Наполнить таблицу salary 15 строками
def insert_salary(rows_number):
    cursor = conn.cursor()
    for i in range(0, rows_number):  
        cursor.execute(f"INSERT INTO salary (month_salary) VALUES ('{1000 + i * 100}');")
    conn.commit()
    conn.close()

# Наполнить таблицу employee_salary 40 строками:
# - в 10 строк из 40 вставить несуществующие employee_id
def insert_employee_salary(rows_number, employees_num, salaries_num, not_exist_number):
    cursor = conn.cursor()
    for i in range(1, rows_number + 1): 
        salary_id = random.randint(1, salaries_num)
        if i <= rows_number - not_exist_number:
            cursor.execute(f"INSERT INTO employee_salary (employee_id, salary_id) VALUES ({i}, {salary_id});")
        else:
            cursor.execute(f"INSERT INTO employee_salary (employee_id, salary_id) VALUES ({i + employees_num}, {salary_id});")
    conn.commit()
    conn.close()
 
# Наполнить таблицу roles_employee 40 строками:
def insert_employee_roles(rows_number, roles_number):
    cursor = conn.cursor()
    for i in range(1, rows_number + 1): 
        cursor.execute(f"INSERT INTO roles_employee (employee_id, role_id) VALUES ({i}, {random.randint(1, roles_number)});")
    conn.commit()
    conn.close()

# insert_employees(70)
# insert_salary(15)
# insert_employee_salary(40, 70, 14, 10)
# insert_employee_roles(40, 20)


