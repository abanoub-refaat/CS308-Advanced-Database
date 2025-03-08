-- Write a PL/SQL block that prints each employee's last_name, his manger's last_name, and his department's name.

DECLARE
    CURSOR emp_cursor IS
        SELECT e.last_name, m.last_name, d.department_name 
        FROM   EMPLOYEES e JOIN EMPLOYEES m 
        ON     e.manager_id = m.employee_id 
        JOIN    departments d  
        ON   e.department_id = d.department_id;
    emp_name    VARCHAR2(20);
    mgr_name    VARCHAR2(20);
    dept_name   VARCHAR2(20);
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_name, mgr_name, dept_name;
        EXIT WHEN emp_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(mgr_name || ' ' || emp_name || ' ' || dept_name);
    END LOOP;
    CLOSE emp_cursor;
END;
/

SELECT last_name, MANAGER_ID, DEPARTMENT_ID
FROM  employees;

SELECT e.last_name, m.last_name
FROM   EMPLOYEES e JOIN EMPLOYEES m
ON     e.manager_id = m.employee_id;

SELECT d.department_name
FROM   EMPLOYEES e JOIN departments d
ON     e.department_id = d.department_id;