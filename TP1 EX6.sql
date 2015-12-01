SET SEVEROUTPUT ON;
DECLARE
  rslt NUMBER(6,4);
  x NUMBER(6,4);
BEGIN
  x := 45;
  rslt := sin(x)*sin(x)+cos(x)*cos(x);
  rslt := round(rslt);
  DBMS_OUTPUT.PUT_LINE('The result is:'||rslt);
END;