-- Procedures: are a type of subprogram that performs an action.
CREATE OR REPLACE PROCEDURE raise_sal (
   id      IN EMPLOYEES.EMPLOYEE_ID%TYPE,
   precent IN NUMBER
) IS
BEGIN
   UPDATE EMPLOYEES
   SET salary = salary * ( 1 + precent / 100 )
   WHERE employee_id = id;
END raise_sal;
/
-- executing a procedure:
EXECUTE RAISE_SAL(176, 10);

CREATE OR REPLACE PROCEDURE query_emp (
   id     IN EMPLOYEES.EMPLOYEE_ID%TYPE,
   emp_name   OUT EMPLOYEES.LAST_NAME%TYPE,
   salary OUT EMPLOYEES.SALARY%TYPE
) IS
BEGIN
   SELECT last_name, salary INTO emp_name, salary
   FROM employees
   WHERE employee_id = id;
END;
/

SET SERVEROUTPUT ON;

DECLARE
   emp_name EMPLOYEES.LAST_NAME%TYPE;
   emp_sal EMPLOYEES.SALARY%TYPE;
BEGIN
   QUERY_EMP(171, emp_name, emp_sal);
   DBMS_OUTPUT.PUT_LINE(emp_name || ' ' || emp_sal);
END;
/

CREATE OR REPLACE PROCEDURE format_phone
   (phone_no IN OUT VARCHAR2) IS
BEGIN
   phone_no := '(' || SUBSTR(phone_no, 1, 3) ||
               ')' || SUBSTR(phone_no, 4, 3) ||
               '-' || SUBSTR(phone_no, 7);
END;
/

CREATE OR REPLACE PROCEDURE add_dept(
   name IN departments.department_name%TYPE := 'UNKNOWN',
   loc  IN departments.location_id%TYPE DEFAULT 1700
) IS
BEGIN
   INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID)
   VALUES (DEPARTMENTS_SEQ.nextval, name, loc);
END;
/

-- passing parameters by position:
EXECUTE ADD_DEPT('TRAINING', 2500);

-- passing parameters by name:
EXECUTE ADD_DEPT(loc => 2400, name => 'EDUCATION');

-- Invoking Procedures

CREATE OR REPLACE PROCEDURE process_employees IS
   CURSOR emp_cursor IS
    SELECT employee_id
    FROM EMPLOYEES;
BEGIN
   FOR emp_rec IN emp_cursor
   LOOP
      raise_sal(emp_rec.employee_id, 10);
   END LOOP;
   COMMIT;
END;
/

DROP PROCEDURE raise_sal;