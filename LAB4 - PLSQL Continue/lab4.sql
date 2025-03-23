-- pl sql
-- variables
-- loops
-- data structure
-- sub programs (functions, processes)

-- parameters
-- types
-- default values
-- packages

SET SERVEROUTPUT ON;

--* out takes only the reference.
--* in out takes the value.
--* the default values are for the in parameters only.
create or REPLACE procedure proc(x in number default 3, y out number, z in out number) is
begin 
    y := 10;
    DBMS_OUTPUT.PUT_LINE(x);
end;
/

create or REPLACE procedure proc1(x1 NUMBER, x2 NUMBER, x3 NUMBER) is
begin 
    DBMS_OUTPUT.PUT_LINE('x1 ' || x1);
end;
/

DECLARE
 z NUMBER := 1;
 a NUMBER := 2;
BEGIN
    proc(1, z, a);
    DBMS_OUTPUT.PUT_LINE(z);
    -- pass by name
    proc1(x1 => 3, x3 => 3, x2 => 0);
end;
/

-- packages

CREATE or replace PACKAGE pk is
    var1 NUMBER;
    procedure proc(num1 NUMBER);
   -- FUNCTION fun(num1 NUMBER) return NUMBER;
end;
/

create or replace PACKAGE body pk is

    --! forward declaration
    FUNCTION fun(num1 number) return number;

    procedure proc(num1 NUMBER) is
    BEGIN 
        DBMS_OUTPUT.PUT_LINE(fun(num1));
    END;

    --! private function
    FUNCTION fun(num1 number) return number is
    BEGIN
        return num1 * 2;
    end;
end;
/

-- test pakages
BEGIN
    pk.proc(1);
end;
/