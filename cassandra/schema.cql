CREATE KEYSPACE IF NOT EXISTS libraryhub WITH replication = {'class':'SimpleStrategy','replication_factor':1};
USE libraryhub;
CREATE TABLE IF NOT EXISTS member_activity (
 member_id text, event_time timestamp, event_id text, event_type text, book_id text, details text,
 PRIMARY KEY ((member_id), event_time, event_id)
) WITH CLUSTERING ORDER BY (event_time DESC);
CREATE TABLE IF NOT EXISTS book_activity (
 book_id text, event_time timestamp, event_id text, event_type text, member_id text, details text,
 PRIMARY KEY ((book_id), event_time, event_id)
) WITH CLUSTERING ORDER BY (event_time DESC);
INSERT INTO member_activity VALUES ('MEMBER-001','2026-09-20 10:00:00','evt-1','BOOK_VIEWED','BOOK-001','technical search');
INSERT INTO member_activity VALUES ('MEMBER-001','2026-09-20 11:00:00','evt-2','BOOK_BORROWED','BOOK-001','copy 101');
INSERT INTO member_activity VALUES ('MEMBER-001','2026-09-21 09:00:00','evt-3','REVIEW_POSTED','BOOK-001','five stars');
INSERT INTO book_activity VALUES ('BOOK-001','2026-09-20 10:00:00','evt-1','BOOK_VIEWED','MEMBER-001','technical search');
INSERT INTO book_activity VALUES ('BOOK-001','2026-09-20 11:00:00','evt-2','BOOK_BORROWED','MEMBER-001','copy 101');
