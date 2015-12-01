SET SERVEROUTPUT ON;
DECLARE
co NUMBER(6,2);
BEGIN
SELECT count(*) INTO co FROM rectangle WHERE id=122;
if (co!=0) THEN
  UPDATE rectangle SET area = 400 WHERE id=122;
ELSE 
  DBMS_OUTPUT.PUT_LINE('id does not exist.');
END IF;

END;

--select * from rectangle;
