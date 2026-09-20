USE libraryhub;
-- M1: individual record
SELECT * FROM members WHERE member_id = 1;
-- M2: member history
SELECT * FROM loans WHERE member_id = 1 ORDER BY borrowed_at DESC;
-- M3: join
SELECT l.loan_id, m.name, b.title, l.status, l.borrowed_at
FROM loans l JOIN members m ON m.member_id=l.member_id
JOIN copies c ON c.copy_id=l.copy_id JOIN books b ON b.book_id=c.book_id;
-- M4/M5: transaction and consistency; procedure succeeds for copy 102, then second call fails
SELECT copy_id,status FROM copies WHERE copy_id=102;
CALL borrow_book(2,102,14);
SELECT copy_id,status FROM copies WHERE copy_id=102;
CALL borrow_book(3,102,14);
-- M6: stored procedure result
SELECT loan_id,member_id,copy_id,status FROM loans WHERE copy_id=102;
