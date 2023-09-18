/* Write your T-SQL query statement below */
WITH salary_table AS (
    SELECT DISTINCT
        departmentId,
        salary
    FROM Employee
), salary_rank AS (
    SELECT
        ROW_NUMBER() OVER (PARTITION BY departmentId ORDER BY salary DESC) as row_num,
        departmentId,
        salary
    FROM salary_table
)

SELECT
    dpt.name AS Department,
    emp.name AS Employee,
    emp.salary AS Salary
FROM salary_rank sr
LEFT JOIN Employee emp
    ON emp.salary = sr.salary AND emp.departmentId = sr.departmentId
LEFT JOIN Department dpt
    ON emp.departmentId = dpt.id
WHERE sr.row_num <= 3
