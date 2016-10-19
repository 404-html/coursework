SELECT DISTINCT C.custid, C.cname, O.odate
FROM Customers C, Orders O
WHERE C.custid = O.ocust
  AND odate >= ALL(SELECT O2.odate
      	  	   FROM   Orders O2
	 	   WHERE  C.custid = O2.ocust);
