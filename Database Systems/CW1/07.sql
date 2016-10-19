SELECT *
FROM (SELECT P.pcode, SUM(D.qty) AS total
      FROM Products P, Details D
      WHERE P.pcode = D.pcode
      GROUP BY P.pcode) AS s
WHERE s.total > 10
