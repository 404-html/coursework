WITH S AS (SELECT O.ordid, P.ptype
       	   FROM Products P
	   	LEFT JOIN Details D
		ON P.pcode = D.pcode
		LEFT JOIN Orders O
		ON D.ordid = O.ordid
	   ORDER BY O.ordid)
SELECT S.ptype, COUNT(count)
FROM (SELECT S.ordid, COUNT(DISTINCT S.ptype) count
      FROM S
      GROUP BY S.ordid) R
      RIGHT JOIN S
      ON S.ordid = R.ordid
WHERE R.count = 1
GROUP BY S.ptype;
