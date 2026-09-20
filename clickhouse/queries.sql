-- A1: time analysis
SELECT loan_date, count() AS loans FROM libraryhub.loan_facts GROUP BY loan_date ORDER BY loan_date;
-- A2: top entities
SELECT book_id, count() AS borrow_count FROM libraryhub.loan_facts GROUP BY book_id ORDER BY borrow_count DESC LIMIT 10;
-- A3: grouped analysis
SELECT category, count() AS loans FROM libraryhub.loan_facts GROUP BY category ORDER BY loans DESC;
