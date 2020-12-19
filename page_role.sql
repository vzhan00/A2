-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: database_design
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `page_role`
--

DROP TABLE IF EXISTS `page_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(45) NOT NULL,
  `page_id` int NOT NULL,
  `developer_id` int NOT NULL,
  PRIMARY KEY (`id`,`role`,`page_id`,`developer_id`),
  KEY `page_role_2_page_idx` (`page_id`),
  KEY `page_role_2_developer_idx` (`developer_id`),
  KEY `page_role_enumeration_idx` (`role`),
  CONSTRAINT `page_role_2_developer` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`id`),
  CONSTRAINT `page_role_2_page` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`),
  CONSTRAINT `page_role_enumeration` FOREIGN KEY (`role`) REFERENCES `role` (`role`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_role`
--

LOCK TABLES `page_role` WRITE;
/*!40000 ALTER TABLE `page_role` DISABLE KEYS */;
INSERT INTO `page_role` VALUES (1,'editor',123,1),(2,'reviewer',123,1),(3,'writer',123,1),(4,'editor',234,2),(5,'reviewer',234,2),(6,'writer',234,2),(7,'editor',345,3),(8,'reviewer',345,3),(9,'writer',345,3),(10,'editor',456,1),(11,'reviewer',456,1),(12,'writer',456,1),(13,'editor',567,2),(14,'reviewer',567,2),(15,'writer',567,2);
/*!40000 ALTER TABLE `page_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `page_role_AFTER_INSERT` AFTER INSERT ON `page_role` FOR EACH ROW BEGIN
  IF NEW.role = 'admin' OR NEW.role = 'owner' THEN
    INSERT INTO page_priviledge VALUES (NEW.id, 'write', NEW.page_id, NEW.developer_id);
    INSERT INTO page_priviledge VALUES (NEW.id, 'update', NEW.page_id, NEW.developer_id);
    INSERT INTO page_priviledge VALUES (NEW.id, 'delete', NEW.page_id, NEW.developer_id);
    INSERT INTO page_priviledge VALUES (NEW.id, 'read', NEW.page_id, NEW.developer_id);
  END IF;
  IF NEW.role='editor' THEN
     INSERT INTO page_priviledge VALUES (NEW.id, 'read', NEW.page_id, NEW.developer_id);
     INSERT INTO page_priviledge VALUES (NEW.id, 'update', NEW.page_id, NEW.developer_id);
  END IF;
  IF NEW.role='writer' THEN
     INSERT INTO page_priviledge VALUES (NEW.id, 'create', NEW.page_id, NEW.developer_id);
     INSERT INTO page_priviledge VALUES (NEW.id, 'read', NEW.page_id, NEW.developer_id);
     INSERT INTO page_priviledge VALUES (NEW.id, 'update', NEW.page_id, NEW.developer_id);
  END IF;
  IF NEW.role = 'reviewer' THEN
    INSERT INTO page_priviledge VALUES (NEW.id, 'read', NEW.page_id, NEW.developer_id);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `page_role_AFTER_UPDATE` AFTER UPDATE ON `page_role` FOR EACH ROW BEGIN
 IF NEW.role = 'admin' OR NEW.role = 'owner' THEN
	DELETE FROM page_priviledge
    WHERE page_role.developer_id=page_priviledge.developer_id;
    INSERT INTO page_priviledge VALUES (NEW.id, 'write', NEW.page_id, NEW.developer_id);
    INSERT INTO page_priviledge VALUES (NEW.id, 'update', NEW.page_id, NEW.developer_id);
    INSERT INTO page_priviledge VALUES (NEW.id, 'delete', NEW.page_id, NEW.developer_id);
    INSERT INTO page_priviledge VALUES (NEW.id, 'read', NEW.page_id, NEW.developer_id);
  END IF;
  IF NEW.role='editor' THEN
  	DELETE FROM page_priviledge
    WHERE page_role.developer_id=page_priviledge.developer_id;
	INSERT INTO page_priviledge VALUES (NEW.id, 'read', NEW.page_id, NEW.developer_id);
	INSERT INTO page_priviledge VALUES (NEW.id, 'update', NEW.page_id, NEW.developer_id);
  END IF;
  IF NEW.role='writer' THEN
	DELETE FROM page_priviledge
    WHERE page_role.developer_id=page_priviledge.developer_id;
	INSERT INTO page_priviledge VALUES (NEW.id, 'create', NEW.page_id, NEW.developer_id);
	INSERT INTO page_priviledge VALUES (NEW.id, 'read', NEW.page_id, NEW.developer_id);
	INSERT INTO page_priviledge VALUES (NEW.id, 'update', NEW.page_id, NEW.developer_id);
  END IF;
  IF NEW.role = 'reviewer' THEN
	DELETE FROM page_priviledge
    WHERE page_role.developer_id=page_priviledge.developer_id;
    INSERT INTO page_priviledge VALUES (NEW.id, 'read', NEW.page_id, NEW.developer_id);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `page_role_AFTER_DELETE` AFTER DELETE ON `page_role` FOR EACH ROW BEGIN
  IF role = 'admin' OR role = 'owner' THEN
    DELETE FROM page_priviledge
    WHERE page_role.developer_id=page_priviledge.developer_id;
  END IF;
  IF role='editor' THEN
	DELETE FROM page_priviledge
    WHERE page_role.developer_id=page_priviledge.developer_id;
  END IF;
  IF role='writer' THEN
    DELETE FROM page_priviledge
    WHERE page_role.developer_id=page_priviledge.developer_id;
  END IF;
  IF role = 'reviewer' THEN
    DELETE FROM page_priviledge
    WHERE page_role.developer_id=page_priviledge.developer_id;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-19 22:12:12