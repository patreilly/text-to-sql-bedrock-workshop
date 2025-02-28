-- Core HR Schema
DROP SCHEMA IF EXISTS hr_core;
CREATE SCHEMA hr_core;

-- Employee and Organization Structure
CREATE TABLE hr_core.locations (
    location_id INT PRIMARY KEY,
    address_line1 VARCHAR(100),
    address_line2 VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    is_remote BOOLEAN,
    location_type VARCHAR(20),
    INDEX idx_city_country (city, country),
    INDEX idx_location_type (location_type)
);

CREATE TABLE hr_core.employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    hire_date DATETIME,
    is_active BOOLEAN DEFAULT true,
    current_location_id INT,
    FOREIGN KEY (current_location_id) REFERENCES hr_core.locations(location_id),
    INDEX idx_name (last_name, first_name),
    INDEX idx_hire_date (hire_date),
    INDEX idx_is_active (is_active),
    INDEX idx_current_location (current_location_id)
);

CREATE TABLE hr_core.departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    cost_center VARCHAR(20),
    INDEX idx_department_name (department_name),
    INDEX idx_cost_center (cost_center)
);

CREATE TABLE hr_core.job_titles (
    job_title_id INT PRIMARY KEY,
    title_name VARCHAR(50),
    job_level INT,
    job_family VARCHAR(50),
    INDEX idx_title_name (title_name),
    INDEX idx_job_level (job_level),
    INDEX idx_job_family (job_family)
);

-- Employee Position History
CREATE TABLE hr_core.employee_positions (
    position_id INT PRIMARY KEY,
    employee_id INT,
    department_id INT,
    job_title_id INT,
    manager_id INT,
    start_date DATE,
    end_date DATE,
    salary DECIMAL(12,2),
    FOREIGN KEY (employee_id) REFERENCES hr_core.employee(employee_id),
    FOREIGN KEY (department_id) REFERENCES hr_core.departments(department_id),
    FOREIGN KEY (job_title_id) REFERENCES hr_core.job_titles(job_title_id),
    FOREIGN KEY (manager_id) REFERENCES hr_core.employee(employee_id),
    INDEX idx_employee_id (employee_id),
    INDEX idx_department_id (department_id),
    INDEX idx_job_title_id (job_title_id),
    INDEX idx_manager_id (manager_id),
    INDEX idx_dates (start_date, end_date),
    INDEX idx_salary (salary)
);

-- Time Off Schema
DROP SCHEMA IF EXISTS hr_timeoff;
CREATE SCHEMA hr_timeoff;

CREATE TABLE hr_timeoff.leave_types (
    leave_type_id INT PRIMARY KEY,
    leave_type_name VARCHAR(50),
    is_paid BOOLEAN,
    INDEX idx_leave_type_name (leave_type_name),
    INDEX idx_is_paid (is_paid)
);

CREATE TABLE hr_timeoff.leave_requests (
    leave_request_id INT PRIMARY KEY,
    employee_id INT,
    leave_type_id INT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    approved_by INT,
    FOREIGN KEY (employee_id) REFERENCES hr_core.employee(employee_id),
    FOREIGN KEY (leave_type_id) REFERENCES hr_timeoff.leave_types(leave_type_id),
    FOREIGN KEY (approved_by) REFERENCES hr_core.employee(employee_id),
    INDEX idx_employee_id (employee_id),
    INDEX idx_leave_type_id (leave_type_id),
    INDEX idx_dates (start_date, end_date),
    INDEX idx_status (status),
    INDEX idx_approved_by (approved_by)
);

-- Training Schema
DROP SCHEMA IF EXISTS hr_training;
CREATE SCHEMA hr_training;

CREATE TABLE hr_training.courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    description TEXT,
    duration_hours INT,
    INDEX idx_course_name (course_name),
    INDEX idx_duration_hours (duration_hours)
);

CREATE TABLE hr_training.employee_courses (
    employee_id INT,
    course_id INT,
    completion_date DATE,
    certification_id VARCHAR(50),
    PRIMARY KEY (employee_id, course_id),
    FOREIGN KEY (employee_id) REFERENCES hr_core.employee(employee_id),
    FOREIGN KEY (course_id) REFERENCES hr_training.courses(course_id),
    INDEX idx_completion_date (completion_date),
    INDEX idx_certification_id (certification_id)
);

-- Benefits Schema
DROP SCHEMA IF EXISTS hr_benefits;
CREATE SCHEMA hr_benefits;

CREATE TABLE hr_benefits.retirement_plans (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50),
    description TEXT,
    provider VARCHAR(50),
    INDEX idx_plan_name (plan_name),
    INDEX idx_provider (provider)
);

CREATE TABLE hr_benefits.employee_retirement_plans (
    employee_id INT,
    plan_id INT,
    enrollment_date DATE,
    contribution_percentage DECIMAL(5,2),
    PRIMARY KEY (employee_id, plan_id),
    FOREIGN KEY (employee_id) REFERENCES hr_core.employee(employee_id),
    FOREIGN KEY (plan_id) REFERENCES hr_benefits.retirement_plans(plan_id),
    INDEX idx_enrollment_date (enrollment_date),
    INDEX idx_contribution_percentage (contribution_percentage)
);

