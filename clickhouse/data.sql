-- One row per statement: clickhouse-client ends inline INSERT data at the end of the line when running scripts.
INSERT INTO libraryhub.loan_facts VALUES ('2026-09-10',1,'BOOK-001','Technical',1,'ACTIVE');
INSERT INTO libraryhub.loan_facts VALUES ('2026-09-11',2,'BOOK-002','Technical',2,'RETURNED');
INSERT INTO libraryhub.loan_facts VALUES ('2026-09-12',3,'BOOK-003','Fiction',3,'RETURNED');
INSERT INTO libraryhub.loan_facts VALUES ('2026-09-15',4,'BOOK-001','Technical',2,'RETURNED');
INSERT INTO libraryhub.loan_facts VALUES ('2026-09-18',5,'BOOK-004','Children',1,'RETURNED');
INSERT INTO libraryhub.loan_facts VALUES ('2026-09-20',6,'BOOK-001','Technical',3,'ACTIVE');
