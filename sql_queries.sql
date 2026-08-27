

SELECT COUNT(*) FROM orders;

SELECT SUM(Net_Amount) FROM orders;

SELECT Product, SUM(Net_Amount)
FROM orders
GROUP BY Product
ORDER BY 2 DESC;

SELECT City, SUM(Net_Amount)
FROM orders
GROUP BY City;

SELECT Month, SUM(Net_Amount)
FROM orders
GROUP BY Month;

SELECT Product, SUM(Profit)
FROM orders
GROUP BY Product
ORDER BY 2 DESC;

SELECT Payment_Mode, COUNT(*)
FROM orders
GROUP BY Payment_Mode;

SELECT * FROM orders
WHERE Order_Status = 'Cancelled';