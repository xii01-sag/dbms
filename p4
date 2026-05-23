CREATE DATABASE COMPANY04;
USE COMPANY04;

CREATE TABLE CUSTOMERS (
    ID Int Primary key Auto_Increment,
    NAME varchar(255),
    AGE int,
    ADDRESS varchar(255),
    SALARY decimal(10, 2)
);

DELIMITER //
CREATE TRIGGER after_insert_salary_difference
AFTER INSERT ON CUSTOMERS
FOR EACH ROW
BEGIN
    SET @my_sal_diff = CONCAT('salary inserted is ', NEW.SALARY);
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_update_salary_difference
AFTER UPDATE ON CUSTOMERS
FOR EACH ROW
BEGIN
    DECLARE old_salary Decimal(10, 2);
    DECLARE new_salary Decimal(10, 2);
    SET old_salary = OLD.SALARY;
    SET new_salary = NEW.SALARY;
    SET @my_sal_diff = CONCAT('salary difference after update is ', new_salary - old_salary);
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_delete_salary_difference
AFTER DELETE ON CUSTOMERS
FOR EACH ROW
BEGIN
    SET @my_sal_diff = CONCAT('salary deleted is ', OLD.SALARY);
END; //
DELIMITER ;

INSERT INTO CUSTOMERS (Name, Age, Address, Salary)
VALUES ('shankar', 35, '123 Main St', 50000.00);
SELECT @my_sal_diff AS sal_diff;

UPDATE CUSTOMERS SET Salary = 55000.00 WHERE ID = 1;
SELECT @my_sal_diff AS sal_diff;

DELETE FROM CUSTOMERS WHERE ID = 1;
SELECT @my_sal_diff AS sal_diff;
