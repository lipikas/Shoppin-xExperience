DROP DATABASE IF EXISTS 336project;
CREATE DATABASE IF NOT EXISTS 336project;
USE 336project;

DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
	staff_id int primary key NOT NULL AUTO_INCREMENT,
    name varchar(50),
    phone varchar(13),
    login varchar(50),
    email varchar(50),
    password varchar(50),
    isAdmin boolean,
    isCustomerRep boolean
);

/*Creating admin and customer rep accounts*/
INSERT INTO Staff (name, login, password, isAdmin, isCustomerRep) VALUES 
	('admin', 'admin', 'root', TRUE, FALSE),
    ('Daniel', 'Daniel', 'danspass', FALSE, TRUE),
    ('Jennifer', 'Jennifer', 'jenspass', FALSE, TRUE),
    ('Avani', 'Avani', 'avanispass', FALSE, TRUE),
    ('Lipika', 'Lipika', 'lipikaspass', FALSE, TRUE)
;

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
	c_id int auto_increment,
    name varchar(50),
    phone varchar(13),
    login varchar(50),
    email varchar(50),
    password varchar(50),
    UNIQUE(c_id)
);
DROP TABLE IF EXISTS Items;
CREATE TABLE Items (
	item_id int primary key NOT NULL AUTO_INCREMENT,
    category varchar(50),
    color varchar(50),
    size int,
    description varchar(100)
);
DROP TABLE IF EXISTS Sells;
CREATE TABLE Sells (
	bc_id int NULL,
    sc_id int NULL,
    date datetime,
    item_id int,
    price float,
    foreign key (bc_id) references Customers (c_id),
    foreign key (sc_id) references Customers (c_id),
    foreign key (item_id) references Items (item_id),
    UNIQUE (bc_id, sc_id, date)
);

DROP TABLE IF EXISTS WantedItems;
CREATE TABLE WantedItems (
	c_id int NULL,
    foreign key (c_id) references Customers (c_id),
    category varchar(50),
    color varchar(50),
    size int,
	UNIQUE  (c_id, category, color, size)
);

DROP TABLE IF EXISTS Bids;
CREATE TABLE Bids (
	bid_id int primary key NOT NULL AUTO_INCREMENT,
    creator_id int NULL,
    auction_id int NULL,
    foreign key (creator_id) references Customers(c_id),
    price float,
    upper_limit float,
	auto_inc float
);

DROP TABLE IF EXISTS Alerts;
CREATE TABLE Alerts (
	c_id int,
    message varchar(100),
    UNIQUE  (c_id, message),
    foreign key (c_id) references Customers (c_id)
);

DROP TABLE IF EXISTS Questions;
CREATE TABLE Questions (
	q_id int NOT NULL AUTO_INCREMENT,
	c_id int,
    staff_id int,
    message varchar(100) NOT NULL,
    answer varchar(100) DEFAULT NULL,
    answered boolean DEFAULT NULL,
    primary key (q_id),
    foreign key (c_id) references Customers (c_id),
    foreign key (staff_id) references Staff (staff_id)
);

DROP TABLE IF EXISTS AuctionContains;
CREATE TABLE AuctionContains (
	auction_id int primary key NOT NULL AUTO_INCREMENT,
    initial_price float,
    current_price float,
    startdate date,
    end_time datetime,
    bid_inc float,
    min_price float,
    active boolean,
    item_id int NOT NULL,
    creator_id int NULL,
    highest_bidder_id int NULL,
    foreign key (highest_bidder_id) references Customers(c_id),
    foreign key (creator_id) references Customers(c_id),
    foreign key (item_id) references Items (item_id)
);
