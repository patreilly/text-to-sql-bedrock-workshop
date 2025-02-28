-- Insert sample data for hr_reporting.employee_directory
-- This combines data from employee, departments, job_titles, and locations
INSERT INTO hr_reporting.employee_directory 
(employee_id, full_name, email, department_name, job_title, manager_name, location_city, location_country, is_remote, hire_date, current_salary) VALUES
(10001, 'John Smith', 'john.smith@company.com', 'Executive', 'Chief Executive Officer', NULL, 'Seattle', 'USA', FALSE, '2018-06-15 09:00:00', 250000.00),
(10002, 'Jane Doe', 'jane.doe@company.com', 'Human Resources', 'HR Director', 'John Smith', 'Seattle', 'USA', FALSE, '2019-03-12 08:30:00', 120000.00),
(10003, 'Michael Johnson', 'michael.johnson@company.com', 'Finance', 'Chief Financial Officer', 'John Smith', 'San Francisco', 'USA', FALSE, '2017-11-23 10:00:00', 190000.00),
(10004, 'Emily Williams', 'emily.williams@company.com', 'Human Resources', 'HR Manager', 'Jane Doe', 'Austin', 'USA', FALSE, '2020-01-07 09:15:00', 82000.00),
(10005, 'David Brown', 'david.brown@company.com', 'Information Technology', 'Chief Technology Officer', 'John Smith', 'Boston', 'USA', FALSE, '2018-09-30 08:45:00', 180000.00),
(10006, 'Sarah Miller', 'sarah.miller@company.com', 'Marketing', 'Marketing Specialist', 'John Smith', 'Chicago', 'USA', TRUE, '2019-07-14 09:30:00', 65000.00),
(10007, 'Robert Davis', 'robert.davis@company.com', 'Sales', 'Sales Representative', 'John Smith', 'Toronto', 'Canada', FALSE, '2021-02-28 10:15:00', 60000.00),
(10008, 'Jennifer Wilson', 'jennifer.wilson@company.com', 'Marketing', 'Marketing Manager', 'John Smith', 'London', 'UK', FALSE, '2018-05-17 09:45:00', 88000.00),
(10009, 'Thomas Taylor', 'thomas.taylor@company.com', 'Research and Development', 'Research Scientist', 'John Smith', NULL, NULL, TRUE, '2020-11-09 08:00:00', 82000.00),
(10010, 'Laura Martinez', 'laura.martinez@company.com', 'Sales', 'Sales Manager', 'John Smith', 'San Francisco', 'USA', FALSE, '2019-10-22 09:00:00', 92000.00),
(10011, 'James Anderson', 'james.anderson@company.com', 'Finance', 'Finance Manager', 'Michael Johnson', 'Seattle', 'USA', FALSE, '2017-08-01 10:30:00', 92000.00),
(10012, 'Patricia Thomas', 'patricia.thomas@company.com', 'Information Technology', 'Software Engineer', 'David Brown', 'Austin', 'USA', FALSE, '2021-04-15 09:30:00', 75000.00),
(10013, 'Mark Jackson', 'mark.jackson@company.com', 'Information Technology', 'Senior Software Engineer', 'David Brown', 'Boston', 'USA', FALSE, '2018-12-05 08:45:00', 95000.00),
(10014, 'Elizabeth White', 'elizabeth.white@company.com', 'Marketing', 'Marketing Specialist', 'John Smith', 'Chicago', 'USA', TRUE, '2020-06-18 10:00:00', 64000.00),
(10015, 'Richard Harris', 'richard.harris@company.com', 'Sales', 'Sales Representative', 'Laura Martinez', NULL, NULL, TRUE, '2019-09-03 09:15:00', 65000.00);

