SELECT *
FROM Orders O
WHERE O.odate < '20160916'
  AND NOT EXISTS (SELECT 1
      	  	  FROM Details D
		  WHERE O.ordid = D.ordid);
