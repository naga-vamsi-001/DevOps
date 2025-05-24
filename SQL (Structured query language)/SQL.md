# 📘 SQL Concepts & Practice Notes

This repository contains personal learning notes, queries, and examples on SQL, built while exploring real-world data engineering challenges.

---

## 🧠 Table of Contents

1. [Data Types](#data-types)
2. [DML / DDL / TCL](#dml--ddl--tcl)
3. [Constraints](#constraints)
4. [Joins](#joins)
5. [Functions](#functions)
6. [Window Functions](#window-functions)
7. [Subqueries & CTEs](#subqueries--ctes)
8. [Set Operators](#set-operators)
9. [Pivoting](#pivoting)
10. [Common Use-Cases](#common-use-cases)
11. [To-Do: Advanced Topics](#to-do-advanced-topics)

---

## ✅ Data Types
SQL data types define the kind of data a column can hold.

| Type      | Description                 | Example |
|-----------|-----------------------------|---------|
| INT       | Whole numbers               | `age INT` |
| FLOAT     | Decimal numbers             | `price FLOAT` |
| CHAR      | Fixed-length string         | `code CHAR(5)` |
| VARCHAR   | Variable-length string      | `name VARCHAR(50)` |
| DATE      | Date values                 | `dob DATE` |

---

## ✅ DML / DDL / TCL
- **DML (Data Manipulation Language)**: Used to modify data (INSERT, UPDATE, DELETE).
- **DDL (Data Definition Language)**: Used to define or alter schema (CREATE, ALTER, DROP).
- **TCL (Transaction Control Language)**: Used to manage transactions (COMMIT, ROLLBACK).

**Example DML:**
```sql
INSERT INTO employee (id, name) VALUES (1, 'John');
```
**Example DDL:**
```sql
CREATE TABLE department (id INT, name VARCHAR(50));
```
**Example TCL:**
```sql
COMMIT;
```

---

## ✅ Constraints
Constraints enforce rules on data.
- **PRIMARY KEY**: Uniquely identifies each record.
- **FOREIGN KEY**: Enforces link between two tables.
- **UNIQUE**: Ensures all values are different.
- **NOT NULL**: Ensures a column can't have NULL.
- **CHECK**: Validates condition.

**Example:**
```sql
CREATE TABLE employee (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  dept_id INT,
  CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES department(id)
);
```

---

## ✅ Joins
Joins combine rows from multiple tables based on related columns.
- **INNER JOIN**: Only matching rows.
- **LEFT JOIN**: All from left + matches.
- **RIGHT JOIN**: All from right + matches.
- **FULL JOIN**: All rows from both sides.
- **CROSS JOIN**: Cartesian product.
- **NATURAL JOIN**: Automatically joins on same column names.

**Example (INNER JOIN):**
```sql
SELECT a.name, b.salary
FROM employee a
INNER JOIN payroll b ON a.id = b.emp_id;
```

---

## ✅ Functions
Functions perform operations on data.
- **String Functions**: `CONCAT`, `SUBSTR`, `INSTR`, `LENGTH`, `REVERSE`
- **NULL Functions**: `NVL`, `COALESCE`
- **Numeric Functions**: `MOD`, `ROUND`

**Example:**
```sql
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM users;
SELECT COALESCE(middle_name, 'N/A') FROM users;
SELECT MOD(score, 2) FROM results;
```

---

## ✅ Window Functions
Window functions perform calculations across a set of rows related to the current row.

- **RANK()**: Assigns the same rank to rows with equal values. If two rows tie at rank 1, the next rank is 3 (i.e., it skips ranks).
- **DENSE_RANK()**: Similar to RANK, but does **not** skip any ranks. If two rows tie at rank 1, the next rank is 2.
- **ROW_NUMBER()**: Assigns a unique row number to each row, even if values are the same.

**Difference:**
If 3 people have salaries: 1000, 1000, 900:
- RANK: 1, 1, 3
- DENSE_RANK: 1, 1, 2
- ROW_NUMBER: 1, 2, 3

**Examples:**
```sql
SELECT name, RANK() OVER (ORDER BY salary DESC) AS salary_rank FROM employee;
SELECT name, DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank FROM employee;
SELECT name, ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num FROM employee;
```

---

## ✅ Subqueries & CTEs
- **Subquery**: Query inside another query.
- **CTE (Common Table Expression)**: Temporary named result set.

**Example:**
```sql
WITH top_employees AS (
  SELECT id, salary FROM employee ORDER BY salary DESC LIMIT 5
)
SELECT * FROM top_employees;
```

---

## ✅ Set Operators
Set operators combine result sets.
- `UNION`: Combines and removes duplicates.
- `UNION ALL`: Includes all.
- `INTERSECT`: Only common rows.
- `MINUS`: Subtracts one from another.

**Example:**
```sql
SELECT city FROM customers
UNION
SELECT city FROM suppliers;
```

---

## ✅ Pivoting
Transform data between rows and columns.
- **Pivot**: Rows → Columns
- **Unpivot**: Columns → Rows

**Pivot Example:**
```sql
SELECT * FROM (
  SELECT dept, salary FROM employee
)
PIVOT (
  SUM(salary) FOR dept IN ('HR', 'ENG', 'MKT')
);
```
**Unpivot Example:**
```sql
SELECT emp_id, value
FROM employee
UNPIVOT (
  value FOR col IN (bonus, commission)
);
```

---

## ✅ Common Use-Cases
- **NULL handling**
- **Pattern matching**
- **Aggregations**
- **Row-wise ranking**

**Examples:**
```sql
SELECT NVL(middle_name, 'Unknown') FROM employee;
SELECT * FROM users WHERE name LIKE 'A%';
SELECT department, COUNT(*) FROM employee GROUP BY department;
SELECT name, RANK() OVER (PARTITION BY department ORDER BY salary DESC) FROM employee;
```

---

## 🔭 To-Do: Advanced Topics

- [ ] Indexes (clustered vs non-clustered)
- [ ] Execution Plans & Optimization
- [ ] Transactions & Isolation Levels
- [ ] Stored Procedures & Triggers
- [ ] Temp Tables vs CTE
- [ ] Error Handling
- [ ] Security (GRANT, REVOKE, Roles)
- [ ] Views & Materialized Views

---

## 📌 References

- [SQL Server Docs](https://learn.microsoft.com/en-us/sql/)
- [Oracle SQL Docs](https://docs.oracle.com/en/database/oracle/)
- [SQL Style Guide](https://www.sqlstyle.guide/)
