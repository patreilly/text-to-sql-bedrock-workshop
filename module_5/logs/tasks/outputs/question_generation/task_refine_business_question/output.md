<question>What are the employee names, current job titles, departments, promotion dates, and percentage salary increases for all active employees who received promotions between [CURRENT_DATE - 12 MONTHS] and [CURRENT_DATE], ordered by promotion date from newest to oldest?</question>

This refined question is better because:
1. Explicitly defines the date range with clear SQL-compatible terminology
2. Specifies the sort order direction (newest to oldest)
3. Adds "promotion dates" to the output fields for better context
4. Maintains all the strong elements of the original:
   - Clear focus on active employees
   - Specific measurable metrics (salary percentage increase)
   - Required data points are available in the schema
   - Reasonable query complexity
   - Clear business value
5. Uses precise language that maps directly to database fields
6. Can be answered using available tables:
   - hr_promotions.promotions
   - hr_core.employee
   - hr_core.employee_positions
   - hr_core.job_titles
   - hr_core.departments
7. Ensures temporal clarity with explicit date range
8. Maintains reasonable query complexity while providing comprehensive information