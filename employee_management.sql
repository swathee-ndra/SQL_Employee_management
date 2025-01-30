-- Create Database
CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

-- Create Departments Table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    budget DECIMAL(15,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Create Positions Table
CREATE TABLE positions (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2)
) ENGINE=InnoDB;

-- Create Employees Table
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    position_id INT,
    department_id INT,
    salary DECIMAL(10,2) NOT NULL,
    manager_id INT,
    FOREIGN KEY (position_id) REFERENCES positions(position_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
) ENGINE=InnoDB;

-- Create Leave_Records Table
CREATE TABLE leave_records (
    leave_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    leave_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
) ENGINE=InnoDB;

-- Create Projects Table
CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(15,2),
    status ENUM('ACTIVE', 'COMPLETED', 'ON_HOLD') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- Create Project_Assignments Table
CREATE TABLE project_assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    employee_id INT,
    role VARCHAR(50),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
) ENGINE=InnoDB;

-- Insert Sample Data
INSERT INTO departments (department_name, location, budget) VALUES
('IT', 'Building A', 1000000.00),
('HR', 'Building B', 500000.00),
('Finance', 'Building A', 750000.00);

INSERT INTO positions (title, min_salary, max_salary) VALUES
('Software Engineer', 60000.00, 120000.00),
('HR Manager', 55000.00, 90000.00),
('Financial Analyst', 50000.00, 95000.00);

-- Create Views
CREATE VIEW employee_directory AS
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.email,
    d.department_name,
    p.title AS position,
    e.salary
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN positions p ON e.position_id = p.position_id;

-- Create Stored Procedures
DELIMITER //

CREATE PROCEDURE GetDepartmentStats()
BEGIN
    SELECT 
        d.department_name,
        COUNT(e.employee_id) as employee_count,
        ROUND(AVG(e.salary), 2) as avg_salary,
        MIN(e.salary) as min_salary,
        MAX(e.salary) as max_salary
    FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_name;
END //

CREATE PROCEDURE GetEmployeeLeaves(IN emp_id INT)
BEGIN
    SELECT 
        leave_type,
        start_date,
        end_date,
        status,
        DATEDIFF(end_date, start_date) + 1 as days
    FROM leave_records
    WHERE employee_id = emp_id
    ORDER BY start_date DESC;
END //

DELIMITER ;
