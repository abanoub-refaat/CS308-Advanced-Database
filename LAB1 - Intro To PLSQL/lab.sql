SET SERVEROUTPUT ON;  -- by default is OFF so we need to activate it.

DECLARE 
    emp_hiredate date;
    x varchar(100);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, world ' || x);
    x := q'[Abanoub'S]';
    DBMS_OUTPUT.PUT_LINE('Hello, world ' || x); --CONCATINATION
END;
/

DECLARE
    sal employees.salary%type;
BEGIN 
    SELECT salary INTO sal 
    FROM employees
    WHERE last_name = 'Atkinson';
    DBMS_OUTPUT.PUT_LINE('The value of the salary of the employee is: ' || sal); 
END;
/
