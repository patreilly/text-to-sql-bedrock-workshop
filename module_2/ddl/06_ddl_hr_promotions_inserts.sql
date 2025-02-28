-- Insert sample data for hr_promotions.promotion_types
INSERT INTO hr_promotions.promotion_types (promotion_type_id, type_name, description) VALUES
(1, 'Performance-Based', 'Promotion based on exceptional performance and achievement of targets'),
(2, 'Merit-Based', 'Promotion based on demonstrated skills, capabilities, and professional growth'),
(3, 'Structural', 'Promotion due to organizational restructuring or department expansion'),
(4, 'Role Expansion', 'Promotion reflecting expanded responsibilities within current role'),
(5, 'Career Path Progression', 'Standard promotion following established career development path'),
(6, 'Leadership Development', 'Promotion specifically targeting growth of management capabilities'),
(7, 'Technical Advancement', 'Promotion based on advanced technical expertise and specialization');

-- Insert sample data for hr_promotions.promotions
-- These reference the employees and positions we've already created
INSERT INTO hr_promotions.promotions (promotion_id, employee_id, promotion_type_id, old_position_id, new_position_id, promotion_date, salary_increase_percentage) VALUES
-- Jane Doe's promotions (HR Specialist -> HR Manager -> HR Director)
(1, 2, 5, 2, 3, '2020-03-01', 54.55),  -- Significant increase with first management role
(2, 2, 2, 3, 4, '2022-01-01', 41.18),  -- Substantial increase to director level

-- Michael Johnson's promotions (Accountant -> Senior Accountant -> Finance Manager -> CFO)
(3, 3, 2, 5, 6, '2018-11-23', 25.00),  -- Merit-based to senior accountant
(4, 3, 5, 6, 7, '2020-06-01', 26.67),  -- Career path to manager role
(5, 3, 1, 7, 8, '2022-01-01', 100.00), -- Performance-based to CFO with major raise

-- Emily Williams's promotion (HR Specialist -> HR Manager)
(6, 4, 5, 9, 10, '2021-07-01', 57.69), -- Career path progression

-- David Brown's promotions (Software Engineer -> Senior Software Engineer -> IT Manager -> CTO)
(7, 5, 2, 11, 12, '2019-09-30', 28.57), -- Merit-based promotion to senior engineer
(8, 5, 6, 12, 13, '2021-01-01', 27.78), -- Leadership development to manager
(9, 5, 1, 13, 14, '2022-07-01', 56.52), -- Performance-based promotion to CTO

-- Jennifer Wilson's promotion (Marketing Specialist -> Marketing Manager)
(10, 8, 2, 17, 18, '2019-05-17', 41.94), -- Merit-based promotion to manager role

-- Laura Martinez's promotion (Sales Representative -> Sales Manager)
(11, 10, 1, 20, 21, '2021-10-22', 58.62), -- Performance-based to manager

-- James Anderson's promotions (Accountant -> Senior Accountant -> Finance Manager)
(12, 11, 5, 22, 23, '2019-08-02', 24.14), -- Career path to senior accountant
(13, 11, 2, 23, 24, '2021-04-01', 27.78), -- Merit-based to finance manager

-- Mark Jackson's promotion (Software Engineer -> Senior Software Engineer)
(14, 13, 7, 26, 27, '2020-12-05', 31.94) -- Technical advancement promotion
;