SELECT province, city, first_name, last_name, total
FROM (SELECT c.PROVINCE, c.CITY, c.first_name, c.last_name, Min(o.total_price) as total,
             ROW_NUMBER() OVER (PARTITION BY c.province ORDER BY Min(o.total_price)) as amount
      FROM orders o INNER JOIN
           customers c
           ON o.customer_id= c.customer_id
      GROUP BY c.PROVINCE, c.CITY, c.last_name, c.first_name
     ) sc
WHERE amount = 1
ORDER BY total DESC;