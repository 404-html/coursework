SELECT S.invid
FROM (SELECT I.invid, I.amount, SUM(P.price*D.qty) price
      FROM Invoices I
      	   LEFT JOIN Details D
      	   ON I.ordid = D.ordid
      	   LEFT JOIN Products P
      	   ON D.pcode = P.pcode
      GROUP BY I.invid) S
WHERE S.amount >= CAST((S.price*1.2) AS numeric(5,2))
ORDER BY S.invid;
