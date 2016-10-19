SELECT I.invid, I.issued, O.ordid, O.odate
FROM Orders O, Invoices I
WHERE I.ordid = O.ordid
  AND I.issued < O.odate;
