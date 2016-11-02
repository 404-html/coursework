WITH S AS (
SELECT C.custid, COALESCE(SUM(D.qty*P.price),0) sum
FROM Customers C
     LEFT JOIN Orders O
     ON C.custid = O.ocust
     AND O.odate BETWEEN '20160101' AND '20160630'
     LEFT JOIN Details D
     ON O.ordid = D.ordid
     LEFT JOIN Products P
     ON D.pcode = P.pcode
     AND P.ptype = 'MUSIC'
GROUP BY C.custid
ORDER BY C.custid
)
SELECT S.custid, S.sum
FROM S
WHERE S.sum < 50;
