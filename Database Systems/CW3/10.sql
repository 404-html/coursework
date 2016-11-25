WITH S AS (
     SELECT Ar.aname, Al.title, Al.ryear, Al.rtype
     FROM Artists Ar 
     	  LEFT JOIN Albums Al
	  ON Ar.aname = Al.artist
          AND Al.rtype = 'STUDIO'
),
R AS(
SELECT S1.aname, S1.ryear y1, S2.ryear y2
FROM S S1
     LEFT JOIN S S2
     ON  S1.aname =  S2.aname
     AND S1.title <> S2.title
     AND S1.ryear <  S2.ryear
WHERE NOT EXISTS ( SELECT *
     	       	   FROM S S3
		   WHERE S1.aname = S3.aname
		     AND S1.ryear < S3.ryear
		     AND S3.ryear < S2.ryear)
ORDER BY S1.aname, S1.ryear
)
SELECT Ar.aname
FROM Artists Ar
WHERE NOT EXISTS ( SELECT *
      	  	   FROM R
		   WHERE Ar.aname = R.aname
		     AND (R.y2 - R.y1) > 4)
ORDER BY Ar.aname;
