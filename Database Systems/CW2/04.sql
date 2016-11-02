WITH S AS ( SELECT C.custid, P.ptype, COUNT(P.ptype) count
       	    FROM Products P
       	    	 RIGHT JOIN Details D
     	    	 ON P.pcode = D.pcode
    	    	 RIGHT JOIN Orders O
    	    	 ON D.ordid = O.ordid
    	    	 RIGHT JOIN Customers C
    	    	 ON O.ocust = C.custid
       	    GROUP BY C.custid, P.ptype
       	    ORDER BY C.custid )

SELECT S.ptype, S.custid
FROM (SELECT S.ptype, MAX(S.count) count  
      FROM S
      GROUP BY S.ptype) T, S
WHERE T.ptype = S.ptype
  AND T.count = S.count;
