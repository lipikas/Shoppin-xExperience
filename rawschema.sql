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
DROP TABLE IF EXISTS Items;
CREATE TABLE Items (
	item_id int primary key auto_increment default(0),
    category varchar(50),
    color varchar(50),
    size int,
    description varchar(100)
);
DROP TABLE IF EXISTS Sells;
CREATE TABLE Sells (
	bc_id int,
    sc_id int,
    date datetime,
    item_id int,
    price float,
    foreign key (bc_id) references Customers (c_id),
    foreign key (sc_id) references Customers (c_id),
    foreign key (item_id) references Items (item_id),
    primary key (bc_id, sc_id, date)
);

DROP TABLE IF EXISTS WantedItems;
CREATE TABLE WantedItems (
	c_id int,
    foreign key (c_id) references Customers (c_id),
    category varchar(50),
    color varchar(50),
    size int,
	primary key (c_id, category, color, size)
);

DROP TABLE IF EXISTS Bids;
CREATE TABLE Bids (
	bid_id int primary key auto_increment default(0),
    creator_id int NOT NULL,
    auction_id int NOT NULL,
    foreign key (creator_id) references Customers(c_id),
    price float,
    upper_limit float
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
    highest_bidder_id int,
    foreign key (highest_bidder_id) references Customers(c_id),
    foreign key (creator_id) references Customers(c_id),
    foreign key (item_id) references Items (item_id)
);

