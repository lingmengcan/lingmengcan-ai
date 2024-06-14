-- MariaDB dump 10.19-11.3.2-MariaDB, for osx10.19 (arm64)
--
-- Host: localhost    Database: lingmengcan-ai
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `conversation`
--

DROP TABLE IF EXISTS `conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversation` (
  `conversation_id` varchar(36) NOT NULL,
  `conversation_name` varchar(32) NOT NULL,
  `user_name` varchar(32) NOT NULL,
  `llm` varchar(32) NOT NULL DEFAULT '',
  `temperature` float NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`conversation_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation`
--

LOCK TABLES `conversation` WRITE;
/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
INSERT INTO `conversation` VALUES
('1ec36d62-ba77-4dd5-838a-c95263c10204','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:14:31','2024-04-01 16:20:49'),
('1f456d10-f5b8-47ca-b298-9c457d56933d','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:21:09','2024-04-01 16:29:02'),
('28f946ac-23f7-4723-a9c2-59b59a411223','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:22:05','2024-04-01 16:28:54'),
('2e4bf445-31b7-496f-923d-db07edfdc7a7','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:19:02','2024-04-01 16:29:14'),
('32a6ede0-6d83-451c-9589-b87e153f8bf8','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:24:21','2024-04-01 16:27:16'),
('35d81424-1700-4bf4-8818-14037f0ffa91','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:23:27','2024-04-01 16:28:57'),
('3e2ff68c-9599-488d-bb53-1d0e48ecb5ef','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:14:26','2024-04-01 16:16:25'),
('53820c3c-532e-4068-8a73-8a6150af307c','新建对话','admin','ChatGLM3',0.5,0,'2024-05-09 16:42:06','2024-05-09 16:42:06'),
('564127e4-614e-41a2-b007-a42567997ed1','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:13:29','2024-04-01 16:13:52'),
('5a597d1b-bdd0-4655-96c3-b65bd1f40f09','新建对话2','admin','ChatGLM3',0.5,0,'2024-04-01 16:39:22','2024-04-03 17:32:11'),
('5c2b5555-ca96-457b-a207-7fadf3be2602','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:04:12','2024-04-01 16:04:30'),
('5fa8d167-bee1-4d2c-999b-b98f29295e74','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:21:44','2024-04-01 16:28:59'),
('728034b6-a376-4d0f-879d-4a335cf86643','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:24:17','2024-04-01 16:28:21'),
('86133e89-fc22-405c-8c8d-5cebf91d2c5f','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:08:44','2024-04-01 16:13:11'),
('99f21206-3e37-4c16-8ac1-fa27b368489f','新建对话1','admin','ChatGLM3',0.5,1,'2024-04-01 16:12:48','2024-04-01 16:13:04'),
('9bd99fc8-0c02-4317-8462-4e2d2a2317e4','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:20:54','2024-04-01 16:29:05'),
('9d470c53-11fd-4953-a7f6-2660db7e5dab','新建对话1','admin','ChatGLM3',0.5,0,'2024-04-01 16:30:33','2024-04-01 16:30:37'),
('a87e716d-a1d6-4e7a-9fe7-e73e6e81a775','新建对话','admin','ChatGLM3',0.5,1,'2024-04-01 16:16:57','2024-04-01 16:29:17'),
('d8b45320-ef1b-45f6-afed-77a7b6a09e96','新建对话','admin','gpt-3.5-turbo',0.5,0,'2024-04-07 16:43:20','2024-04-07 16:43:27');
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dict`
--

DROP TABLE IF EXISTS `dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dict` (
  `dict_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dict_type` varchar(32) NOT NULL DEFAULT '',
  `dict_code` varchar(32) NOT NULL,
  `dict_name` varchar(32) NOT NULL,
  `sort` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` varchar(512) NOT NULL,
  `created_user` varchar(32) NOT NULL,
  `updated_user` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict`
--

LOCK TABLES `dict` WRITE;
/*!40000 ALTER TABLE `dict` DISABLE KEYS */;
INSERT INTO `dict` VALUES
(1,'ROOT_TYPE','SYS_SEX','性别',2,0,'性别','admin','admin','2024-01-08 10:57:05','2024-01-08 11:09:18'),
(2,'ROOT_TYPE','SYS_STATUS','状态',1,0,'状态（0：正常，1：停用，-1：删除）','admin','admin','2024-01-08 11:03:52','2024-01-08 11:03:52'),
(3,'SYS_STATUS','0','正常',1,0,'正常','admin','admin','2024-01-08 11:06:22','2024-01-08 11:06:22'),
(4,'SYS_STATUS','1','停用',2,0,'停用','admin','admin','2024-01-08 11:07:59','2024-01-08 11:12:48'),
(5,'SYS_STATUS','-1','删除',3,1,'状态软删除','admin','admin','2024-01-08 11:08:47','2024-01-08 11:12:54'),
(6,'SYS_SEX','1','男',1,0,'男','admin','admin','2024-01-08 11:10:05','2024-01-08 11:10:29'),
(7,'SYS_SEX','0','女',2,0,'女','admin','admin','2024-01-08 11:10:24','2024-01-08 11:10:24'),
(8,'SYS_SEX','2','未知',3,0,'未知','admin','admin','2024-01-08 11:10:56','2024-01-08 11:10:56'),
(9,'MODEL_TYPE','GENERAL_MODEL','通用模型',1,0,'通用模型','admin','admin','2024-01-08 10:57:05','2024-01-08 10:57:05'),
(10,'MODEL_TYPE','EMBEDDING_MODEL','Embedding模型',2,0,'Embedding模型','admin','admin','2024-01-08 10:57:05','2024-06-03 11:15:45');
/*!40000 ALTER TABLE `dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `file_id` varchar(36) NOT NULL,
  `conversation_id` varchar(36) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(32) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `path` varchar(1024) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_user` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` VALUES
('02d62536-a032-4e94-8690-4450a1c06803','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-03/9ceb91cc-ed61-473f-abec-9eec8c9766fa.txt',0,'admin','2024-04-03 17:19:07','2024-04-03 17:19:07'),
('04d1e8d3-fd2f-4cef-9ad1-fa52aa672b23','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-03/512c6d1d-320e-4da7-beff-100fdfea1f1b.txt',0,'admin','2024-04-03 17:32:07','2024-04-03 17:32:07'),
('0ac4060f-e02c-40b0-98e4-0a638486835b','9d470c53-11fd-4953-a7f6-2660db7e5dab','主动.txt','.txt',86,'upload-files/2024-04-01/c1f01cad-3cd0-4e2c-9622-d8bb37bf5848.txt',0,'admin','2024-04-02 10:28:00','2024-04-02 10:28:00'),
('0fa099c4-b2a8-4de1-9673-57c6d613c56f','d8b45320-ef1b-45f6-afed-77a7b6a09e96','演讲稿.docx','.docx',13860,'upload-files/2024-05-20/f9708f71-0bc3-4f46-a4d6-42714c173a31.docx',0,'admin','2024-05-20 11:11:27','2024-05-20 11:11:27'),
('1552a857-f7e5-4b2e-bb3e-dee22bb16a80','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-07/2df774ad-a200-4151-b9c1-7e8dfe8948dc.txt',0,'admin','2024-04-07 16:41:49','2024-04-07 16:41:49'),
('3262c2f1-d150-4c28-8b97-dd1ed1a4e6c4','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-01/bb87902f-2f2c-4055-ae03-3ce6962a83f4.txt',0,'admin','2024-04-01 16:49:15','2024-04-01 16:49:15'),
('3423342f-55bd-459d-9044-8675d4569ac4','d8b45320-ef1b-45f6-afed-77a7b6a09e96','演讲稿.docx','.docx',13860,'upload-files/2024-05-20/07baec31-4b8f-4a45-810c-b9cf82cd3379.docx',0,'admin','2024-05-20 11:15:18','2024-05-20 11:15:18'),
('41801ca9-f31f-4c7d-bfcd-c3bbda1434b1','53820c3c-532e-4068-8a73-8a6150af307c','主动.txt','.txt',86,'undefined/2024-05-09/14c5ce52-ba3b-4863-8a2b-623899ca84c1.txt',0,'admin','2024-05-09 16:53:54','2024-05-09 16:53:54'),
('51919cd4-cd09-40ac-a2eb-4c26cc1f128e','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-03/0c96562c-1e72-4d09-aeab-59f587ad616a.txt',0,'admin','2024-04-03 17:24:39','2024-04-03 17:24:39'),
('567ceb9a-7bc9-4c22-9717-82bc96387daa','53820c3c-532e-4068-8a73-8a6150af307c','主动.txt','.txt',86,'undefined/2024-05-09/994a4724-f8cc-42c8-9c18-a83d8413e6c7.txt',0,'admin','2024-05-09 16:50:49','2024-05-09 16:50:49'),
('59dd1073-7bfa-4f65-9114-fc678f993f12','d8b45320-ef1b-45f6-afed-77a7b6a09e96','演讲稿.docx','.docx',13860,'upload-files/2024-05-20/291010d6-e96f-4b95-bc26-41db5e39d1bd.docx',0,'admin','2024-05-20 11:17:59','2024-05-20 11:17:59'),
('6172c143-b68b-40a5-b7e2-18f24fa8d4fe','53820c3c-532e-4068-8a73-8a6150af307c','主动.txt','.txt',86,'undefined/2024-05-09/18b47a60-e823-4db8-bfd8-8e27c4c17ab9.txt',0,'admin','2024-05-09 16:43:03','2024-05-09 16:43:03'),
('64834d7e-a3f8-4684-b871-a2a7168fef30','','编译加速思路.docx','.docx',71832,'upload-files/2024-04-01/c6c81834-68cb-4fa7-9fbc-76d97932745a.docx',0,'admin','2024-04-01 16:00:50','2024-04-01 16:00:50'),
('65290a86-a658-40ea-a7d5-1ae6f2768bd1','d8b45320-ef1b-45f6-afed-77a7b6a09e96','主动.txt','.txt',86,'upload-files/2024-04-07/c35ab7f2-c43e-442f-b9e4-b63ea0d6d507.txt',0,'admin','2024-04-07 16:43:26','2024-04-07 16:43:26'),
('6886de97-1b5e-441e-83d7-facea1df7303','53820c3c-532e-4068-8a73-8a6150af307c','主动.txt','.txt',86,'undefined/2024-05-09/5c4a4401-9f99-49df-b42a-4b728419e0ae.txt',0,'admin','2024-05-09 16:57:47','2024-05-09 16:57:47'),
('69973f13-e925-4758-9a81-4882d6b50f84','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-02/5c3a8131-65d2-442f-a816-75fab5d017ba.txt',0,'admin','2024-04-03 16:31:29','2024-04-03 16:31:29'),
('6a84b4f3-3ce2-4438-8e58-4c44a971d7e9','d8b45320-ef1b-45f6-afed-77a7b6a09e96','编译加速思路.docx','.docx',71832,'upload-files/2024-04-07/97051752-536b-4b2f-8a79-ae6fbc05caf4.docx',0,'admin','2024-04-07 16:44:31','2024-04-07 16:44:31'),
('786b2938-0325-4a20-a2f2-297926d575db','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-03/7e5796aa-5993-450a-97e4-77a94740581c.txt',0,'admin','2024-04-03 17:26:03','2024-04-03 17:26:03'),
('7bdb7935-6743-48d9-b7b9-5d1db49b0356','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-01/8936a308-0a5d-439c-8176-97dc97f1d8cd.txt',0,'admin','2024-04-01 19:34:50','2024-04-01 19:34:50'),
('8484d921-8000-46bd-913d-cd0514078d30','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-01/f3185fb5-ec11-42d2-9d81-384c2ad9d367.txt',0,'admin','2024-04-01 16:48:10','2024-04-01 16:48:10'),
('9ced16b8-6615-4f0b-b497-ce94d878ffa4','53820c3c-532e-4068-8a73-8a6150af307c','主动.txt','.txt',86,'undefined/2024-05-09/156377ca-840c-4519-87b3-92cb9201b2ad.txt',0,'admin','2024-05-09 16:58:47','2024-05-09 16:58:47'),
('a06f7479-14d8-41e7-bc4c-6f4f0e8b151f','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','编译加速思路.docx','.docx',71832,'upload-files/2024-04-01/4c7e9954-4699-49e0-bf16-2634ed08deb7.docx',0,'admin','2024-04-01 16:39:38','2024-04-01 16:39:38'),
('a86cd627-4682-4d0d-a5a3-2b80bd8e71a0','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-01/b5b8d8de-6b22-40cd-92a0-501f16902ea8.txt',0,'admin','2024-04-01 19:20:09','2024-04-01 19:20:09'),
('aff15c34-df92-4dae-9ddd-e95869321656','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-01/4d03d504-3149-460f-a48d-98271dd4b75c.txt',0,'admin','2024-04-01 19:21:35','2024-04-01 19:21:35'),
('c3e0d531-6eb1-4cb6-823d-37edd672e62c','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-03/d7dd1525-2735-4cb8-9bb1-ffaf36753c80.txt',0,'admin','2024-04-03 17:24:02','2024-04-03 17:24:02'),
('d80080db-8421-40da-b2aa-c8e4db3e83bb','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-01/6ad7108c-3b3f-4997-84f6-c2444247cb62.txt',0,'admin','2024-04-01 19:22:47','2024-04-01 19:22:47'),
('da560a24-f250-425e-a63b-d0b76cc6f788','53820c3c-532e-4068-8a73-8a6150af307c','主动.txt','.txt',86,'undefined/2024-05-09/3160b1b4-f270-4b83-8ee7-fbf6dd12be70.txt',0,'admin','2024-05-09 16:54:19','2024-05-09 16:54:19'),
('e7bac30f-b538-44fd-a635-8a482beadddf','d8b45320-ef1b-45f6-afed-77a7b6a09e96','演讲稿.docx','.docx',13860,'upload-files/2024-05-20/53399431-eceb-413f-bd66-a163f4fdb63b.docx',0,'admin','2024-05-20 11:14:42','2024-05-20 11:14:42'),
('e85fbdbb-db51-49d1-a0b4-298646b0d139','9d470c53-11fd-4953-a7f6-2660db7e5dab','主动.txt','.txt',86,'upload-files/2024-04-01/448eb148-5e39-4b4b-b2d8-fa7db7208320.txt',0,'admin','2024-04-02 10:41:03','2024-04-02 10:41:03'),
('ea6e7d12-8789-4273-bf5d-5ec98074f0ce','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','.txt',86,'upload-files/2024-04-03/b1cd6775-766d-43ac-a625-caf324d8bd85.txt',0,'admin','2024-04-03 17:20:40','2024-04-03 17:20:40'),
('f8660d31-ff7c-4237-a8ba-40f9d5d53a75','53820c3c-532e-4068-8a73-8a6150af307c','主动.txt','.txt',86,'undefined/2024-05-09/7017451a-33c0-46d2-8449-c7e3376c820b.txt',0,'admin','2024-05-09 16:55:37','2024-05-09 16:55:37'),
('fb8730e0-a7b3-4014-9f2f-fe780841a231','53820c3c-532e-4068-8a73-8a6150af307c','主动.txt','.txt',86,'undefined/2024-05-09/52036122-fced-4663-bdcd-625eec1167f3.txt',0,'admin','2024-05-09 16:50:25','2024-05-09 16:50:25');
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `menu_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `menu_name` varchar(64) DEFAULT NULL,
  `menu_code` varchar(64) DEFAULT NULL,
  `component` varchar(32) DEFAULT NULL,
  `path` varchar(256) DEFAULT NULL,
  `query` varchar(128) DEFAULT NULL,
  `redirect` varchar(128) DEFAULT NULL,
  `permissions` varchar(256) DEFAULT NULL,
  `menu_type` varchar(16) DEFAULT NULL,
  `hidden` int(11) DEFAULT NULL,
  `cached` int(11) DEFAULT NULL,
  `icon` varchar(64) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_user` varchar(32) DEFAULT NULL,
  `updated_user` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES
(1,0,'系统设置','system','admin','system','','/system/user','','contents',0,0,'SettingsOutline',3,0,'系统管理目录','admin','admin','2021-09-26 14:42:01','2024-01-08 16:00:35'),
(2,0,'AI Draw','draw','layout','draw','','/draw/generate','draw_generate','contents',0,0,'BrushOutline',2,0,'AI Draw','admin','admin','2021-09-26 14:46:28','2022-09-06 10:41:04'),
(3,0,'LLM Chat','llm','layout','chat/',NULL,'/chat','chat_index','contents',0,0,'ChatboxOutline',1,0,'LLM Chat','admin','admin','2022-06-08 16:46:18','2024-01-08 16:04:36'),
(4,0,'系统监控','monitor','admin','monitor',NULL,'/monitor/log','','contents',0,0,'TvOutline',4,0,'系统工具','admin','admin','2022-05-19 11:11:06','2024-01-10 10:30:59'),
(5,0,'仪表盘','dashboard','layout','dashboard','','/dashboard/list','dashboard_list','contents',0,0,'StatsChartOutline',5,0,'','admin','admin','2022-08-15 11:06:50','2023-11-24 19:30:15'),
(7,0,'lingmengcan','https://lingmengcan.space','layout','lingmengcan',NULL,NULL,'','contents',0,0,'DiamondOutline',6,0,'lingmengcan 主页','admin','admin','2022-05-19 11:16:45','2024-01-08 16:22:03'),
(8,1,'用户管理','user','/system/user/index','user','',NULL,'system_user_index','menu',0,0,'',1,0,'用户管理菜单','admin','admin','2021-10-21 10:34:32','2023-12-28 14:26:37'),
(9,1,'角色管理','role','/system/role/index','role','','','system_role_index','menu',0,0,'',2,0,'角色管理菜单','admin','admin','2021-10-21 10:36:49','2023-11-23 11:11:08'),
(10,1,'菜单管理','menu','/system/menu/index','menu','',NULL,'system_menu_index','menu',0,0,'',3,0,'菜单管理菜单','admin','admin','2021-10-21 10:38:03','2023-11-23 11:12:12'),
(11,1,'字典管理','dict','/system/dict/index','param',NULL,NULL,'system_dict_index','menu',0,0,'',4,0,'字典管理','admin','admin','2022-05-20 11:09:04','2024-01-03 16:08:24'),
(12,2,'生成',NULL,'/draw/generate','generate','','','draw_generate','menu',0,0,'',1,0,'数据门户列表','admin','admin','2022-08-15 17:01:20','2022-09-06 10:51:55'),
(13,3,'对话','chat','/chat/index',':conversationId?',NULL,NULL,'chat_index','menu',0,0,'',1,0,'chat','admin','admin','2022-08-25 17:16:46','2024-05-20 14:56:22'),
(14,4,'日志管理',NULL,'/monitor/log/index','log',NULL,NULL,'monitor:log:index','menu',0,0,'',1,0,'301','admin','admin','2022-05-19 11:18:49','2022-07-12 15:07:32'),
(15,4,'服务运行',NULL,'/monitor/server/index','server','','','monitor:server:index','menu',0,0,'',1,0,'','admin','admin','2022-07-04 14:09:38','2022-07-12 17:14:00'),
(16,5,'仪表盘列表',NULL,'/dashboard/index','list','','','dashboard_list','menu',0,0,'',1,0,'','admin','admin','2022-08-15 16:52:15','2022-08-15 17:15:24'),
(18,3,'chat_index','chat_noid','/chat/index','noid','','','llm_test','menu',1,1,'AirplaneOutline',0,0,'test','admin','admin','2023-11-21 15:38:20','2024-05-20 14:56:46'),
(21,8,'用户查询',NULL,'','',NULL,NULL,'system_user_query','action',0,0,'',1,0,'','admin','admin','2022-05-23 14:25:32','2023-12-28 14:16:20'),
(22,8,'用户新增',NULL,'','',NULL,NULL,'system_user_add','action',0,0,'',2,0,'','admin','admin','2022-05-23 14:28:27','2023-12-28 14:15:35'),
(23,8,'用户修改',NULL,'','',NULL,NULL,'system_user_edit','action',0,0,'',3,0,'','admin','admin','2022-05-23 14:28:45','2023-12-28 14:15:24'),
(24,8,'用户删除',NULL,'','',NULL,NULL,'system_user_delete','action',0,0,'',4,0,'','admin','admin','2022-05-23 14:29:14','2023-12-28 14:15:13'),
(25,9,'角色查询',NULL,'','',NULL,NULL,'system_role_query','action',0,0,'',3,0,'','admin','admin','2022-06-08 16:44:56','2023-12-28 14:16:58'),
(26,9,'角色新增',NULL,'','',NULL,NULL,'system_role_add','action',0,0,'',4,0,'','admin','admin','2022-06-08 16:45:27','2023-12-28 14:16:54'),
(27,9,'角色修改',NULL,'','',NULL,NULL,'system_role_edit','action',0,0,'',5,0,'','admin','admin','2022-06-08 16:45:53','2023-12-28 14:17:23'),
(28,9,'角色删除',NULL,'','',NULL,NULL,'system_role_delete','action',0,0,'',6,0,'','admin','admin','2022-06-08 16:46:18','2023-12-28 14:17:31'),
(29,9,'分配用户',NULL,'system/role/role-user','user',NULL,NULL,'system_role_user','action',1,0,'',2,0,'','admin','admin','2022-06-08 16:48:01','2023-11-23 11:11:39'),
(30,10,'菜单新增',NULL,'','list','',NULL,'system_menu_add','action',1,0,'',1,0,'','admin','admin','2022-06-29 16:19:21','2023-11-23 11:10:27'),
(31,10,'菜单删除','','','','','','system_menu_delete','action',0,0,'',3,0,'','admin','admin','2023-11-21 21:00:38','2023-11-23 11:31:55'),
(32,10,'菜单编辑','','','','','','system_menu_edit','action',0,0,'',2,0,'','admin','admin','2023-11-23 11:30:47','2023-11-23 11:30:47'),
(33,10,'菜单查询','','','','','','system_menu_query','action',0,0,'',4,0,'','admin','admin','2023-11-23 11:33:03','2023-11-23 11:34:02'),
(34,8,'重置密码','reset_pwd','','','','','system_user_resetpwd','action',0,0,'',5,0,'重置密码','admin','admin','2023-12-28 19:55:49','2023-12-28 19:55:49'),
(35,11,'字典查询','dict_query','','','','','system_dict_query','action',0,0,'',1,0,'','admin','admin','2024-01-08 10:48:08','2024-01-08 10:48:08'),
(36,11,'字典新增','','','','','','system_dict_add','action',0,0,'',2,0,'','admin','admin','2024-01-08 10:49:10','2024-01-08 10:49:21'),
(37,11,'字典修改','','','','','','system_dict_edit','action',0,0,'',3,0,'','admin','admin','2024-01-08 10:49:42','2024-01-08 10:49:48'),
(38,11,'字典删除','','','','','','system_dict_delete','action',0,0,'',0,0,'','admin','admin','2024-01-08 10:52:23','2024-01-08 10:52:23'),
(39,3,'应用','apps','/llm/app/index','app','','','llm_app_index','menu',0,0,'',2,0,'应用管理','admin','admin','2024-05-20 11:39:09','2024-05-20 11:41:29'),
(40,3,'模型库','model','/llm/model/index','model','','','llm_model_index','menu',0,0,'',4,0,'模型库管理','admin','admin','2024-05-20 11:42:25','2024-05-20 11:42:25'),
(41,3,'知识库','knowledge','/llm/knowledge/index','knowledge','','','llm_knowledge_index','menu',0,0,'',3,0,'知识库管理','admin','admin','2024-05-20 11:43:40','2024-05-20 11:43:40'),
(42,3,'训练','train','/llm/train/index','train','','','llm_train_index','menu',0,0,'',5,0,'模型微调','admin','admin','2024-05-20 11:46:34','2024-05-20 14:56:08');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `message_id` varchar(36) NOT NULL,
  `previous_id` varchar(36) NOT NULL DEFAULT '',
  `file_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `conversation_id` varchar(36) NOT NULL,
  `message_text` text NOT NULL,
  `sender` enum('Human','Assistant','System') NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES
('03adeac2-59cf-4352-9abe-0d9202dc3fef','fd23a740-8979-43be-9cb3-94a755158fd9','c3e0d531-6eb1-4cb6-823d-37edd672e62c','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','很抱歉，我无法提供文档摘要，因为我不知道文档的具体内容。如果您能提供文档的一些关键信息或关键点，我可以帮您总结出摘要。','Assistant',1,0,'2024-04-03 17:24:05'),
('1105897f-4f9c-4c4c-a25c-881470d38e52','','65290a86-a658-40ea-a7d5-1ae6f2768bd1','d8b45320-ef1b-45f6-afed-77a7b6a09e96','主动.txt','Human',1,0,'2024-04-07 16:43:27'),
('17488083-c2a2-4d4e-8a7c-b2c7e55ec24d','','1552a857-f7e5-4b2e-bb3e-dee22bb16a80','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','Human',1,0,'2024-04-07 16:41:53'),
('1a066968-cee1-4c86-a6a0-c6334306e6dc','17488083-c2a2-4d4e-8a7c-b2c7e55ec24d','1552a857-f7e5-4b2e-bb3e-dee22bb16a80','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','已暂停生成。','Assistant',1,0,'2024-04-07 16:42:43'),
('1fdf868f-d57b-4b6a-91bd-50afc56b230d','fc9bf14f-76bb-4fde-960f-3976187a6600','0fa099c4-b2a8-4de1-9673-57c6d613c56f','d8b45320-ef1b-45f6-afed-77a7b6a09e96','','Assistant',0,0,'2024-05-20 11:11:28'),
('24ee27cd-4d02-4a7a-8eb9-d1d536f81ad7','99498b7e-b3ac-4e42-b230-e79355841215','','d8b45320-ef1b-45f6-afed-77a7b6a09e96','这个文档的','Assistant',1,0,'2024-05-20 11:21:49'),
('2bdb242e-cd8a-4ae3-b3a4-68d650244999','dcf7eaa6-1e39-4789-b900-a202a579267e','02d62536-a032-4e94-8690-4450a1c06803','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','','Assistant',0,0,'2024-04-03 17:19:09'),
('382bbe79-c704-49dd-9447-a57a72fd6fe5','4241150d-8ba7-49a0-bed6-787d360acc65','ea6e7d12-8789-4273-bf5d-5ec98074f0ce','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','抱歉，我无法输出文档摘要，因为我无法访问外部资源。如果您有任何问题需要帮助解答，请随时告诉我。','Assistant',1,0,'2024-04-03 17:20:43'),
('40887bd0-4f2c-4f8f-9cd7-ce4ba2828ff4','b9175624-9da2-406e-bda8-16e02c3cfa5e','04d1e8d3-fd2f-4cef-9ad1-fa52aa672b23','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','','Assistant',0,0,'2024-04-03 17:32:11'),
('4241150d-8ba7-49a0-bed6-787d360acc65','','ea6e7d12-8789-4273-bf5d-5ec98074f0ce','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','输出文档摘要+++主动.txt','Human',1,0,'2024-04-03 17:20:41'),
('4d68eb54-87b7-433c-84a7-e46291996ad6','','e7bac30f-b538-44fd-a635-8a482beadddf','d8b45320-ef1b-45f6-afed-77a7b6a09e96','演讲稿.docx','Human',1,0,'2024-05-20 11:14:43'),
('53c879d1-f7dc-43ff-87ea-192e61ba83b4','afc4f6ab-f306-4dc9-a972-fda4003a6ed5','69973f13-e925-4758-9a81-4882d6b50f84','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动是指在某种情况下，主动采取行动或者主动做出决定，而不是被动地等待别人的指示或者安排。在各种场合下，主动都是一种积极的态度和行为方式，可以更好地掌控局面，实现自己的目标和愿望。在工作、学习、生活等方面，主动都是一种重要的品质，可以让人更加成功和幸福。因此，我们应该时刻保持主动的心态，积极主动地去面对生活中的各种挑战和困难，不断提高自己的能力和素质，实现自己的人生价值。','Assistant',1,0,'2024-04-03 16:31:39'),
('5e81a498-8f27-49f0-b2a0-8ac61562d0b4','','59dd1073-7bfa-4f65-9114-fc678f993f12','d8b45320-ef1b-45f6-afed-77a7b6a09e96','演讲稿.docx','Human',1,0,'2024-05-20 11:18:01'),
('617fc1cf-33dc-475e-8b8b-5393bb60a922','1105897f-4f9c-4c4c-a25c-881470d38e52','65290a86-a658-40ea-a7d5-1ae6f2768bd1','d8b45320-ef1b-45f6-afed-77a7b6a09e96','抱歉，我无法提供关于文档摘要的信息，因为在您提供的已知内容中并没有涉及到文档摘要。如果您有任何其他问题或需要帮助，请随时告诉我。','Assistant',1,0,'2024-04-07 16:43:30'),
('6f321dcd-2dfe-4f2f-b4ec-4c727aedc075','','','d8b45320-ef1b-45f6-afed-77a7b6a09e96','上面上传的文档','Human',1,0,'2024-05-20 11:22:00'),
('793ec192-1453-413e-9ba7-58813d7b4eea','5e81a498-8f27-49f0-b2a0-8ac61562d0b4','59dd1073-7bfa-4f65-9114-fc678f993f12','d8b45320-ef1b-45f6-afed-77a7b6a09e96','根据提供的内容，这篇文档主要介绍了一位学生参加“传承好少年”竞选的背景和理念。学生表示热爱传统文化，担任学校“红领巾监督员”，乐于为集体服务，积极参加各项活动，包括担任校园讲解员。学生表示希望通过自己的实际行动传递热爱和尊重，如果当选，将加倍努力传承传统文化。','Assistant',1,0,'2024-05-20 11:18:04'),
('805fbd06-43b2-4856-b13e-616d663f73d1','','786b2938-0325-4a20-a2f2-297926d575db','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','输出文档摘要+++主动.txt','Human',1,0,'2024-04-03 17:26:04'),
('99498b7e-b3ac-4e42-b230-e79355841215','','','d8b45320-ef1b-45f6-afed-77a7b6a09e96','这个文档的前5个字是什么','Human',1,0,'2024-05-20 11:21:48'),
('a45df6c8-8d7e-4973-b42a-28d724a95f80','e18a3520-5daa-45ee-8162-3558bb1a99c5','3423342f-55bd-459d-9044-8675d4569ac4','d8b45320-ef1b-45f6-afed-77a7b6a09e96','','Assistant',0,0,'2024-05-20 11:15:19'),
('a4bdcffe-2909-4069-8f62-b12f0e1821f9','','e85fbdbb-db51-49d1-a0b4-298646b0d139','9d470c53-11fd-4953-a7f6-2660db7e5dab','主动.txt','Human',1,0,'2024-04-02 10:41:04'),
('afc4f6ab-f306-4dc9-a972-fda4003a6ed5','','69973f13-e925-4758-9a81-4882d6b50f84','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','Human',1,0,'2024-04-03 16:31:34'),
('b0327e51-d2d4-4517-9a2e-a7732e5a418a','805fbd06-43b2-4856-b13e-616d663f73d1','786b2938-0325-4a20-a2f2-297926d575db','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','抱歉，没有足够的相关信息来生成文档摘要。如果您提供更多细节或具体问题，我将尽力提供帮助。','Assistant',1,0,'2024-04-03 17:26:06'),
('b9175624-9da2-406e-bda8-16e02c3cfa5e','','04d1e8d3-fd2f-4cef-9ad1-fa52aa672b23','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','主动.txt','Human',1,0,'2024-04-03 17:32:11'),
('ba52d6b1-b195-428f-8289-19ff7e76e10b','6f321dcd-2dfe-4f2f-b4ec-4c727aedc075','','d8b45320-ef1b-45f6-afed-77a7b6a09e96','上面上传的文档','Assistant',1,0,'2024-05-20 11:22:00'),
('bd42c75f-683f-4ba3-9534-8e13fbd04e1b','f8c503c4-ca16-43f3-aa1a-9cb0569070d0','51919cd4-cd09-40ac-a2eb-4c26cc1f128e','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','很抱歉，我无法直接输出文档摘要。如果您需要帮助提炼文档摘要，您可以提供文档的关键信息或主题，我将尽力为您总结提炼。','Assistant',1,0,'2024-04-03 17:24:42'),
('c5e65930-0c89-40ab-8670-3b35f7328159','','6a84b4f3-3ce2-4438-8e58-4c44a971d7e9','d8b45320-ef1b-45f6-afed-77a7b6a09e96','编译加速思路.docx','Human',1,0,'2024-04-07 16:44:32'),
('dcf7eaa6-1e39-4789-b900-a202a579267e','','02d62536-a032-4e94-8690-4450a1c06803','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','输出文档摘要+++主动.txt','Human',1,0,'2024-04-03 17:19:08'),
('e18a3520-5daa-45ee-8162-3558bb1a99c5','','3423342f-55bd-459d-9044-8675d4569ac4','d8b45320-ef1b-45f6-afed-77a7b6a09e96','演讲稿.docx','Human',1,0,'2024-05-20 11:15:19'),
('ee24f920-e607-4f85-ac27-e611c10309bc','c5e65930-0c89-40ab-8670-3b35f7328159','6a84b4f3-3ce2-4438-8e58-4c44a971d7e9','d8b45320-ef1b-45f6-afed-77a7b6a09e96','根据已知内容，编译加速的研究主要涉及软件工程方法和充分利用机器性能两个方向。在软件工程方法方面，可以通过使用命令行编译、分布式编译、优化编译流程等方式来提升编译速度。在充分利用机器性能方面，可以考虑升级高配置机器、使用多线程编译、使用ccache等方法来加快编译速度。','Assistant',1,0,'2024-04-07 16:44:36'),
('f8bfd4c6-a1ca-40a0-843f-942f5348a996','4d68eb54-87b7-433c-84a7-e46291996ad6','e7bac30f-b538-44fd-a635-8a482beadddf','d8b45320-ef1b-45f6-afed-77a7b6a09e96','','Assistant',0,0,'2024-05-20 11:14:43'),
('f8c503c4-ca16-43f3-aa1a-9cb0569070d0','','51919cd4-cd09-40ac-a2eb-4c26cc1f128e','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','输出文档摘要+++主动.txt','Human',1,0,'2024-04-03 17:24:40'),
('f8e13e32-38d4-4906-ae1c-e5da95fc2a74','a4bdcffe-2909-4069-8f62-b12f0e1821f9','e85fbdbb-db51-49d1-a0b4-298646b0d139','9d470c53-11fd-4953-a7f6-2660db7e5dab','已暂停生成。','Assistant',1,0,'2024-04-02 10:41:42'),
('fc9bf14f-76bb-4fde-960f-3976187a6600','','0fa099c4-b2a8-4de1-9673-57c6d613c56f','d8b45320-ef1b-45f6-afed-77a7b6a09e96','演讲稿.docx','Human',1,0,'2024-05-20 11:11:28'),
('fd23a740-8979-43be-9cb3-94a755158fd9','','c3e0d531-6eb1-4cb6-823d-37edd672e62c','5a597d1b-bdd0-4655-96c3-b65bd1f40f09','输出文档摘要+++主动.txt','Human',1,0,'2024-04-03 17:24:03');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model`
--

DROP TABLE IF EXISTS `model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model` (
  `model_id` varchar(36) NOT NULL,
  `model_name` varchar(255) NOT NULL,
  `model_type` varchar(32) NOT NULL,
  `model_type_name` varchar(32) NOT NULL,
  `base_url` varchar(512) NOT NULL,
  `api_key` varchar(128) NOT NULL,
  `sort` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_user` varchar(32) NOT NULL,
  `updated_user` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`model_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model`
--

LOCK TABLES `model` WRITE;
/*!40000 ALTER TABLE `model` DISABLE KEYS */;
INSERT INTO `model` VALUES
('601278f2-8bf1-4eff-a684-a7eff61d1274','text-embedding-3-small','EMBEDDING_MODEL','Embedding模型','','',12,0,'openai 嵌入式模型','admin','admin','2024-06-11 19:34:12','2024-06-11 19:34:12'),
('78e33981-4e01-445d-89e1-bfacc0affb0d','ChatGLM3-6B','GENERAL_MODEL','通用模型','http://127.0.0.1:8000/v1/','',1,0,'ChatGLM3 是智谱AI和清华大学 KEG 实验室联合发布的对话预训练模型','admin','admin','2024-06-11 16:47:27','2024-06-11 19:47:53'),
('86409bd7-666d-4ddb-9809-7c52ef3dc56a','gpt-4','GENERAL_MODEL','通用模型','https://oai.hconeai.com/v1','',2,0,'GPT-4（Generative Pretrained Transformer 4）是一种自然语言处理（NLP）AI模型。','admin','admin','2024-06-07 17:13:21','2024-06-11 19:48:17'),
('930c4de3-3706-4a44-b14e-ff6b5ec70f28','GLM-4-9B','GENERAL_MODEL','通用模型','','',4,0,'GLM-4-9B 是智谱 AI 推出的最新一代预训练模型 GLM-4 系列中的开源版本','admin','admin','2024-06-11 19:29:51','2024-06-11 19:29:51'),
('c0db3b5b-9afb-40f7-b0bd-9426dc0c25c3','gpt-35-turbo','GENERAL_MODEL','通用模型','https://oai.hconeai.com/v1','',3,0,'由OpenAI开发的，基于GPT-3的模型。设计来帮助用户回答问题，提供建议和解决问题。','admin','admin','2024-06-11 15:10:05','2024-06-11 19:48:08'),
('e5de59e7-e71f-45f4-b0f7-4f5d0c3d14fc','bge-large-zh-v1.5','EMBEDDING_MODEL','Embedding模型','','',11,0,'bge-large-zh是由智源研究院研发的中文版文本表示模型，可将任意文本映射为低维稠密向量，以用于检索、分类、聚类或语义匹配等任务，并可支持为大模型调用外部知识','admin','admin','2024-06-11 19:31:29','2024-06-11 19:31:29');
/*!40000 ALTER TABLE `model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prompt`
--

DROP TABLE IF EXISTS `prompt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prompt` (
  `prompt_id` varchar(36) NOT NULL,
  `title` varchar(32) NOT NULL,
  `content` varchar(1024) NOT NULL,
  `user_name` varchar(32) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`prompt_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prompt`
--

LOCK TABLES `prompt` WRITE;
/*!40000 ALTER TABLE `prompt` DISABLE KEYS */;
/*!40000 ALTER TABLE `prompt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) NOT NULL,
  `role_code` varchar(32) NOT NULL,
  `sort` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` varchar(512) NOT NULL,
  `created_user` varchar(32) NOT NULL,
  `updated_user` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES
(1,'管理员','admin',1,0,'超级管理员','admin','admin','2021-11-02 10:37:56','2023-11-14 17:15:19'),
(2,'客人','guest',2,0,'客人','admin','admin','2021-11-02 10:38:34','2023-11-14 17:15:29');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_menu`
--

DROP TABLE IF EXISTS `role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_menu` (
  `role_id` bigint(20) unsigned NOT NULL,
  `menu_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menu`
--

LOCK TABLES `role_menu` WRITE;
/*!40000 ALTER TABLE `role_menu` DISABLE KEYS */;
INSERT INTO `role_menu` VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,13),
(1,14),
(1,15),
(1,16),
(1,18),
(1,21),
(1,22),
(1,23),
(1,24),
(1,25),
(1,26),
(1,27),
(1,28),
(1,29),
(1,30),
(1,31),
(1,32),
(1,33),
(1,34),
(1,35),
(1,36),
(1,37),
(1,38),
(1,39),
(1,40),
(1,41),
(1,42),
(2,12);
/*!40000 ALTER TABLE `role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_user` (
  `role_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
INSERT INTO `role_user` VALUES
(1,1);
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) NOT NULL,
  `nick_name` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `phone` varchar(32) NOT NULL,
  `sex` varchar(1) NOT NULL,
  `avatar` varchar(128) NOT NULL,
  `password` varchar(512) NOT NULL,
  `login_ip` varchar(64) NOT NULL,
  `login_date` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` varchar(512) NOT NULL,
  `created_user` varchar(32) NOT NULL,
  `updated_user` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'admin','超级管理员','admin@lmc.com','12345678901','1','','$2b$10$bgJ1x5CdyFAbt13v4.efFOT51F2Gxeg/C7xdfrdciDkgeayZPzl2K','127.0.0.1','2021-10-22 09:54:19',0,'超级管理员','admin','admin','2021-10-22 09:54:19','2022-05-30 16:06:27');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'lingmengcan-ai'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-14 11:34:50
