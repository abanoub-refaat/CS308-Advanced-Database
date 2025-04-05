-- Functions: are a named PL/SQL block that returns a value.

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION get_sal
    (id EMPLOYEES.EMPLOYEE_ID%TYPE) RETURN NUMBER IS 
    sal EMPLOYEES.SALARY%type := 0;
BEGIN
    SELECT salary
    INTO sal
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = id;
    RETURN sal;
END;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(get_sal(100));

CREATE OR REPLACE FUNCTION tax(value IN NUMBER) RETURN NUMBER IS
BEGIN
    RETURN (value * 0.08);
END;
/

DROP FUNCTION get_sal;
