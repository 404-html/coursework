SELECT C.country, COUNT(O)
FROM Customers C, Orders O
WHERE C.custid = O.ocust
  AND O.odate BETWEEN '20160101' AND '20161231'
GROUP BY C.country;
