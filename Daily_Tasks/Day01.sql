-- Write a PL/SQL block that prints each department's name and the number of employees in it.

DECLARE
    CURSOR dept_cursor IS 
        SELECT department_name
        FROM DEPARTMENTS;
    dept_name DEPARTMENTS.department_name%TYPE;
    emp_num NUMBER;
BEGIN
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO dept_name;
        EXIT WHEN dept_cursor%NOTFOUND;

        SELECT COUNT(*) INTO emp_num FROM EMPLOYEES
        WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM departments WHERE department_name = dept_name);

        DBMS_OUTPUT.PUT_LINE(dept_name || ' ' || emp_num);
    END LOOP;
    CLOSE dept_cursor;
END;
/

SELECT DEPARTMENT_NAME FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 10;

SELECT COUNT(*) FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 10;

DECLARE 
  CURSOR dept_names is 
    SELECT department_name
    FROM departments;
  
  dept_name departments.department_name%TYPE;
  emp_num NUMBER;
  
BEGIN
  OPEN dept_names;
  LOOP 
    fetch dept_names into dept_name;
    EXIT WHEN dept_names%NOTFOUND;
    
    SELECT SUM(CASE d.department_name WHEN dept_name THEN 1 ELSE 0 END) INTO emp_num
    FROM employees e JOIN departments d
    ON e.department_id = d.department_id;
    
    DBMS_OUTPUT.PUT_LINE(dept_name || ' ' || emp_num);
  END LOOP;
END;
/