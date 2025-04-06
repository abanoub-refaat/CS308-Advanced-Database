SET SERVEROUTPUT ON;

-- variables
-- control statments
-- datastructure
-- proc, fun
-- exception handling
-- pakage
-- triggers: event drivin
-- schedules

CREATE or REPLACE TRIGGER tri1
before insert or delete or update on table_1
begin
    dbms_output.put_line('here in trigger');
end;
/

CREATE OR REPLACE TRIGGER test
after insert or delete or update on table_1
begin
    IF updating then
        DBMS_OUTPUT.PUT_LINE('after - updating');
    else if deleting THEN
        DBMS_OUTPUT.PUT_LINE('after - deleting');
        end if;
    end if;
end;
/

create table table_1 (
    id NUMBER PRIMARY KEY,
    name varchar2(30) not null
)
/

insert into TABLE_1 values(1, 'riad');
insert into TABLE_1 values(2, 'riad');

select * from TABLE_1;

create or REPLACE TRIGGER tr3
after delete on table_1
for each ROW
    -- :new, :old
BEGIN
    insert into table_2 values (:old.id, :old.name);
end;
/

-- insert multiple rows
insert into TABLE_1
select employee_id, last_name from EMPLOYEES
where employee_id BETWEEN 101 and 120;
