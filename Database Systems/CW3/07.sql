WITH S AS (
     SELECT Ar.aname, Al.rtype
     FROM Artists Ar 
     	  LEFT JOIN Albums Al
	  ON Ar.aname = Al.artist
),
R AS (
SELECT aname, COUNT(rtype) filter (where rtype = 'LIVE') lc,  
       	      COUNT(rtype) filter (where rtype = 'STUDIO') sc,  
	      COUNT(rtype) filter (where rtype = 'COMPILATION') cc
FROM S
GROUP BY aname
ORDER BY aname
)
SELECT aname
FROM R
WHERE (lc + cc) > sc
ORDER BY aname;
