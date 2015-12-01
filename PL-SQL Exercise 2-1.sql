--PL/SQL Exercise 2
--Problem 1
SET SERVEROUTPUT ON;
DECLARE
	i NUMBER;
	j NUMBER;
	rslt NUMBER;
BEGIN
	j:=8;
	FOR i IN 1..10 LOOP
		rslt:=i*j;
		DBMS_OUTPUT.PUT_LINE(i||' '||j||' '||rslt||' ');
	END LOOP;
END;


--Problem 2
--(sript to create table)
DECLARE
	i NUMBER;
	J NUMBER;
	rslt NUMBER;
	
BEGIN
	j:=8;
	FOR i IN 1..20 LOOP
		rslt:=i*j;
		INSERT INTO multiplication_table VALUES(i, j, rslt);
	END LOOP;
END;



--Problem 3
DECLARE 
	CURSOR mycur IS SELECT * FROM multiplication_table FOR UPDATE;
	line_rec mycur%ROWTYPE;
BEGIN
	IF NOT mycur%ISOPEN THEN
		OPEN mycur;
	END IF;
	LOOP
		FETCH mycur INTO line_rec;
		EXIT WHEN mycur%NOTFOUND;
		line_rec.multiplier:=7;
		line_rec.result:= line_rec.tab_number * line_rec.multiplier;
		UPDATE multiplication_table SET result=line_rec.result, multiplier=line_rec.multiplier WHERE CURRENT OF mycur;
	END LOOP;
	CLOSE mycur;
	
	IF NOT mycur%ISOPEN THEN
		OPEN mycur;
	END IF;
	LOOP
		FETCH mycur INTO line_rec;
		EXIT WHEN mycur%NOTFOUND;
		IF (line_rec.tab_number mod 2!=0) THEN
			DELETE FROM multiplication_table WHERE CURRENT OF mycur;
		END IF;
	END LOOP;
END;


--Problem 4
SET SERVEROUTPUT ON;
DECLARE
	nb_female NUMBER;
  age NUMBER;
	CURSOR mycur IS SELECT ms_id, ms_name, ms_birthdate FROM moviestar;
	line_rec mycur%ROWTYPE;
	-- ..:= EXTRACT(YEAR FROM ..)
BEGIN
	SELECT COUNT(*) INTO nb_female FROM moviestar WHERE ms_gender='F';
	DBMS_OUTPUT.PUT_LINE('The number of females is: '||nb_female);
	IF NOT mycur%ISOPEN THEN
		OPEN mycur;
	END IF;
	LOOP
		FETCH mycur INTO line_rec;
		EXIT WHEN mycur%NOTFOUND;
		age:= EXTRACT(YEAR FROM sysdate) - EXTRACT(YEAR FROM line_rec.ms_birthdate);
		DBMS_OUTPUT.PUT_LINE('id: '||line_rec.ms_id||';   name: '||line_rec.ms_name||'  age: '||age||';');
	END LOOP;
	CLOSE mycur;
END;

--Problem 5
--script to create tables;
SET SERVEROUTPUT ON;
DECLARE
	profit_made NUMBER;
	CURSOR cur_basicinfo IS SELECT X.drug_id, X.drug_name, X.QTY_ORDERED, X.UNIT_PURCHASE_PRICE, Y.QTY_SOLD, Y.UNIT_SALE_PRICE FROM pharmacy_purchases X, pharmacy_sales Y
	WHERE X.drug_id=Y.drug_id FOR UPDATE;
	rec_cur_basicinfo cur_basicinfo%ROWTYPE;
	
	CURSOR cur_notsold IS SELECT X.drug_id, X.drug_name FROM pharmacy_purchases X, pharmacy_sales Y
	WHERE X.drug_id=Y.drug_id AND Y.qty_sold=0  FOR UPDATE;
	rec_cur_notsold cur_notsold%ROWTYPE;
		
	CURSOR cur_outofstock IS SELECT X.drug_id, X.drug_name FROM pharmacy_purchases X, pharmacy_sales Y
	WHERE X.drug_id=Y.drug_id AND X.qty_ordered=Y.qty_sold FOR UPDATE;
	rec_cur_outofstock cur_outofstock%ROWTYPE;
BEGIN	
	DBMS_OUTPUT.PUT_LINE('*************** Basic Information ***************');
	IF NOT cur_basicinfo%ISOPEN THEN
		OPEN cur_basicinfo;
	END IF;
	LOOP
		FETCH cur_basicinfo INTO rec_cur_basicinfo;
		EXIT WHEN cur_basicinfo%NOTFOUND;
		profit_made:=rec_cur_basicinfo.qty_sold *
						(rec_cur_basicinfo.unit_sale_price - rec_cur_basicinfo.unit_purchase_price);
		DBMS_OUTPUT.PUT_LINE('##'||rec_cur_basicinfo.drug_name||'##   ##'||rec_cur_basicinfo.drug_id||'##');
		DBMS_OUTPUT.PUT_LINE('----Purchased: '||rec_cur_basicinfo.qty_ordered);
		DBMS_OUTPUT.PUT_LINE('----Sold: '||rec_cur_basicinfo.qty_sold);
		DBMS_OUTPUT.PUT_LINE('----Profit Made: '||profit_made);
	END LOOP;
	CLOSE cur_basicinfo;
	
	DBMS_OUTPUT.PUT_LINE('*************** Drugs not sold at all ***************');
	
	DBMS_OUTPUT.PUT_LINE('*************** Drugs out of stock ***************');
