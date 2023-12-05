CREATE DATABASE orders;
go

USE orders;
go

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Beverages');
INSERT INTO category(categoryName) VALUES ('Condiments');
INSERT INTO category(categoryName) VALUES ('Dairy Products');
INSERT INTO category(categoryName) VALUES ('Produce');
INSERT INTO category(categoryName) VALUES ('Meat/Poultry');
INSERT INTO category(categoryName) VALUES ('Seafood');
INSERT INTO category(categoryName) VALUES ('Confections');
INSERT INTO category(categoryName) VALUES ('Grains/Cereals');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Rolex 116500 Daytona', 1, 'The Rolex 116500 is a watch model from the Rolex brand and Daytona collection.',38161.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Rolex 116520 Daytona',1,'The Rolex 116520 is a watch model from the Rolex brand and Daytona collection.',29245.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Rolex 126334 Datejust',1,'The Rolex 126334 is a watch model from the Rolex brand and Datejust collection.',17198.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Rolex 228235 Day-Date',1,'The Rolex 228235 is a watch model from the Rolex brand and Day-Date collection.',64605.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Rolex 124300 Oyster Perpetual',1,'The Rolex 124300 is a watch model from the Rolex brand and Oyster Perpetual collection.',11761.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Patek Philippe 5711/1A Nautilus',2,'The Patek Philippe 5711/1A is a watch model from the Patek Philippe brand and Nautilus collection.',136730.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Patek Philippe 5167A Aquanaut',2,'The Patek Philippe 5167A is a watch model from the Patek Philippe brand and Aquanaut collection.',70344.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Audemars Piguet 15500ST Royal Oak', 3, 'The Audemars Piguet 15500ST is a watch model from the Royal Oak collection.', 52083.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Audemars Piguet 26331ST Royal Oak', 3, 'The Audemars Piguet 26331ST is a watch model from the Royal Oak collection.', 60781.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Omega 310.32.42.50.02.001 Speedmaster', 4, 'The Omega 310.32.42.50.02.001 is a Speedmaster model.', 23565.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Omega 3510.50 Speedmaster', 4, 'The Omega 3510.50 is a Speedmaster model.', 3480.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Omega 310.30.42.50.01.002 Speedmaster', 4, 'The Omega 310.30.42.50.01.002 is a Speedmaster model.', 8235.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Omega 311.30.42.30.01.005 Speedmaster', 4, 'The Omega 311.30.42.30.01.005 is a Speedmaster model.', 6177.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grand Seiko SLGH005', 5, 'The Grand Seiko SLGH005 is a model from Grand Seiko.', 7277.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grand Seiko SLGA007', 5, 'The Grand Seiko SLGA007 is a model from Grand Seiko.', 11291.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grand Seiko SBGA211', 5, 'The Grand Seiko SBGA211 is a model from Grand Seiko.', 5581.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grand Seiko SBGA413', 5, 'The Grand Seiko SBGA413 is a model from Grand Seiko.', 6411.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grand Seiko SLGA009', 5, 'The Grand Seiko SLGA009 is a model from Grand Seiko.', 7764.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grand Seiko SBGA407', 5, 'The Grand Seiko SBGA407 is a model from Grand Seiko.', 5908.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grand Seiko SBGE275', 5, 'The Grand Seiko SBGE275 is a model from Grand Seiko.', 8931.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grand Seiko SBGJ237', 5, 'The Grand Seiko SBGJ237 is a model from Grand Seiko.', 5314.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cartier WSSA0030', 6, 'The Cartier WSSA0030 is a Santos model from Cartier.', 8316.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cartier WSSA0018', 6, 'The Cartier WSSA0018 is a Santos model from Cartier.', 8691.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cartier WHSA0015', 6, 'The Cartier WHSA0015 is a Santos model from Cartier.', 29712.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cartier WSSA0029', 6, 'The Cartier WSSA0029 is a Santos model from Cartier.', 7987.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cartier W1556243', 6, 'The Cartier W1556243 is a Rotonde model from Cartier.', 29485.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cartier WSSA0037', 6, 'The Cartier WSSA0037 is a Santos model from Cartier.', 8395.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cartier W51008Q3', 6, 'The Cartier W51008Q3 is a Tank model from Cartier.', 2742.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cartier WSSA0039', 6, 'The Cartier WSSA0039 is a Santos model from Cartier.', 8994.00);

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , '304Arnold!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , '304Bobby!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , '304Candace!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , '304Darren!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , '304Beth!');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.png' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.png' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.png' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.png' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.png' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.png' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.png' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/8.png' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/9.png' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.png' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/11.png' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/12.png' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/13.png' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/14.png' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/15.png' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/16.png' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/17.png' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/18.png' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'img/19.png' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'img/20.png' WHERE ProductId = 20;
UPDATE Product SET productImageURL = 'img/21.png' WHERE ProductId = 21;
UPDATE Product SET productImageURL = 'img/22.png' WHERE ProductId = 22;
UPDATE Product SET productImageURL = 'img/23.png' WHERE ProductId = 23;
UPDATE Product SET productImageURL = 'img/24.png' WHERE ProductId = 24;
UPDATE Product SET productImageURL = 'img/25.png' WHERE ProductId = 25;
UPDATE Product SET productImageURL = 'img/26.png' WHERE ProductId = 26;
UPDATE Product SET productImageURL = 'img/27.png' WHERE ProductId = 27;
UPDATE Product SET productImageURL = 'img/28.png' WHERE ProductId = 28;
UPDATE Product SET productImageURL = 'img/29.png' WHERE ProductId = 29;