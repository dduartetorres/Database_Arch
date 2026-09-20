USE libraryhub;
DELIMITER //
CREATE PROCEDURE borrow_book(IN p_member_id INT, IN p_copy_id INT, IN p_due_days INT)
BEGIN
  DECLARE v_status VARCHAR(20);
  START TRANSACTION;
  SELECT status INTO v_status FROM copies WHERE copy_id = p_copy_id FOR UPDATE;
  IF v_status IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Copy does not exist';
  ELSEIF v_status <> 'AVAILABLE' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Copy is not available';
  ELSE
    UPDATE copies SET status = 'LOANED' WHERE copy_id = p_copy_id;
    INSERT INTO loans(member_id, copy_id, borrowed_at, due_date, status)
      VALUES (p_member_id, p_copy_id, NOW(), DATE_ADD(CURDATE(), INTERVAL p_due_days DAY), 'ACTIVE');
    COMMIT;
  END IF;
END//
DELIMITER ;