-- Insert sample data for hr_reporting.leave_summary
INSERT INTO hr_reporting.leave_summary 
(employee_id, full_name, department_name, leave_type_name, total_days_taken, last_leave_date, pending_requests) VALUES
-- Vacation leave summaries
(10001, 'John Smith', 'Executive', 'Vacation', 5, '2023-07-14', 0),
(10002, 'Jane Doe', 'Human Resources', 'Vacation', 12, '2023-09-01', 0),
(10003, 'Michael Johnson', 'Finance', 'Vacation', 5, '2023-05-26', 0),
(10004, 'Emily Williams', 'Human Resources', 'Vacation', 5, '2023-11-24', 1),
(10005, 'David Brown', 'Information Technology', 'Vacation', 12, '2023-06-16', 0),
(10006, 'Sarah Miller', 'Marketing', 'Vacation', 5, '2023-04-07', 0),
(10007, 'Robert Davis', 'Sales', 'Vacation', 5, '2023-08-11', 0),
(10008, 'Jennifer Wilson', 'Marketing', 'Vacation', 12, '2023-01-20', 0),
(10009, 'Thomas Taylor', 'Research and Development', 'Vacation', 12, '2023-08-04', 0),
(10010, 'Laura Martinez', 'Sales', 'Vacation', 5, '2023-05-19', 0),

-- Sick leave summaries
(10001, 'John Smith', 'Executive', 'Sick Leave', 0, NULL, 0),
(10002, 'Jane Doe', 'Human Resources', 'Sick Leave', 2, '2023-03-16', 0),
(10003, 'Michael Johnson', 'Finance', 'Sick Leave', 0, NULL, 0),
(10004, 'Emily Williams', 'Human Resources', 'Sick Leave', 3, '2023-02-10', 0),
(10005, 'David Brown', 'Information Technology', 'Sick Leave', 0, NULL, 0),
(10006, 'Sarah Miller', 'Marketing', 'Sick Leave', 3, '2023-10-18', 0),
(10012, 'Patricia Thomas', 'Information Technology', 'Sick Leave', 5, '2023-10-13', 0),
(10014, 'Elizabeth White', 'Marketing', 'Sick Leave', 5, '2023-03-10', 0),
(10011, 'James Anderson', 'Finance', 'Sick Leave', 2, '2023-09-12', 0),
(10015, 'Richard Harris', 'Sales', 'Sick Leave', 0, NULL, 0),

-- Personal and other leave types
(10003, 'Michael Johnson', 'Finance', 'Personal Leave', 1, '2023-10-09', 0),
(10009, 'Thomas Taylor', 'Research and Development', 'Personal Leave', 1, '2023-11-01', 0),
(10010, 'Laura Martinez', 'Sales', 'Family Medical Leave', 12, '2023-11-03', 0),
(10005, 'David Brown', 'Information Technology', 'Bereavement', 3, '2023-09-20', 0),
(10015, 'Richard Harris', 'Sales', 'Jury Duty', 5, '2023-09-29', 0),
(10008, 'Jennifer Wilson', 'Marketing', 'Unpaid Leave', 15, '2023-02-15', 0);

-- Insert sample data for hr_reporting.training_compliance
INSERT INTO hr_reporting.training_compliance 
(employee_id, full_name, department_name, job_title, total_courses_completed, last_completion_date, certifications_count) VALUES
(10001, 'John Smith', 'Executive', 'Chief Executive Officer', 4, '2022-06-17', 4),
(10002, 'Jane Doe', 'Human Resources', 'HR Director', 5, '2022-07-05', 5),
(10003, 'Michael Johnson', 'Finance', 'Chief Financial Officer', 5, '2022-06-20', 5),
(10004, 'Emily Williams', 'Human Resources', 'HR Manager', 4, '2022-02-15', 4),
(10005, 'David Brown', 'Information Technology', 'Chief Technology Officer', 6, '2021-01-15', 6),
(10006, 'Sarah Miller', 'Marketing', 'Marketing Specialist', 4, '2021-09-15', 4),
(10007, 'Robert Davis', 'Sales', 'Sales Representative', 4, '2022-02-18', 4),
(10008, 'Jennifer Wilson', 'Marketing', 'Marketing Manager', 5, '2020-06-18', 5),
(10009, 'Thomas Taylor', 'Research and Development', 'Research Scientist', 4, '2022-07-05', 4),
(10010, 'Laura Martinez', 'Sales', 'Sales Manager', 5, '2021-06-10', 5),
(10011, 'James Anderson', 'Finance', 'Finance Manager', 5, '2022-03-22', 5),
(10012, 'Patricia Thomas', 'Information Technology', 'Software Engineer', 4, '2022-05-15', 4),
(10013, 'Mark Jackson', 'Information Technology', 'Senior Software Engineer', 7, '2022-01-17', 7),
(10014, 'Elizabeth White', 'Marketing', 'Marketing Specialist', 4, '2021-11-22', 4),
(10015, 'Richard Harris', 'Sales', 'Sales Representative', 5, '2022-04-15', 5);

