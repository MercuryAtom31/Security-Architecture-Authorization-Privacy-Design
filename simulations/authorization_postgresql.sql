-- PostgreSQL authorization simulation for Part 2
-- Model: Hybrid RBAC + ABAC (RBAC baseline in SQL)

BEGIN;

-- 1) Creating group roles (NOLOGIN)
CREATE ROLE hr_role NOLOGIN;
CREATE ROLE finance_analyst_role NOLOGIN;
CREATE ROLE finance_manager_role NOLOGIN;
CREATE ROLE payroll_role NOLOGIN;
CREATE ROLE auditor_role NOLOGIN;

-- 2) Example user accounts (LOGIN roles)
CREATE ROLE user_hr1 LOGIN PASSWORD 'ChangeMe_HR1';
CREATE ROLE user_fin_analyst1 LOGIN PASSWORD 'ChangeMe_FIN1';
CREATE ROLE user_payroll1 LOGIN PASSWORD 'ChangeMe_PAY1';

-- 3) Granting object-level permissions
-- Assuming these tables exist in schema public:
-- public.employee_records, public.financial_reports, public.payroll, public.audit_logs

GRANT SELECT, UPDATE (employee_name, address, tax_code)
ON TABLE public.employee_records
TO hr_role;

GRANT SELECT
ON TABLE public.financial_reports
TO finance_analyst_role;

GRANT SELECT, UPDATE
ON TABLE public.payroll
TO payroll_role;

GRANT SELECT
ON TABLE public.audit_logs
TO auditor_role;

-- Finance manager can review/approve reports (modeled as SELECT/UPDATE)
GRANT SELECT, UPDATE
ON TABLE public.financial_reports
TO finance_manager_role;

-- Separation of duties example:
-- Explicitly ensuring finance managers cannot modify payroll
REVOKE UPDATE
ON TABLE public.payroll
FROM finance_manager_role;

-- 4) Assigning group roles to users
GRANT hr_role TO user_hr1;
GRANT finance_analyst_role TO user_fin_analyst1;
GRANT payroll_role TO user_payroll1;

COMMIT;
