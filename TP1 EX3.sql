SET SERVEROUTPUT ON;
DECLARE
time1 DATE;
time2 DATE;
BEGIN
time1 := SYSDATE;
DBMS_LOCK_SLEEP(10);
time2 := SYSDATE;
DBMS_OUTPUT.PUT_LINE('The time between the two instants is'|| (time2-time1));
END;