-- Insert sample data for hr_reporting.compensation_history
INSERT INTO hr_reporting.compensation_history 
(employee_id, full_name, department_name, job_title, salary_amount, previous_salary, change_percentage, change_date, change_reason) VALUES
-- Initial compensation entries (first salary)
(10001, 'John Smith', 'Executive', 'Chief Executive Officer', 250000.00, NULL, NULL, '2018-06-15', 'New Hire'),
(10002, 'Jane Doe', 'Human Resources', 'HR Specialist', 55000.00, NULL, NULL, '2019-03-12', 'New Hire'),
(10003, 'Michael Johnson', 'Finance', 'Accountant', 60000.00, NULL, NULL, '2017-11-23', 'New Hire'),

-- Salary changes due to promotions
(10002, 'Jane Doe', 'Human Resources', 'HR Manager', 85000.00, 55000.00, 54.55, '2020-03-01', 'Promotion'),
(10002, 'Jane Doe', 'Human Resources', 'HR Director', 120000.00, 85000.00, 41.18, '2022-01-01', 'Promotion'),
(10003, 'Michael Johnson', 'Finance', 'Senior Accountant', 75000.00, 60000.00, 25.00, '2018-11-23', 'Promotion'),
(10003, 'Michael Johnson', 'Finance', 'Finance Manager', 95000.00, 75000.00, 26.67, '2020-06-01', 'Promotion'),
(10003, 'Michael Johnson', 'Finance', 'Chief Financial Officer', 190000.00, 95000.00, 100.00, '2022-01-01', 'Promotion'),
(10004, 'Emily Williams', 'Human Resources', 'HR Manager', 82000.00, 52000.00, 57.69, '2021-07-01', 'Promotion'),
(10005, 'David Brown', 'Information Technology', 'Senior Software Engineer', 90000.00, 70000.00, 28.57, '2019-09-30', 'Promotion'),
(10005, 'David Brown', 'Information Technology', 'IT Manager', 115000.00, 90000.00, 27.78, '2021-01-01', 'Promotion'),
(10005, 'David Brown', 'Information Technology', 'Chief Technology Officer', 180000.00, 115000.00, 56.52, '2022-07-01', 'Promotion'),

-- Annual merit increases
(10006, 'Sarah Miller', 'Marketing', 'Marketing Specialist', 65000.00, 62000.00, 4.84, '2020-07-14', 'Annual Merit'),
(10007, 'Robert Davis', 'Sales', 'Sales Representative', 60000.00, NULL, NULL, '2021-02-28', 'New Hire'),
(10008, 'Jennifer Wilson', 'Marketing', 'Marketing Manager', 88000.00, 62000.00, 41.94, '2019-05-17', 'Promotion'),
(10009, 'Thomas Taylor', 'Research and Development', 'Research Scientist', 82000.00, 80000.00, 2.50, '2021-11-09', 'Annual Merit'),
(10010, 'Laura Martinez', 'Sales', 'Sales Manager', 92000.00, 58000.00, 58.62, '2021-10-22', 'Promotion'),
(10011, 'James Anderson', 'Finance', 'Finance Manager', 92000.00, 72000.00, 27.78, '2021-04-01', 'Promotion'),
(10012, 'Patricia Thomas', 'Information Technology', 'Software Engineer', 75000.00, NULL, NULL, '2021-04-15', 'New Hire'),
(10013, 'Mark Jackson', 'Information Technology', 'Senior Software Engineer', 95000.00, 72000.00, 31.94, '2020-12-05', 'Promotion'),
(10014, 'Elizabeth White', 'Marketing', 'Marketing Specialist', 64000.00, 60000.00, 6.67, '2021-06-18', 'Annual Merit'),
(10015, 'Richard Harris', 'Sales', 'Sales Representative', 65000.00, 60000.00, 8.33, '2020-09-03', 'Annual Merit');

