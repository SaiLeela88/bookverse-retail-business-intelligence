/* ============================================================
   BOOKVERSE RETAIL BUSINESS INTELLIGENCE & SALES ANALYTICS
   SQL PROJECT
   Database: BookVerse_DB
   ============================================================ */


/* ============================================================
   1. DATABASE SETUP
   ============================================================ */

CREATE DATABASE IF NOT EXISTS BookVerse_DB;
USE BookVerse_DB;


/* ============================================================
   2. DATA VALIDATION
   ============================================================ */

-- Check record counts
SELECT 'Books' AS Table_Name, COUNT(*) AS Record_Count
FROM Books
UNION ALL
SELECT 'Customers', COUNT(*)
FROM Customers
UNION ALL
SELECT 'Orders', COUNT(*)
FROM Orders;

-- Check duplicate Book IDs
SELECT Book_ID, COUNT(*) AS Duplicate_Count
FROM Books
GROUP BY Book_ID
HAVING COUNT(*) > 1;

-- Check duplicate Customer IDs
SELECT Customer_ID, COUNT(*) AS Duplicate_Count
FROM Customers
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- Check duplicate Order IDs
SELECT Order_ID, COUNT(*) AS Duplicate_Count
FROM Orders
GROUP BY Order_ID
HAVING COUNT(*) > 1;


/* ============================================================
   3. SPRINT 3 – OVERALL BUSINESS ANALYSIS
   ============================================================ */

-- Total number of books
SELECT COUNT(*) AS Total_Books
FROM Books;

-- Total number of customers
SELECT COUNT(*) AS Total_Customers
FROM Customers;

-- Total number of orders
SELECT COUNT(*) AS Total_Orders
FROM Orders;

-- Total number of genres
SELECT COUNT(DISTINCT Genre) AS Total_Genres
FROM Books;

-- List of genres
SELECT DISTINCT Genre
FROM Books
ORDER BY Genre;

-- Total number of countries
SELECT COUNT(DISTINCT Country) AS Total_Countries
FROM Customers;

-- Total quantity sold
SELECT SUM(Quantity) AS Total_Quantity_Sold
FROM Orders;

-- Total revenue
SELECT ROUND(SUM(Total_Amount), 2) AS Total_Revenue
FROM Orders;

-- Average order value
SELECT ROUND(AVG(Total_Amount), 2) AS Average_Order_Value
FROM Orders;


/* ============================================================
   4. SPRINT 4.1 – SALES ANALYSIS
   ============================================================ */

-- Total order volume
SELECT COUNT(*) AS Total_Orders
FROM Orders;

-- Total quantity sold
SELECT SUM(Quantity) AS Total_Quantity_Sold
FROM Orders;

-- Total revenue
SELECT ROUND(SUM(Total_Amount), 2) AS Total_Revenue
FROM Orders;

-- Sales by book
SELECT
    b.Book_ID,
    b.Title,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Quantity_Sold DESC;

-- Sales by author
SELECT
    b.Author,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY Revenue DESC;

-- Sales by genre
SELECT
    b.Genre,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC;

-- Monthly sales trend
SELECT
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,
    COUNT(*) AS Total_Orders,
    SUM(Quantity) AS Quantity_Sold,
    ROUND(SUM(Total_Amount), 2) AS Revenue
FROM Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Order_Year, Order_Month;

-- Yearly sales trend
SELECT
    YEAR(Order_Date) AS Order_Year,
    COUNT(*) AS Total_Orders,
    SUM(Quantity) AS Quantity_Sold,
    ROUND(SUM(Total_Amount), 2) AS Revenue
FROM Orders
GROUP BY YEAR(Order_Date)
ORDER BY Order_Year;

-- High-value books
SELECT
    b.Book_ID,
    b.Title,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
HAVING SUM(o.Total_Amount) >= 500
ORDER BY Revenue DESC;

