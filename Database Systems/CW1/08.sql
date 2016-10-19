SELECT s.pcode, s.price
FROM (SELECT P.pcode, P.price, AVG(D.qty) AS avg
      FROM Products P, Details D
      WHERE P.pcode = D.pcode
      GROUP BY P.pcode) AS s
WHERE s.avg >= 8;
