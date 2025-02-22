SET SERVEROUTPUT ON;

VARIABLE employee_salary    NUMBER;
BEGIN
    SELECT salary INTO employee_salary
    FROM   EMPLOYEES 
    WHERE  employee_id = 178;
END;
/