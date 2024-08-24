CREATE TABLE IF NOT EXISTS InventoryManager (
    ID       INTEGER PRIMARY KEY AUTOINCREMENT,
    PASSWORD VARCHAR(20) NOT NULL,
    NAME     VARCHAR(30) NOT NULL,
    AGE      INT,
    GENDER   TEXT,
    PHONE    TEXT,
    POSITION TEXT
);

CREATE TABLE IF NOT EXISTS PRODUCT (
    PRODUCT_ID       INT PRIMARY KEY,
    PRODUCT_TYPE     VARCHAR(20) NOT NULL,
    PRODUCT_NAME     VARCHAR(20) NOT NULL,
    PRODUCT_PRICE    DOUBLE      NOT NULL,
    PRODUCT_QUANTITY INT         NOT NULL
);

CREATE TABLE IF NOT EXISTS SUPPLIER (
    SUPPLIER_ID       INT PRIMARY KEY,
    RETAILER_LOCATION VARCHAR(200) NOT NULL,
    CONTACT_NO        VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS PURCHASE_ORDER (
    PURCHASE_ORDER_NUMBER INTEGER NOT NULL,
    SUPPLIER_ID           INTEGER NOT NULL,
    PRODUCT_ID            INTEGER NOT NULL,
    QUANTITY              INT     NOT NULL,
    ORDER_DATE            DATE    NOT NULL,
    PRICE                 INT     NOT NULL,
    PRIMARY KEY (PURCHASE_ORDER_NUMBER, SUPPLIER_ID, PRODUCT_ID),
    FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER (SUPPLIER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
);

CREATE TABLE IF NOT EXISTS RETAILER (
    RETAILER_ID INTEGER PRIMARY KEY,
    LOCATION    VARCHAR(100) NOT NULL,
    CONTACT_NO  VARCHAR(50)  NOT NULL
);

CREATE TABLE IF NOT EXISTS RETURN_ORDER (
    RETURN_ID     INT,
    SUPPLIER_ID   INT,
    PRODUCT_ID    INT,
    QUANTITY      INT  NOT NULL,
    RETURN_DATE   DATE NOT NULL,
    RETURN_REASON VARCHAR(200),
    PRIMARY KEY (RETURN_ID, SUPPLIER_ID, PRODUCT_ID),
    FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER (SUPPLIER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
);

CREATE TABLE IF NOT EXISTS STOCK_RETURN (
    RETAILER_ID INT  NOT NULL,
    PRODUCT_ID  INT  NOT NULL,
    RETURN_ID   INT  NOT NULL,
    QUANTITY    INT  NOT NULL,
    RETURN_DATE DATE NOT NULL,
    PRIMARY KEY (RETAILER_ID, PRODUCT_ID, RETURN_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
    FOREIGN KEY (RETAILER_ID) REFERENCES RETAILER (RETAILER_ID)
);

CREATE TABLE IF NOT EXISTS StockTransfer (
    PRODUCT_ID        INT  NOT NULL,
    RETAILER_ID       INT  NOT NULL,
    TRANSFER_QUANTITY INT  NOT NULL,
    TRANSFER_DATE     DATE NOT NULL,
    PRIMARY KEY (PRODUCT_ID, RETAILER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
    FOREIGN KEY (RETAILER_ID) REFERENCES RETAILER (RETAILER_ID)
);
