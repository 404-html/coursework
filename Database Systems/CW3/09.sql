WITH S AS (
     SELECT Ar.aname, Al.title, Al.rating
     FROM Artists Ar 
     	  LEFT JOIN Albums Al
	  ON Ar.aname = Al.artist
),
R AS (
SELECT aname, CAST(COUNT(rating) AS float) total,  
       	      COUNT(rating) filter (where rating >= 3) mt3,  
	      COUNT(rating) filter (where rating <  3) lt3
FROM S
GROUP BY aname
)
SELECT aname, CAST(lt3/total*100 AS numeric(5,2))
FROM R
WHERE total <> 0
ORDER BY aname;
