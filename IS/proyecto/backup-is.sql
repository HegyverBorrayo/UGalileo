-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: is-2020.cj5s6t6xgk70.us-east-2.rds.amazonaws.com    Database: db_is_2020
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED='';

--
-- Table structure for table `Bodega`
--

DROP TABLE IF EXISTS `Bodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bodega` (
  `IdBodega` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) DEFAULT NULL,
  `slot_totales` int DEFAULT NULL,
  `slot_disponibles` int DEFAULT NULL,
  PRIMARY KEY (`IdBodega`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bodega`
--

LOCK TABLES `Bodega` WRITE;
/*!40000 ALTER TABLE `Bodega` DISABLE KEYS */;
INSERT INTO `Bodega` VALUES (3,'Santa Clara',100,74),(4,'Amatitlan',100,85),(5,'#1 Tienda Para Inventario 2',999999,999499),(6,'IS Ventas Inventario 2',999999,999998),(7,'POS 2',50000,48998),(8,'Casa de Erinson ',69,67);
/*!40000 ALTER TABLE `Bodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Compras`
--

DROP TABLE IF EXISTS `Compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Compras` (
  `IdCompras` int NOT NULL AUTO_INCREMENT,
  `IdProducto` int DEFAULT NULL,
  `Unidades` int DEFAULT NULL,
  `Fecha_compra` date DEFAULT NULL,
  PRIMARY KEY (`IdCompras`),
  KEY `IdProducto` (`IdProducto`),
  CONSTRAINT `Compras_ibfk_1` FOREIGN KEY (`IdProducto`) REFERENCES `Producto` (`IdProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Compras`
--

LOCK TABLES `Compras` WRITE;
/*!40000 ALTER TABLE `Compras` DISABLE KEYS */;
INSERT INTO `Compras` VALUES (1,1,5,'2020-10-21'),(2,1,500,'2020-10-21'),(3,2,1,'2020-10-22'),(4,2,1,'2020-10-22'),(5,2,3,'2020-10-23'),(6,2,4,'2020-10-23'),(7,1,1000,'2020-10-23');
/*!40000 ALTER TABLE `Compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DetalleBodega`
--

DROP TABLE IF EXISTS `DetalleBodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DetalleBodega` (
  `IdDetalleBodega` int NOT NULL AUTO_INCREMENT,
  `IdProducto` int DEFAULT NULL,
  `Idbodega` int DEFAULT NULL,
  `Unidades_disponibles` int DEFAULT NULL,
  PRIMARY KEY (`IdDetalleBodega`),
  KEY `IdProducto` (`IdProducto`),
  KEY `Idbodega` (`Idbodega`),
  CONSTRAINT `DetalleBodega_ibfk_1` FOREIGN KEY (`IdProducto`) REFERENCES `Producto` (`IdProducto`),
  CONSTRAINT `DetalleBodega_ibfk_2` FOREIGN KEY (`Idbodega`) REFERENCES `Bodega` (`IdBodega`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DetalleBodega`
--

LOCK TABLES `DetalleBodega` WRITE;
/*!40000 ALTER TABLE `DetalleBodega` DISABLE KEYS */;
INSERT INTO `DetalleBodega` VALUES (5,2,3,11),(6,1,3,15),(7,2,4,15),(8,1,5,500),(9,2,6,1),(10,2,7,4),(11,1,7,998),(12,2,8,2);
/*!40000 ALTER TABLE `DetalleBodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ingresos`
--

DROP TABLE IF EXISTS `Ingresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ingresos` (
  `IdIngreso` int NOT NULL AUTO_INCREMENT,
  `IdProducto` int DEFAULT NULL,
  `IdBodega` int DEFAULT NULL,
  `Unidades` int DEFAULT NULL,
  `Fecha_ingreso` date DEFAULT NULL,
  PRIMARY KEY (`IdIngreso`),
  KEY `IdProducto` (`IdProducto`),
  KEY `IdBodega` (`IdBodega`),
  CONSTRAINT `Ingresos_ibfk_1` FOREIGN KEY (`IdProducto`) REFERENCES `Producto` (`IdProducto`),
  CONSTRAINT `Ingresos_ibfk_2` FOREIGN KEY (`IdBodega`) REFERENCES `Bodega` (`IdBodega`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingresos`
--

LOCK TABLES `Ingresos` WRITE;
/*!40000 ALTER TABLE `Ingresos` DISABLE KEYS */;
INSERT INTO `Ingresos` VALUES (12,2,3,15,'2020-10-19'),(13,2,3,10,'2020-10-19'),(14,1,3,15,'2020-10-19'),(15,1,5,5,'2020-10-21'),(16,1,5,500,'2020-10-21'),(17,2,6,1,'2020-10-22'),(18,2,6,1,'2020-10-22'),(19,2,3,3,'2020-10-23'),(20,2,7,4,'2020-10-23'),(21,1,7,1000,'2020-10-23');
/*!40000 ALTER TABLE `Ingresos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Producto`
--

DROP TABLE IF EXISTS `Producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Producto` (
  `IdProducto` int NOT NULL AUTO_INCREMENT,
  `sku` varchar(12) DEFAULT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `precio_compra` float(10,2) DEFAULT NULL,
  `unidades_disponibles` int DEFAULT NULL,
  PRIMARY KEY (`IdProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Producto`
--

LOCK TABLES `Producto` WRITE;
/*!40000 ALTER TABLE `Producto` DISABLE KEYS */;
INSERT INTO `Producto` VALUES (1,'HP-15-DB1022','HP 15-DB1022LA ','HP 15-DB1022LA RYZEN 3 2.6GHZ 16GB DDR4 1TB W10H 15.6',4156.00,10),(2,'CEL-XI-N9412','CELULAR XIAOMI NOTE 9','CELULAR XIAOMI NOTE 9 6.53 48MGPXL 4GB 128GB NEGRO',1882.00,10),(3,'AUD-XIA-BLTW','AUDIFONO XIAOMI BLUETOOTH','AUDIFONO XIAOMI BLUETOOTH Mi TRUE WIRELESS 2 BASIC BLANCO',266.00,0);
/*!40000 ALTER TABLE `Producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Salidas`
--

DROP TABLE IF EXISTS `Salidas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Salidas` (
  `IdSalida` int NOT NULL AUTO_INCREMENT,
  `IdDetalleBodega` int DEFAULT NULL,
  `Unidades` int DEFAULT NULL,
  `Fecha_salida` date DEFAULT NULL,
  PRIMARY KEY (`IdSalida`),
  KEY `IdDetalleBodega` (`IdDetalleBodega`),
  CONSTRAINT `Salidas_ibfk_1` FOREIGN KEY (`IdDetalleBodega`) REFERENCES `DetalleBodega` (`IdDetalleBodega`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Salidas`
--

LOCK TABLES `Salidas` WRITE;
/*!40000 ALTER TABLE `Salidas` DISABLE KEYS */;
INSERT INTO `Salidas` VALUES (1,8,1,'2020-10-21'),(2,8,1,'2020-10-21'),(3,8,1,'2020-10-21'),(4,8,1,'2020-10-21'),(5,8,1,'2020-10-21'),(6,9,1,'2020-10-22'),(7,11,1,'2020-10-23'),(8,11,1,'2020-10-27');
/*!40000 ALTER TABLE `Salidas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Traslados`
--

DROP TABLE IF EXISTS `Traslados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Traslados` (
  `IdTraslado` int NOT NULL AUTO_INCREMENT,
  `IdDetalleBodega` int DEFAULT NULL,
  `IdBodegaNueva` int DEFAULT NULL,
  `Unidades` int DEFAULT NULL,
  `Fecha_traslado` date DEFAULT NULL,
  PRIMARY KEY (`IdTraslado`),
  KEY `IdDetalleBodega` (`IdDetalleBodega`),
  KEY `IdBodegaNueva` (`IdBodegaNueva`),
  CONSTRAINT `Traslados_ibfk_1` FOREIGN KEY (`IdDetalleBodega`) REFERENCES `DetalleBodega` (`IdDetalleBodega`),
  CONSTRAINT `Traslados_ibfk_2` FOREIGN KEY (`IdBodegaNueva`) REFERENCES `Bodega` (`IdBodega`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Traslados`
--

LOCK TABLES `Traslados` WRITE;
/*!40000 ALTER TABLE `Traslados` DISABLE KEYS */;
INSERT INTO `Traslados` VALUES (1,5,4,15,'2020-10-20'),(2,5,8,2,'2020-10-24');
/*!40000 ALTER TABLE `Traslados` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-28 11:56:42
