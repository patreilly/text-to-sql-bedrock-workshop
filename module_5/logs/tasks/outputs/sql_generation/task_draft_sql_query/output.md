```sql
/* 
Retirement Plan Participation Analysis Query
- Analyzes retirement plan participation by department
- Only includes active employees enrolled since 2019
- Shows departments with 5+ enrolled employees
- Includes contribution and salary averages
*/

WITH current_positions AS (
    -- Get the most recent position for each employee
    SELECT 
        ep.employee_id,
        ep.department_id,
        ep.salary
    FROM hr_core.employee_positions ep
    INNER JOIN (
        SELECT employee_id, MAX(start_date) as max_start_date
        FROM hr_core.employee_positions
        GROUP BY employee_id
    ) latest ON ep.employee_id = latest.employee_id 
    AND ep.start_date = latest.max_start_date
)

SELECT 
    d.department_name,
    COUNT(DISTINCT e.employee_id) as enrolled_employees,
    ROUND(AVG(erp.contribution_percentage), 2) as avg_contribution_pct,
    ROUND(AVG(cp.salary), 2) as avg_base_salary,
    CONCAT(rp.provider, ' - ', rp.plan_name) as retirement_plan_details
FROM hr_core.departments d
INNER JOIN current_positions cp ON d.department_id = cp.department_id
INNER JOIN hr_core.employee e ON cp.employee_id = e.employee_id
INNER JOIN hr_benefits.employee_retirement_plans erp ON e.employee_id = erp.employee_id
INNER JOIN hr_benefits.retirement_plans rp ON erp.plan_id = rp.plan_id
WHERE 
    e.is_active = true  -- Only active employees
    AND erp.enrollment_date >= '2019-01-01'  -- Enrollments since 2019
GROUP BY 
    d.department_id,
    d.department_name,
    rp.provider,
    rp.plan_name
HAVING 
    COUNT(DISTINCT e.employee_id) >= 5  -- Only departments with 5+ enrolled employees
ORDER BY 
    avg_contribution_pct DESC;  -- Sort by contribution percentage descending
```