-- Insert sample data for hr_reporting.department_metrics (continued)
INSERT INTO hr_reporting.department_metrics 
(department_id, department_name, total_employees, avg_salary, avg_tenure_years, remote_employee_count, open_positions) VALUES
(10001, 'Executive', 1, 250000.00, 5.4, 0, 0),
(10002, 'Human Resources', 2, 101000.00, 3.7, 0, 1),
(10003, 'Finance', 2, 141000.00, 5.8, 0, 2),
(10004, 'Information Technology', 3, 116666.67, 3.9, 0, 3),
(10005, 'Marketing', 3, 72333.33, 3.5, 1, 0),
(10006, 'Sales', 3, 72333.33, 2.9, 1, 2),
(10007, 'Research and Development', 1, 82000.00, 3.1, 1, 1),
(10008, 'Customer Support', 0, 0.00, 0.0, 0, 3),
(10009, 'Operations', 0, 0.00, 0.0, 0, 2),
(10010, 'Legal', 0, 0.00, 0.0, 0, 1);

-- Insert sample data for hr_reporting.benefits_summary
INSERT INTO hr_reporting.benefits_summary 
(employee_id, full_name, department_name, retirement_plan_name, contribution_percentage, enrollment_date, total_benefits_cost) VALUES
-- Executive plan enrollments
(10001, 'John Smith', 'Executive', '401(k) Executive Plan', 15.00, '2018-07-01', 37500.00),
(10001, 'John Smith', 'Executive', 'Employee Stock Purchase Plan', 10.00, '2018-07-01', 25000.00),
(10003, 'Michael Johnson', 'Finance', '401(k) Executive Plan', 12.00, '2017-12-01', 22800.00),
(10003, 'Michael Johnson', 'Finance', 'Employee Stock Purchase Plan', 8.00, '2018-01-15', 15200.00),
(10005, 'David Brown', 'Information Technology', '401(k) Executive Plan', 10.00, '2018-10-15', 18000.00),
(10005, 'David Brown', 'Information Technology', 'Employee Stock Purchase Plan', 7.50, '2018-10-15', 13500.00),

-- Standard 401(k) enrollments
(10002, 'Jane Doe', 'Human Resources', '401(k) Basic Plan', 8.50, '2019-04-01', 10200.00),
(10002, 'Jane Doe', 'Human Resources', 'Health Savings Account (HSA)', 3.00, '2019-04-01', 3600.00),
(10004, 'Emily Williams', 'Human Resources', '401(k) Basic Plan', 6.00, '2020-02-01', 4920.00),
(10004, 'Emily Williams', 'Human Resources', 'Health Savings Account (HSA)', 2.50, '2020-02-01', 2050.00),
(10006, 'Sarah Miller', 'Marketing', '401(k) Basic Plan', 5.00, '2019-08-01', 3250.00),
(10007, 'Robert Davis', 'Sales', '401(k) Basic Plan', 4.00, '2021-04-01', 2400.00),
(10008, 'Jennifer Wilson', 'Marketing', '401(k) Basic Plan', 6.50, '2018-06-01', 5720.00),
(10010, 'Laura Martinez', 'Sales', '401(k) Basic Plan', 6.00, '2019-11-15', 5520.00),
(10010, 'Laura Martinez', 'Sales', 'Employee Stock Purchase Plan', 5.00, '2020-06-01', 4600.00),
(10011, 'James Anderson', 'Finance', '401(k) Basic Plan', 9.00, '2017-09-01', 8280.00),
(10011, 'James Anderson', 'Finance', 'Health Savings Account (HSA)', 3.50, '2019-01-01', 3220.00),
(10013, 'Mark Jackson', 'Information Technology', '401(k) Basic Plan', 7.50, '2019-01-15', 7125.00),
(10013, 'Mark Jackson', 'Information Technology', 'Employee Stock Purchase Plan', 4.00, '2020-01-15', 3800.00),
(10014, 'Elizabeth White', 'Marketing', '401(k) Basic Plan', 5.00, '2020-07-15', 3200.00),
(10015, 'Richard Harris', 'Sales', '401(k) Basic Plan', 6.00, '2019-10-01', 3900.00),
(10015, 'Richard Harris', 'Sales', 'Health Savings Account (HSA)', 2.00, '2021-01-01', 1300.00),

-- Roth 401(k) enrollments
(10009, 'Thomas Taylor', 'Research and Development', 'Roth 401(k) Plan', 7.00, '2021-01-01', 5740.00),
(10012, 'Patricia Thomas', 'Information Technology', 'Roth 401(k) Plan', 8.00, '2021-05-01', 6000.00);