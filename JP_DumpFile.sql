CREATE DATABASE  IF NOT EXISTS `jewelrypalace` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jewelrypalace`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: jewelrypalace
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_category` varchar(255) DEFAULT NULL,
  `product_price` decimal(10,2) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `action_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
INSERT INTO `activity_log` VALUES (4,202,'ER-0033','earring',1000.00,'deleted','2024-09-03 03:53:34'),(5,203,'ER-0033','earring',1000.00,'deleted','2024-09-05 03:58:34'),(6,204,'ER-0033','earring',1000.00,'deleted','2024-09-06 02:21:53'),(7,205,'ER-0033','earring',1000.00,'deleted','2024-09-13 03:36:15');
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Admin','admin@example.com','password');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  `user_id` int DEFAULT '1',
  `admin_id` int NOT NULL DEFAULT '1',
  `quantity` int DEFAULT '10',
  `added_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `sold_out_time` timestamp NULL DEFAULT NULL,
  `deleted_time` timestamp NULL DEFAULT NULL,
  `soldout_quantity_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `user_id` (`user_id`),
  KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'ER-0001','earring','earring1.jpg',3130000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(2,'ER-0002','earring','earring2.jpg',3140000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(3,'ER-0003','earring','earring3.jpg',3080000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(4,'ER-0004','earring','earring4.jpg',2680000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(5,'ER-0005','earring','earring5.jpg',1530000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(6,'ER-0006','earring','earring6.jpg',2630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(7,'ER-0007','earring','earring7.jpg',3630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(8,'ER-0008','earring','earring8.jpg',1730000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(9,'ER-0009','earring','earring9.jpg',2950000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(10,'ER-0010','earring','earring10.jpg',2350000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(11,'ER-0011','earring','earring11.jpg',1930000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(12,'ER-0012','earring','earring12.jpg',2360000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(13,'ER-0013','earring','earring13.jpg',1870000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(14,'ER-0014','earring','earring14.jpg',3850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(15,'ER-0015','earring','earring15.jpg',550000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(16,'ER-0016','earring','earring16.jpg',850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(17,'ER-0017','earring','earring17.jpg',1850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(18,'ER-0018','earring','earring18.jpg',3630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(19,'ER-0019','earring','earring19.jpg',1730000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(20,'ER-0020','earring','earring20.jpg',2950000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(21,'ER-0021','earring','earring21.jpg',2330000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(22,'ER-0022','earring','earring22.jpg',1930000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(23,'ER-0023','earring','earring23.jpg',2360000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(24,'ER-0024','earring','earring24.jpg',5680000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(25,'ER-0025','earring','earring25.jpeg',2850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(26,'ER-0026','earring','earring26.jpg',2630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(27,'ER-0027','earring','earring27.jpg',2800000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(28,'ER-0028','earring','earring28.jpg',2500000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(29,'ER-0029','earring','earring29.png',750000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(30,'ER-0030','earring','earring30.jpg',3530000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(31,'ER-0031','earring','earring31.jpg',3250000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(32,'ER-0032','earring','earring32.jpg',650000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(33,'BL-0001','bracelet','Bracelet1.jpg',3130000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(34,'BL-0002','bracelet','Bracelet2.jpg',3140000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(35,'BL-0003','bracelet','Bracelet3.jpg',3080000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(36,'BL-0004','bracelet','Bracelet4.jpg',2680000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(37,'BL-0005','bracelet','Bracelet5.jpg',1530000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(38,'BL-0006','bracelet','Bracelet6.jpg',2630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(39,'BL-0007','bracelet','Bracelet7.jpg',3630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(40,'BL-0008','bracelet','Bracelet8.jpg',1730000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(41,'BL-0009','bracelet','Bracelet9.jpg',2950000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(42,'BL-0010','bracelet','Bracelet10.jpg',2350000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(43,'BL-0011','bracelet','Bracelet11.jpg',1930000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(44,'BL-0012','bracelet','Bracelet12.jpg',2360000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(45,'BL-0013','bracelet','Bracelet13.jpg',1870000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(46,'BL-0014','bracelet','Bracelet14.jpg',3850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(47,'BL-0015','bracelet','Bracelet15.jpg',550000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(48,'BL-0016','bracelet','Bracelet16.jpg',850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(49,'BL-0017','bracelet','Bracelet17.jpg',1850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(50,'BL-0018','bracelet','Bracelet18.jpg',3630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(51,'BL-0019','bracelet','Bracelet19.jpg',1730000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(52,'BL-0020','bracelet','Bracelet20.jpg',2950000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(53,'BL-0021','bracelet','Bracelet21.jpg',2330000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(54,'NL-0001','necklace','necklace1.jpg',3130000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(55,'NL-0002','necklace','necklace2.jpg',3140000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(56,'NL-0003','necklace','necklace3.jpg',3080000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(57,'NL-0004','necklace','necklace4.jpg',2680000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(58,'NL-0005','necklace','necklace5.jpg',1530000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(59,'NL-0006','necklace','necklace6.jpg',2630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(60,'NL-0007','necklace','necklace7.jpg',3630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(61,'NL-0008','necklace','necklace8.jpg',1730000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(62,'NL-0009','necklace','necklace9.jpg',2950000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(63,'NL-0010','necklace','necklace10.jpg',2350000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(64,'NL-0011','necklace','necklace11.jpg',1930000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(65,'NL-0012','necklace','necklace12.jpg',2360000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(66,'NL-0013','necklace','necklace13.jpg',1870000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(67,'NL-0014','necklace','necklace14.jpg',3850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(68,'NL-0015','necklace','necklace15.jpg',550000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(69,'NL-0016','necklace','necklace16.jpg',850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(70,'NL-0017','necklace','necklace17.jpg',1850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(71,'NL-0018','necklace','necklace18.jpg',3630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(72,'NL-0019','necklace','necklace19.jpg',1730000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(73,'NL-0020','necklace','necklace20.jpg',2950000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(74,'NL-0021','necklace','necklace21.jpg',2330000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(75,'NL-0022','necklace','necklace22.jpg',1990000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(76,'NL-0023','necklace','necklace23.jpg',2450000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(77,'NL-0024','necklace','necklace24.jpg',2700000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(78,'NL-0025','necklace','necklace25.jpg',3000000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(79,'RG-0001','ring','ring1.jpg',3130000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(80,'RG-0002','ring','ring2.jpg',3140000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(81,'RG-0003','ring','ring3.jpg',3080000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(82,'RG-0004','ring','ring4.jpg',2680000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(83,'RG-0005','ring','ring5.jpg',1530000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(84,'RG-0006','ring','ring6.jpg',2630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(85,'RG-0007','ring','ring7.jpg',3630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(86,'RG-0008','ring','ring8.jpg',1730000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(87,'RG-0009','ring','ring9.jpg',2950000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(88,'RG-0010','ring','ring10.jpg',2350000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(89,'RG-0011','ring','ring11.jpg',1930000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(90,'RG-0012','ring','ring12.jpg',2360000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(91,'RG-0013','ring','ring13.jpg',1870000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(92,'RG-0014','ring','ring14.jpg',3850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(93,'RG-0015','ring','ring15.jpg',550000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(94,'RG-0016','ring','ring16.jpg',850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(95,'RG-0017','ring','ring17.jpg',1850000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(96,'RG-0018','ring','ring18.jpg',3630000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(97,'RG-0019','ring','ring19.jpg',1730000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(98,'RG-0020','ring','ring20.jpg',2950000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL),(99,'RG-0021','ring','ring21.jpg',2330000.00,1,1,10,'2024-08-31 21:50:34',NULL,NULL,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `content` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (131,'Aung Thura Kyaw','I purchased the diamond pendant for my wife, and she absolutely loves it! The craftsmanship is exquisite, and it sparkles beautifully in any light. Highly recommend this piece for anyone looking to add a touch of elegance to their collection.\r\n','2024-09-05 16:03:52'),(132,'Aung Thura Kyaw','I purchased the diamond pendant for my wife, and she absolutely loves it! The craftsmanship is exquisite, and it sparkles beautifully in any light. Highly recommend this piece for anyone looking to add a touch of elegance to their collection.','2024-09-05 16:03:56'),(133,'Aung Thura Kyaw','I purchased the diamond pendant for my wife, and she absolutely loves it! The craftsmanship is exquisite, and it sparkles beautifully in any light. Highly recommend this piece for anyone looking to add a touch of elegance to their collection.','2024-09-05 16:04:01'),(134,'Aung Thura Kyaw','I purchased the diamond pendant for my wife, and she absolutely loves it! The craftsmanship is exquisite, and it sparkles beautifully in any light. Highly recommend this piece for anyone looking to add a touch of elegance to their collection.','2024-09-05 16:04:05'),(135,'Aung Thura Kyaw','I purchased the diamond pendant for my wife, and she absolutely loves it! The craftsmanship is exquisite, and it sparkles beautifully in any light. Highly recommend this piece for anyone looking to add a touch of elegance to their collection.','2024-09-05 16:04:09'),(140,'Aung Thura Kyaw','I purchased the diamond pendant for my wife, and she absolutely loves it! The craftsmanship is exquisite, and it sparkles beautifully in any light. Highly recommend this piece for anyone looking to add a touch of elegance to their collection.','2024-09-06 03:30:05');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingcart`
