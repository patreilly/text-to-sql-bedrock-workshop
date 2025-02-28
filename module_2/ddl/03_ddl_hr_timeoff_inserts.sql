-- Insert sample data for hr_timeoff.leave_types
INSERT INTO hr_timeoff.leave_types (leave_type_id, leave_type_name, is_paid) VALUES
(1, 'Vacation', TRUE),
(2, 'Sick Leave', TRUE),
(3, 'Personal Leave', TRUE),
(4, 'Family Medical Leave', TRUE),
(5, 'Bereavement', TRUE),
(6, 'Jury Duty', TRUE),
(7, 'Unpaid Leave', FALSE),
(8, 'Parental Leave', TRUE),
(9, 'Military Leave', TRUE),
(10, 'COVID-19 Leave', TRUE);

-- Insert sample data for hr_timeoff.leave_requests
-- These reference the employees and leave types we've already created
INSERT INTO hr_timeoff.leave_requests (leave_request_id, employee_id, leave_type_id, start_date, end_date, status, approved_by) VALUES
-- John Smith's leave requests
(1, 1, 1, '2023-07-10', '2023-07-14', 'Approved', 1),  -- Self-approved as CEO

-- Jane Doe's leave requests
(2, 2, 2, '2023-03-15', '2023-03-16', 'Approved', 1),  -- Approved by John (CEO)
(3, 2, 1, '2023-08-21', '2023-09-01', 'Approved', 1),  -- Approved by John (CEO)

-- Michael Johnson's leave requests
(4, 3, 1, '2023-05-22', '2023-05-26', 'Approved', 1),  -- Approved by John (CEO)
(5, 3, 3, '2023-10-09', '2023-10-09', 'Approved', 1),  -- Approved by John (CEO)

-- Emily Williams's leave requests
(6, 4, 2, '2023-02-08', '2023-02-10', 'Approved', 2),  -- Approved by Jane (HR Director)
(7, 4, 1, '2023-11-20', '2023-11-24', 'Pending', NULL), -- Still pending approval

-- David Brown's leave requests
(8, 5, 1, '2023-06-05', '2023-06-16', 'Approved', 1),  -- Approved by John (CEO)
(9, 5, 5, '2023-09-18', '2023-09-20', 'Approved', 1),  -- Approved by John (CEO) - bereavement leave

-- Sarah Miller's leave requests
(10, 6, 1, '2023-04-03', '2023-04-07', 'Approved', 1), -- Approved by John (CEO)
(11, 6, 2, '2023-10-16', '2023-10-18', 'Approved', 1), -- Approved by John (CEO)

-- Robert Davis's leave requests
(12, 7, 1, '2023-08-07', '2023-08-11', 'Approved', 1), -- Approved by John (CEO)

-- Jennifer Wilson's leave requests (former employee)
(13, 8, 1, '2023-01-09', '2023-01-20', 'Approved', 1), -- Approved by John (CEO)
(14, 8, 7, '2023-02-01', '2023-02-15', 'Approved', 1), -- Approved unpaid leave

-- Thomas Taylor's leave requests
(15, 9, 1, '2023-07-24', '2023-08-04', 'Approved', 1), -- Approved by John (CEO)
(16, 9, 3, '2023-11-01', '2023-11-01', 'Approved', 1), -- Approved by John (CEO) - personal day

-- Laura Martinez's leave requests
(17, 10, 1, '2023-05-15', '2023-05-19', 'Approved', 1), -- Approved by John (CEO)
(18, 10, 4, '2023-10-23', '2023-11-03', 'Approved', 1), -- Approved by John (CEO) - family medical leave

-- James Anderson's leave requests
(19, 11, 1, '2023-06-19', '2023-06-30', 'Approved', 3), -- Approved by Michael (CFO)
(20, 11, 2, '2023-09-11', '2023-09-12', 'Approved', 3), -- Approved by Michael (CFO)

-- Patricia Thomas's leave requests
(21, 12, 1, '2023-07-31', '2023-08-11', 'Approved', 5), -- Approved by David (CTO)
(22, 12, 2, '2023-10-02', '2023-10-06', 'Denied', 5),   -- Denied by David (CTO)
(23, 12, 2, '2023-10-09', '2023-10-13', 'Approved', 5), -- Approved by David (CTO) - rescheduled sick leave

-- Mark Jackson's leave requests
(24, 13, 1, '2023-04-17', '2023-04-28', 'Approved', 5), -- Approved by David (CTO)

-- Elizabeth White's leave requests
(25, 14, 2, '2023-03-06', '2023-03-10', 'Approved', 1), -- Approved by John (CEO)
(26, 14, 1, '2023-12-18', '2023-12-29', 'Pending', NULL), -- Still pending approval for December vacation

-- Richard Harris's leave requests
(27, 15, 1, '2023-05-01', '2023-05-12', 'Approved', 10), -- Approved by Laura (Sales Manager)
(28, 15, 6, '2023-09-25', '2023-09-29', 'Approved', 10), -- Approved by Laura (Sales Manager) - jury duty
(29, 15, 1, '2023-12-11', '2023-12-15', 'Pending', NULL); -- Still pending approval for December vacation