
SELECT S.custid, COUNT(DISTINCT S.ordid), CAST(SUM(S.spent)/NULLIF(COUNT(DISTINCT S.ordid),0) AS numeric(5,2))
FROM (SELECT C.custid, O.ordid, COALESCE(SUM(D.qty*P.price),0) spent
      FROM Customers C
     	  LEFT JOIN Orders O
     	  ON C.custid = O.ocust
     	  LEFT JOIN Details D
     	  ON O.ordid = D.ordid
     	  LEFT JOIN Products P
     	  ON D.pcode = P.pcode
      GROUP BY C.custid, O.ordid
      ORDER BY C.custid
     ) AS S
GROUP BY S.custid;
