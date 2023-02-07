-- These queries were run on a MySQL database created using .csv files available per the UML diagram also in this repository
-- Queries run well in a MySQL environment (MySQL Server 8.0.31)

-- Which brand saw the most dollars spent in the month of June? (as Brand Code and sale value):
SELECT BRAND_CODE, SUM(TOTAL_FINAL_PRICE) as sale_june FROM receipt_items WHERE ((REWARDS_RECEIPT_ID IN (SELECT ID FROM receipts WHERE PURCHASE_DATE LIKE '____-06-%')) AND BRAND_CODE <> '') GROUP BY BRAND_CODE ORDER BY sale_june DESC LIMIT 1;
-- Answer: KIRKLAND SIGNATURE, 2571.8299999999936
-- Which brand saw the most dollars spent in the month of June? (as Brand Code & Name that exist in our Brands Table):
SELECT B.BRAND_CODE, B.NAME, A.sale_june FROM brands as B JOIN (SELECT BRAND_CODE, SUM(TOTAL_FINAL_PRICE) as sale_june FROM receipt_items WHERE ((REWARDS_RECEIPT_ID IN (SELECT ID FROM receipts WHERE PURCHASE_DATE LIKE '____-06-%')) AND BRAND_CODE <> '') GROUP BY BRAND_CODE ORDER BY sale_june DESC) AS A ON A.BRAND_CODE=B.BRAND_CODE LIMIT 1;
-- Answer: PEPSI, Pepdi, 491.5200000000002


-- Which user spent the most money in the month of August? (As UserID & Money spent in Aug)
SELECT USER_ID, SUM(TOTAL_SPENT) as money_spent_aug FROM receipts WHERE PURCHASE_DATE LIKE '____-08-%' GROUP BY USER_ID ORDER BY money_spent_aug DESC LIMIT 1;
-- Answer: 609ab37f7a2e8f2f95ae968f, 157739.13999999998


-- What is the name of the most expensive item purchased? (DESCRIPTION, TOTAL_FINAL_PRICE, QUANTITY_PURCHASED)
SELECT DESCRIPTION, TOTAL_FINAL_PRICE, QUANTITY_PURCHASED FROM receipt_items WHERE TOTAL_FINAL_PRICE/QUANTITY_PURCHASED IN (SELECT MAX(TOTAL_FINAL_PRICE/QUANTITY_PURCHASED) FROM receipt_items);
-- Answer: Starbucks Iced Coffee Premium Coffee Beverage Unsweetened Blonde Roast Bottle 48 Oz 1 Ct, 31005.99, 1


-- How many users scanned in each month? (As Month & Num of users that scanned)
SELECT SUBSTRING(DATE_SCANNED,6,2) AS Month_ ,COUNT(DISTINCT USER_ID) AS Num_of_users_that_scanned FROM receipts GROUP BY Month_;
-- Answer: 
-- 01,  97
-- 02,	87
-- 03,	89
-- 04,	90
-- 05,	88
-- 06,	88
-- 07,	88
-- 08,	88
-- 09,	88
-- 10,	91
-- 11,	93
-- 12,	98