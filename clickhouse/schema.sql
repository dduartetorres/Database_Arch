CREATE DATABASE IF NOT EXISTS libraryhub;
CREATE TABLE IF NOT EXISTS libraryhub.loan_facts (
 loan_date Date, loan_id UInt32, book_id String, category String, member_id UInt32, status String
) ENGINE=MergeTree ORDER BY (loan_date, category, book_id);
