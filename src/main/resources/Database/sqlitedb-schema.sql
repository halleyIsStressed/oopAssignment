CREATE TABLE IF NOT EXISTS InventoryManager (
    ID       TEXT PRIMARY KEY,
    PASSWORD VARCHAR(20) NOT NULL,
    NAME     VARCHAR(30) NOT NULL,
    AGE      INT,
    GENDER   TEXT,
    PHONE    TEXT,
    EMAIL    TEXT
);

CREATE TRIGGER IF NOT EXISTS createInventoryManager
    AFTER INSERT
    ON InventoryManager
BEGIN
    UPDATE InventoryManager
    SET ID = PRINTF('IM%05d', new.ROWID),
    EMAIL = PRINTF('IM%05d@gmail.com', new.ROWID)
    WHERE ROWID = new.ROWID;
END;


CREATE TABLE IF NOT EXISTS STAFF (
    ID       TEXT PRIMARY KEY,
    PASSWORD VARCHAR(20) NOT NULL,
    NAME     VARCHAR(30) NOT NULL,
    AGE      INT,
    GENDER   TEXT,
    PHONE    TEXT,
    EMAIL    TEXT,
    POSITION TEXT
);

CREATE TRIGGER IF NOT EXISTS createSTAFF
    AFTER INSERT
    ON STAFF
BEGIN
    UPDATE STAFF
    SET ID = PRINTF('S%05d', new.oid) ,
    EMAIL = PRINTF('S%05d@gmail.com', new.oid)
    WHERE oid = new.ROWID;
END;


CREATE TABLE IF NOT EXISTS PRODUCT (
    PRODUCT_ID       TEXT PRIMARY KEY,
    PRODUCT_TYPE     VARCHAR(20) NOT NULL,
    PRODUCT_NAME     VARCHAR(20) NOT NULL,
    PRODUCT_PRICE    DOUBLE      NOT NULL,
    PRODUCT_QUANTITY INT         NOT NULL
);

CREATE TRIGGER IF NOT EXISTS createProductId
    AFTER INSERT
    ON PRODUCT
BEGIN
    UPDATE PRODUCT
    SET PRODUCT_ID = PRINTF('P%05d', new.oid)
    WHERE oid = new.ROWID;
END;

CREATE TABLE IF NOT EXISTS SUPPLIER (
    SUPPLIER_ID       TEXT PRIMARY KEY ,
    SUPPLIER_NAME     VARCHAR(50) NOT NULL ,
    CONTACT_NO        TEXT NOT NULL,
    ADDRESS           TEXT         NOT NULL ,
    EMAIL             TEXT         NOT NULL,
    CREATE_DATE       DATETIME NOT NULL ON CONFLICT REPLACE DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER IF NOT EXISTS createSUPPLIER
    AFTER INSERT
    ON SUPPLIER
BEGIN
    UPDATE SUPPLIER
    SET SUPPLIER_ID = PRINTF('SP%05d', new.oid)
    WHERE oid = new.ROWID;
END;

CREATE TABLE IF NOT EXISTS PURCHASE_ORDER (
    PURCHASE_ORDER_NUMBER TEXT    ,
    SUPPLIER_ID           TEXT   ,
    PRODUCT_ID            TEXT   ,
    QUANTITY              INT     NOT NULL,
    ORDER_DATE            DATE    ,
    PRICE                 INT     ,
    STATUS                TEXT    ,
    PRIMARY KEY (PURCHASE_ORDER_NUMBER, SUPPLIER_ID, PRODUCT_ID),
    FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER (SUPPLIER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
);

CREATE TRIGGER IF NOT EXISTS createPURCHASE_ORDER
    AFTER INSERT
    ON PURCHASE_ORDER
BEGIN
    UPDATE PURCHASE_ORDER
    SET  PURCHASE_ORDER_NUMBER = PRINTF('PO%05d', new.oid)
    WHERE oid = new.ROWID;
END;

CREATE TABLE IF NOT EXISTS BRANCH (
    BRANCH_ID  TEXT PRIMARY KEY ,
    Location   TEXT NOT NULL,
    CONTACT_NO  VARCHAR(50)  NOT NULL,
    MANAGER VARCHAR(50)  NOT NULL,
    DATE   DATETIME NOT NULL DEFAULT (DATE('now'))
);

CREATE TRIGGER IF NOT EXISTS createBRANCH
    AFTER INSERT
    ON BRANCH
BEGIN
    UPDATE BRANCH
    SET  BRANCH_ID = PRINTF('BR%05d', new.oid)
    WHERE oid = new.ROWID;
END;


CREATE TABLE IF NOT EXISTS RETURN_ORDER (
    RETURN_ID     TEXT ,
    SUPPLIER_ID   TEXT NOT NULL,
    PRODUCT_ID    TEXT NOT NULL,
    QUANTITY      INT  NOT NULL,
    RETURN_DATE   DATETIME NOT NULL DEFAULT (DATE('now')),
    RETURN_REASON VARCHAR(200),
    PRIMARY KEY (RETURN_ID, SUPPLIER_ID, PRODUCT_ID),
    FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER (SUPPLIER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
);

CREATE TRIGGER IF NOT EXISTS createRETURN_ORDER
    AFTER INSERT
    ON RETURN_ORDER
BEGIN
    UPDATE RETURN_ORDER
    SET  RETURN_ID= PRINTF('RO%05d', new.oid)
    WHERE oid = new.ROWID;
END;

CREATE TABLE IF NOT EXISTS STOCK_RETURN (
    RETURN_ID   TEXT  NOT NULL,
    BRANCH_ID TEXT  NOT NULL,
    PRODUCT_ID  TEXT  NOT NULL,
    QUANTITY    INT  NOT NULL,
    RETURN_DATE DATE NOT NULL,
    PRIMARY KEY (RETURN_ID,BRANCH_ID, PRODUCT_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
    FOREIGN KEY (BRANCH_ID) REFERENCES BRANCH (BRANCH_ID)
);
CREATE TRIGGER IF NOT EXISTS createSTOCK_RETURN
    AFTER INSERT
    ON STOCK_RETURN
BEGIN
    UPDATE STOCK_RETURN
    SET  RETURN_ID= PRINTF('SO%05d', new.oid)
    WHERE oid = new.ROWID;
END;


CREATE TABLE IF NOT EXISTS STOCK_TRANSFER (
    TRANSFER_ID       TEXT,
    PRODUCT_ID        TEXT  NOT NULL,
    BRANCH_ID       TEXT NOT NULL,
    TRANSFER_QUANTITY INT  NOT NULL,
    REQUEST_DATE     DATE NOT NULL,
    STATUS           TEXT NOT NULL,
    PRIMARY KEY (TRANSFER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
    FOREIGN KEY (BRANCH_ID) REFERENCES BRANCH (BRANCH_ID)
);
CREATE TRIGGER IF NOT EXISTS createRequestID
    AFTER INSERT
    ON STOCK_TRANSFER
BEGIN
    UPDATE STOCK_TRANSFER
    SET  TRANSFER_ID= PRINTF('TR%05d', new.oid)
    WHERE oid = new.ROWID;
END;
