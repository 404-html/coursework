WITH SS AS (
SELECT C.custid, O.odate, O.ordid
FROM Customers C
     LEFT JOIN Orders O
     ON C.custid = O.ocust
ORDER BY C.custid, O.odate),
      
     S AS (
SELECT S11.custid, S11.odate, S11.ordid
FROM SS S11
WHERE NOT EXISTS (SELECT *
      	  	  FROM SS S12
		  WHERE S11.custid = S12.custid
		    AND S11.odate = S12.odate
		    AND S11.ordid > S12.ordid)),

     R AS (
SELECT S1.custid, DATE_PART('day',S1.odate::timestamp - S2.odate::timestamp) AS diff
FROM S S1
     LEFT JOIN S S2
     ON S1.custid = S2.custid
     AND S1.ordid <> S2.ordid
     AND S1.odate > S2.odate  
WHERE NOT EXISTS (SELECT *
      	  	  FROM S S3
		  WHERE S1.custid = S3.custid
		    AND S1.ordid <> S3.ordid
		    AND S3.ordid <> S2.ordid
		    AND S1.odate>S3.odate
		    AND S3.odate>S2.odate)
      AND S2.odate IS NOT NULL
ORDER BY S1.custid)

SELECT T.custid
FROM (SELECT R.custid, COUNT(R.diff) count, AVG(R.diff) avg
      FROM R
      GROUP BY R.custid
      ORDER BY R.custid) T
WHERE T.count > 4
  AND T.avg < 30;
