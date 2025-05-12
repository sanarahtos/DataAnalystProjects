-- sandwich categories
SELECT DISTINCT Category
FROM PortfolioProject.dbo.LBSandwiches;

-- top sandwiches overall
SELECT Item, SUM(Quantity) AS total
FROM PortfolioProject.dbo.LBSandwiches
GROUP BY Item
ORDER BY total DESC;

-- top veggie sandwiches 
SELECT Item, SUM(Quantity) AS total
FROM PortfolioProject.dbo.LBSandwiches
WHERE Category = 'VEGGIE SANDWICHES'
GROUP BY Item
ORDER BY total DESC;

-- top vegan sandwiches 
SELECT Item, SUM(Quantity) AS total
FROM PortfolioProject.dbo.LBSandwiches
WHERE Category = 'VEGAN SANDWICHES'
GROUP BY Item
ORDER BY total DESC;

-- LB Sales by week
SELECT Week, SUM(CAST(REPLACE(Sales, ',', '') AS INT)) AS weekly_sales
FROM PortfolioProject.dbo.LocSales
WHERE Location = 'Long Beach'
GROUP BY Week
ORDER BY Week;

-- LB Labor by week
SELECT Week, SUM(CAST(REPLACE(Labor_Hrs, ',', '') AS INT)) AS weekly_labor
FROM PortfolioProject.dbo.LocLabor
WHERE Location = 'Long Beach'
GROUP BY Week
ORDER BY Week;

-- total orders grouped by order type
SELECT Order_Type, (COUNT(Order_Type)) AS count_orders
FROM PortfolioProject.dbo.LBSandwiches
GROUP BY Order_Type;
