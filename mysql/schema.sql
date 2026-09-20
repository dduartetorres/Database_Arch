CREATE DATABASE IF NOT EXISTS libraryhub;
USE libraryhub;

CREATE TABLE members (
  member_id INT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(180) NOT NULL UNIQUE,
  created_at DATETIME NOT NULL
);

CREATE TABLE books (
  book_id VARCHAR(30) PRIMARY KEY,
  isbn VARCHAR(20) NOT NULL UNIQUE,
  title VARCHAR(255) NOT NULL,
  category VARCHAR(80) NOT NULL
);

CREATE TABLE copies (
  copy_id INT PRIMARY KEY,
  book_id VARCHAR(30) NOT NULL,
  copy_condition VARCHAR(30) NOT NULL DEFAULT 'GOOD',
  status ENUM('AVAILABLE','LOANED','MAINTENANCE') NOT NULL DEFAULT 'AVAILABLE',
  CONSTRAINT fk_copy_book FOREIGN KEY (book_id) REFERENCES books(book_id),
  INDEX idx_copies_book_status (book_id, status)
);

CREATE TABLE loans (
  loan_id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NOT NULL,
  copy_id INT NOT NULL,
  borrowed_at DATETIME NOT NULL,
  due_date DATE NOT NULL,
  returned_at DATETIME NULL,
  status ENUM('ACTIVE','RETURNED','OVERDUE') NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_loan_member FOREIGN KEY (member_id) REFERENCES members(member_id),
  CONSTRAINT fk_loan_copy FOREIGN KEY (copy_id) REFERENCES copies(copy_id),
  INDEX idx_loans_member_date (member_id, borrowed_at DESC),
  INDEX idx_loans_copy_status (copy_id, status)
);

DELIMITER //
CREATE TRIGGER prevent_duplicate_active_loan
BEFORE INSERT ON loans
FOR EACH ROW
BEGIN
  IF NEW.status IN ('ACTIVE','OVERDUE') AND EXISTS (
    SELECT 1 FROM loans WHERE copy_id = NEW.copy_id AND status IN ('ACTIVE','OVERDUE')
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Copy is already loaned';
  END IF;
END//
DELIMITER ;
