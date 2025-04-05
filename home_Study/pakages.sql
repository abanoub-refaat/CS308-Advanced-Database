-- create a pakage: (like an interface)
CREATE OR REPLACE PACKAGE comm_pkg IS 
    std_comm NUMBER := 0.10; 
    PROCEDURE reset_comm(new_comm NUMBER);
END;
/

-- create a pakage body:
CREATE OR REPLACE PACKAGE BODY comm_pkg IS
    FUNCTION validate (comm NUMBER) RETURN BOOLEAN IS
        max_comm employees.commission_pct%TYPE;
    BEGIN
        SELECT MAX(commission_pct) iNTO max_comm
        FROM employees;
        RETURN (comm BETWEEN 0.0 AND max_comm);
    END;

    PROCEDURE reset_comm (new_comm NUMBER) IS
    BEGIN
        IF validate(new_comm) THEN
            std_comm := new_comm;
        ELSE raise_application_error(-20210, 'Bad Commission');
        END IF;
    END;
END;
/

EXECUTE comm_pkg.reset_comm(0.15);

DROP PACKAGE comm_pkg;