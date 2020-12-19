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
-- Table structure for table `website_role`
--

DROP TABLE IF EXISTS `website_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(45) NOT NULL,
  `website_id` int NOT NULL,
  `developer_id` int NOT NULL,
  PRIMARY KEY (`id`,`role`,`website_id`,`developer_id`),
  KEY `website_role_2_website_idx` (`website_id`),
  KEY `website_role_2_developer_idx` (`developer_id`),
  KEY `website_role_enumeration_idx` (`role`),
  CONSTRAINT `website_role_2_developer` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`id`),
  CONSTRAINT `website_role_2_website` FOREIGN KEY (`website_id`) REFERENCES `website` (`id`),
  CONSTRAINT `website_role_enumeration` FOREIGN KEY (`role`) REFERENCES `role` (`role`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_role`
--

LOCK TABLES `website_role` WRITE;
/*!40000 ALTER TABLE `website_role` DISABLE KEYS */;
INSERT INTO `website_role` VALUES (14,'owner',123,1),(66,'editor',123,1),(67,'admin',123,1),(119,'owner',123,1),(120,'editor',123,1),(121,'admin',123,1),(68,'owner',234,2),(69,'editor',234,2),(70,'admin',234,2),(122,'owner',234,2),(123,'editor',234,2),(124,'admin',234,2),(71,'owner',345,3),(72,'editor',345,3),(73,'admin',345,3),(125,'owner',345,3),(126,'editor',345,3),(127,'admin',345,3),(74,'owner',456,1),(75,'editor',456,1),(76,'admin',456,1),(128,'owner',456,1),(129,'editor',456,1),(130,'admin',456,1),(77,'owner',567,2),(78,'editor',567,2),(79,'admin',567,2),(131,'owner',567,2),(132,'editor',567,2),(133,'admin',567,2),(80,'owner',678,3),(81,'editor',678,3),(82,'admin',678,3),(134,'owner',678,3),(135,'editor',678,3),(136,'admin',678,3);
/*!40000 ALTER TABLE `website_role` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `website_role_AFTER_INSERT` AFTER INSERT ON `website_role` FOR EACH ROW BEGIN
  IF NEW.role = 'admin' OR NEW.role = 'owner' THEN
    INSERT INTO website_priviledge VALUES (NEW.id, 'write', NEW.website_id, NEW.developer_id);
    INSERT INTO website_priviledge VALUES (NEW.id, 'update', NEW.website_id, NEW.developer_id);
    INSERT INTO website_priviledge VALUES (NEW.id, 'delete', NEW.website_id, NEW.developer_id);
    INSERT INTO website_priviledge VALUES (NEW.id, 'read', NEW.website_id, NEW.developer_id);
  END IF;
  IF NEW.role='editor' THEN
     INSERT INTO website_priviledge VALUES (NEW.id, 'read', NEW.website_id, NEW.developer_id);
     INSERT INTO website_priviledge VALUES (NEW.id, 'update', NEW.website_id, NEW.developer_id);
  END IF;
  IF NEW.role='writer' THEN
     INSERT INTO website_priviledge VALUES (NEW.id, 'create', NEW.website_id, NEW.developer_id);
     INSERT INTO website_priviledge VALUES (NEW.id, 'read', NEW.website_id, NEW.developer_id);
     INSERT INTO website_priviledge VALUES (NEW.id, 'update', NEW.website_id, NEW.developer_id);
  END IF;
  IF NEW.role = 'reviewer' THEN
    INSERT INTO website_priviledge VALUES (NEW.id, 'read', NEW.website_id, NEW.developer_id);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `website_role_AFTER_UPDATE` AFTER UPDATE ON `website_role` FOR EACH ROW BEGIN
  IF role = 'admin' OR role = 'owner' THEN
    DELETE FROM website_priviledge
    WHERE website_role.developer_id=website_priviledge.developer_id;
	INSERT INTO website_priviledge VALUES (1, 'write', NEW.website_id, NEW.developer_id);
    INSERT INTO website_priviledge VALUES (NEW.id, 'update', NEW.website_id, NEW.developer_id);
    INSERT INTO website_priviledge VALUES (NEW.id, 'delete', NEW.website_id, NEW.developer_id);
    INSERT INTO website_priviledge VALUES (NEW.id, 'read', NEW.website_id, NEW.developer_id);
  END IF;
  IF role='editor' THEN
	DELETE FROM website_priviledge
    WHERE website_role.developer_id=website_priviledge.developer_id;
	INSERT INTO website_priviledge VALUES (NEW.id, 'read', NEW.website_id, NEW.developer_id);
	INSERT INTO website_priviledge VALUES (NEW.id, 'update', NEW.website_id, NEW.developer_id);
  END IF;
  IF role='writer' THEN
	DELETE FROM website_priviledge
    WHERE website_role.developer_id=website_priviledge.developer_id;
	INSERT INTO website_priviledge VALUES (NEW.id, 'create', NEW.website_id, NEW.developer_id);
	INSERT INTO website_priviledge VALUES (NEW.id, 'read', NEW.website_id, NEW.developer_id);
	INSERT INTO website_priviledge VALUES (NEW.id, 'update', NEW.website_id, NEW.developer_id);
  END IF;
  IF role = 'reviewer' THEN
    DELETE FROM website_priviledge
    WHERE website_role.developer_id=website_priviledge.developer_id;
	INSERT INTO website_priviledge VALUES (NEW.id, 'read', NEW.website_id, NEW.developer_id);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `website_role_AFTER_DELETE` AFTER DELETE ON `website_role` FOR EACH ROW BEGIN
  IF role = 'admin' OR role = 'owner' THEN
    DELETE FROM website_priviledge
    WHERE website_role.developer_id=website_priviledge.developer_id;
  END IF;
  IF role='editor' THEN
	DELETE FROM website_priviledge
    WHERE website_role.developer_id=website_priviledge.developer_id;
  END IF;
  IF role='writer' THEN
	DELETE FROM website_priviledge
    WHERE website_role.developer_id=website_priviledge.developer_id;
  END IF;
  IF role = 'reviewer' THEN
    DELETE FROM website_priviledge
    WHERE website_role.developer_id=website_priviledge.developer_id;
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

-- Dump completed on 2020-10-19 22:12:15