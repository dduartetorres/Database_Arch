USE libraryhub;
-- C1: recent activity for one member
SELECT * FROM member_activity WHERE member_id='MEMBER-001' LIMIT 10;
-- C2: related history for one book
SELECT * FROM book_activity WHERE book_id='BOOK-001' LIMIT 10;
