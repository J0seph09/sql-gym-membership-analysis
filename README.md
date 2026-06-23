# sql-gym-membership-analysis

## Project Overview
In this personal project I analyzed a simulated gym memembership dataset modeled after the Anytime Fitness-style membership business in Lacey Township, NJ. The database tracks membership plans, customers, referrals, active/churned memberships, monthly dues, failed payments, and customer-level revenue.

## Database Design
The project uses four tables:
- The "plans" table is membership types and monthly prices
- The "customers" table is customer records and referral relationships
- The "memberships" table is customer plan enrollment, start and end dates and membership status
- The "monthly_dues" table is the monthly billing records, payment amounts, and payment status

## SQL Concepts Used
- Table creation with primary keys and foreign keys
- Relational joins
- Self-joins
- Conditional aggregation with SUM(CASE WHEN...)
- Common table expressions
- Window functions
- Date math with `DATEDIFF`
- Grouping and ordering
- Customer lifetime value analysis

## Business/Finance Questions Answered 
- How much revenue does each plan generate by month?
- What is total monthly recurring revenue?
- Which membership plan generates the most total revenue?
- What is the failed payment rate by month?
- Which customers were referred by other customers?
- What is the 3-month moving average of revenue?
- What is the average customer lifetime for active vs. churned memberships?
- What is the overall churn rate?
- Which customers have generated the highest lifetime revenue?

## Key Findings 
- Total paid revenue across the dataset was $1,967.00.
- Customer lifetime value analysis showed that the highest-revenue customers were primarily on the Pro plan because of the higher monthly price.
- The student plan generated the highest total revenue at $1,015.00.
- The overall churn rate was **25.0%**.
- Failed payment rates were highest in months where the sample had fewer total billings or multiple failed payments.

## Files
- Anytime Fitness Sql.sql: full SQL script
- charts and data.pdf
