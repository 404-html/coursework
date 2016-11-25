WITH S AS (
     SELECT Ar.aname, Al.title, Al.tracks, T.track_number, Al.ryear, T.track_length
     FROM Artists Ar
     	  LEFT JOIN Albums Al
	  ON Ar.aname = Al.artist
	  LEFT JOIN Tracks T
	  ON Ar.aname = T.album_artist
	  AND Al.title = T.album_title
),
R AS (
  SELECT S.aname, S.title, COUNT(S.track_number) ht, SUM(S.track_length) sl
  FROM S
  GROUP BY S.aname, S.title
),
T AS (
  SELECT DISTINCT S.title, S.aname, S.tracks, S.ryear
  FROM S
)
SELECT CAST(FLOOR(AVG(R.sl)/60) AS INTEGER) minutes, CAST(AVG(R.sl)%60 AS INTEGER) seconds
FROM R, T
WHERE T.title = R.title
  AND T.aname = R.aname
  AND T.tracks = R.ht
  AND T.tracks >= 10
  AND T.ryear BETWEEN '1990' AND '1999';
