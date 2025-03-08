-- Write a PL/SQL block, which declares and uses cursors with parameters.In a loop, use a cursor to retrieve the department number and the department name from the departments table for a department whose department_id is less than 100. Pass the department number to another cursor as a parameter to retrieve from the employees table the details of employee last name, job, hire date, and salary of those employees whose employee_id is less than 120 and who work in that department. 


DECLARE
    -- A)
    CURSOR dept_cursor IS 
        SELECT department_id, department_name 
        FROM   departments
        WHERE  department_id < 100
        ORDER BY department_id;
    -- B)
    CURSOR emp_cursor(deptno NUMBER) IS 
        SELECT last_name, job_id, hire_date, salary
        FROM   employees
        WHERE employee_id < 120 
        AND  department_id = deptno;
    -- C)
    dept_no   departments.department_id%TYPE ;
    dept_name departments.department_name%TYPE;
    emp_name employees.last_name%TYPE;
    jId employees.job_id%TYPE;
    hDate employees.hire_date%TYPE;
    sal employees.salary%TYPE;
BEGIN
    -- D
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO dept_no, dept_name;
        EXIT WHEN dept_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(dept_name || ' ' || dept_no);

        OPEN emp_cursor(dept_no);
        LOOP
            FETCH emp_cursor INTO emp_name, jId, hDate, sal;
            EXIT WHEN emp_cursor%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(emp_name || ' ' || jId || ' ' || hDate || ' ' || sal);
        END LOOP;
        CLOSE emp_cursor;
    END LOOP;
    CLOSE dept_cursor;
END;
/