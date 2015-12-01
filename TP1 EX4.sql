SET SERVEROUPUT ON;
DECLARE 
youngest DATE;
oldest DATE;
BEGIN
SELECT MIN(ms_birthdate) INTO youngest FROM moviestar;
SELECT MAX(ms_birthdate) INTO oldest FROM moviestar;
DBMS_OUTPUT.PUT_LINE('Birthdate of the youngest moviestar: '||to_char(youngest,'dd-MON-yyyy'));
DBMS_OUTPUT.PUT_LINE('Birthdate of the oldest moviestar: '||to_char(oldest,'dd-MON-yyyy'));
END;