# SQL_Employee_management
A fully-featured Employee Management System built with MySQL designed to handle and streamline various aspects of organizational data. This system efficiently manages employee information, departmental structures, leave records, project assignments, and generates detailed reports for better decision-making and analysis.

## Features

- Employee Information Management
- Department and Position Tracking
- Leave Management System
- Project Assignment Tracking
- Comprehensive Reporting System

## Database Schema

The system includes the following main tables:
- Departments
- Positions
- Employees
- Leave Records
- Projects
- Project Assignments

## Installation

1. Install MySQL Workbench
2. Open MySQL Workbench and connect to your server
3. Open the `database/schema.sql` file
4. Execute the script to create the database and tables

```sql
source path/to/schema.sql
```

## Usage

### Basic Queries

```sql
-- Get all employees with their departments
SELECT * FROM employee_directory;

-- Get department statistics
CALL GetDepartmentStats();

-- Get employee leave history
CALL GetEmployeeLeaves(employee_id);
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
