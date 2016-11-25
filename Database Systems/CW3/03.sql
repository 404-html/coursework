WITH S AS (
     SELECT Ar.aname, Al.title, Al.ryear, Al.rating
     FROM Artists Ar 
     	  LEFT JOIN Albums Al
	  ON Ar.aname = Al.artist
	  AND Al.rtype = 'LIVE'
WHERE Ar.country = 'GBR'
  AND Al.title IS NOT NULL
),
R AS (SELECT Al.ryear, AVG(Al.rating) rating
      FROM Albums Al
      GROUP BY Al.ryear
)
SELECT S.title, S.aname
FROM S, R 
WHERE S.ryear = R.ryear
  AND S.rating > R.rating
ORDER BY S.title, S.aname;
