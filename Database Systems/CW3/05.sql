WITH S AS (
     SELECT Ar.aname, Al.title, Al.tracks, T.track_number
     FROM Artists Ar
     	  LEFT JOIN Albums Al
	  ON Ar.aname = Al.artist
	  LEFT JOIN Tracks T
	  ON Ar.aname = T.album_artist
	  AND Al.title = T.album_title
),
R AS (
  SELECT S.aname, S.title, COUNT(S.track_number) ht
  FROM S
  GROUP BY S.aname, S.title
),
T AS (
  SELECT DISTINCT S.title, S.aname, S.tracks
  FROM S
)
SELECT T.title, T.aname, (T.tracks - R.ht)
FROM R, T
     WHERE T.title = R.title
     AND T.aname = R.aname
     AND T.tracks > R.ht
ORDER BY T.title, T.aname;