-- High-volume books
SELECT
    b.Book_ID,
    b.Title,
    SUM(o.Quantity) AS Quantity_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
HAVING SUM(o.Quantity) >= 15
ORDER BY Quantity_Sold DESC;


/* ============================================================
   5. SPRINT 4.2 – CUSTOMER ANALYSIS
   ============================================================ */

-- Orders by customer
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Orders DESC;

-- Total purchase by customer
SELECT
    c.Customer_ID,
    c.Name,
    ROUND(SUM(o.Total_Amount), 2) AS Total_Purchase
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Purchase DESC;

-- Average spending by customer
SELECT
    c.Customer_ID,
    c.Name,
    ROUND(AVG(o.Total_Amount), 2) AS Average_Spending
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Average_Spending DESC;

-- Repeat customers
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2
ORDER BY Total_Orders DESC;

-- Customer activity by country
SELECT
    c.Country,
    COUNT(DISTINCT c.Customer_ID) AS Active_Customers,
    COUNT(o.Order_ID) AS Total_Orders,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Country
ORDER BY Revenue DESC;

-- Customers buying multiple genres
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(DISTINCT b.Genre) AS Genres_Purchased
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
JOIN Books b
    ON o.Book_ID = b.Book_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(DISTINCT b.Genre) >= 2
ORDER BY Genres_Purchased DESC;

-- High-value customers
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Quantity) AS Total_Quantity,
    ROUND(SUM(o.Total_Amount), 2) AS Total_Spending
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spending DESC;


/* ============================================================
   6. SPRINT 4.3 – PRODUCT ANALYSIS
   ============================================================ */

-- Highest quantity-selling books
SELECT
    b.Book_ID,
    b.Title,
    SUM(o.Quantity) AS Quantity_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Quantity_Sold DESC;

-- Highest revenue-generating books
SELECT
    b.Book_ID,
    b.Title,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Revenue DESC;

-- Genre-wise sales
SELECT
    b.Genre,
    SUM(o.Quantity) AS Quantity_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Quantity_Sold DESC;

-- Genre-wise revenue
SELECT
    b.Genre,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC;

-- Author performance
SELECT
    b.Author,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY Revenue DESC;

-- High-priced books
SELECT
    Book_ID,
    Title,
    Author,
    Genre,
    Price
FROM Books
WHERE Price >= 40
ORDER BY Price DESC;

-- Low-sales books
SELECT
    b.Book_ID,
    b.Title,
    b.Price,
    COALESCE(SUM(o.Quantity), 0) AS Quantity_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Price
HAVING COALESCE(SUM(o.Quantity), 0) <= 5
ORDER BY Quantity_Sold ASC;

-- Never-ordered books
SELECT
    b.Book_ID,
    b.Title,
    b.Author,
    b.Genre,
    b.Price
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL
ORDER BY b.Book_ID;

-- Price vs sales
SELECT
    b.Book_ID,
    b.Title,
    b.Price,
    COALESCE(SUM(o.Quantity), 0) AS Quantity_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Price
ORDER BY b.Price DESC;


/* ============================================================
   7. SPRINT 4.4 – INVENTORY ANALYSIS
   ============================================================ */

-- Current stock
SELECT
    Book_ID,
    Title,
    Genre,
    Stock
FROM Books
ORDER BY Stock ASC;

-- Low-stock books
SELECT
    Book_ID,
    Title,
    Genre,
    Stock
FROM Books
WHERE Stock <= 10
ORDER BY Stock ASC;

-- Stock by genre
SELECT
    Genre,
    SUM(Stock) AS Total_Stock
FROM Books
GROUP BY Genre
ORDER BY Total_Stock DESC;

-- Inventory value by genre
SELECT
    Genre,
    ROUND(SUM(Price * Stock), 2) AS Inventory_Value
FROM Books
GROUP BY Genre
ORDER BY Inventory_Value DESC;

-- Inventory value by author
SELECT
    Author,
    ROUND(SUM(Price * Stock), 2) AS Inventory_Value
