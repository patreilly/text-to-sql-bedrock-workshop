```sql
-- Calculate remote work adoption rates by department
-- Shows departments with greatest variance from company average
-- Only includes departments with 5+ employees and active employees

WITH current_positions AS (
    -- Get current positions for active employees only
    SELECT ep.*
    FROM hr_core.employee_positions ep
    INNER JOIN hr_core.employee e ON ep.employee_id = e.employee_id
    WHERE e.is_active = true 
    AND ep.end_date IS NULL
),
dept_metrics AS (
    -- Calculate metrics per department
    SELECT 
        d.department_name,
        COUNT(*) as total_employees,
        SUM(CASE WHEN l.is_remote = true THEN 1 ELSE 0 END) as remote_employees,
        ROUND(SUM(CASE WHEN l.is_remote = true THEN 1 ELSE 0 END) / COUNT(*), 2) as dept_remote_pct
    FROM current_positions cp
    INNER JOIN hr_core.departments d ON cp.department_id = d.department_id
    INNER JOIN hr_core.employee e ON cp.employee_id = e.employee_id
    INNER JOIN hr_core.locations l ON e.current_location_id = l.location_id
    GROUP BY d.department_name
    HAVING COUNT(*) >= 5
),
company_avg AS (
    -- Calculate company-wide average remote percentage
    SELECT ROUND(AVG(dept_remote_pct), 2) as company_remote_pct
    FROM dept_metrics
)
SELECT 
    dm.department_name,
    dm.total_employees,
    dm.remote_employees,
    dm.dept_remote_pct as department_remote_percentage,
    ROUND(dm.dept_remote_pct - ca.company_remote_pct, 2) as variance_from_company_avg
FROM dept_metrics dm
CROSS JOIN company_avg ca
ORDER BY ABS(dm.dept_remote_pct - ca.company_remote_pct) DESC;
```