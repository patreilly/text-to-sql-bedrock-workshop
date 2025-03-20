The following tables and columns are needed to answer the business question about remote work adoption rates by department:

1. hr_core.departments
   - department_id (PK)
   - department_name
   Relevance: Required to identify and name each department for the analysis and final output.

2. hr_core.employee
   - employee_id (PK)
   - is_active
   - current_location_id (FK to locations)
   Relevance: Needed to filter for active employees only and link to their current location information.

3. hr_core.locations
   - location_id (PK)
   - is_remote
   Relevance: Critical for determining whether an employee is working remotely or not.

4. hr_core.employee_positions
   - employee_id (FK)
   - department_id (FK)
   - end_date
   Relevance: Required to establish which department each employee currently belongs to (where end_date is null for current positions).

These tables will be joined together to:
1. Link employees to their current departments (employee_positions to departments)
2. Determine remote status of each employee (employee to locations)
3. Filter for active employees only (employee.is_active)
4. Calculate department-level statistics (grouping by department)
5. Compare against company-wide averages

The relationships between these tables are:
- employee_positions.employee_id → employee.employee_id
- employee_positions.department_id → departments.department_id
- employee.current_location_id → locations.location_id

This combination of tables and columns will allow us to:
- Count total active employees per department
- Count remote workers per department
- Calculate department-level remote work percentages
- Compare against company-wide averages
- Filter out departments with fewer than 5 employees
- Sort by variance from company average

No other tables in the schema are needed as these four tables contain all the necessary information to fully answer the business question about remote work adoption rates.