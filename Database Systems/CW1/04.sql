SELECT *
FROM Customers C
WHERE NOT EXISTS (SELECT 1
      	  	  FROM Orders O
		  WHERE C.custid = O.ocust
		    AND O.odate BETWEEN '20160101' AND '20161231');
