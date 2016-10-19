SELECT *
FROM   (SELECT I.invid,(SUM(P.amount) - I.amount) AS refund
        FROM Invoices I, Payments P
	WHERE I.invid = P.invid
	GROUP BY I.invid) AS s
WHERE s.refund > 0;
