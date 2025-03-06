SET SERVEROUTPUT ON;

DECLARE 
    emp_name    VARCHAR2(20) DEFAULT 'Bebo';
BEGIN
    DBMS_OUTPUT.PUT_LINE('My name is: ' || emp_name);

    -- redeclaration for emp_name
    emp_name := 'Abanoub';
    DBMS_OUTPUT.PUT_LINE('My name is: ' || emp_name);
END;

---- 

DECLARE
    event VARCHAR2(20);
BEGIN
    event := q'[Mother's day]';
    DBMS_OUTPUT.PUT_LINE('2nd Sunday in May is: ' || event);
END;

---

VARIABLE emp_salary NUMBER -- Global variable
BEGIN 
    SELECT salary INTO :emp_salary
    FROM   employees
    WHERE  EMPLOYEE_ID = 178;
END;

---

<<outer>>
DECLARE
    test_variable VARCHAR2(20) := 'Global variable';
BEGIN
    DECLARE 
        test_variable VARCHAR2(20) :='local variable';
    BEGIN
        DBMS_OUTPUT.PUT_LINE(test_variable);
        DBMS_OUTPUT.PUT_LINE(outer.test_variable); -- Global variable
    END;
    DBMS_OUTPUT.PUT_LINE(outer.test_variable);
END;

-- validation:
-- valid := (emp_num IS NOT NULL);