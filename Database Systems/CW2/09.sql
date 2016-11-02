WITH S AS (
SELECT C.custid, O.odate, O.ordid
FROM Customers C
     LEFT JOIN Orders O
     ON C.custid = O.ocust
ORDER BY C.custid, O.odate)

SELECT S1.custid, MAX(S1.odate - S2.odate)
FROM S S1
     LEFT JOIN S S2
     ON S1.custid = S2.custid
     AND S1.ordid <> S2.ordid
     AND S1.odate >= S2.odate  
WHERE NOT EXISTS (SELECT *
      	  	  FROM S S3
		  WHERE S1.custid = S3.custid
		    AND S1.odate>S3.odate
		    AND S3.odate>S2.odate)
      AND S2.odate IS NOT NULL
GROUP BY S1.custid
ORDER BY S1.custid;