-- Promotions Schema
DROP SCHEMA IF EXISTS hr_promotions;
CREATE SCHEMA hr_promotions;

CREATE TABLE hr_promotions.promotion_types (
    promotion_type_id INT PRIMARY KEY,
    type_name VARCHAR(50),
    description TEXT,
    INDEX idx_type_name (type_name)
);

CREATE TABLE hr_promotions.promotions (
    promotion_id INT PRIMARY KEY,
    employee_id INT,
    promotion_type_id INT,
    old_position_id INT,
    new_position_id INT,
    promotion_date DATE,
    salary_increase_percentage DECIMAL(5,2),
    FOREIGN KEY (employee_id) REFERENCES hr_core.employee(employee_id),
    FOREIGN KEY (promotion_type_id) REFERENCES hr_promotions.promotion_types(promotion_type_id),
    FOREIGN KEY (old_position_id) REFERENCES hr_core.employee_positions(position_id),
    FOREIGN KEY (new_position_id) REFERENCES hr_core.employee_positions(position_id),
    INDEX idx_employee_id (employee_id),
    INDEX idx_promotion_type_id (promotion_type_id),
    INDEX idx_position_ids (old_position_id, new_position_id),
    INDEX idx_promotion_date (promotion_date),
    INDEX idx_salary_increase (salary_increase_percentage)
);

-- Reporting Schema
DROP SCHEMA IF EXISTS hr_reporting;
CREATE SCHEMA hr_reporting;

-- Employee Directory Report
CREATE TABLE hr_reporting.employee_directory (
    employee_id INT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    department_name VARCHAR(50),
    job_title VARCHAR(50),
    manager_name VARCHAR(100),
    location_city VARCHAR(50),
    location_country VARCHAR(50),
    is_remote BOOLEAN,
    hire_date DATETIME,
    current_salary DECIMAL(12,2),
    INDEX idx_employee_id (employee_id),
    INDEX idx_full_name (full_name),
    INDEX idx_email (email),
    INDEX idx_department_name (department_name),
    INDEX idx_job_title (job_title),
    INDEX idx_location (location_city, location_country),
    INDEX idx_hire_date (hire_date),
    INDEX idx_salary (current_salary)
);

-- Leave Balance Report
CREATE TABLE hr_reporting.leave_summary (
    employee_id INT,
    full_name VARCHAR(100),
    department_name VARCHAR(50),
    leave_type_name VARCHAR(50),
    total_days_taken INT,
    last_leave_date DATE,
    pending_requests INT,
    INDEX idx_employee_id (employee_id),
    INDEX idx_full_name (full_name),
    INDEX idx_department_name (department_name),
    INDEX idx_leave_type (leave_type_name),
    INDEX idx_last_leave_date (last_leave_date)
);

-- Training Compliance Report
CREATE TABLE hr_reporting.training_compliance (
    employee_id INT,
    full_name VARCHAR(100),
    department_name VARCHAR(50),
    job_title VARCHAR(50),
    total_courses_completed INT,
    last_completion_date DATE,
    certifications_count INT,
    INDEX idx_employee_id (employee_id),
    INDEX idx_full_name (full_name),
    INDEX idx_department_name (department_name),
    INDEX idx_job_title (job_title),
    INDEX idx_last_completion_date (last_completion_date),
    INDEX idx_courses_completed (total_courses_completed)
);

-- Compensation History Report
CREATE TABLE hr_reporting.compensation_history (
    employee_id INT,
    full_name VARCHAR(100),
    department_name VARCHAR(50),
    job_title VARCHAR(50),
    salary_amount DECIMAL(12,2),
    previous_salary DECIMAL(12,2),
    change_percentage DECIMAL(5,2),
    change_date DATE,
    change_reason VARCHAR(50),
    INDEX idx_employee_id (employee_id),
    INDEX idx_full_name (full_name),
    INDEX idx_department_name (department_name),
    INDEX idx_job_title (job_title),
    INDEX idx_salary (salary_amount),
    INDEX idx_change_date (change_date),
    INDEX idx_change_reason (change_reason)
);

-- Department Headcount Report
CREATE TABLE hr_reporting.department_metrics (
    department_id INT,
    department_name VARCHAR(50),
    total_employees INT,
    avg_salary DECIMAL(12,2),
    avg_tenure_years DECIMAL(5,2),
    remote_employee_count INT,
    open_positions INT,
    INDEX idx_department_id (department_id),
    INDEX idx_department_name (department_name),
    INDEX idx_total_employees (total_employees),
    INDEX idx_avg_salary (avg_salary)
);

-- Benefits Enrollment Summary
CREATE TABLE hr_reporting.benefits_summary (
    employee_id INT,
    full_name VARCHAR(100),
    department_name VARCHAR(50),
    retirement_plan_name VARCHAR(50),
    contribution_percentage DECIMAL(5,2),
    enrollment_date DATE,
    total_benefits_cost DECIMAL(12,2),
    INDEX idx_employee_id (employee_id),
    INDEX idx_full_name (full_name),
    INDEX idx_department_name (department_name),
    INDEX idx_retirement_plan (retirement_plan_name),
    INDEX idx_enrollment_date (enrollment_date),
    INDEX idx_benefits_cost (total_benefits_cost)
);