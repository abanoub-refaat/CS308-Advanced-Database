-- Composet Datatypes

SET SERVEROUTPUT ON;

-- PL/SQL Records:
DECLARE
    TYPE emp_record_type IS RECORD
        (last_name  VARCHAR2(25),
         job_id     VARCHAR2(10),
         salary     NUMBER(8,2));
    
    emp_record emp_record_type;
BEGIN
    DBMS_OUTPUT.PUT_LINE('done');
END;
/

DEFINE employee_number = 124
    DECLARE 
        emp_rec     EMPLOYEES%ROWTYPE;
    BEGIN
        SELECT * INTO emp_rec FROM employees
        WHERE employee_id = &employee_number;

        INSERT INTO retired_emps(empno, ename, job, mgr, hiredate, leavedate, sal, comm, deptno)
        VALUES (emp_rec.employee_id, emp_rec.last_name, emp_rec.hiredate, SYSDATE, emp_rec.deprtment_id);
    END;
    /

-- PL/SQL INDEX BY TABLES

DECLARE
    TYPE dept_table_type IS TABLE OF 
      departments%ROWTYPE
      INDEX BY PLS_INTEGER;

    dept_table dept_table_type; -- Each element of dept_table is a record
BEGIN
    dept_table(15).location_id := 17000;
    DBMS_OUTPUT.PUT_LINE('');
END;
/

DECLARE
    -- type declaration 
    TYPE emp_table_type IS TABLE OF 
        EMPLOYEES%ROWTYPE INDEX BY PLS_INTEGER;
    
    -- an instance of the type
    my_emp_table  emp_table_type;
    max_count   NUMBER(3) := 104;
BEGIN
    -- for storing the values of the employees form id = 100 to id = 104
    FOR i IN 100 .. max_count
    LOOP
        SELECT * INTO my_emp_table(i) FROM employees
        WHERE employee_id = i;
    END LOOP;

    -- printing the values of the index by table
    FOR i IN my_emp_table.FIRST .. my_emp_table.LAST 
    LOOP
        DBMS_OUTPUT.PUT_LINE(my_emp_table(i).last_name);
    END LOOP;
END;
/

-- NESTED TABLES
DECLARE
    TYPE location_type IS TABLE OF locations.CITY%TYPE;
    offices location_type;
    table_count NUMBER;
BEGIN
    offices := location_type('Bombay', 'Tokyo', 'Singapore', 'Oxford');
    table_count := offices.count();

    FOR i IN 1 .. table_count LOOP
        DBMS_OUTPUT.PUT_LINE(offices(i));
    END LOOP;
END;
/

-- VARRAY
DECLARE
    TYPE location_type IS VARRAY(3) OF locations.CITY%TYPE;
    offices location_type;
BEGIN
    offices := location_type('Bombay', 'Tokyo', 'Singapore');

    FOR i IN 1 .. offices.count() LOOP
        DBMS_OUTPUT.PUT_LINE(offices(i));
    END LOOP;
END;
/