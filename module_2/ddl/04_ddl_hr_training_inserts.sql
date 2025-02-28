-- Insert sample data for hr_training.courses
INSERT INTO hr_training.courses (course_id, course_name, description, duration_hours) VALUES
(1, 'Workplace Safety Fundamentals', 'Essential safety protocols and emergency procedures for all employees', 4),
(2, 'Corporate Compliance and Ethics', 'Overview of company policies, ethical guidelines, and legal compliance', 6),
(3, 'Leadership Essentials', 'Core leadership skills for new and aspiring managers', 16),
(4, 'Advanced Management Techniques', 'Strategic management and team leadership for experienced managers', 24),
(5, 'Financial Management for Non-Financial Professionals', 'Basic accounting and finance concepts for non-finance staff', 8),
(6, 'Project Management Fundamentals', 'Introduction to project planning, execution, and monitoring', 12),
(7, 'Advanced Project Management', 'Advanced techniques including risk management and agile methodologies', 20),
(8, 'Software Engineering Best Practices', 'Coding standards, testing methodologies, and software design patterns', 16),
(9, 'Cloud Computing Fundamentals', 'Introduction to cloud architectures, services, and deployment models', 10),
(10, 'Data Privacy and Security', 'Security protocols and data protection compliance requirements', 8),
(11, 'Effective Communication Skills', 'Verbal and written communication techniques for the workplace', 8),
(12, 'Customer Service Excellence', 'Strategies for exceptional customer experience and satisfaction', 6),
(13, 'Sales Techniques and Negotiation', 'Advanced selling and negotiation skills for sales professionals', 16),
(14, 'Digital Marketing Fundamentals', 'Introduction to digital marketing channels and strategies', 12),
(15, 'HR Compliance Training', 'Legal requirements and best practices for HR professionals', 8);

-- Insert sample data for hr_training.employee_courses
INSERT INTO hr_training.employee_courses (employee_id, course_id, completion_date, certification_id) VALUES
-- John Smith (CEO) completed leadership courses
(1, 2, '2019-01-15', 'CERT-ETH-1001'),
(1, 3, '2019-04-22', 'CERT-LE-1002'),
(1, 4, '2019-08-10', 'CERT-AM-1003'),
(1, 10, '2022-06-17', 'CERT-SEC-1004'),

-- Jane Doe (HR Director) completed HR and leadership courses
(2, 2, '2019-05-20', 'CERT-ETH-2001'),
(2, 3, '2020-01-28', 'CERT-LE-2002'),
(2, 11, '2020-09-15', 'CERT-COM-2003'),
(2, 15, '2021-03-12', 'CERT-HR-2004'),
(2, 10, '2022-07-05', 'CERT-SEC-2005'),

-- Michael Johnson (CFO) completed finance and leadership courses
(3, 2, '2018-03-10', 'CERT-ETH-3001'),
(3, 3, '2018-11-07', 'CERT-LE-3002'),
(3, 4, '2019-10-15', 'CERT-AM-3003'),
(3, 5, '2018-07-22', 'CERT-FIN-3004'),
(3, 10, '2022-06-20', 'CERT-SEC-3005'),

-- Emily Williams (HR Manager)
(4, 2, '2020-03-25', 'CERT-ETH-4001'),
(4, 3, '2021-05-18', 'CERT-LE-4002'),
(4, 11, '2021-08-10', 'CERT-COM-4003'),
(4, 15, '2022-02-15', 'CERT-HR-4004'),

-- David Brown (CTO) completed technical and leadership courses
(5, 2, '2019-02-17', 'CERT-ETH-5001'),
(5, 3, '2019-07-20', 'CERT-LE-5002'),
(5, 4, '2020-11-05', 'CERT-AM-5003'),
(5, 8, '2019-05-12', 'CERT-SE-5004'),
(5, 9, '2020-08-22', 'CERT-CLOUD-5005'),
(5, 10, '2021-01-15', 'CERT-SEC-5006'),

