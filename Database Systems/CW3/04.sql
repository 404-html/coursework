SELECT Al.title, Ar.aname, T.track_number
FROM Artists Ar
     LEFT JOIN Albums Al
     ON Ar.aname = Al.artist
     LEFT JOIN Tracks T
     ON Ar.aname = T.album_artist
     AND Al.title = T.album_title
WHERE T.track_length < 154
  AND Al.rating >= 4
  AND Al.ryear > 1995
ORDER BY Al.title, Ar.aname, T.track_number;

