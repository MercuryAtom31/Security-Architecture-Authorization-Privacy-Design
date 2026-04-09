# Authorization Model Design

## Scenario

The company stores financial reports and payroll data, both of which are highly sensitive. A weak authorization model could lead to data leaks, fraud, and compliance violations.

## Chosen Model

Hybrid model (RBAC + ABAC)

This model is selected because:
- RBAC gives clear, manageable role boundaries.
- ABAC adds context checks for stronger security decisions.

## Users

- Employee
- HR Officer
- Finance Analyst
- Finance Manager
- Payroll Specialist
- Security Auditor
- System Administrator

## Roles and Attributes

### RBAC Roles

- EMPLOYEE
- HR
- FINANCE_ANALYST
- FINANCE_MANAGER
- PAYROLL
- AUDITOR
- ADMIN

### ABAC Attributes

- Department
- Clearance level
- Employment status
- MFA status
- Access time window
- Device trust state

## Protected Resources

- Payroll database
- Financial reports repository
- Employee PII records
- Audit logs
- IAM configuration

## Permissions (Access Matrix)

| Role | Payroll Data | Financial Reports | Employee PII | Audit Logs | IAM Config |
| --- | --- | --- | --- | --- | --- |
| Employee | No access | No access | Own record (read) | No access | No access |
| HR | Read/Update limited fields | No access | Read/Update | No access | No access |
| Finance Analyst | No access | Read | No access | No access | No access |
| Finance Manager | Read (aggregated only) | Read/Approve | No access | Read (team scope) | No access |
| Payroll Specialist | Read/Update payroll | No access | Read minimum fields | No access | No access |
| Auditor | No access | Read (historical) | Masked read | Read | No access |
| Admin | No business-data read by default | No business-data read by default | No business-data read by default | Read | Admin only |

## ABAC Enforcement Logic

Access is granted only if all conditions are true:
- User account is active.
- MFA verification is successful.
- Request is within approved access hours.
- Device meets compliance requirements.
- Clearance level matches resource classification.

## Least Privilege Enforcement

- Default deny is applied to all new users and roles.
- Each role receives only task-specific permissions.
- Sensitive fields are restricted even when table access is allowed.
- Privileged access is temporary and expires automatically.

Examples:
- Employees can view only their own records.
- Finance analysts can read reports but cannot modify payroll.
- Admin manages platform security and IAM, not business financial content by default.

## Separation of Duties Enforcement

- Payroll entry and payroll approval are assigned to different roles.
- Financial report creation and approval are assigned to different roles.
- IAM administration is separated from HR and finance operations.
- Auditor role is read-only and cannot alter records.

This separation prevents any single person from controlling an end-to-end sensitive workflow.

## Diagrams

- [Access Matrix diagram](../diagrams/access-matrix.puml)

## Tool Selection

Option B: SQL simulation using GRANT and REVOKE.

```sql
CREATE ROLE hr_role;
CREATE ROLE finance_analyst_role;
CREATE ROLE finance_manager_role;
CREATE ROLE payroll_role;
CREATE ROLE auditor_role;

GRANT SELECT, UPDATE (employee_name, address, tax_code)
ON employee_records TO hr_role;

GRANT SELECT ON financial_reports TO finance_analyst_role;
GRANT SELECT, UPDATE ON payroll TO payroll_role;
GRANT SELECT ON audit_logs TO auditor_role;

REVOKE UPDATE ON payroll FROM finance_manager_role;
GRANT SELECT, APPROVE ON financial_reports TO finance_manager_role;

GRANT hr_role TO user_hr1;
GRANT payroll_role TO user_payroll1;
GRANT finance_analyst_role TO user_fin_analyst1;
```

## Why This Model Is Effective

- It is practical to implement in enterprise systems.
- It enforces least privilege and separation of duties in measurable ways.
- It reduces attack surface while supporting real operational needs.

## Conclusion

The hybrid RBAC + ABAC model provides a strong balance of control and flexibility for protecting payroll and financial data. It supports least privilege, separation of duties, and contextual access checks, making it suitable for a realistic enterprise environment.
