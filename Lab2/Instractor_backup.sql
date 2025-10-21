-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: Instractor
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Exam`
--

DROP TABLE IF EXISTS `Exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Exam` (
  `Exam_ID` int NOT NULL AUTO_INCREMENT,
  `Exam_Date` date DEFAULT NULL,
  `Score` int DEFAULT NULL,
  `Student_ID` int DEFAULT NULL,
  `Subject_ID` int DEFAULT NULL,
  PRIMARY KEY (`Exam_ID`),
  KEY `Student_ID` (`Student_ID`),
  KEY `Subject_ID` (`Subject_ID`),
  CONSTRAINT `Exam_ibfk_1` FOREIGN KEY (`Student_ID`) REFERENCES `Student` (`Student_ID`),
  CONSTRAINT `Exam_ibfk_2` FOREIGN KEY (`Subject_ID`) REFERENCES `Subject` (`Subject_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Exam`
--

LOCK TABLES `Exam` WRITE;
/*!40000 ALTER TABLE `Exam` DISABLE KEYS */;
INSERT INTO `Exam` VALUES (1,'2025-05-10',90,6,1),(2,'2025-05-15',85,6,2),(3,'2025-05-12',70,7,3),(4,'2025-05-20',80,8,1),(5,'2025-05-22',95,10,5);
/*!40000 ALTER TABLE `Exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Phone`
--

DROP TABLE IF EXISTS `Phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Phone` (
  `Phone_ID` int NOT NULL AUTO_INCREMENT,
  `Phone_Number` varchar(20) DEFAULT NULL,
  `Student_ID` int DEFAULT NULL,
  PRIMARY KEY (`Phone_ID`),
  KEY `Student_ID` (`Student_ID`),
  CONSTRAINT `Phone_ibfk_1` FOREIGN KEY (`Student_ID`) REFERENCES `Student` (`Student_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Phone`
--

LOCK TABLES `Phone` WRITE;
/*!40000 ALTER TABLE `Phone` DISABLE KEYS */;
INSERT INTO `Phone` VALUES (1,'01012345678',1),(2,'01122334455',1),(3,'01234567890',2),(4,'01098765432',3),(5,'01111222333',4);
/*!40000 ALTER TABLE `Phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student` (
  `Student_ID` int NOT NULL AUTO_INCREMENT,
  `gender` enum('male','femal') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `firstName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  `contactInfo` json DEFAULT NULL,
  PRIMARY KEY (`Student_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (1,NULL,NULL,NULL,NULL,NULL),(2,NULL,NULL,NULL,NULL,NULL),(3,NULL,NULL,NULL,NULL,NULL),(4,NULL,NULL,NULL,NULL,NULL),(5,NULL,NULL,NULL,NULL,NULL),(6,'femal','2000-04-03','Aya','Hamed','{\"email\": \"ayah@gmail.com\", \"address\": \"hjs\"}'),(7,'femal','1999-05-12','Mona','Ali','{\"email\": \"mona.ali@gmail.com\", \"address\": \"Cairo\"}'),(8,'male','2001-08-20','Omar','Hassan','{\"email\": \"omar.hassan@gmail.com\", \"address\": \"Alexandria\"}'),(9,'femal','2000-11-02','Sara','Mostafa','{\"email\": \"sara.mostafa@gmail.com\", \"address\": \"Giza\"}'),(10,'male','1998-12-25','Ahmed','Mahmoud','{\"email\": \"ahmed.mahmoud@gmail.com\", \"address\": \"Mansoura\"}'),(16,'male','1989-03-12','Ahmed','Mostafa','{\"email\": \"ahmed.m@gmail.com\", \"address\": \"Cairo\"}'),(17,'male','1990-07-25','Omar','Ali','{\"email\": \"omar.ali@gmail.com\", \"address\": \"Giza\"}'),(18,'femal','1991-09-20','Sara','Mahmoud','{\"email\": \"sara.m@gmail.com\", \"address\": \"Alex\"}'),(19,'male','1992-01-10','Youssef','Hassan','{\"email\": \"youssef.h@gmail.com\", \"address\": \"Mansoura\"}'),(20,'femal','1993-05-15','Mona','Fathy','{\"email\": \"mona.f@gmail.com\", \"address\": \"Tanta\"}');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student_Subject`
--

DROP TABLE IF EXISTS `Student_Subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student_Subject` (
  `Student_ID` int NOT NULL,
  `Subject_ID` int NOT NULL,
  PRIMARY KEY (`Student_ID`,`Subject_ID`),
  KEY `fk_subject` (`Subject_ID`),
  CONSTRAINT `fk_student` FOREIGN KEY (`Student_ID`) REFERENCES `Student` (`Student_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_subject` FOREIGN KEY (`Subject_ID`) REFERENCES `Subject` (`Subject_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student_Subject`
--

LOCK TABLES `Student_Subject` WRITE;
/*!40000 ALTER TABLE `Student_Subject` DISABLE KEYS */;
INSERT INTO `Student_Subject` VALUES (1,1),(3,1),(1,2),(3,2),(2,3),(4,3),(2,4),(4,4),(5,5);
/*!40000 ALTER TABLE `Student_Subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Subject`
--

DROP TABLE IF EXISTS `Subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Subject` (
  `Subject_ID` int NOT NULL AUTO_INCREMENT,
  `Subject_Name` varchar(30) DEFAULT NULL,
  `Descrption` varchar(100) DEFAULT NULL,
  `Max_Score` int DEFAULT NULL,
  PRIMARY KEY (`Subject_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Subject`
--

LOCK TABLES `Subject` WRITE;
/*!40000 ALTER TABLE `Subject` DISABLE KEYS */;
INSERT INTO `Subject` VALUES (1,'C','Introduction to C Programming',100),(2,'CPP','Object-Oriented Programming in C++',100),(3,'HTML','Web Page Structure',100),(4,'JS','JavaScript Basics',100),(5,'Database','Database Fundamentals',100);
/*!40000 ALTER TABLE `Subject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-21 19:46:00
