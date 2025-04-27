-- When should a trigger fire?
-- before, after, instade of
INSERT INTO departments (department_id,department_name, location_id)
VALUES(400, 'CONSULTING', 2400);

-- We have trigger event:
-- Determines which DML statement causes the trigger to execute
-- trigger body:
-- Determines what action is performed


-- Creating a DML Statement Trigger:
CREATE OR REPLACE TRIGGER secure_emp
--timing
BEFORE INSERT
ON employees BEGIN
    IF(TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN')) OR
        (TO_CHAR(SYSDATE, 'HH23:MI') NOT BETWEEN '09:00' AND '18:00') THEN
        RAISE_APPLICATION_ERROR(-20500, 'You may inser into employees table only during business hours.');
    END IF;
END;
/

INSERT INTO EMPLOYEES (EMPLOYEE_ID, LAST_NAME, FIRST_NAME,email, hire_date, JOB_ID, SALARY, DEPARTMENT_ID)
VALUES (300, 'Smith', 'Rob', 'RSMITH', SYSDATE, 'IT_PROG', 4500, 60);

-- Using Conditional Predicates
CREATE OR REPLACE TRIGGER secure_emp BEFORE
INSERT OR UPDATE OR DELETE ON employees BEGIN
 IF (TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN')) OR
   (TO_CHAR(SYSDATE,'HH24') 
       NOT BETWEEN '08' AND '18') THEN
   IF DELETING THEN RAISE_APPLICATION_ERROR(
    -20502,'You may delete from EMPLOYEES table'||
           'only during business hours.');
   ELSIF INSERTING THEN RAISE_APPLICATION_ERROR(
    -20500,'You may insert into EMPLOYEES table'|| 
           'only during business hours.');
   ELSIF UPDATING('SALARY') THEN
    RAISE_APPLICATION_ERROR(-20503, 'You may update SALARY only during business hours.');
   ELSE RAISE_APPLICATION_ERROR(-20504,'You may
    update EMPLOYEES table only during normal hours.');
   END IF;
 END IF;
END;
/

CREATE OR REPLACE TRIGGER restrict_salary
BEFORE INSERT OR UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
  IF NOT (:NEW.job_id IN ('AD_PRES', 'AD_VP'))
     AND :NEW.salary > 15000 THEN
    RAISE_APPLICATION_ERROR (-20202,
      'Employee cannot earn more than $15,000.');
  END IF;
END;
/

-- it should not be allowed.
UPDATE employees
SET salary = 15500
WHERE last_name = 'Russell';

-- OLD and NEW Qualifires
CREATE OR REPLACE TRIGGER audit_emp_values
AFTER DELETE OR INSERT OR UPDATE ON employees
FOR EACH ROW
BEGIN
  INSERT INTO audit_emp(user_name, time_stamp, id,
    old_last_name, new_last_name, old_title,
    new_title, old_salary, new_salary)
  VALUES (USER, SYSDATE, :OLD.employee_id,
    :OLD.last_name, :NEW.last_name, :OLD.job_id,
    :NEW.job_id, :OLD.salary, :NEW.salary);
END;
/

CREATE OR REPLACE TRIGGER derive_commission_pct
BEFORE INSERT OR UPDATE OF salary ON employees
FOR EACH ROW
WHEN (NEW.job_id = 'SA_REP')
BEGIN
 IF INSERTING THEN
   :NEW.commission_pct := 0;
 ELSIF :OLD.commission_pct IS NULL THEN
   :NEW.commission_pct := 0;
 ELSE 
   :NEW.commission_pct := :OLD.commission_pct+0.05;
 END IF;
END;
/

ALTER TRIGGER secure_emp DISABLE;

ALTER TABLE EMPLOYEES DISABLE ALL TRIGGERS;

ALTER TRIGGER restrict_salary COMPILE;

DROP TRIGGER secure_emp;
