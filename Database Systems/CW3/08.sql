WITH S AS (
     SELECT Ar.aname, Al.title, Al.ryear, Al.rating
     FROM Artists Ar 
     	  LEFT JOIN Albums Al
	  ON Ar.aname = Al.artist
WHERE Ar.country = 'USA'
  AND Ar.atype = 'BAND'
)
SELECT COUNT(S1.aname)
FROM S S1
WHERE S1.rating = 5
  AND NOT EXISTS (SELECT *
      	  	  FROM S S2
		  WHERE S1.aname =  S2.aname
		    AND S1.title <> S2.title
		    AND S2.ryear <  S1.ryear);