-- Sarah Miller (Marketing Specialist)
(6, 1, '2019-08-05', 'CERT-SAFE-6001'),
(6, 2, '2020-01-17', 'CERT-ETH-6002'),
(6, 11, '2020-11-30', 'CERT-COM-6003'),
(6, 14, '2021-09-15', 'CERT-DIGI-6004'),

-- Robert Davis (Sales Representative)
(7, 1, '2021-03-22', 'CERT-SAFE-7001'),
(7, 2, '2021-05-10', 'CERT-ETH-7002'),
(7, 12, '2021-10-05', 'CERT-CUST-7003'),
(7, 13, '2022-02-18', 'CERT-SALES-7004'),

-- Jennifer Wilson (former Marketing Manager - some certifications expired)
(8, 1, '2018-07-10', 'CERT-SAFE-8001'),
(8, 2, '2018-09-15', 'CERT-ETH-8002'),
(8, 11, '2019-02-22', 'CERT-COM-8003'),
(8, 14, '2019-11-07', 'CERT-DIGI-8004'),
(8, 3, '2020-06-18', 'CERT-LE-8005'),

-- Thomas Taylor (Research Scientist)
(9, 1, '2021-01-15', 'CERT-SAFE-9001'),
(9, 2, '2021-03-20', 'CERT-ETH-9002'),
(9, 6, '2022-02-10', 'CERT-PM-9003'),
(9, 10, '2022-07-05', 'CERT-SEC-9004'),

-- Laura Martinez (Sales Manager)
(10, 1, '2020-01-15', 'CERT-SAFE-10001'),
(10, 2, '2020-03-17', 'CERT-ETH-10002'),
(10, 3, '2020-09-22', 'CERT-LE-10003'),
(10, 12, '2021-01-15', 'CERT-CUST-10004'),
(10, 13, '2021-06-10', 'CERT-SALES-10005'),

-- James Anderson (Finance Manager)
(11, 1, '2018-09-20', 'CERT-SAFE-11001'),
(11, 2, '2018-11-25', 'CERT-ETH-11002'),
(11, 3, '2019-07-15', 'CERT-LE-11003'),
(11, 5, '2018-10-05', 'CERT-FIN-11004'),
(11, 10, '2022-03-22', 'CERT-SEC-11005'),

-- Patricia Thomas (Software Engineer)
(12, 1, '2021-05-17', 'CERT-SAFE-12001'),
(12, 2, '2021-07-20', 'CERT-ETH-12002'),
(12, 8, '2021-12-10', 'CERT-SE-12003'),
(12, 9, '2022-05-15', 'CERT-CLOUD-12004'),

-- Mark Jackson (Senior Software Engineer)
(13, 1, '2019-01-20', 'CERT-SAFE-13001'),
(13, 2, '2019-03-15', 'CERT-ETH-13002'),
(13, 6, '2019-08-22', 'CERT-PM-13003'),
(13, 8, '2019-05-10', 'CERT-SE-13004'),
(13, 9, '2020-02-15', 'CERT-CLOUD-13005'),
(13, 7, '2021-04-22', 'CERT-APM-13006'),
(13, 10, '2022-01-17', 'CERT-SEC-13007'),

-- Elizabeth White (Marketing Specialist)
(14, 1, '2020-07-15', 'CERT-SAFE-14001'),
(14, 2, '2020-09-20', 'CERT-ETH-14002'),
(14, 11, '2021-03-05', 'CERT-COM-14003'),
(14, 14, '2021-11-22', 'CERT-DIGI-14004'),

-- Richard Harris (Sales Representative)
(15, 1, '2019-10-17', 'CERT-SAFE-15001'),
(15, 2, '2019-12-12', 'CERT-ETH-15002'),
(15, 12, '2020-05-20', 'CERT-CUST-15003'),
(15, 13, '2021-02-10', 'CERT-SALES-15004'),
(15, 11, '2022-04-15', 'CERT-COM-15005');