-- Insert sample data for hr_benefits.retirement_plans
INSERT INTO hr_benefits.retirement_plans (plan_id, plan_name, description, provider) VALUES
(1, '401(k) Basic Plan', 'Standard 401(k) retirement savings plan with employer matching up to 4%', 'Fidelity Investments'),
(2, '401(k) Executive Plan', 'Enhanced 401(k) plan for executive staff with higher contribution limits and additional investment options', 'Fidelity Investments'),
(3, 'Roth 401(k) Plan', 'Tax-advantaged retirement savings plan with post-tax contributions', 'Vanguard Group'),
(4, 'Pension Plan', 'Traditional defined benefit pension plan for long-term employees', 'Prudential Financial'),
(5, 'Health Savings Account (HSA)', 'Tax-advantaged medical savings account for employees with high-deductible health plans', 'HealthEquity'),
(6, 'Employee Stock Purchase Plan', 'Program allowing employees to purchase company stock at a discounted rate', 'E*TRADE Financial');

-- Insert sample data for hr_benefits.employee_retirement_plans
INSERT INTO hr_benefits.employee_retirement_plans (employee_id, plan_id, enrollment_date, contribution_percentage) VALUES
-- John Smith (CEO) enrolled in executive plan and stock purchase
(1, 2, '2018-07-01', 15.00),
(1, 6, '2018-07-01', 10.00),

-- Jane Doe (HR Director) enrolled in standard 401(k) and HSA
(2, 1, '2019-04-01', 8.50),
(2, 5, '2019-04-01', 3.00),

-- Michael Johnson (CFO) enrolled in executive plan and stock purchase
(3, 2, '2017-12-01', 12.00),
(3, 6, '2018-01-15', 8.00),

-- Emily Williams (HR Manager) enrolled in standard 401(k) and HSA
(4, 1, '2020-02-01', 6.00),
(4, 5, '2020-02-01', 2.50),

-- David Brown (CTO) enrolled in executive plan and stock purchase
(5, 2, '2018-10-15', 10.00),
(5, 6, '2018-10-15', 7.50),

-- Sarah Miller (Marketing Specialist) enrolled in standard 401(k)
(6, 1, '2019-08-01', 5.00),

-- Robert Davis (Sales Representative) enrolled in standard 401(k)
(7, 1, '2021-04-01', 4.00),

-- Jennifer Wilson (former Marketing Manager) was enrolled in standard 401(k)
(8, 1, '2018-06-01', 6.50),

-- Thomas Taylor (Research Scientist) enrolled in Roth 401(k)
(9, 3, '2021-01-01', 7.00),

-- Laura Martinez (Sales Manager) enrolled in standard 401(k) and stock purchase
(10, 1, '2019-11-15', 6.00),
(10, 6, '2020-06-01', 5.00),

-- James Anderson (Finance Manager) enrolled in standard 401(k) and HSA
(11, 1, '2017-09-01', 9.00),
(11, 5, '2019-01-01', 3.50),

-- Patricia Thomas (Software Engineer) enrolled in Roth 401(k)
(12, 3, '2021-05-01', 8.00),

-- Mark Jackson (Senior Software Engineer) enrolled in standard 401(k) and stock purchase
(13, 1, '2019-01-15', 7.50),
(13, 6, '2020-01-15', 4.00),

-- Elizabeth White (Marketing Specialist) enrolled in standard 401(k)
(14, 1, '2020-07-15', 5.00),

-- Richard Harris (Sales Representative) enrolled in standard 401(k) and HSA
(15, 1, '2019-10-01', 6.00),
(15, 5, '2021-01-01', 2.00);