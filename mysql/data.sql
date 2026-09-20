USE libraryhub;
INSERT INTO members VALUES
(1,'Ana Silva','ana@example.com','2026-09-01 09:00:00'),
(2,'Bruno Costa','bruno@example.com','2026-09-02 10:00:00'),
(3,'Carla Mendes','carla@example.com','2026-09-03 11:00:00');
INSERT INTO books VALUES
('BOOK-001','9780000000011','Distributed Systems in Practice','Technical'),
('BOOK-002','9780000000028','SQL Fundamentals','Technical'),
('BOOK-003','9780000000035','The Island of Stories','Fiction'),
('BOOK-004','9780000000042','Learning for Children','Children');
INSERT INTO copies VALUES
(101,'BOOK-001','GOOD','AVAILABLE'),(102,'BOOK-001','GOOD','AVAILABLE'),
(201,'BOOK-002','GOOD','AVAILABLE'),(301,'BOOK-003','GOOD','AVAILABLE'),(401,'BOOK-004','GOOD','AVAILABLE');
INSERT INTO loans(member_id,copy_id,borrowed_at,due_date,returned_at,status) VALUES
(1,101,'2026-09-10 10:00:00','2026-09-24',NULL,'ACTIVE'),
(2,201,'2026-09-11 12:00:00','2026-09-25','2026-09-18 09:00:00','RETURNED'),
(3,301,'2026-09-12 14:00:00','2026-09-26','2026-09-20 15:00:00','RETURNED');
UPDATE copies SET status='LOANED' WHERE copy_id=101;
