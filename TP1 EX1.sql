SET SERVEROUTPUT ON;
DECLARE
average NUMBER(6,2);
BEGIN
SELECT AVG(mo_length) INTO average FROM movie WHERE mo_genre='action-adventure';
DBMS_OUTPUT.PUT_LINE('Average of length:'||average);
END;