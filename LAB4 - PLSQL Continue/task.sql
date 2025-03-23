SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE task_pk1 IS
    procedure proc;
    FUNCTION fun(n NUMBER) RETURN NUMBER;
END;
/

CREATE OR REPLACE PACKAGE BODY task_pk1 IS

    PROCEDURE proc IS 
    BEGIN
        FOR emp_record IN (
            SELECT e.last_name name, d.department_name dep_name, m.last_name m_name
            FROM EMPLOYEES e 
            JOIN DEPARTMENTS d 
            ON   e.DEPARTMENT_ID = d.DEPARTMENT_ID
            JOIN EMPLOYEES m
            ON   e.MANAGER_ID = m.EMPLOYEE_ID
            ) LOOP
        DBMS_OUTPUT.PUT_LINE(emp_record.name || ' ' || emp_record.dep_name || ' ' || emp_record.m_name);
        END LOOP;
    END;

    FUNCTION fun(n NUMBER) RETURN NUMBER IS
    BEGIN
        IF n = 0 THEN 
            RETURN 1;
        END IF;
        RETURN(n * fun(n - 1));
    END;
END;
/

-- test task_pk1
BEGIN
    TASK_PK1.PROC;
    DBMS_OUTPUT.PUT_LINE(TASK_PK1.FUN(5));
END;
/

BEGIN
    FOR emp_record IN (
        SELECT e.last_name name, d.department_name dep_name, m.last_name m_name
        FROM EMPLOYEES e 
        JOIN DEPARTMENTS d 
        ON   e.DEPARTMENT_ID = d.DEPARTMENT_ID
        JOIN EMPLOYEES m
        ON   e.MANAGER_ID = m.EMPLOYEE_ID
        ) LOOP
    DBMS_OUTPUT.PUT_LINE(emp_record.name || ' ' || emp_record.dep_name || ' ' || emp_record.m_name);
    END LOOP;
END;
/