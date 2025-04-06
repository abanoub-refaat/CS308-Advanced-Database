SET SERVEROUTPUT ON;

CREATE PROCEDURE add_department (
    name VARCHAR2, mgr NUMBER, loc NUMBER
) IS
BEGIN 
    INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
    VALUES (DEPARTMENTS_SEQ.nextval, name, mgr, loc);
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Err: adding dept: ' || name);
END;
/

-- define a user-made exception


DECLARE 
    input_date date := '&date';
    num NUMBER;
    ex EXCEPTION;
BEGIN
    IF input_date >= sysdate THEN
        RAISE ex;
    END IF;

    SELECT COUNT(*) INTO num FROM EMPLOYEES
    WHERE input_date > hire_date;

    DBMS_OUTPUT.PUT_LINE(num);

EXCEPTION 
    WHEN ex THEN
        DBMS_OUTPUT.PUT_LINE('invalid date ya 2lby');
END;
/