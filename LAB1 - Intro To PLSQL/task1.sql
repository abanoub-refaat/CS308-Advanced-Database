DECLARE
    emp_name VARCHAR(20);
    manag_name VARCHAR(20);
BEGIN
    SELECT e.last_name , m.last_name INTO emp_name, manag_name -- each select has one INTO cluase
    FROM Employees e
    JOIN Employees m 
    ON (e.manager_id = m.employee_id)
    WHERE e.employee_id = &id;
    DBMS_OUTPUT.PUT_LINE(q'[Employee's name is: ]' || emp_name || q'[ and his manager's name is ]' || manag_name); 
END;