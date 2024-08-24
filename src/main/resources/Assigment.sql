CREATE TABLE IF NOT EXISTS InventoryManager (
                    ID INTEGER PRIMARY KEY AUTOINCREMENT,
                    PASSWORD VARCHAR(20),
                    NAME VARCHAR(30) NULL,
                    AGE INT NOT NULL,
                    GENDER TEXT NOT NULL,
                    PHONE TEXT NOT NULL,
                    POSITION TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS PRODUCT (
                    PRODUCT_ID INT PRIMARY KEY,
                    PRODUCT_TYPE VARCHAR(20) NOT NULL,
                    PRODUCT_NAME VARCHAR(20) NOT NULL,
                    PRODUCT_PRICE DOUBLE NOT NULL,
                    PRODUCT_QUANTITY INT NOT NULL
);
CREATE TABLE IF NOT EXISTS SUPPLIER (
                    SUPPLIER_ID INT PRIMARY KEY ,
                    RETAILER_LOCATION VARCHAR(200) NOT NULL,
                    CONTACT_NO VARCHAR(200) NOT NULL
);
CREATE TABLE IF NOT EXISTS PURCHASE_ORDER (
                    PURCHASE_ORDER_NUMBER INTEGER NOT NULL,
                    SUPPLIER_ID INTEGER NOT NULL,
                    PRODUCT_ID INTEGER NOT NULL,
                    QUANTITY INT NOT NULL,
                    ORDER_DATE DATE NOT NULL,
                    PRICE INT NOT NULL,
                    PRIMARY KEY (PURCHASE_ORDER_NUMBER, SUPPLIER_ID, PRODUCT_ID),
                    FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER(SUPPLIER_ID),
                    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);
CREATE TABLE IF NOT EXISTS RETAILER (
                    RETAILER_ID INTEGER PRIMARY KEY ,
                    LOCATION VARCHAR(100) NOT NULL ,
                    CONTACT_NO VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS RETURN_ORDER (
                    RETURN_ID INT,
                    SUPPLIER_ID INT,
                    PRODUCT_ID INT,
                    QUANTITY INT NOT NULL,
                    RETURN_DATE DATE NOT NULL,
                    RETURN_REASON VARCHAR(200) NOT NULL,
                    PRIMARY KEY (RETURN_ID, SUPPLIER_ID, PRODUCT_ID),
                    FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER(SUPPLIER_ID),
                    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);
CREATE TABLE IF NOT EXISTS STOCK_RETURN(
                    RETAILER_ID INT NOT NULL,
                    PRODUCT_ID INT NOT NULL,
                    RETURN_ID INT NOT NULL,
                    QUANTITY INT NOT NULL,
                    RETURN_DATE DATE NOT NULL,
                    PRIMARY KEY (RETAILER_ID,PRODUCT_ID,RETURN_ID),
                    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
                    FOREIGN KEY (RETAILER_ID) REFERENCES RETAILER(RETAILER_ID)
);
CREATE TABLE IF NOT EXISTS StockTransfer (
                    PRODUCT_ID INT NOT NULL,
                    RETAILER_ID INT  NOT NULL,
                    TRANSFER_QUANTITY INT NOT NULL,
                    TRANSFER_DATE DATE NOT NULL,
                    PRIMARY KEY (PRODUCT_ID, RETAILER_ID),
                    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
                    FOREIGN KEY (RETAILER_ID) REFERENCES RETAILER(RETAILER_ID)
);

INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (1, 'Fishing Rod', 'Spinning Rod', 150.00, 10);
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (2, 'Fishing Rod', 'Casting Rod', 120.00, 15);
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (3, 'Fishing Reel', 'Spinning Reel', 75.00, 20);
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (4, 'Fishing Reel', 'Baitcasting Reel', 85.00, 12);
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (5, 'Fishing Line', 'Braided Line', 25.00, 50);
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (6, 'Fishing Line', 'Monofilament Line', 15.00, 60);
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (7, 'Fishing Lure', 'Crankbait', 8.50, 100);
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (8, 'Fishing Lure', 'Spinnerbait', 7.00, 80);
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (9, 'Fishing Accessory', 'Fishing Pliers', 12.00, 25);
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_TYPE, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_QUANTITY) VALUES (10, 'Fishing Accessory', 'Tackle Box', 45.00, 30);
