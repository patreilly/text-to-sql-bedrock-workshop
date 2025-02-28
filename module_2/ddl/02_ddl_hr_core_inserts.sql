-- Insert sample data for hr_core.locations
INSERT INTO hr_core.locations (location_id, address_line1, address_line2, city, state, country, is_remote, location_type) VALUES 
(1, '123 Main St', 'Suite 100', 'Seattle', 'WA', 'USA', FALSE, 'Corporate HQ'),
(2, '456 Market St', '15th Floor', 'San Francisco', 'CA', 'USA', FALSE, 'Regional Office'),
(3, '789 Tech Blvd', NULL, 'Austin', 'TX', 'USA', FALSE, 'Branch Office'),
(4, '101 Innovation Way', 'Building A', 'Boston', 'MA', 'USA', FALSE, 'R&D Center'),
(5, '555 Remote Ave', NULL, 'Chicago', 'IL', 'USA', TRUE, 'Remote Hub'),
(6, '22 Maple Street', 'Floor 3', 'Toronto', 'ON', 'Canada', FALSE, 'International Office'),
(7, '8 Canary Wharf', NULL, 'London', NULL, 'UK', FALSE, 'International Office'),
(8, NULL, NULL, NULL, NULL, NULL, TRUE, 'Fully Remote');

-- Insert sample data for hr_core.employee
INSERT INTO hr_core.employee (employee_id, first_name, last_name, email, hire_date, is_active, current_location_id) VALUES 
(1, 'John', 'Smith', 'john.smith@company.com', '2018-06-15 09:00:00', TRUE, 1),
(2, 'Jane', 'Doe', 'jane.doe@company.com', '2019-03-12 08:30:00', TRUE, 1),
(3, 'Michael', 'Johnson', 'michael.johnson@company.com', '2017-11-23 10:00:00', TRUE, 2),
(4, 'Emily', 'Williams', 'emily.williams@company.com', '2020-01-07 09:15:00', TRUE, 3),
(5, 'David', 'Brown', 'david.brown@company.com', '2018-09-30 08:45:00', TRUE, 4),
(6, 'Sarah', 'Miller', 'sarah.miller@company.com', '2019-07-14 09:30:00', TRUE, 5),
(7, 'Robert', 'Davis', 'robert.davis@company.com', '2021-02-28 10:15:00', TRUE, 6),
(8, 'Jennifer', 'Wilson', 'jennifer.wilson@company.com', '2018-05-17 09:45:00', FALSE, 7),
(9, 'Thomas', 'Taylor', 'thomas.taylor@company.com', '2020-11-09 08:00:00', TRUE, 8),
(10, 'Laura', 'Martinez', 'laura.martinez@company.com', '2019-10-22 09:00:00', TRUE, 2),
(11, 'James', 'Anderson', 'james.anderson@company.com', '2017-08-01 10:30:00', TRUE, 1),
(12, 'Patricia', 'Thomas', 'patricia.thomas@company.com', '2021-04-15 09:30:00', TRUE, 3),
(13, 'Mark', 'Jackson', 'mark.jackson@company.com', '2018-12-05 08:45:00', TRUE, 4),
(14, 'Elizabeth', 'White', 'elizabeth.white@company.com', '2020-06-18 10:00:00', TRUE, 5),
(15, 'Richard', 'Harris', 'richard.harris@company.com', '2019-09-03 09:15:00', TRUE, 8);

-- Insert sample data for hr_core.departments
INSERT INTO hr_core.departments (department_id, department_name, cost_center) VALUES 
(1, 'Executive', 'CC-1001'),
(2, 'Human Resources', 'CC-2001'),
(3, 'Finance', 'CC-3001'),
(4, 'Information Technology', 'CC-4001'),
(5, 'Marketing', 'CC-5001'),
(6, 'Sales', 'CC-6001'),
(7, 'Research and Development', 'CC-7001'),
(8, 'Customer Support', 'CC-8001'),
(9, 'Operations', 'CC-9001'),
(10, 'Legal', 'CC-1010');

