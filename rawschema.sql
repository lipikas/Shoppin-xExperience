DROP DATABASE IF EXISTS 336project;
CREATE DATABASE IF NOT EXISTS 336project;
USE 336project;

DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
	staff_id int primary key auto_increment default (0),
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
	c_id int primary key auto_increment default(0),
    name varchar(50),
    phone varchar(13),
    login varchar(50),
    email varchar(50),
    password varchar(50)
);

DROP TABLE IF EXISTS Sells;
CREATE TABLE Sells (
	bc_id int,
    sc_id int,
    date datetime,
    item_id int,
    price float,
    primary key (bc_id, sc_id, date)
);

DROP TABLE IF EXISTS WantedItems;
CREATE TABLE WantedItems (
	c_id int primary key,
    foreign key (c_id) references Customers (c_id),
    category varchar(50),
    color varchar(50),
    size int
);

DROP TABLE IF EXISTS Bids;
CREATE TABLE Bids (
	bid_id int primary key auto_increment default(0),
    creator_id int NOT NULL,
    foreign key (creator_id) references Customers(c_id),
    date datetime,
    price float,
    upper_limit float
);

DROP TABLE IF EXISTS Items;
CREATE TABLE Items (
	item_id int primary key auto_increment default(0),
    category varchar(50),
    color varchar(50),
    size int,
    description varchar(100)
);

DROP TABLE IF EXISTS Alerts;
CREATE TABLE Alerts (
	c_id int,
    message varchar(100),
    primary key (c_id, message),
    foreign key (c_id) references Customers (c_id)
);

DROP TABLE IF EXISTS Questions;
CREATE TABLE Questions (
	c_id int,
    staff_id int,
    message varchar(100),
    answer varchar(100),
    answered boolean,
    primary key (c_id, message),
    foreign key (c_id) references Customers (c_id),
    foreign key (staff_id) references Staff (staff_id)
);

DROP TABLE IF EXISTS AuctionContains;
CREATE TABLE AuctionContains (
	auction_id int primary key auto_increment default(0),
    current_price float,
    end_time datetime,
    bid_inc float,
    min_price float,
    active boolean,
    item_id int NOT NULL,
    creator_id int NOT NULL,
    foreign key (creator_id) references Customers(c_id),
    foreign key (item_id) references Items (item_id)
);

DROP TABLE IF EXISTS Helps;
CREATE TABLE Helps (
	staff_id int,
    c_id int,
    primary key (staff_id, c_id),
    foreign key (staff_id) references Staff (staff_id),
    foreign key (c_id) references Customers (c_id)
);

DROP TABLE IF EXISTS Place;
CREATE TABLE Place (
	c_id int,
    bid_id int,
    primary key (c_id, bid_id),
    foreign key (c_id) references Customers (c_id),
    foreign key (bid_id) references Bids (bid_id)
);

DROP TABLE IF EXISTS BidOn;
CREATE TABLE BidOn (
    bid_id int,
    auction_id int,
    primary key (bid_id, auction_id),
    foreign key (bid_id) references Bids (bid_id),
    foreign key (auction_id) references AuctionContains (auction_id)
);