-- MySQL dump 10.15  Distrib 10.0.19-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: dvdshop
-- ------------------------------------------------------
-- Server version	10.0.19-MariaDB-1~trusty-log

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

--
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor` (
  `actor_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `unicode` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`actor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actor`
--

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
INSERT INTO `actor` VALUES (1,'Aun Kunkola','M','','',1),(2,'Botom','M','','',1),(3,'Cat James','M','','',1),(4,'Bebe fifi','F','','',1),(5,'Coco','F','','',1);
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `album_id` bigint(20) NOT NULL DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `publish_date` datetime DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `production_id` bigint(20) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `edition_year` int(10) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,'Sunday 555','2015-05-28 00:00:00',1,1,1,NULL,2015,2.50),(2,'HM v180','2015-05-28 00:00:00',1,1,1,NULL,2015,2.50),(3,'Town Production v90','2015-05-28 00:00:00',1,1,1,NULL,2014,2.50),(4,'Sunday v153','2015-06-01 07:00:00',2,2,2,NULL,2013,2.50),(5,'Pheng Record v15','2015-06-01 07:00:00',2,2,2,NULL,2015,2.50);
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albumactor`
--

DROP TABLE IF EXISTS `albumactor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albumactor` (
  `album_actor_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `actor_id` bigint(20) NOT NULL,
  `album_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`album_actor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albumactor`
--

LOCK TABLES `albumactor` WRITE;
/*!40000 ALTER TABLE `albumactor` DISABLE KEYS */;
INSERT INTO `albumactor` VALUES (1,1,1),(2,1,2),(3,2,1),(4,1,5),(5,1,4);
/*!40000 ALTER TABLE `albumactor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albumtype`
--

DROP TABLE IF EXISTS `albumtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albumtype` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `Unicode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albumtype`
--

LOCK TABLES `albumtype` WRITE;
/*!40000 ALTER TABLE `albumtype` DISABLE KEYS */;
INSERT INTO `albumtype` VALUES (1,'Karaoke','ការ៉ាឣូខេ'),(2,'CD','ស៊ីដី');
/*!40000 ALTER TABLE `albumtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `artist_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `Unicode` varchar(255) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'VEAREAK YOT','M','វីរះយុទ្ធ',1,NULL),(2,'PREASOVATH','M','ព្រាបសុវត្តិ',1,NULL),(3,'KHATHSOKHEAM','F','ខាតសុខីម',1,NULL),(4,'Sereymon','M','សិរីមន្ត',2,NULL),(5,'Sophea','F','សុខសោភា',2,NULL),(6,'Sokunisa','F','សុគុនិសា',2,NULL);
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
  `genre_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `unicode` varchar(255) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Cha cha cha','ឆាច ឆាច ឆា',1),(2,'Madison','ម៉ាឌីសូន',1),(3,'Roim Vong','រាំវង',1),(4,'Lam Leai','ឡាំលាវ',1);
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `language_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `unicode` varchar(255) DEFAULT NULL,
  `flag_image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'Combodian','ខ្មែរ','https://s3-us-west-2.amazonaws.com/cdworld-images/flags/cambodia.png'),(2,'Thai','ថៃ','https://s3-us-west-2.amazonaws.com/cdworld-images/flags/thailand.png'),(3,'Chinese','ចិន','https://s3-us-west-2.amazonaws.com/cdworld-images/flags/chinese.jpg'),(4,'English','អងគ្លេស','https://s3-us-west-2.amazonaws.com/cdworld-images/flags/english.jpg'),(5,'Korean','កូរ៉េ','https://s3-us-west-2.amazonaws.com/cdworld-images/flags/korean.jpg'),(6,'Japanes','ជប៉ុន','https://s3-us-west-2.amazonaws.com/cdworld-images/flags/japanese.jpg');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production`
--

DROP TABLE IF EXISTS `production`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `production` (
  `production_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `Unicode` varchar(255) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`production_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production`
--

