SELECT O.ordid, O.odate, SUM(s.amount) AS amount
FROM Orders O, (SELECT D.ordid, (D.qty * P.price) AS amount
     	        FROM Details D, Products P
     	  	WHERE D.pcode = P.pcode) AS s
WHERE O.ordid = s.ordid
  AND NOT EXISTS (SELECT *
      	  	  FROM Invoices I
		  WHERE O.ordid = I.ordid)
GROUP BY O.ordid;
