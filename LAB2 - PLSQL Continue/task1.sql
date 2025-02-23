 -- Check if a given numer is divisible by 3 or 5 or both.
DECLARE 
    x NUMBER := &x;
BEGIN
    if x mod 3 = 0 and x mod 5 = 0 then
        DBMS_OUTPUT.PUT_LINE(x ||' is divisable by Both');
    elsif x mod 3 = 0 then
        DBMS_OUTPUT.PUT_LINE(x || ' is Divisable by 3 only');
    elsif x mod 5 = 0 then
        DBMS_OUTPUT.PUT_LINE(x || ' is Divisable by 5 only');
    else
        DBMS_OUTPUT.PUT_LINE(x || ' is NOT DIVISABLE BY 5 NOR 3');
    end if;
END;