LOCK TABLES `production` WRITE;
/*!40000 ALTER TABLE `production` DISABLE KEYS */;
INSERT INTO `production` VALUES (1,'HM',NULL,1,'https://s3-us-west-2.amazonaws.com/cdworld-images/SD/SD_VCD_131.jpg'),(2,'SUNDAY',NULL,1,'https://s3-us-west-2.amazonaws.com/cdworld-images/SD/SD_VCD_131.jpg'),(3,'Town','ថោន',1,'https://s3-us-west-2.amazonaws.com/cdworld-images/productions/town.png'),(4,'Pleng Record','ភ្លេងរីខត',1,'https://s3-us-west-2.amazonaws.com/cdworld-images/productions/plengrecord.jpg'),(5,'M Production','ផលិតអឹម',1,'https://s3-us-west-2.amazonaws.com/cdworld-images/productions/m.jpg'),(6,'Daimond Music','ដាយមិនម្ញួស៊ីក',1,'https://s3-us-west-2.amazonaws.com/cdworld-images/productions/daimondmusic.png');
/*!40000 ALTER TABLE `production` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `track` (
  `track_Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `length` varchar(20) DEFAULT NULL,
  `unicode` varchar(255) DEFAULT NULL,
  `album_id` bigint(20) DEFAULT NULL,
  `genre_id` bigint(20) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`track_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track`
--

LOCK TABLES `track` WRITE;
/*!40000 ALTER TABLE `track` DISABLE KEYS */;
INSERT INTO `track` VALUES (1,'Missing YOU WHEN Drunk','4:10','នឹកឣូនពេលស្រវឹង',1,1,1,0.20),(2,'Bong Reav Rok EY','3:50','បងរាវរកឣី',1,1,1,0.20),(3,'Girl Friend','4:00','មិត្តស្រី',2,2,1,0.20),(4,'My Baby','3:30','បងសំលាញ',2,2,2,0.20);
/*!40000 ALTER TABLE `track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trackactor`
--

DROP TABLE IF EXISTS `trackactor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackactor` (
  `track_actor_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `actor_id` bigint(20) NOT NULL,
  `track_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`track_actor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trackactor`
--

LOCK TABLES `trackactor` WRITE;
/*!40000 ALTER TABLE `trackactor` DISABLE KEYS */;
INSERT INTO `trackactor` VALUES (1,1,1),(2,1,2),(3,1,3);
/*!40000 ALTER TABLE `trackactor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trackartist`
--

DROP TABLE IF EXISTS `trackartist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackartist` (
  `track_artist_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `artist_id` bigint(20) NOT NULL,
  `track_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`track_artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trackartist`
--

LOCK TABLES `trackartist` WRITE;
/*!40000 ALTER TABLE `trackartist` DISABLE KEYS */;
INSERT INTO `trackartist` VALUES (1,1,1),(2,2,2),(3,3,2),(4,1,3),(5,4,3),(6,2,3),(7,5,4),(8,6,4);
/*!40000 ALTER TABLE `trackartist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `access_token` varchar(255) NOT NULL,
  `provider_id` varchar(255) NOT NULL,
  `provider_user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Sokheng Sam','sokhengmail@yahoo.com','CAACEdEose0cBAO9ecfcoP3yvCODdXBJSaAiKnnZBrLbTSZAkQJ1fqRnf35Sntd27yZBlQ5eI31qsFOm0fyhMsccxj8joipjxLYS22FHZBo4Fukza0M9MSDWDb9LT2X8y8nzZAth3meqvmhFaZAj6T1ZAuSNV3FNkTLvVS1iacZBYey5TgqL6OlCSGZCGkI4DytNIYdhNkIsgRrhfD5ZA6gZCzuDcyZBVf295ZCZBEZD','facebook','100001191951721'),(2,'Anomymous Khun','khunsith.khim@gmail.com','CAAMWpDcv6rQBAD62LRXY5MIaY9ZC1Yz7CXpIcGlTaFqY1Hu2Q22lNlBbmdsqk9yFhBVtRZCqXVuTT9mtMf1WeVrhr79ZB3JTvxUvvuxC8UFaZBBxEZCS334bF3u06l9BDemKM5AxrLGLfJVwRKH9N5FjIrBSk6XKrVTg58NPS48P8KZCUX9u0srAkAZCEgDkkgKT5AJMKB8ZCaZCiP1OZBbMNtHtWnQvEWPXm4DE3hPTWOBwZDZD','facebook','10204639359528483'),(3,'Hay Vichet',NULL,'CAALAETBq2EQBABJknDC0xV5lZBnZA1ltuKoDvp1MH2PpW0fqvOf8VZCiurFAtf75LveoHL9g0CZAaxbteFiTQS0j2tRcUoTEgbTiekM7UpAooD8dfuqHmYDrBnzPPlxxZBRMUa7V3FOCTgxnxm90M0X07KN8oid3zzhYykwhf5aNWV7m0TJSTfL2fjj7wKbl4t7jlAUIVheJUOg0GdwhCFnvA3BTKZBD0ieUqZAZB5bUHQZDZD','facebook','826631317392740');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useralbum`
--

DROP TABLE IF EXISTS `useralbum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `useralbum` (
  `user_album_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `album_id` bigint(20) DEFAULT NULL,
  `favorite` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_album_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useralbum`
--

LOCK TABLES `useralbum` WRITE;
/*!40000 ALTER TABLE `useralbum` DISABLE KEYS */;
INSERT INTO `useralbum` VALUES (1,1,1,1),(3,1,2,1),(4,2,1,0),(5,1,4,1);
/*!40000 ALTER TABLE `useralbum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertrack`
--

DROP TABLE IF EXISTS `usertrack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usertrack` (
  `user_track_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `track_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`user_track_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertrack`
--

LOCK TABLES `usertrack` WRITE;
/*!40000 ALTER TABLE `usertrack` DISABLE KEYS */;
INSERT INTO `usertrack` VALUES (1,1,1),(2,1,2);
/*!40000 ALTER TABLE `usertrack` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-15 15:21:42
