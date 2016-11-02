SELECT C.country, COUNT(O.ordid)
FROM Customers C 
     LEFT OUTER JOIN Orders O
     ON C.custid = O.ocust
     AND O.odate BETWEEN '20160101' AND '20161231'
GROUP BY C.country;
