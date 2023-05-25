USE dv1664;
-- Namn: Tobias Gustafsson

-- Uppgift 1
DROP TABLE IF EXISTS Candy;
CREATE TABLE Candy(
	candyNumber INT,
    candyName VARCHAR(255),
    pricePerGram FLOAT,
    gelatinfri VARCHAR(5),
    PRIMARY KEY (candyNumber)
);

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
	customerNumber INT,
    customerName VARCHAR(255),
    invoiceAddress VARCHAR(255),
    PRIMARY KEY (customerNumber)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
	orderNumber INT,
    weight INT,
    recipient VARCHAR(255),
    recipientAddress VARCHAR(255),
    candyNumber INT,
    customerNumber INT,
    message VARCHAR(255),
	PRIMARY KEY (orderNumber),
	FOREIGN KEY (candyNumber) REFERENCES Candy(candyNumber),
	FOREIGN KEY (customerNumber) REFERENCES Customer(customerNumber)
);

INSERT INTO Candy (candyNumber, candyName, pricePerGram, gelatinfri) VALUES
  (123, "Dajm", 0.5, "Y"), 
  (456, "Lakrits", 0.4,"N"), 
  (789, "Mörk choklad", 0.7, "Y");

INSERT INTO Customer (customerNumber, customerName, invoiceAddress) VALUES
  (1, "Kajsa Kavat", "Hemv 4"), 
  (2, "Pelle Svanslös", "Grusgatan 5"), 
  (3, "Grodan Boll", "Stora vägen 4");
  
  INSERT INTO Orders (orderNumber, weight, recipient, recipientAddress, candyNumber, customerNumber, message) VALUES 
  (1, 500, "Birk", "Mattisborgen", 123, 3, "Till en godisälskare"), 
  (2, 300, "Lora", "Storgatan 6", 789, 1, "Ha en bra dag!"), 
  (3, 1000, "Ronja", "Storgatan 6", 123, 1, "Grattis på födelsedagen");
  
