SELECT P.ptype, CAST(
		     CAST(SUM(D.qty) AS float)/
       		     CAST(COUNT(DISTINCT O.ordid) AS float)
		AS numeric(5,2)) average
FROM Products P
     LEFT JOIN Details D
     ON P.pcode = D.pcode
     LEFT JOIN Orders O
     ON D.ordid = O.ordid
GROUP BY P.ptype;
