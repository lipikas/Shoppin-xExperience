CREATE DATABASE  IF NOT EXISTS `336project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `336project`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: 336project
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `c_id` int(11) NULL,
  `message` varchar(100) NOT NULL,
  UNIQUE (`c_id`,`message`),
  CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `customers` (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auctioncontains`
--

DROP TABLE IF EXISTS `auctioncontains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auctioncontains` (
  `auction_id` int(11) NOT NULL AUTO_INCREMENT,
  `initial_price` float DEFAULT NULL,
  `current_price` float DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `bid_inc` float DEFAULT NULL,
  `min_price` float DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `item_id` int(11) NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `highest_bidder_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`auction_id`),
  KEY `highest_bidder_id` (`highest_bidder_id`),
  KEY `creator_id` (`creator_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `auctioncontains_ibfk_1` FOREIGN KEY (`highest_bidder_id`) REFERENCES `customers` (`c_id`),
  CONSTRAINT `auctioncontains_ibfk_2` FOREIGN KEY (`creator_id`) REFERENCES `customers` (`c_id`),
  CONSTRAINT `auctioncontains_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auctioncontains`
--

LOCK TABLES `auctioncontains` WRITE;
/*!40000 ALTER TABLE `auctioncontains` DISABLE KEYS */;
/*!40000 ALTER TABLE `auctioncontains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bids`
--

DROP TABLE IF EXISTS `bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bids` (
  `bid_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_id` int(11) NOT NULL,
  `auction_id` int(11) NOT NULL,
  `price` float DEFAULT NULL,
  `upper_limit` float DEFAULT NULL,
  `auto_inc` float DEFAULT NULL,
  PRIMARY KEY (`bid_id`),
  KEY `creator_id` (`creator_id`),
  CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `customers` (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bids`
--

LOCK TABLES `bids` WRITE;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
/*!40000 ALTER TABLE `bids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `c_id` int(11) NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `login` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
   UNIQUE  (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `q_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_id` int(11) NULL,
  `staff_id` int(11) DEFAULT NULL,
  `message` varchar(100) NOT NULL,
  `answer` varchar(100) DEFAULT NULL,
  `answered` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`q_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `customers` (`c_id`),
  CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sells`
--

DROP TABLE IF EXISTS `sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sells` (
  `bc_id` int(11) NULL,
  `sc_id` int(11) NULL,
  `date` datetime NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
   UNIQUE  (`bc_id`,`sc_id`,`date`),
  KEY `sc_id` (`sc_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `sells_ibfk_1` FOREIGN KEY (`bc_id`) REFERENCES `customers` (`c_id`),
  CONSTRAINT `sells_ibfk_2` FOREIGN KEY (`sc_id`) REFERENCES `customers` (`c_id`),
  CONSTRAINT `sells_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sells`
--

LOCK TABLES `sells` WRITE;
/*!40000 ALTER TABLE `sells` DISABLE KEYS */;
/*!40000 ALTER TABLE `sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `login` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `isAdmin` tinyint(1) DEFAULT NULL,
  `isCustomerRep` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'admin',NULL,'admin',NULL,'root',1,0),(2,'Daniel',NULL,'Daniel',NULL,'danspass',0,1),(3,'Jennifer',NULL,'Jennifer',NULL,'jenspass',0,1),(4,'Avani',NULL,'Avani',NULL,'avanispass',0,1),(5,'Lipika',NULL,'Lipika',NULL,'lipikaspass',0,1);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wanteditems`
--

DROP TABLE IF EXISTS `wanteditems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wanteditems` (
  `c_id` int(11) NULL,
  `category` varchar(50) NOT NULL,
  `color` varchar(50) NOT NULL,
  `size` int(11) NOT NULL,
   UNIQUE  (`c_id`,`category`,`color`,`size`),
  CONSTRAINT `wanteditems_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `customers` (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wanteditems`
-- 

LOCK TABLES `wanteditems` WRITE;
/*!40000 ALTER TABLE `wanteditems` DISABLE KEYS */;
/*!40000 ALTER TABLE `wanteditems` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-07 16:20:15
