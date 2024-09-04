CREATE TABLE IF NOT EXISTS InventoryManager (
    ID       TEXT PRIMARY KEY,
    PASSWORD VARCHAR(20) NOT NULL,
    NAME     VARCHAR(30) NOT NULL,
    AGE      INT,
    GENDER   TEXT,
    PHONE    TEXT,
    POSITION TEXT
);

CREATE TRIGGER IF NOT EXISTS createInventoryManager
    AFTER INSERT
    ON InventoryManager
BEGIN
    UPDATE InventoryManager
    SET ID = PRINTF('IM%05d', new.oid)
    WHERE oid = new.ROWID;
END;

CREATE TABLE IF NOT EXISTS STAFF (
    ID       TEXT PRIMARY KEY,
    PASSWORD VARCHAR(20) NOT NULL,
    NAME     VARCHAR(30) NOT NULL,
    AGE      INT,
    GENDER   TEXT,
    PHONE    TEXT,
    POSITION TEXT
);

CREATE TRIGGER IF NOT EXISTS createSTAFF
    AFTER INSERT
    ON STAFF
BEGIN
    UPDATE STAFF
    SET ID = PRINTF('S%05d', new.oid)
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
    PURCHASE_ORDER_NUMBER TEXT    NOT NULL,
    SUPPLIER_ID           TEXT    NOT NULL,
    PRODUCT_ID            TEXT    NOT NULL,
    QUANTITY              INT     NOT NULL,
    ORDER_DATE            DATE    NOT NULL,
    PRICE                 INT     NOT NULL,
    STATUS                TEXT    NOT NULL,
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

CREATE TABLE IF NOT EXISTS RETAILER (
    RETAILER_ID  TEXT PRIMARY KEY ,
    LOCATION    VARCHAR(100) NOT NULL,
    CONTACT_NO  VARCHAR(50)  NOT NULL
);

CREATE TRIGGER IF NOT EXISTS createRETAILER
    AFTER INSERT
    ON RETAILER
BEGIN
    UPDATE RETAILER
    SET  RETAILER_ID = PRINTF('RT%05d', new.oid)
    WHERE oid = new.ROWID;
END;


CREATE TABLE IF NOT EXISTS RETURN_ORDER (
    RETURN_ID     TEXT NOT NULL,
    SUPPLIER_ID   TEXT NOT NULL,
    PRODUCT_ID    TEXT NOT NULL,
    QUANTITY      INT  NOT NULL,
    RETURN_DATE   DATE NOT NULL,
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
    RETAILER_ID TEXT  NOT NULL,
    PRODUCT_ID  TEXT  NOT NULL,
    QUANTITY    INT  NOT NULL,
    RETURN_DATE DATE NOT NULL,
    PRIMARY KEY (RETURN_ID,RETAILER_ID, PRODUCT_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
    FOREIGN KEY (RETAILER_ID) REFERENCES RETAILER (RETAILER_ID)
);
CREATE TRIGGER IF NOT EXISTS createSTOCK_RETURN
    AFTER INSERT
    ON STOCK_RETURN
BEGIN
    UPDATE STOCK_RETURN
    SET  RETURN_ID= PRINTF('SO%05d', new.oid)
    WHERE oid = new.ROWID;
END;


CREATE TABLE IF NOT EXISTS StockTransfer (
    PRODUCT_ID        TEXT  NOT NULL,
    RETAILER_ID       TEXT NOT NULL,
    TRANSFER_QUANTITY INT  NOT NULL,
    TRANSFER_DATE     DATE NOT NULL,
    PRIMARY KEY (PRODUCT_ID, RETAILER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
    FOREIGN KEY (RETAILER_ID) REFERENCES RETAILER (RETAILER_ID)
);
