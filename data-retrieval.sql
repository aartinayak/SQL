
--  >>> Query 1 <<<
-- Table: World

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | name        | varchar |
-- | continent   | varchar |
-- | area        | int     |
-- | population  | int     |
-- | gdp         | int     |
-- +-------------+---------+
-- name is the primary key column for this table.
-- Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.
--  

-- A country is big if:

-- it has an area of at least three million (i.e., 3000000 km2), or
-- it has a population of at least twenty-five million (i.e., 25000000).
-- Write an SQL query to report the name, population, and area of the big countries.

-- Return the result table in any order.

SELECT name AS name, population AS population, area AS area
FROM World
WHERE
area >= 3000000 OR population >= 25000000;

--  >>> Query 2 <<<
-- Table: Customer

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- | referee_id  | int     |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
--  

-- Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.

-- Return the result table in any order.

SELECT name from Customer
WHERE 
referee_id != 2 OR referee_id IS NULL
