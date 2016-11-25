WITH S AS (
     SELECT Ar.aname, Al.title, Al.ryear, Al.rating
     FROM Artists Ar 
     	  LEFT JOIN Albums Al
	  ON Ar.aname = Al.artist
WHERE Ar.atype = 'BAND'
  AND Al.title IS NOT NULL
)
SELECT S1.title, S1.aname
FROM S S1
WHERE NOT EXISTS ( SELECT *
      	  	   FROM S S2
		   WHERE S1.aname = S2.aname
		     AND S1.title <> S2.title
		     AND S2.ryear < S1.ryear
		     AND S2.rating >= S1.rating )
ORDER BY S1.aname, S1.title;
