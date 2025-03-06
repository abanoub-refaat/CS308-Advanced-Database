SET SERVEROUTPUT ON;

DECLARE
    fname VARCHAR2(25);
BEGIN
    SELECT first_name INTO fname
    FROM   employees
    WHERE  employee_id = 200;
    DBMS_OUTPUT.PUT_LINE('First name is ' || fname);
END;
/
---

DECLARE
    emp_hiredate employees.hire_date%TYPE;
    emp_salary employees.salary%TYPE;
BEGIN
    SELECT hire_date, salary 
    INTO   emp_hiredate, emp_salary
    FROM   EMPLOYEES
    WHERE  employee_id = 100;

    DBMS_OUTPUT.PUT_LINE(emp_hiredate||' '|| emp_salary);
END;
/
---

BEGIN
    INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY)
    VALUES (EMPLOYEES_SEQ.nextval, 'Ruth', 'Cores', 'RCORES', sysdate, 'AD_ASST', 4000);
END;
/

-- Cursor: is a pointer to the private memory area allocated by the Oracle Server. 
-- Implicit cursors
-- Explicit cursors

---

DECLARE
    myage NUMBER := 31;
BEGIN
    IF myage < 11 
     THEN
        DBMS_OUTPUT.PUT_LINE('A child');
    ELSIF myage > 11 AND myage < 20 
     THEN
        DBMS_OUTPUT.PUT_LINE('A teenager');
    ELSE
        DBMS_OUTPUT.PUT_LINE('An adult');
    END IF;
END;
/

-- NULL > 1 IS NULL
-- NULL + 5 IS NULL
-- NOT NULL IS NULL
-- NULL = NULL IS NULL
-- NULL OR TRUE IS TRUE

---

DECLARE
    countryid LOCATIONS.COUNTRY_ID%TYPE := 'CA';
    loc_id  LOCATIONS.location_id%TYPE;
    counter NUMBER(2) := 1;
    new_city LOCATIONS.CITY%TYPE := 'Montreal';
BEGIN
    SELECT MAX(location_id) INTO loc_id
    FROM LOCATIONS
    WHERE country_id = countryid;

    LOOP
        INSERT INTO LOCATIONS(LOCATION_ID, CITY, COUNTRY_ID)
        VALUES ((loc_id + counter), new_city, countryid);
        counter := counter + 1;
        EXIT WHEN counter > 3;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;
/

---

