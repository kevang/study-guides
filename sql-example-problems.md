## SQL for Analytics

### Example Problems

#### Medium: Department Top Three Salaries

**Problem**: Write a SQL query to find employees who earn the top three salaries in each department.

```sql
SELECT d.Name AS Department, e.Name AS Employee, e.Salary
FROM Employee e
JOIN Department d ON e.DepartmentId = d.Id
WHERE (
    SELECT COUNT(DISTINCT e2.Salary)
    FROM Employee e2
    WHERE e2.Salary > e.Salary AND e2.DepartmentId = e.DepartmentId
) < 3
ORDER BY d.Name, e.Salary DESC;
```

#### Medium: Consecutive Numbers

**Problem**: Write a SQL query to find all numbers that appear at least three times consecutively.

```sql
SELECT DISTINCT l1.Num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 ON l1.Id = l2.Id - 1 AND l1.Num = l2.Num
JOIN Logs l3 ON l2.Id = l3.Id - 1 AND l2.Num = l3.Num;
```

#### Advanced: Human Traffic of Stadium

**Problem**: Write a SQL query to display the records with three or more consecutive rows where the amount of people is greater than or equal to 100.

```sql
SELECT DISTINCT s1.*
FROM Stadium s1
JOIN Stadium s2 ON ABS(s1.id - s2.id) <= 2
JOIN Stadium s3 ON ABS(s1.id - s3.id) <= 2 AND ABS(s2.id - s3.id) <= 2
WHERE s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100
    AND s1.id != s2.id AND s1.id != s3.id AND s2.id != s3.id
ORDER BY s1.id;
```

#### Advanced: Market Analysis

**Problem**: Write a SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.

```sql
SELECT u.user_id AS buyer_id, u.join_date, 
    COUNT(CASE WHEN YEAR(o.order_date) = 2019 THEN 1 ELSE NULL END) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.buyer_id
GROUP BY u.user_id, u.join_date
ORDER BY u.user_id;
```

#### Advanced: Tournament Winners

**Problem**: Write a SQL query to find the winner in each group.

```sql
WITH PlayerScores AS (
    SELECT player_id, group_id, SUM(score) AS total_score
    FROM (
        SELECT first_player AS player_id, first_score AS score
        FROM Matches m
        JOIN Players p ON m.first_player = p.player_idgg
        
        UNION ALL
        
        SELECT second_player, second_score
        FROM Matches m
        JOIN Players p ON m.second_player = p.player_id
    ) AS scores
    JOIN Players p ON scores.player_id = p.player_id
    GROUP BY player_id, group_id
),
RankedScores AS (
    SELECT player_id, group_id, total_score,
        RANK() OVER (PARTITION BY group_id ORDER BY total_score DESC, player_id) AS rnk
    FROM PlayerScores
)
SELECT group_id, player_id
FROM RankedScores
WHERE rnk = 1
ORDER BY group_id;
```