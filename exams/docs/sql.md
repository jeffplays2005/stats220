`ROUND` is a function that rounds a number to a specified number of decimal places.

`AVG` is a function that calculates the average of a set of values, and takes an optional parameter to specify the number of decimal places to round to (defaults to 0).

`GROUP BY` is a clause that groups rows that have the same values into summary rows, and takes one or more columns as arguments.

`INNER JOIN <table>` and `ON <table.key = table2.key2>` are used to combine rows from two or more tables based on a related column between them. An example:

```sql
SELECT students.name, AVG(grades.grade) AS average_grade
FROM students
INNER JOIN grades ON students.id = grades.student_id
GROUP BY students.name;
```
