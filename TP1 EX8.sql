DROP TABLE customer_loan;
CREATE TABLE customer_loan(
custo_number NUMBER(16,2) PRIMARY KEY,
custo_name  VARCHAR2(50),
amount_loan_taken NUMBER(16,2),
date_loan_taken DATE);

DROP TABLE interest_loan;
CREATE TABLE interest_loan(
custo_number NUMBER(16,2) PRIMARY KEY,
interest_one_year NUMBER(32),
interest_two_years NUMBER(32),
interest_three_years NUMBER(32),
interest_four_years NUMBER(32),
interest_five_years NUMBER(32));

INSERT INTO customer_loan VALUES(1123,'ZENG Yuhao', 6000, NULL);
INSERT INTO customer_loan VALUES(1124,'IKEDA Enzo', 2500, NULL);

--select * from customer_loan;

SET SERVEROUTPUT ON;
DECLARE
nb_customer NUMERIC(16);

BEGIN
SELECT COUNT(*) INTO nb_customer FROM customer_loan;

FOR idx IN 1..nb_customer
LOOP
    SELECT custo_number, amount_loan_taken INTO custo_id, loan FROM customer_loan;
    
    INSERT INTO interest_loan VALUES(custo_id, NULL, NULL, NULL, NULL, NULL);
    
    FOR nb_years IN 1..5 
    LOOP
        IF (nb_years<=3) THEN
          amount_interest := loan * 0.05 * nb_years;
       ELSE
         interest_past := loan * 0.05 * 3;  --interest of first 3 years;
         loan := loan + amount_interest; --laon of first 3 years;
         amount_interest := loan* 0.05 * (nb_years-3); -- interest of last 2 years;
         amount_interest := amount_interest + interest_past;
        END IF;
      
       IF (nb_years = 1) THEN
          UPDATE interest_loan SET interest_one_year = amount_interest WHERE custo_number = custo_id;
       ELSIF (nb_years = 2) THEN
          UPDATE interest_loan SET interest_two_year = amount_interest WHERE custo_number = custo_id;
       ELSIF (nb_years = 3) THEN
          UPDATE interest_loan SET interest_three_year = amount_interest WHERE custo_number = custo_id;
       ELSIF (nb_years = 4) THEN
          UPDATE interest_loan SET interest_four_year = amount_interest WHERE custo_number = custo_id;
       ELSIF (nb_years = 5) THEN
          UPDATE interest_loan SET interest_five_year = amount_interest WHERE custo_number = custo_id; 
       END IF;
    END LOOP; --loop y
END LOOP; --loop idx


END;