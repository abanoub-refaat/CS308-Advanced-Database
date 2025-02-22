SET SERVEROUTPUT ON;

<<outer>> -- identifer
DECLARE 
    father_name     VARCHAR(20) := 'Patrick';
    date_of_birth   DATE := '20-Apr-1972';
BEGIN
    DECLARE
        child_name      VARCHAR(20) := 'Mike';
        date_of_birth   DATE := '12-Dec-2002';
    BEGIN
        DBMS_OUTPUT.PUT_LINE(q'[Father's Name :]' || father_name);
        DBMS_OUTPUT.PUT_LINE('Date of birth: ' || outer.date_of_birth); -- child since it is in the scope
        DBMS_OUTPUT.PUT_LINE(q'[Child's Name: ]' || child_name);
        DBMS_OUTPUT.PUT_LINE('Date of birth: ' || date_of_birth); -- child since it is in the scope
    END;
END;
/

<<outer>>
DECLARE
    myName     VARCHAR(20) := 'Abanoub';
BEGIN
    DECLARE
        myName  VARCHAR(20) := 'Bebo';
        hisName VARCHAR(20) := 'Bob';
    BEGIN
        DBMS_OUTPUT.PUT_LINE(myName); -- Bebo
        DBMS_OUTPUT.PUT_LINE(outer.myName); -- Abanoub
    END;
    DBMS_OUTPUT.PUT_LINE(hisName); -- Error: hisName must be declared
END;
/