END;



--Problem 6
DECLARE
    total course_marks.total_marks%TYPE;
    grad course_marks.grade%TYPE;
    CURSOR mycur IS SELECT * FROM course_marks FOR UPDATE;
    rec_mycur mycur%ROWTYPE;
BEGIN
    IF NOT mycur%ISOPEN THEN
        OPEN mycur;
    END IF;
    LOOP
        FETCH mycur INTO rec_mycur;
        EXIT WHEN mycur%NOTFOUND;
        
        total:= rec_mycur.quiz_marks + rec_mycur.a1_marks  
                                + rec_mycur.a2_marks + rec_mycur.final_exam;
    
                
        IF total>80 AND total<=100 THEN 
            grad:='A+';
        ELSIF total>70 AND total<=79 THEN
            grad:='A';
        ELSIF total>67 AND total<=69 THEN 
            grad:='A-';
        ELSIF total>63 AND total<=66 THEN
            grad:='B+';
        ELSIF total>60 AND total<=62 THEN 
            grad:='B';
        ELSIF total>57 AND total<=59 THEN
            grad:='B-';
        ELSIF total>47 AND total<=56 THEN 
            grad:='C';
        ELSIF total>40 AND total<=46 THEN
            grad:='D';
        ELSE 
            grad:='F';
        END IF;
        
        UPDATE course_marks SET total_marks=total, grade=grad WHERE CURRENT OF mycur;
    END LOOP;
    CLOSE mycur;
END;


--Problem 7
DECLARE
    total course_marks.total_marks%TYPE;
    grad course_marks.grade%TYPE;
    CURSOR mycur IS SELECT * FROM course_marks FOR UPDATE;
    rec_mycur mycur%ROWTYPE;
BEGIN
    IF NOT mycur%ISOPEN THEN
        OPEN mycur;
    END IF;
    LOOP
        FETCH mycur INTO rec_mycur;
        EXIT WHEN mycur%NOTFOUND;
        
        total:= rec_mycur.quiz_marks + rec_mycur.a1_marks  
                                + rec_mycur.a2_marks + rec_mycur.final_exam;
    
        CASE 
        WHEN total>80 AND total<=100 THEN 
            grad:='A+';
        WHEN total>70 AND total<=79 THEN
            grad:='A';
        WHEN total>67 AND total<=69 THEN 
            grad:='A-';
        WHEN total>63 AND total<=66 THEN
            grad:='B+';
        WHEN total>60 AND total<=62 THEN 
            grad:='B';
        WHEN total>57 AND total<=59 THEN
            grad:='B-';
        WHEN total>47 AND total<=56 THEN 
            grad:='C';
        WHEN total>40 AND total<=46 THEN
            grad:='D';
        ELSE 
            grad:='F';
        END CASE;
        
        UPDATE course_marks SET total_marks=total, grade=grad WHERE CURRENT OF mycur;
    END LOOP;
    CLOSE mycur;
END;

--Problem 8
SET SERVEROUTPUT ON;
DECLARE 
    CURSOR cur_bookbase IS SELECT * FROM book_base;
    rec_cur_bookbase cur_bookbase%ROWTYPE;
    nb_times_borrowed NUMBER;
    max_day_borrowed NUMBER;
    min_day_borrowed NUMBER;
    
BEGIN
    --determine the usage of each and every book by listing each book
    --how many times it was borrowed, minimum days of usage by the borrowers
    --maximum days of usages by the borrowers
    IF NOT cur_bookbase%ISOPEN THEN 
        OPEN cur_bookbase;
    END IF;
    LOOP
        FETCH cur_bookbase INTO rec_cur_bookbase;
        EXIT WHEN cur_bookbase%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('##'||rec_cur_bookbase.title||'##   ##'||rec_cur_bookbase.book_id||'##');
        
        SELECT COUNT(*), MAX(EXTRACT(DAY FROM Y.actual_date_returned)-EXTRACT(DAY FROM Y.date_borrowed)),
              MIN(EXTRACT(DAY FROM Y.actual_date_returned)-EXTRACT(DAY FROM Y.date_borrowed))
        INTO nb_times_borrowed, max_day_borrowed, min_day_borrowed FROM bookbase X, books_borrowed Y 
        WHERE X.book_id=Y.book_id;
        
        DBMS_OUTPUT.PUT_LINE('---- Times borrowed: '||nb_times_borrowed);
        DBMS_OUTPUT.PUT_LINE('---- Max days borrowed: '||max_day_borrowed);
        DBMS_OUTPUT.PUT_LINE('---- Min days borrowed: '||min_day_borrowed);
    END LOOP;
    CLOSE cur_bookcase;
END;