-- Explicit cursoes:
--  can process beyond the first row return by the query, row by row
--  keep track of which row is currently being processed
--  allow the programmer to manually control explict cursors in the PL/SQL block

SET SERVEROUTPUT ON;

DECLARE
    CURSOR emp_cursor IS 
        -- not including th INTO clause since it will appear in the FETCH statment later. 
        SELECT employee_id, last_name FROM employees
        WHERE department_id = 30;
    empno employees.employee_id%TYPE;
    lname employees.last_name%Type;
BEGIN
    OPEN emp_cursor; -- opening the cursor
    LOOP
        FETCH emp_cursor INTO empno, lname;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(empno || ' ' || lname);
    END LOOP;
    CLOSE emp_cursor; -- closing the cursor
END;
/

-- Cursor FOR loop
DECLARE
    CURSOR emp_cursor IS 
    SELECT employee_id, last_name FROM employees
    WHERE department_id = 30;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ' ' || emp_record.last_name);
    END LOOP;
END;
/

BEGIN
    FOR emp_record IN (SELECT employee_id, last_name
     FROM EMPLOYEES WHERE DEPARTMENT_ID = 30)
    LOOP
        DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ' ' || emp_record.last_name);
    END LOOP;
END;
/


-- Curosors with parameters
DECLARE
    CURSOR emp_cursor(deptno NUMBER) IS 
     SELECT employee_id, last_name
     FROM   EMPLOYEES
     WHERE  DEPARTMENT_ID = deptno
     FOR UPDATE;
    dept_id NUMBER;
    lname   VARCHAR2(15);
BEGIN
    OPEN emp_cursor(15);
    CLOSE emp_cursor;

    OPEN emp_cursor(20);
    CLOSE emp_cursor;

    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- Cursors with subqueries
DECLARE
    cursor my_cursor IS 
        SELECT t1.department_id, t1.department_name, t2.staff
        FROM    departments t1, (SELECT department_id, COUNT(*) AS staff
                                 FROM EMPLOYEES
                                 GROUP BY department_id) t2
        WHERE t1.department_id = t2.department_id
        AND   t2.staff >= 3;
BEGIN
    DBMS_OUTPUT.PUT_LINE('');
END;
/