-- Insert sample data for hr_core.job_titles
INSERT INTO hr_core.job_titles (job_title_id, title_name, job_level, job_family) VALUES 
(1, 'Chief Executive Officer', 10, 'Executive'),
(2, 'Chief Financial Officer', 9, 'Executive'),
(3, 'Chief Technology Officer', 9, 'Executive'),
(4, 'HR Director', 8, 'Management'),
(5, 'HR Manager', 7, 'Management'),
(6, 'HR Specialist', 5, 'Human Resources'),
(7, 'Finance Manager', 7, 'Management'),
(8, 'Senior Accountant', 6, 'Finance'),
(9, 'Accountant', 5, 'Finance'),
(10, 'IT Manager', 7, 'Management'),
(11, 'Senior Software Engineer', 6, 'Technology'),
(12, 'Software Engineer', 5, 'Technology'),
(13, 'Marketing Director', 8, 'Management'),
(14, 'Marketing Manager', 7, 'Management'),
(15, 'Marketing Specialist', 5, 'Marketing'),
(16, 'Sales Director', 8, 'Management'),
(17, 'Sales Manager', 7, 'Management'),
(18, 'Sales Representative', 5, 'Sales'),
(19, 'R&D Director', 8, 'Management'),
(20, 'Research Scientist', 6, 'Research');

-- Insert sample data for hr_core.employee_positions
-- Note that we're setting some end_dates to NULL to indicate current positions
INSERT INTO hr_core.employee_positions (position_id, employee_id, department_id, job_title_id, manager_id, start_date, end_date, salary) VALUES 
-- John Smith's career path - CEO
(1, 1, 1, 1, NULL, '2018-06-15', NULL, 250000.00),

-- Jane Doe's career path - HR Director
(2, 2, 2, 6, 1, '2019-03-12', '2020-02-28', 55000.00),
(3, 2, 2, 5, 1, '2020-03-01', '2021-12-31', 85000.00),
(4, 2, 2, 4, 1, '2022-01-01', NULL, 120000.00),

-- Michael Johnson's career path - CFO
(5, 3, 3, 9, 1, '2017-11-23', '2018-11-22', 60000.00),
(6, 3, 3, 8, 1, '2018-11-23', '2020-05-31', 75000.00),
(7, 3, 3, 7, 1, '2020-06-01', '2021-12-31', 95000.00),
(8, 3, 3, 2, 1, '2022-01-01', NULL, 190000.00),

-- Emily Williams's career path - HR Manager
(9, 4, 2, 6, 2, '2020-01-07', '2021-06-30', 52000.00),
(10, 4, 2, 5, 2, '2021-07-01', NULL, 82000.00),

-- David Brown's career path - CTO
(11, 5, 4, 12, 1, '2018-09-30', '2019-09-29', 70000.00),
(12, 5, 4, 11, 1, '2019-09-30', '2020-12-31', 90000.00),
(13, 5, 4, 10, 1, '2021-01-01', '2022-06-30', 115000.00),
(14, 5, 4, 3, 1, '2022-07-01', NULL, 180000.00),

-- Sarah Miller's career path - Marketing Specialist
(15, 6, 5, 15, 1, '2019-07-14', NULL, 65000.00),

-- Robert Davis's career path - Sales Representative
(16, 7, 6, 18, 1, '2021-02-28', NULL, 60000.00),

-- Jennifer Wilson's career path (former employee) - Marketing Manager
(17, 8, 5, 15, 1, '2018-05-17', '2019-05-16', 62000.00),
(18, 8, 5, 14, 1, '2019-05-17', '2023-02-15', 88000.00),

-- Thomas Taylor's career path - Research Scientist
(19, 9, 7, 20, 1, '2020-11-09', NULL, 82000.00),

-- Laura Martinez's career path - Sales Manager
(20, 10, 6, 18, 1, '2019-10-22', '2021-10-21', 58000.00),
(21, 10, 6, 17, 1, '2021-10-22', NULL, 92000.00),

-- James Anderson's career path - Finance Manager
(22, 11, 3, 9, 3, '2017-08-01', '2019-08-01', 58000.00),
(23, 11, 3, 8, 3, '2019-08-02', '2021-03-31', 72000.00),
(24, 11, 3, 7, 3, '2021-04-01', NULL, 92000.00),

-- Patricia Thomas's career path - Software Engineer
(25, 12, 4, 12, 5, '2021-04-15', NULL, 75000.00),

-- Mark Jackson's career path - Senior Software Engineer
(26, 13, 4, 12, 5, '2018-12-05', '2020-12-04', 72000.00),
(27, 13, 4, 11, 5, '2020-12-05', NULL, 95000.00),

-- Elizabeth White's career path - Marketing Specialist
(28, 14, 5, 15, 1, '2020-06-18', NULL, 64000.00),

-- Richard Harris's career path - Sales Representative
(29, 15, 6, 18, 10, '2019-09-03', NULL, 65000.00);