-- MariaDB dump 10.19-11.0.2-MariaDB, for osx10.18 (arm64)
--
-- Host: localhost    Database: lingmengcan
-- ------------------------------------------------------
-- Server version	11.0.2-MariaDB

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
-- Table structure for table `dept`
--

DROP TABLE IF EXISTS `dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept` (
  `dept_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `dept_name` varchar(32) DEFAULT NULL,
  `leader` varchar(32) DEFAULT NULL,
  `sort` int(4) DEFAULT NULL,
  `status` tinyint(2) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_user` varchar(32) DEFAULT NULL,
  `updated_user` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept`
--

LOCK TABLES `dept` WRITE;
/*!40000 ALTER TABLE `dept` DISABLE KEYS */;
INSERT INTO `dept` VALUES
(1,0,'s科技','lingmengcan',1,0,'灵萌灿科技','admin','admin','2022-05-23 17:14:13','2022-05-23 17:28:54'),
(2,1,'研发部','lingmengcan',1,0,'负责研发','admin','admin','2022-05-23 17:31:31','2022-08-15 17:20:53'),
(3,0,'测试','test',2,0,'','admin','admin','2022-07-11 10:23:51','2022-07-12 10:32:26');
/*!40000 ALTER TABLE `dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dict`
--

DROP TABLE IF EXISTS `dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dict` (
  `dict_id` bigint(20) unsigned NOT NULL,
  `dict_type` varchar(32) DEFAULT NULL,
  `dict_code` varchar(32) DEFAULT NULL,
  `dict_name` varchar(32) DEFAULT NULL,
  `sort` int(4) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_user` varchar(32) DEFAULT NULL,
  `updated_user` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dict_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict`
--

LOCK TABLES `dict` WRITE;
/*!40000 ALTER TABLE `dict` DISABLE KEYS */;
/*!40000 ALTER TABLE `dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dict_type`
--

DROP TABLE IF EXISTS `dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dict_type` (
  `dict_type_id` bigint(20) unsigned NOT NULL,
  `dict_type_name` varchar(64) DEFAULT NULL,
  `dict_type` varchar(32) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_user` varchar(32) DEFAULT NULL,
  `updated_user` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dict_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict_type`
--

LOCK TABLES `dict_type` WRITE;
/*!40000 ALTER TABLE `dict_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `dict_type` ENABLE KEYS */;
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
  `hidden` int(1) DEFAULT NULL,
  `cached` int(1) DEFAULT NULL,
  `icon` varchar(64) DEFAULT NULL,
  `sort` int(4) DEFAULT NULL,
  `status` tinyint(2) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_user` varchar(32) DEFAULT NULL,
  `updated_user` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES
(1,0,'系统设置','system','admin','right','',NULL,'','contents',0,0,'SettingsOutline',3,0,'系统管理目录','admin','admin','2021-09-26 14:42:01','2022-08-15 11:12:57'),
(2,0,'AI Draw','draw','layout','draw','','/draw/generate','draw_generate','contents',0,0,'BrushOutline',2,0,'AI Draw','admin','admin','2021-09-26 14:46:28','2022-09-06 10:41:04'),
(3,0,'LLM Chat','llm','layout','llm',NULL,'/llm/chat','llm_chat','contents',0,0,'ChatboxOutline',1,0,'LLM Chat','admin','admin','2022-06-08 16:46:18','2023-11-23 15:43:39'),
(4,0,'系统监控','monitor','layout','monitor',NULL,NULL,'','contents',0,0,'TvOutline',4,0,'系统工具','admin','admin','2022-05-19 11:11:06','2022-08-15 11:13:19'),
(5,0,'仪表盘','dashboard','layout','dashboard','','/dashboard/list','dashboard_list','contents',0,0,'StatsChartOutline',5,0,'','admin','admin','2022-08-15 11:06:50','2023-11-24 19:30:15'),
(6,0,'可视化','visual','canvas','visual','','','','contents',0,1,'AccessibilityOutline',7,1,'a','admin','admin','2022-08-25 17:16:46','2023-11-21 16:24:42'),
(7,0,'lingmengcan','https://lingmengcan.tech','layout','lingmengcan',NULL,NULL,'','contents',0,0,'DiamondOutline',6,0,'lingmengcan.tech','admin','admin','2022-05-19 11:16:45','2022-08-15 11:13:23'),
(8,1,'用户管理','user','/system/user/index','user','',NULL,'right:user:list','menu',0,0,'',1,0,'用户管理菜单','admin','admin','2021-10-21 10:34:32','2022-05-23 14:57:59'),
(9,1,'角色管理','role','/system/role/index','role','','','system_role_index','menu',0,0,'',2,0,'角色管理菜单','admin','admin','2021-10-21 10:36:49','2023-11-23 11:11:08'),
(10,1,'菜单管理','menu','/system/menu/index','menu','',NULL,'system_menu_index','menu',0,0,'',3,0,'菜单管理菜单','admin','admin','2021-10-21 10:38:03','2023-11-23 11:12:12'),
(11,1,'字典管理','param','/system/param/index','param',NULL,NULL,'system_param_index','menu',0,0,'',4,0,'字典管理','admin','admin','2022-05-20 11:09:04','2023-11-22 10:10:02'),
(12,2,'生成',NULL,'/draw/generate','generate','','','draw_generate','menu',0,0,'',1,0,'数据门户列表','admin','admin','2022-08-15 17:01:20','2022-09-06 10:51:55'),
(13,3,'对话','chat','/llm/chat','chat',NULL,NULL,'llm_chat','menu',0,0,'',1,0,'chat','admin','admin','2022-08-25 17:16:46','2023-11-21 16:28:23'),
(14,4,'日志管理',NULL,'/monitor/log/index','log',NULL,NULL,'monitor:log:index','menu',0,0,'',1,0,'301','admin','admin','2022-05-19 11:18:49','2022-07-12 15:07:32'),
(15,4,'服务运行',NULL,'/monitor/server/index','server','','','monitor:server:index','menu',0,0,'',1,0,'','admin','admin','2022-07-04 14:09:38','2022-07-12 17:14:00'),
(16,5,'仪表盘列表',NULL,'/dashboard/index','list','','','dashboard_list','menu',0,0,'',1,0,'','admin','admin','2022-08-15 16:52:15','2022-08-15 17:15:24'),
(17,6,' 查看门户',NULL,'/visual/preview/index','preview/:spaceId','','','visual:preview','menu',1,0,'',2,0,'','admin','admin','2022-08-19 14:53:20','2023-11-21 16:28:58'),
(18,3,'test','test','test','test','','','llm_test','menu',1,1,'AirplaneOutline',2,0,'test','admin','admin','2023-11-21 15:38:20','2023-11-21 15:38:20'),
(19,6,'页面设计',NULL,'/visual/page/index','page/:spaceId','','','visual:page','menu',1,0,'',4,0,'报表设计','admin','admin','2022-08-19 15:12:01','2022-08-30 11:18:40'),
(20,6,'权限管理',NULL,'/visual/permission/index','permission/:spaceId','','','visual:permission','menu',1,0,'',5,0,'','admin','admin','2022-08-19 15:14:12','2022-08-30 11:18:35'),
(21,8,'用户查询',NULL,'','',NULL,NULL,'right:user:query','button',0,0,'',1,0,'','admin','admin','2022-05-23 14:25:32','2022-05-23 14:58:40'),
(22,8,'用户新增',NULL,'','',NULL,NULL,'right:user:add','button',0,0,'',2,0,'','admin','admin','2022-05-23 14:28:27','2022-05-23 14:58:53'),
(23,8,'用户修改',NULL,'','',NULL,NULL,'right:user:edit','button',0,0,'',3,0,'','admin','admin','2022-05-23 14:28:45','2022-05-23 14:59:03'),
(24,8,'用户删除',NULL,'','',NULL,NULL,'right:user:delete','button',0,0,'',4,0,'','admin','admin','2022-05-23 14:29:14','2022-05-23 14:59:14'),
(25,9,'角色查询',NULL,'','',NULL,NULL,'system_role_query','button',0,0,'',3,0,'','admin','admin','2022-06-08 16:44:56','2022-06-30 11:00:58'),
(26,9,'角色新增',NULL,'','',NULL,NULL,'system_role_add','button',0,0,'',4,0,'','admin','admin','2022-06-08 16:45:27','2022-06-30 11:01:26'),
(27,9,'角色修改',NULL,'','',NULL,NULL,'system_role_edit','button',0,0,'',5,0,'','admin','admin','2022-06-08 16:45:53','2022-06-30 11:01:34'),
(28,9,'角色删除',NULL,'','',NULL,NULL,'system_role_delete','button',0,0,'',6,0,'','admin','admin','2022-06-08 16:46:18','2022-06-30 11:01:44'),
(29,9,'分配用户',NULL,'system/role/role-user','user',NULL,NULL,'system_role_user','action',1,0,'',2,0,'','admin','admin','2022-06-08 16:48:01','2023-11-23 11:11:39'),
(30,10,'菜单新增',NULL,'','list','',NULL,'system_menu_add','action',1,0,'',1,0,'','admin','admin','2022-06-29 16:19:21','2023-11-23 11:10:27'),
(31,10,'菜单删除','','','','','','system_menu_delete','action',0,0,'',3,0,'','admin','admin','2023-11-21 21:00:38','2023-11-23 11:31:55'),
(32,10,'菜单编辑','','','','','','system_menu_edit','action',0,0,'',2,0,'','admin','admin','2023-11-23 11:30:47','2023-11-23 11:30:47'),
(33,10,'菜单查询','','','','','','system_menu_query','action',0,0,'',4,0,'','admin','admin','2023-11-23 11:33:03','2023-11-23 11:34:02');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) DEFAULT NULL,
  `role_code` varchar(32) DEFAULT NULL,
  `sort` int(4) DEFAULT NULL,
  `status` tinyint(2) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_user` varchar(32) DEFAULT NULL,
  `updated_user` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES
(1,'管理员','admin',1,0,'超级管理员','admin','admin','2021-11-02 10:37:56','2023-11-14 17:15:19'),
(2,'客人','guest',2,0,'客人','admin','admin','2021-11-02 10:38:34','2023-11-14 17:15:29'),
(3,'test2','test',3,0,'test','admin','admin','2021-11-02 17:17:12','2023-11-13 15:39:20'),
(16,'test','test2',4,0,'test2','admin','admin','2023-11-14 17:15:44','2023-11-14 17:15:44'),
(17,'0','0',0,-1,'','admin','admin','2023-11-14 17:18:43','2023-11-14 20:02:41');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_dept`
--

DROP TABLE IF EXISTS `role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_dept` (
  `role_id` bigint(20) unsigned NOT NULL,
  `dept_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`dept_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_dept`
--

LOCK TABLES `role_dept` WRITE;
/*!40000 ALTER TABLE `role_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_dept` ENABLE KEYS */;
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
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
(1,6),
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
(1,17),
(1,18),
(1,19),
(1,20),
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
  PRIMARY KEY (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
INSERT INTO `role_user` VALUES
(1,1),
(2,1),
(3,2),
(3,3);
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `space`
--

DROP TABLE IF EXISTS `space`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `space` (
  `space_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `space_name` varchar(128) NOT NULL,
  `status` tinyint(2) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_user` varchar(32) DEFAULT NULL,
  `updated_user` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`space_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='可视化工作空间';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `space`
--

LOCK TABLES `space` WRITE;
/*!40000 ALTER TABLE `space` DISABLE KEYS */;
INSERT INTO `space` VALUES
(1,'a',0,'a','admin','admin','2022-08-16 18:39:11','2022-08-16 18:39:11'),
(2,'b',-1,'2','admin','admin','2022-08-17 10:36:56','2022-08-17 15:01:30'),
(3,'c',-1,'c','admin','admin','2022-08-17 10:40:37','2022-08-17 15:02:04'),
(4,'d',1,'d','admin','admin','2022-08-17 10:41:00','2022-08-17 15:55:59'),
(5,'e',0,'e','admin','admin','2022-08-17 10:44:59','2022-08-17 10:44:59'),
(6,'f',0,'f','admin','admin','2022-08-17 10:45:49','2022-08-17 10:45:49'),
(7,'g',0,'g','admin','admin','2022-08-17 10:47:05','2022-08-17 10:47:05'),
(8,'h',0,'h','admin','admin','2022-08-17 10:48:20','2022-08-17 10:48:20'),
(9,'i',0,'i','admin','admin','2022-08-17 10:48:53','2022-08-17 10:48:53'),
(10,'j',0,'j','admin','admin','2022-08-17 10:52:26','2022-08-17 10:52:26'),
(11,'k',0,'k','admin','admin','2022-08-17 10:53:18','2022-08-17 10:53:18');
/*!40000 ALTER TABLE `space` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(32) DEFAULT NULL,
  `chinese_name` varchar(64) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `avatar` varchar(128) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `salt` varchar(32) DEFAULT NULL,
  `login_ip` varchar(64) DEFAULT NULL,
  `login_date` datetime NOT NULL,
  `status` tinyint(2) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_user` varchar(32) DEFAULT NULL,
  `updated_user` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,1,'admin','超级管理员','admin@lmc.com','12345678901','1','admin','$2b$10$bgJ1x5CdyFAbt13v4.efFOT51F2Gxeg/C7xdfrdciDkgeayZPzl2K','','127.0.0.1','2021-10-22 09:54:19',0,'超级管理员','admin','admin','2021-10-22 09:54:19','2022-05-30 16:06:27'),
(2,2,'ouyangguoling','欧阳国灵','ouyangguoling@lingmengcan.tech','18026927766','1','','$2b$10$HSLQgyJdfKYo0EhVpx2PgOU.r0qLtTFeuARlo.3LF6hzhuAM4t4se',NULL,NULL,'2022-05-30 16:10:55',0,'','admin','admin','2022-05-30 16:10:55','2022-05-30 17:25:29'),
(3,2,'test','测试1','test@lingmengcan.tech','12345678902','0','','$2b$10$CJ/2mrG1m/zZCz9xb8lKQ.7hwNLBTT284s4u3cMivFItM95fBJU9y',NULL,NULL,'2022-05-30 17:23:33',0,'','admin','admin','2022-05-30 17:23:33','2022-07-08 18:32:05');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-29 10:11:40
