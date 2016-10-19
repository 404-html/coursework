-- df: null=0

CREATE TABLE Customers (  -- df: mult=1
    custid   INTEGER PRIMARY KEY,
    cname    VARCHAR(14), -- df: word=names.txt sub=power rate=0.016
    country  CHAR(3)      -- df: word=:GBR,USA,ITA,CHN,JPN
);

-- df price1: int size=999 sub=power alpha=4
-- df price2: int size=99
-- df dot:    const='.'
-- df price:  cat=price1,dot,price2
CREATE TABLE Products (   -- df: size=1000
    pcode    INTEGER PRIMARY KEY,
    pname    VARCHAR(10),
    pdesc    VARCHAR(20),
    price    NUMERIC(6,2) -- df: use=price
);

CREATE TABLE Orders (     -- df: mult=3
    ordid    INTEGER PRIMARY KEY,
    odate    DATE,        -- df: start=2015-01-01 end=2016-09-30
    ocust    INTEGER NOT NULL REFERENCES Customers -- df: null=0
);

CREATE TABLE Details (    -- df: mult=15
    ordid    INTEGER REFERENCES Orders,            -- df: null=0
    pcode    INTEGER REFERENCES Products,          -- df: null=0
    qty      SMALLINT,    -- df: int size=10 sub=power alpha=10
    PRIMARY KEY (ordid, pcode)
);

CREATE TABLE Invoices (    -- df: mult=2
    invid    INTEGER PRIMARY KEY,
    ordid    INTEGER NOT NULL UNIQUE REFERENCES Orders, -- df: null=0 mangle
    amount   NUMERIC(8,2), -- df: use=price
    issued   DATE,         -- df: start=2015-01-01 end=2016-09-30
    due      DATE          -- df: start=2015-01-01 end=2016-09-30
);

CREATE TABLE Payments (    -- df: mult=6
    payid    INTEGER PRIMARY KEY,
    tstamp   TIMESTAMP,    -- df: start='2015-01-01 00:00:00' end='2016-09-30 00:00:00'
    amount   NUMERIC(8,2), -- df: use=price
    invid    INTEGER NOT NULL REFERENCES Invoices
);
