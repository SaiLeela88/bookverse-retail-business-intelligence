# 📚 BookVerse Retail Business Intelligence & Sales Analytics

## 📌 Project Overview

BookVerse is a retail bookstore business that sells books across multiple genres through online and offline channels.

This project uses **MySQL and SQL** to analyze sales performance, customer purchasing behavior, product demand, and inventory availability.

The objective is to transform raw retail transaction data into meaningful business insights that can support better sales, customer, product, and inventory decisions.

---

## 🎯 Business Objectives

- Analyze overall sales and revenue performance
- Identify top-selling books and genres
- Understand customer purchasing behavior
- Identify high-value and repeat customers
- Analyze product and author performance
- Identify low-selling and never-ordered books
- Monitor inventory levels
- Identify high-demand books with low stock
- Identify high-stock books with low sales
- Generate actionable business recommendations

---

## 🗂️ Database Structure

The project uses three main tables:

### 📖 Books

Contains information about the bookstore's products.

- Book_ID
- Title
- Author
- Genre
- Published_Year
- Price
- Stock

### 👤 Customers

Contains customer information.

- Customer_ID
- Name
- Email
- Phone
- City
- Country

### 🛒 Orders

Contains customer order and sales information.

- Order_ID
- Customer_ID
- Book_ID
- Order_Date
- Quantity
- Total_Amount

### 🔗 Relationships

- `Customers.Customer_ID → Orders.Customer_ID`
- `Books.Book_ID → Orders.Book_ID`

---

## 📊 Dataset Summary

| Metric | Value |
|---|---:|
| Books | 500 |
| Customers | 500 |
| Orders | 500 |
| Genres | 7 |
| Countries | 215 |
| Quantity Sold | 2,697 |
| Total Revenue | ₹75,628.66 |
| Average Order Value | ₹151.26 |
| Active Customers | 307 |
| Repeat Customers | 139 |
| Never-Ordered Books | 183 |

---

## 🔍 Analysis Performed

### 1. Overall Business Analysis

- Total books
- Total customers
- Total orders
- Total genres
- Countries served
- Total quantity sold
- Total revenue
- Average order value

### 2. Sales Analysis

- Sales by book
- Sales by author
- Sales by genre
- Monthly sales trends
- Yearly sales trends
- High-value books
- High-volume books

### 3. Customer Analysis

- Orders per customer
- Total customer spending
- Average customer spending
- Repeat customers
- Customer activity by country
- Multi-genre customers
- High-value customers

### 4. Product Analysis

- Highest quantity-selling books
- Highest revenue-generating books
- Genre-wise sales
- Genre-wise revenue
- Author performance
- High-priced books
- Low-sales books
- Never-ordered books
- Price vs. sales analysis

### 5. Inventory Analysis

- Current stock levels
- Low-stock books
- Stock by genre
- Inventory value by genre
- Inventory value by author
- High-value inventory
- High-stock / low-sales books
- Low-stock / high-sales books
- Never-ordered inventory

### 6. Business Opportunity Analysis

- High-selling books with low stock
- High-stock books with low sales
- Popular genres with limited inventory
- High-value customers
- Strong-demand books
- Multi-genre customers
- Promotional opportunities
- Replenishment opportunities

---

## 💡 Key Findings

- **Mystery** was the highest-selling genre with **504 copies sold**.
- **Romance** generated the highest revenue at **₹13,086.98**.
- Several books showed strong sales volume and should be monitored for inventory replenishment.
- **183 books were never ordered**, indicating a significant slow-moving or inactive product segment.
- **139 customers were repeat customers**, showing opportunities for customer retention strategies.
- Total inventory value was approximately **₹6.85 lakh**.
- Some books had high inventory but very low sales, creating opportunities for promotional campaigns.
- Price alone was not a major driver of sales; the price-sales correlation was approximately **0.045**.

---

## 🚀 Business Recommendations

### 📦 Inventory Replenishment

Prioritize high-demand books with low stock to reduce the risk of stockouts and lost sales.

### 🎯 Targeted Promotions

Use discounts, bundles, and promotional campaigns for high-stock and low-sales books.

### 📚 Genre Strategy

Focus marketing and inventory planning on high-performing genres such as Romance and Mystery.

### 👥 Customer Retention

Develop loyalty programs and personalized recommendations for repeat and high-value customers.

### ✍️ Author Promotion

Promote books from high-performing authors to increase sales opportunities.

### 🔎 Product Portfolio Review

Review never-ordered and consistently low-selling books before future inventory purchases.

---

## 🛠️ Tools & Technologies

- **MySQL**
- **SQL**
- **MySQL Workbench**
- **CSV Dataset**
- **GitHub**

---

## 📁 Project Structure

```text
bookverse-retail-business-intelligence/
│
├── Dataset/
│   ├── Books_clean.csv
│   ├── customers_clean.csv
│   └── orders_clean.csv
│
├── SQL/
│   └── BookVerse_Retail_Analysis.sql
│
├── ER_Diagram/
│   └── ER_diagram.png
│
└── PPT/
    └── Book Verse Retail Sales Analytics.pptx.key