--

DROP TABLE IF EXISTS `shoppingcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shoppingcart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `total_cost` decimal(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `shoppingcart_ibfk_2` (`product_id`),
  CONSTRAINT `shoppingcart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shoppingcart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingcart`
--

LOCK TABLES `shoppingcart` WRITE;
/*!40000 ALTER TABLE `shoppingcart` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `total_cost`
--

DROP TABLE IF EXISTS `total_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total_cost` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total_cost` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `total_cost`
--

LOCK TABLES `total_cost` WRITE;
/*!40000 ALTER TABLE `total_cost` DISABLE KEYS */;
INSERT INTO `total_cost` VALUES (1,36300000.00),(2,38500000.00),(3,50050000.00),(4,36300000.00),(5,38500000.00),(6,36300000.00),(7,7260000.00),(8,7260000.00),(9,18150000.00),(10,6260000.00),(11,6260000.00),(12,18780000.00),(13,15650000.00),(14,15650000.00),(15,15650000.00),(16,15650000.00),(17,5000.00),(18,5000.00),(19,36300000.00),(20,36300000.00),(21,36300000.00),(22,3630000.00),(23,6920000.00),(24,10720000.00),(25,18150000.00),(26,25410000.00),(27,17040000.00),(28,17460000.00),(29,22820000.00),(30,9420000.00),(31,14520000.00),(32,11550000.00),(33,36300000.00),(34,14520000.00),(35,3000000.00),(36,36300000.00),(37,3630000.00),(38,3630000.00),(39,3630000.00),(40,18150000.00),(41,9390000.00),(42,36300000.00),(43,36300000.00),(44,14520000.00),(45,38500000.00),(46,31300000.00),(47,28400000.00),(48,36300000.00),(49,3700000.00),(50,31400000.00),(51,9890000.00),(52,14520000.00),(53,12520000.00),(54,23100000.00),(55,31400000.00),(56,21560000.00),(57,36300000.00),(58,14520000.00),(59,2630000.00),(60,31300000.00),(61,18150000.00),(62,36300000.00),(63,38500000.00),(64,36300000.00),(65,31300000.00),(66,31300000.00),(67,62600000.00),(68,31300000.00),(69,31300000.00),(70,74800000.00),(71,31300000.00),(72,31300000.00),(73,36300000.00);
/*!40000 ALTER TABLE `total_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `creation_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Aung Thura Kyaw','thu454909@gmail.com','$2a$10$ebV9JAZ.YjsWqkLI1Fa.3uqYndMdzfTOuSoeg0UX8uAtbK3kmFEdq','2024-08-30 06:45:07');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-03 12:51:18
