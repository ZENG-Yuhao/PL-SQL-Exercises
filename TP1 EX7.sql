SET SEVEROUTPUT ON;
DECLARE
  tt NUMBER(16,4);
  initv NUMBER(16,4);
  accelero NUMBER(16,4);
  distance NUMBER(16,4);
BEGIN
  tt :=600;
  initv := 5;
  accelero := 10;
  distance := initv*tt + 0.5*accelero*tt*tt;
  DBMS_OUTPUT.PUT_LINE('The distance is:'||distance);
END;