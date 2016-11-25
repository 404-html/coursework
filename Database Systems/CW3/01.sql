WITH S AS (
SELECT Ar.aname, Al.rtype, COUNT(Al.rtype) acount
FROM Artists Ar
     LEFT JOIN Albums Al
     ON Ar.aname = Al.artist
GROUP BY Ar.aname, Al.rtype
ORDER BY Ar.aname
)
SELECT S1.aname
FROM S S1
WHERE S1.rtype = 'STUDIO'
  AND S1.acount >= 1
  AND NOT EXISTS ( SELECT *
      	  	   FROM S S2
		   WHERE S1.aname = S2.aname
		     AND S2.rtype <> 'STUDIO');
