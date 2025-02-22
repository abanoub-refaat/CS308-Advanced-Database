SET SERVEROUTPUT ON;

DBMS_OUTPUT.PUT_LINE('THE FIRST NAME OF THE EMPLOYEE IS: ' || F_NAME);

DECLARE 
    emp_hiredate    DATE;
    my_name         VARCHAR2(29); -- strings
    emp_deptno      NUMBER(2) NOT NULL := 10; -- numbers
    location        VARCHAR(13) := 'Atlantaa'; 
    c_com           CONSTANT NUMBER DEFAULT 1400; -- constants with default declaration
BEGIN
    DBMS_OUTPUT.PUT_LINE('my name is: ' || my_name);
    my_name := 'John';
    DBMS_OUTPUT.PUT_LINE('my name is: ' || my_name);
END;

DECLARE 
    event      VARCHAR(20);
BEGIN
    event := q'!Father's Day!';
    DBMS_OUTPUT.PUT_LINE('3rd Sunday in Jun is ' || event);
    event := q'[Mother's Day]';
    DBMS_OUTPUT.PUT_LINE('2nd Sunday in May is ' || event);
END;