FROM Books
GROUP BY Author
ORDER BY Inventory_Value DESC;

-- High-value inventory
SELECT
    Book_ID,
    Title,
    Price,
    Stock,
    ROUND(Price * Stock, 2) AS Inventory_Value
FROM Books
ORDER BY Inventory_Value DESC;

-- High-stock / low-sales books
SELECT
    b.Book_ID,
    b.Title,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Quantity_Sold,
    ROUND(b.Price * b.Stock, 2) AS Inventory_Value
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock, b.Price
HAVING b.Stock >= 50
   AND COALESCE(SUM(o.Quantity), 0) <= 5
ORDER BY b.Stock DESC;

-- Low-stock / high-sales books
SELECT
    b.Book_ID,
    b.Title,
    b.Stock,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
HAVING b.Stock <= 20
   AND SUM(o.Quantity) >= 15
ORDER BY Quantity_Sold DESC;

-- Never-ordered books with inventory
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    b.Price,
    ROUND(b.Price * b.Stock, 2) AS Inventory_Value
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL
ORDER BY Inventory_Value DESC;


/* ============================================================
   8. SPRINT 4.5 – BUSINESS OPPORTUNITIES
   ============================================================ */

-- High-selling books with low stock
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock
HAVING b.Stock <= 20
   AND SUM(o.Quantity) >= 15
ORDER BY Quantity_Sold DESC;

-- High-stock books with low sales
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Quantity_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock
HAVING b.Stock >= 50
   AND COALESCE(SUM(o.Quantity), 0) <= 5
ORDER BY b.Stock DESC;

-- Popular genres with limited inventory
SELECT
    b.Genre,
    SUM(o.Quantity) AS Quantity_Sold,
    SUM(b.Stock) AS Available_Stock,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Quantity_Sold DESC;

-- High-value customers
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Quantity) AS Quantity_Purchased,
    ROUND(SUM(o.Total_Amount), 2) AS Total_Spending
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING SUM(o.Total_Amount) >= 500
ORDER BY Total_Spending DESC;

-- Strong demand books
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre
HAVING SUM(o.Quantity) >= 15
ORDER BY Quantity_Sold DESC;

-- Multi-genre customers
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(DISTINCT b.Genre) AS Genres_Purchased
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
JOIN Books b
    ON o.Book_ID = b.Book_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(DISTINCT b.Genre) >= 2
ORDER BY Genres_Purchased DESC;

-- Promotional attention
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Quantity_Sold,
    ROUND(b.Price * b.Stock, 2) AS Inventory_Value
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock, b.Price
HAVING b.Stock >= 50
   AND COALESCE(SUM(o.Quantity), 0) <= 5
ORDER BY Inventory_Value DESC;

-- Replenishment candidates
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    SUM(o.Quantity) AS Quantity_Sold,
    ROUND(SUM(o.Total_Amount), 2) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock
HAVING b.Stock <= 20
   AND SUM(o.Quantity) >= 15
ORDER BY Quantity_Sold DESC;


/* ============================================================
   9. COMBINED BUSINESS OPPORTUNITY CLASSIFICATION
   ============================================================ */

SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Quantity_Sold,

    CASE
        WHEN b.Stock <= 20
             AND COALESCE(SUM(o.Quantity), 0) >= 15
            THEN 'Replenishment Required'

        WHEN b.Stock >= 50
             AND COALESCE(SUM(o.Quantity), 0) <= 5
            THEN 'Promotional Attention'

        WHEN COALESCE(SUM(o.Quantity), 0) = 0
            THEN 'Never Ordered'

        ELSE 'Normal'
    END AS Business_Opportunity

FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID

GROUP BY
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock

ORDER BY Business_Opportunity, Quantity_Sold DESC;


/* ============================================================
   END OF BOOKVERSE RETAIL ANALYTICS PROJECT
   ============================================================ */