WITH S AS (
SELECT C.custid, P.ptype, COUNT(P.ptype) count
FROM Customers C
     LEFT JOIN Orders O
     ON O.ocust = C.custid
     AND O.odate BETWEEN '20160101' AND '20161231'
     LEFT JOIN Details D
     ON O.ordid = D.ordid
     LEFT JOIN products P
     ON D.pcode = P.pcode
GROUP BY C.custid, P.ptype
ORDER BY C.custid
)
SELECT DISTINCT S1.custid
FROM S AS S1
WHERE NOT EXISTS (SELECT *
      	  	FROM S AS S2
		WHERE S1.custid = S2.custid
		  AND S2.ptype = 'BOOK')
ORDER BY S1.custid;
