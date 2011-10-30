-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: project_development
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.10

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
-- Table structure for table `age_categories`
--

DROP TABLE IF EXISTS `age_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `age_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `age_categories`
--

LOCK TABLES `age_categories` WRITE;
/*!40000 ALTER TABLE `age_categories` DISABLE KEYS */;
INSERT INTO `age_categories` VALUES (1,'General','2011-08-14 07:46:04','2011-08-14 07:46:04'),(2,'Above 18','2011-08-14 07:46:04','2011-08-14 07:46:04'),(3,'Parental','2011-08-14 07:46:04','2011-08-14 07:46:04');
/*!40000 ALTER TABLE `age_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Action','2011-08-14 07:46:04','2011-08-14 07:46:04'),(2,'Adventure','2011-08-14 07:46:04','2011-08-14 07:46:04'),(3,'Simulation','2011-08-14 07:46:04','2011-08-14 07:46:04'),(4,'Role Playing','2011-08-14 07:46:04','2011-08-14 07:46:04'),(5,'Strategy','2011-08-14 07:46:04','2011-08-14 07:46:04');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_games`
--

DROP TABLE IF EXISTS `categories_games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_games` (
  `game_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_games`
--

LOCK TABLES `categories_games` WRITE;
/*!40000 ALTER TABLE `categories_games` DISABLE KEYS */;
INSERT INTO `categories_games` VALUES (1,1),(1,2),(2,1),(2,3),(3,2),(3,4),(4,2),(4,5),(5,1),(5,4),(6,2),(6,5),(7,4),(7,5),(9,1),(9,5),(10,3),(10,4),(11,1),(11,4),(12,1),(12,2),(12,4),(13,2),(13,4),(14,1),(14,5),(15,1),(15,2),(15,4),(15,5),(16,2),(16,5),(17,2),(17,3),(17,4),(18,2),(18,4),(18,5),(19,1),(19,4),(19,5),(20,3),(20,4);
/*!40000 ALTER TABLE `categories_games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_games_users`
--

DROP TABLE IF EXISTS `favorite_games_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorite_games_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `favorite_game_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_games_users`
--

LOCK TABLES `favorite_games_users` WRITE;
/*!40000 ALTER TABLE `favorite_games_users` DISABLE KEYS */;
INSERT INTO `favorite_games_users` VALUES (2,1,12,'2011-08-16 04:31:57','2011-08-16 04:31:57'),(3,1,15,'2011-08-16 04:34:44','2011-08-16 04:34:44'),(4,1,15,'2011-08-16 04:37:33','2011-08-16 04:37:33'),(5,1,12,'2011-08-16 04:38:15','2011-08-16 04:38:15'),(7,2,15,'2011-09-06 06:56:12','2011-09-06 06:56:12'),(8,2,16,'2011-09-06 06:56:14','2011-09-06 06:56:14');
/*!40000 ALTER TABLE `favorite_games_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `age_category_id` int(11) DEFAULT NULL,
  `platform_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_games_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,'Dinner town detective agency','Something\'s not right in DinerTown! Help Bernie the Bookworm become a real detective as you hunt for clues in mysteries like \r\n                   who stuck their finger in all the jelly donuts? and who\'s been partying like a rock star with the zoo animals?\r\n                   ID the culprits as you search out the fun in this lighthearted spoof on traditional Hidden\r\n                   Object games.','x_games_bmx.jpg','image/jpeg',133634,'2011-08-14 07:46:50','2011-08-14 15:30:01',3,1,1),(2,'Game quest Bundle','Jewel Quest 2 and Jewel Quest 3 in one executable file at a great low price! ','gow2-boxshot.jpg','image/jpeg',279664,'2011-08-14 07:46:50','2011-08-14 15:24:25',0,2,1),(3,'Bejeweled 2','Take the classic game of gem-swapping to euphoric new heights! Adapted \r\n                      from its predecessor, Bejeweled 2 features four unique ways to play.','Video-Games.jpg','image/jpeg',83017,'2011-08-14 07:46:50','2011-08-14 15:25:40',1,1,1),(4,'Monopoly','Own it all with this amazing version of the best-known and \n                  loved Monopoly game that brings this timeless family treat to vivid life like never before. Roll the dice and watch the cleverly animated tokens bounce around the board. Challenge your friends and family to exciting Monopoly fun, or play against an advanced AI with multiple difficulty settings. Even change the rules to suit your own tastes and styles! A stirring update to a game that\'s been a family favorite for more than 70 years, Monopoly is a must-have \n                  for any game library.',NULL,NULL,NULL,'2011-08-14 07:46:50','2011-08-14 07:46:50',3,2,2),(5,'Secrets of Great Art','Secrets slither within the canvas in Secrets of Great Art. Only you can uncover the truth behind the brush strokes! Help your amnesia stricken hero recover his lost memory and solve the mystery hidden within antique paintings. Explore 60 unique levels of beautiful paintings and put your perception skills to the test.',NULL,NULL,NULL,'2011-08-14 07:46:50','2011-08-14 07:46:50',0,3,1),(6,'CLUE Accusations and Alibis','Use your powers of perception and ace detective skills to solve a riveting mystery in CLUE Accusations and Alibis, an original new hidden object game inspired by everyone\'s favorite board game. Featuring fashionable updates to your favorite CLUE characters, addictive hidden object gameplay, an all-new mansion to search, and more than 400 unique cases to solve, you\'ll want to return to the scene of the crime again and again. Accept your invitation to murder today!','game-3869928.jpg','image/jpeg',64724,'2011-08-14 07:46:50','2011-08-15 09:06:16',2,1,2),(7,'Elf Bowling 7','Lace up your best pair of bowling shoes and polish your shiny Christmas ball for the wackiest adventure yet! The elves are up to no good and Santa needs your help to show those crazy elves what the true meaning of \'strike\' is. It\'s quirky, hilarious\n                   bowling fun just in time for the holiday season!',NULL,NULL,NULL,'2011-08-14 07:46:50','2011-08-14 07:46:50',2,1,2),(9,'Little Shop of Treasures','Welcome to Huntington, a charming little town where if you look close enough, your dreams will come true. Help Huntington\'s shop owners find more than 1,200 unique, and cleverly hidden, items for their customers and earn enough cash to open a shop of your own! Featuring two great ways to play, an innovative hint feature',NULL,NULL,NULL,'2011-08-14 07:46:50','2011-08-14 07:46:50',3,2,2),(10,'Magic Academy 2','Once again trouble is brewing in the world of magic. A priceless treatise has gone missing and if it falls into the wrong hands, a demon that was banished long ago could be summoned from exile.',NULL,NULL,NULL,'2011-08-14 07:46:50','2011-08-14 07:46:50',3,3,2),(11,'Wedding Dash: Ready, Aim, Love!','Love is in the air as Cupid visits DinerTown and Quinn starts planning her OWN wedding. With the magic of Cupid\'s love arrows, any!',NULL,NULL,NULL,'2011-08-14 07:46:50','2011-08-14 07:46:50',2,3,2),(12,'Artist Colony','Unveil the drama in this casual Sim masterpiece of love, betrayal and creative genius. Inspire artists, sculptors, dancers & musicians to become masters of their craft.!','x_games_bmx.jpg','image/jpeg',133634,'2011-08-14 07:46:50','2011-08-14 15:25:00',2,2,1),(13,'Dream Chronicles: The Chosen Child','Unlock the secrets of the mysterious fairy realm in the third installment of the award-winning Dream Chronicles series. Discover hidden clues and solve challenging puzzles as you join Faye on her quest to save her daughter from the clutches of the Fairy Queen Lilith and reveal the secret prophecy of The Chosen Child','Video-Games.jpg','image/jpeg',83017,'2011-08-14 07:46:50','2011-08-14 15:31:19',0,3,1),(14,'Womens Murder Club: Twice in a Blue Moon','Reveal a criminal\'s murderous clues as he leads you and the Women\'s Murder Club on a shocking seek and find chase through San Francisco. Unravel a vicious tribute to the past by deciphering cryptic messages, uncovering facts and finding a killer before he strikes again.!','Video-Games.jpg','image/jpeg',83017,'2011-08-14 07:46:50','2011-08-14 15:39:18',0,3,2),(15,'Alabama Smith in the Quest of Fate','Alabama Smith is back in an all-new time-twisting adventure involving powerful relics that could alter the destiny of mankind! Join him as he hunts for the elusive Crystals of Fortune using the Amulet of Tim','creation-full.jpg','image/jpeg',1066152,'2011-08-14 07:46:50','2011-08-15 08:00:27',1,2,2),(16,'Avenue Flote','Mysterious events are threatening DinerTown\'s biggest wedding in history. As Flo, you will explore the town, interacting with neighbors that help you solve puzzles, collect missing items, and complete activities to set things right. Can you help Quinn save the wedding?','images.jpeg','image/jpeg',8774,'2011-08-14 07:46:51','2011-08-14 15:25:26',1,2,1),(17,'Dinner detective agency','Something\'s not right in DinerTown! Help Bernie the Bookworm become a real detective as you hunt for clues in mysteries like \r\n                   who stuck their finger in all the jelly donuts? and who\'s been partying like a rock star with the zoo animals?\r\n                   ID the culprits as you search out the fun in this lighthearted spoof on traditional Hidden\r\n                   Object games.','Video-Games.jpg','image/jpeg',83017,'2011-08-14 07:46:51','2011-08-14 15:29:40',2,2,1),(18,'Game Bundle','Jewel Quest 2 and Jewel Quest 3 in one executable file at a great low price! ','violent-games.jpg','image/jpeg',23201,'2011-08-14 07:46:51','2011-08-14 16:02:20',0,2,1),(19,'Monopoly unique','Own it all with this amazing version of the best-known and \n                  loved Monopoly game that brings this timeless family treat to vivid life like never before. Roll the dice and watch the cleverly animated tokens bounce around the board. Challenge your friends and family to exciting Monopoly fun, or play against an advanced AI with multiple difficulty settings. Even change the rules to suit your own tastes and styles! A stirring update to a game that\'s been a family favorite for more than 70 years, Monopoly is a must-have \n                  for any game library.',NULL,NULL,NULL,'2011-08-14 07:46:51','2011-08-14 07:46:51',3,2,1),(20,'Secrets of good Art','Secrets slither within the canvas in Secrets of Great Art. Only you can uncover the truth behind the brush strokes! Help your amnesia stricken hero recover his lost memory and solve the mystery hidden within antique paintings. Explore 60 unique levels of beautiful paintings and put your perception skills to the test.',NULL,NULL,NULL,'2011-08-14 07:46:51','2011-08-14 07:46:51',2,3,2);
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games_users`
--

DROP TABLE IF EXISTS `games_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `grabbed_at` datetime DEFAULT NULL,
  `notified_at` datetime DEFAULT NULL,
  `rented_at` datetime DEFAULT NULL,
  `returned_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_games_users_on_game_id_and_user_id` (`game_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games_users`
--

LOCK TABLES `games_users` WRITE;
/*!40000 ALTER TABLE `games_users` DISABLE KEYS */;
INSERT INTO `games_users` VALUES (1,15,1,3,'2011-08-14 13:58:32','2011-08-14 14:06:13','2011-08-14 13:58:32',NULL,'2011-08-14 14:06:13',NULL),(2,15,2,0,'2011-08-14 14:57:19','2011-08-14 14:57:19',NULL,NULL,NULL,NULL),(4,2,2,0,'2011-08-14 14:59:48','2011-08-14 14:59:48',NULL,NULL,NULL,NULL),(5,14,2,0,'2011-08-14 15:00:07','2011-08-14 15:00:07',NULL,NULL,NULL,NULL),(6,13,2,0,'2011-08-14 15:00:17','2011-08-14 15:00:17',NULL,NULL,NULL,NULL),(7,6,2,4,'2011-08-14 15:01:26','2011-09-11 14:06:20','2011-08-14 15:01:26',NULL,'2011-08-14 15:01:37','2011-09-11 14:06:20'),(8,12,2,3,'2011-09-11 14:07:09','2011-09-11 14:10:45','2011-09-11 14:07:09',NULL,'2011-09-11 14:10:45',NULL);
/*!40000 ALTER TABLE `games_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platforms`
--

DROP TABLE IF EXISTS `platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platforms`
--

LOCK TABLES `platforms` WRITE;
/*!40000 ALTER TABLE `platforms` DISABLE KEYS */;
INSERT INTO `platforms` VALUES (1,'PS3','2011-08-14 07:46:04','2011-08-14 07:46:04'),(2,'Xbox360','2011-08-14 07:46:04','2011-08-14 07:46:04');
/*!40000 ALTER TABLE `platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20091005084251'),('20091009083712'),('20091015052900'),('20091020053935'),('20091022053800'),('20091023091229'),('20091028081457'),('20091029051810'),('20091105063719'),('20091105063741'),('20091110124558'),('20091110124615'),('20091110124626'),('20091110133729'),('20091110133921'),('20091110134050'),('20091111051435'),('20091117040630'),('20091117060659'),('20091117061022'),('20091201051917'),('20091204050244'),('20091204050654'),('20091204050959'),('20091222093650'),('20091222101051'),('20091222101957'),('20110613051733');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_renewals`
--

DROP TABLE IF EXISTS `subscription_renewals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_renewals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `renewed_on` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_renewals`
--

LOCK TABLES `subscription_renewals` WRITE;
/*!40000 ALTER TABLE `subscription_renewals` DISABLE KEYS */;
INSERT INTO `subscription_renewals` VALUES (1,'2011-08-14',1),(2,'2011-08-14',2),(3,'2011-08-14',1),(4,'2011-08-15',1),(5,'2011-09-14',1),(6,'2011-09-13',2),(7,'2011-10-13',2),(8,'2011-11-12',2),(9,'2011-12-12',2),(10,'2012-01-11',2),(11,'2012-02-10',2),(12,'2012-03-11',2),(13,'2012-04-10',2),(14,'2012-05-10',2),(15,'2011-09-11',2);
/*!40000 ALTER TABLE `subscription_renewals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `crypted_password` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identification_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remember_token` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token_expires_at` datetime DEFAULT NULL,
  `reset_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subscribed_on` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  KEY `index_users_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Prashant','psahni@sahni.com','1985-01-01','9210459309','2f03d9ebd96b5a209a64301fccf70f4e8e97e82c','b52bddbc0fe00f5d0626c7043293367f9906a090','JBtKY7N5RO',1,'2011-08-14 13:52:35','2011-08-15 07:55:13',NULL,NULL,NULL,'2011-08-15'),(2,'Tanu','tanu@email.com','1985-01-01','9210459309','d822bb0803aca923d617beb7e0ce8ef4512cb4e8','3c97013c23b69ddc261827e51e0e443a9e1e0a28','0A2UDJLZ2u',1,'2011-08-14 14:16:37','2011-09-11 14:13:15',NULL,NULL,NULL,'2011-09-11');
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

-- Dump completed on 2011-10-28 13:04:53
