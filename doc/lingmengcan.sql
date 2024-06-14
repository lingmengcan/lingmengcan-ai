/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : localhost:3306
 Source Schema         : lingmengcan-ai

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 15/03/2024 18:51:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for conversation
-- ----------------------------
DROP TABLE IF EXISTS `conversation`;
CREATE TABLE `conversation`  (
  `conversation_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `conversation_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `llm` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `temperature` float NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`conversation_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of conversation
-- ----------------------------
INSERT INTO `conversation` VALUES ('29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', '知识库1', 'admin', 'ChatGLM3', 0.5, 0, '2024-02-22 16:53:35', '2024-03-15 15:35:09');
INSERT INTO `conversation` VALUES ('619323ff-2df3-4485-9c97-cb2f08a67c6d', '新建对话', 'admin', 'ChatGLM3', 0.5, 0, '2024-03-08 17:04:37', '2024-03-08 17:04:37');
INSERT INTO `conversation` VALUES ('6f2ba2df-4001-45d3-a2b6-9ec88cbfb455', '新建对话', 'admin', 'ChatGLM3', 0.5, 0, '2024-03-08 17:04:35', '2024-03-08 17:04:35');
INSERT INTO `conversation` VALUES ('72c02f31-89a3-4c80-b8ba-458924648b2f', '新建对话1', 'admin', 'ChatGLM3', 0.5, 0, '2024-02-22 14:44:50', '2024-02-22 14:45:39');

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict`  (
  `dict_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `dict_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `dict_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `dict_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort` int NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dict
-- ----------------------------
INSERT INTO `dict` VALUES (1, 'ROOT_TYPE', 'SYS_SEX', '性别', 2, 0, '性别', 'admin', 'admin', '2024-01-08 10:57:05', '2024-01-08 11:09:18');
INSERT INTO `dict` VALUES (2, 'ROOT_TYPE', 'SYS_STATUS', '状态', 1, 0, '状态（0：正常，1：停用，-1：删除）', 'admin', 'admin', '2024-01-08 11:03:52', '2024-01-08 11:03:52');
INSERT INTO `dict` VALUES (3, 'SYS_STATUS', '0', '正常', 1, 0, '正常', 'admin', 'admin', '2024-01-08 11:06:22', '2024-01-08 11:06:22');
INSERT INTO `dict` VALUES (4, 'SYS_STATUS', '1', '停用', 2, 0, '停用', 'admin', 'admin', '2024-01-08 11:07:59', '2024-01-08 11:12:48');
INSERT INTO `dict` VALUES (5, 'SYS_STATUS', '-1', '删除', 3, 1, '状态软删除', 'admin', 'admin', '2024-01-08 11:08:47', '2024-01-08 11:12:54');
INSERT INTO `dict` VALUES (6, 'SYS_SEX', '1', '男', 1, 0, '男', 'admin', 'admin', '2024-01-08 11:10:05', '2024-01-08 11:10:29');
INSERT INTO `dict` VALUES (7, 'SYS_SEX', '0', '女', 2, 0, '女', 'admin', 'admin', '2024-01-08 11:10:24', '2024-01-08 11:10:24');
INSERT INTO `dict` VALUES (8, 'SYS_SEX', '2', '未知', 3, 0, '未知', 'admin', 'admin', '2024-01-08 11:10:56', '2024-01-08 11:10:56');

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `file_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `conversation_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `file_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `file_size` bigint NOT NULL,
  `path` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file
-- ----------------------------
INSERT INTO `file` VALUES ('01e7042e-e468-4c63-b4ba-3a5949300751', '29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', 't.txt', '.txt', 1741, 'upload-files\\2024-03-15\\fc8044cd-d811-4121-a27c-6a5ae8f541a8.txt', 0, 'admin', '2024-03-15 16:25:08', '2024-03-15 16:25:08');
INSERT INTO `file` VALUES ('7874c71a-4ffb-46dd-8330-1dac3e20b18a', '29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', 't.txt', '.txt', 1741, 'upload-files\\2024-03-15\\b42d9391-7789-4634-b927-a52efe994d69.txt', 0, 'admin', '2024-03-15 16:21:14', '2024-03-15 16:21:14');
INSERT INTO `file` VALUES ('f7f03136-03e9-46b1-8995-4b80fa2df00b', '29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', 't.txt', '.txt', 1741, 'upload-files\\2024-03-14\\11e36dae-862a-433e-b7a5-de1a0d8e13de.txt', 0, 'admin', '2024-03-14 19:41:45', '2024-03-14 19:41:45');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `menu_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` bigint NULL DEFAULT NULL,
  `menu_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `menu_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `component` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `query` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `redirect` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `permissions` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `menu_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `hidden` int NULL DEFAULT NULL,
  `cached` int NULL DEFAULT NULL,
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 0, '系统设置', 'system', 'admin', 'system', '', '/system/user', '', 'contents', 0, 0, 'SettingsOutline', 3, 0, '系统管理目录', 'admin', 'admin', '2021-09-26 14:42:01', '2024-01-08 16:00:35');
INSERT INTO `menu` VALUES (2, 0, 'AI Draw', 'draw', 'layout', 'draw', '', '/draw/generate', 'draw_generate', 'contents', 0, 0, 'BrushOutline', 2, 0, 'AI Draw', 'admin', 'admin', '2021-09-26 14:46:28', '2022-09-06 10:41:04');
INSERT INTO `menu` VALUES (3, 0, 'LLM Chat', 'llm', 'layout', 'chat/', NULL, '/chat', 'chat_index', 'contents', 0, 0, 'ChatboxOutline', 1, 0, 'LLM Chat', 'admin', 'admin', '2022-06-08 16:46:18', '2024-01-08 16:04:36');
INSERT INTO `menu` VALUES (4, 0, '系统监控', 'monitor', 'admin', 'monitor', NULL, '/monitor/log', '', 'contents', 0, 0, 'TvOutline', 4, 0, '系统工具', 'admin', 'admin', '2022-05-19 11:11:06', '2024-01-10 10:30:59');
INSERT INTO `menu` VALUES (5, 0, '仪表盘', 'dashboard', 'layout', 'dashboard', '', '/dashboard/list', 'dashboard_list', 'contents', 0, 0, 'StatsChartOutline', 5, 0, '', 'admin', 'admin', '2022-08-15 11:06:50', '2023-11-24 19:30:15');
INSERT INTO `menu` VALUES (7, 0, 'lingmengcan', 'https://lingmengcan.space', 'layout', 'lingmengcan', NULL, NULL, '', 'contents', 0, 0, 'DiamondOutline', 6, 0, 'lingmengcan 主页', 'admin', 'admin', '2022-05-19 11:16:45', '2024-01-08 16:22:03');
INSERT INTO `menu` VALUES (8, 1, '用户管理', 'user', '/system/user/index', 'user', '', NULL, 'system_user_index', 'menu', 0, 0, '', 1, 0, '用户管理菜单', 'admin', 'admin', '2021-10-21 10:34:32', '2023-12-28 14:26:37');
INSERT INTO `menu` VALUES (9, 1, '角色管理', 'role', '/system/role/index', 'role', '', '', 'system_role_index', 'menu', 0, 0, '', 2, 0, '角色管理菜单', 'admin', 'admin', '2021-10-21 10:36:49', '2023-11-23 11:11:08');
INSERT INTO `menu` VALUES (10, 1, '菜单管理', 'menu', '/system/menu/index', 'menu', '', NULL, 'system_menu_index', 'menu', 0, 0, '', 3, 0, '菜单管理菜单', 'admin', 'admin', '2021-10-21 10:38:03', '2023-11-23 11:12:12');
INSERT INTO `menu` VALUES (11, 1, '字典管理', 'dict', '/system/dict/index', 'param', NULL, NULL, 'system_dict_index', 'menu', 0, 0, '', 4, 0, '字典管理', 'admin', 'admin', '2022-05-20 11:09:04', '2024-01-03 16:08:24');
INSERT INTO `menu` VALUES (12, 2, '生成', NULL, '/draw/generate', 'generate', '', '', 'draw_generate', 'menu', 0, 0, '', 1, 0, '数据门户列表', 'admin', 'admin', '2022-08-15 17:01:20', '2022-09-06 10:51:55');
INSERT INTO `menu` VALUES (13, 3, '对话', 'chat', '/chat/index', ':conversationId?', NULL, NULL, 'chat_index', 'menu', 0, 0, '', 2, 0, 'chat', 'admin', 'admin', '2022-08-25 17:16:46', '2023-11-30 09:54:18');
INSERT INTO `menu` VALUES (14, 4, '日志管理', NULL, '/monitor/log/index', 'log', NULL, NULL, 'monitor:log:index', 'menu', 0, 0, '', 1, 0, '301', 'admin', 'admin', '2022-05-19 11:18:49', '2022-07-12 15:07:32');
INSERT INTO `menu` VALUES (15, 4, '服务运行', NULL, '/monitor/server/index', 'server', '', '', 'monitor:server:index', 'menu', 0, 0, '', 1, 0, '', 'admin', 'admin', '2022-07-04 14:09:38', '2022-07-12 17:14:00');
INSERT INTO `menu` VALUES (16, 5, '仪表盘列表', NULL, '/dashboard/index', 'list', '', '', 'dashboard_list', 'menu', 0, 0, '', 1, 0, '', 'admin', 'admin', '2022-08-15 16:52:15', '2022-08-15 17:15:24');
INSERT INTO `menu` VALUES (18, 3, 'chat_index', 'chat_noid', '/chat/index', 'noid', '', '', 'llm_test', 'menu', 1, 1, 'AirplaneOutline', 1, 0, 'test', 'admin', 'admin', '2023-11-21 15:38:20', '2023-11-30 10:01:23');
INSERT INTO `menu` VALUES (21, 8, '用户查询', NULL, '', '', NULL, NULL, 'system_user_query', 'action', 0, 0, '', 1, 0, '', 'admin', 'admin', '2022-05-23 14:25:32', '2023-12-28 14:16:20');
INSERT INTO `menu` VALUES (22, 8, '用户新增', NULL, '', '', NULL, NULL, 'system_user_add', 'action', 0, 0, '', 2, 0, '', 'admin', 'admin', '2022-05-23 14:28:27', '2023-12-28 14:15:35');
INSERT INTO `menu` VALUES (23, 8, '用户修改', NULL, '', '', NULL, NULL, 'system_user_edit', 'action', 0, 0, '', 3, 0, '', 'admin', 'admin', '2022-05-23 14:28:45', '2023-12-28 14:15:24');
INSERT INTO `menu` VALUES (24, 8, '用户删除', NULL, '', '', NULL, NULL, 'system_user_delete', 'action', 0, 0, '', 4, 0, '', 'admin', 'admin', '2022-05-23 14:29:14', '2023-12-28 14:15:13');
INSERT INTO `menu` VALUES (25, 9, '角色查询', NULL, '', '', NULL, NULL, 'system_role_query', 'action', 0, 0, '', 3, 0, '', 'admin', 'admin', '2022-06-08 16:44:56', '2023-12-28 14:16:58');
INSERT INTO `menu` VALUES (26, 9, '角色新增', NULL, '', '', NULL, NULL, 'system_role_add', 'action', 0, 0, '', 4, 0, '', 'admin', 'admin', '2022-06-08 16:45:27', '2023-12-28 14:16:54');
INSERT INTO `menu` VALUES (27, 9, '角色修改', NULL, '', '', NULL, NULL, 'system_role_edit', 'action', 0, 0, '', 5, 0, '', 'admin', 'admin', '2022-06-08 16:45:53', '2023-12-28 14:17:23');
INSERT INTO `menu` VALUES (28, 9, '角色删除', NULL, '', '', NULL, NULL, 'system_role_delete', 'action', 0, 0, '', 6, 0, '', 'admin', 'admin', '2022-06-08 16:46:18', '2023-12-28 14:17:31');
INSERT INTO `menu` VALUES (29, 9, '分配用户', NULL, 'system/role/role-user', 'user', NULL, NULL, 'system_role_user', 'action', 1, 0, '', 2, 0, '', 'admin', 'admin', '2022-06-08 16:48:01', '2023-11-23 11:11:39');
INSERT INTO `menu` VALUES (30, 10, '菜单新增', NULL, '', 'list', '', NULL, 'system_menu_add', 'action', 1, 0, '', 1, 0, '', 'admin', 'admin', '2022-06-29 16:19:21', '2023-11-23 11:10:27');
INSERT INTO `menu` VALUES (31, 10, '菜单删除', '', '', '', '', '', 'system_menu_delete', 'action', 0, 0, '', 3, 0, '', 'admin', 'admin', '2023-11-21 21:00:38', '2023-11-23 11:31:55');
INSERT INTO `menu` VALUES (32, 10, '菜单编辑', '', '', '', '', '', 'system_menu_edit', 'action', 0, 0, '', 2, 0, '', 'admin', 'admin', '2023-11-23 11:30:47', '2023-11-23 11:30:47');
INSERT INTO `menu` VALUES (33, 10, '菜单查询', '', '', '', '', '', 'system_menu_query', 'action', 0, 0, '', 4, 0, '', 'admin', 'admin', '2023-11-23 11:33:03', '2023-11-23 11:34:02');
INSERT INTO `menu` VALUES (34, 8, '重置密码', 'reset_pwd', '', '', '', '', 'system_user_resetpwd', 'action', 0, 0, '', 5, 0, '重置密码', 'admin', 'admin', '2023-12-28 19:55:49', '2023-12-28 19:55:49');
INSERT INTO `menu` VALUES (35, 11, '字典查询', 'dict_query', '', '', '', '', 'system_dict_query', 'action', 0, 0, '', 1, 0, '', 'admin', 'admin', '2024-01-08 10:48:08', '2024-01-08 10:48:08');
INSERT INTO `menu` VALUES (36, 11, '字典新增', '', '', '', '', '', 'system_dict_add', 'action', 0, 0, '', 2, 0, '', 'admin', 'admin', '2024-01-08 10:49:10', '2024-01-08 10:49:21');
INSERT INTO `menu` VALUES (37, 11, '字典修改', '', '', '', '', '', 'system_dict_edit', 'action', 0, 0, '', 3, 0, '', 'admin', 'admin', '2024-01-08 10:49:42', '2024-01-08 10:49:48');
INSERT INTO `menu` VALUES (38, 11, '字典删除', '', '', '', '', '', 'system_dict_delete', 'action', 0, 0, '', 0, 0, '', 'admin', 'admin', '2024-01-08 10:52:23', '2024-01-08 10:52:23');
INSERT INTO `menu` VALUES (39, 3, '文件上传', '', '', '', '', '', 'chat_upload_file', 'action', 0, 0, '', 3, 0, '', 'admin', 'admin', '2024-03-08 15:50:53', '2024-03-08 15:52:26');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `message_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `previous_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `conversation_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `file_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `message_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sender` enum('Human','Assistant','System') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('06e30ca2-8a6a-4a1b-bdf1-61c383be347e', 'b02f1171-0a5d-47d7-bfae-0b5eac8f5dc8', '29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', '', '\n 我是一个名为 ChatGLM3-6B 的人工智能助手，是基于清华大学 KEG 实验室和智谱 AI 公司于 2023 年共同训练的语言模型开发的。我的任务是针对用户的问题和要求提供适当的答复和支持。', 'Assistant', 1, 0, '2024-02-22 16:53:43');
INSERT INTO `message` VALUES ('09087f36-c1e5-4d70-8541-b562366389b3', '', '72c02f31-89a3-4c80-b8ba-458924648b2f', '', 'hi', 'Human', 1, 0, '2024-02-22 14:44:50');
INSERT INTO `message` VALUES ('14a9a486-2682-4b21-b1b1-8f9daafa86cb', '', '72c02f31-89a3-4c80-b8ba-458924648b2f', '', '你是？', 'Human', 1, 0, '2024-02-22 14:45:09');
INSERT INTO `message` VALUES ('3621cc71-23c2-4676-9709-2d588b970258', '14a9a486-2682-4b21-b1b1-8f9daafa86cb', '72c02f31-89a3-4c80-b8ba-458924648b2f', '', '\n 你好！我是一个人工智能助手，我可以回答你各种问题，帮助你解决问题，有什么需要我帮忙的吗？', 'Assistant', 1, 0, '2024-02-22 14:45:13');
INSERT INTO `message` VALUES ('4eb25cda-61ca-45b5-89a4-04c87bef08aa', '', '29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', '7874c71a-4ffb-46dd-8330-1dac3e20b18a', 't.txt', 'System', 1, 0, '2024-03-15 16:21:14');
INSERT INTO `message` VALUES ('548d6b1f-3e16-45c5-8a01-f59b9ff1303a', '', '72c02f31-89a3-4c80-b8ba-458924648b2f', '', '哪个团队开发的', 'Human', 1, 0, '2024-02-22 14:45:21');
INSERT INTO `message` VALUES ('64037aad-3e53-4c12-957f-3ba8ca8d83f2', '', '619323ff-2df3-4485-9c97-cb2f08a67c6d', '', 'hi', 'Human', 1, 0, '2024-03-15 16:16:56');
INSERT INTO `message` VALUES ('755ce299-4381-477d-add7-8c32901ec7b5', '64037aad-3e53-4c12-957f-3ba8ca8d83f2', '619323ff-2df3-4485-9c97-cb2f08a67c6d', '', '\n Hello! How can I help you today?', 'Assistant', 1, 0, '2024-03-15 16:16:59');
INSERT INTO `message` VALUES ('8aa1c3c0-9d59-44d8-a668-1e3431859829', '', '29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', 'f7f03136-03e9-46b1-8995-4b80fa2df00b', 't.txt', 'System', 1, 0, '2024-03-14 19:41:45');
INSERT INTO `message` VALUES ('9de97dce-5280-4f9f-a5bc-ff539226af1b', '', '619323ff-2df3-4485-9c97-cb2f08a67c6d', '', '你是？', 'Human', 1, 0, '2024-03-15 16:17:09');
INSERT INTO `message` VALUES ('b02f1171-0a5d-47d7-bfae-0b5eac8f5dc8', '', '29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', '', '你是？', 'Human', 1, 0, '2024-02-22 16:53:35');
INSERT INTO `message` VALUES ('b11ef214-26a9-418f-a689-a482351fab32', '09087f36-c1e5-4d70-8541-b562366389b3', '72c02f31-89a3-4c80-b8ba-458924648b2f', '', '\n Hello! How can I assist you today?', 'Assistant', 1, 0, '2024-02-22 14:44:53');
INSERT INTO `message` VALUES ('c3c131d8-ff47-477e-bd91-2439336ebf5a', '548d6b1f-3e16-45c5-8a01-f59b9ff1303a', '72c02f31-89a3-4c80-b8ba-458924648b2f', '', '\n 我是由清华大学 KEG 实验室和智谱 AI 共同开发而成。', 'Assistant', 1, 0, '2024-02-22 14:45:24');
INSERT INTO `message` VALUES ('d372b19b-56d4-4e44-81b8-11e1ab7bbae4', '9de97dce-5280-4f9f-a5bc-ff539226af1b', '619323ff-2df3-4485-9c97-cb2f08a67c6d', '', '\n I am an AI assistant named ChatGLM3-6B, which is developed based on the language model jointly trained by Tsinghua University KEG Lab and Zhipu AI Company in 2023. My job is to provide appropriate answers and support to users\' questions and requests.', 'Assistant', 1, 0, '2024-03-15 16:17:18');
INSERT INTO `message` VALUES ('da5285e7-79ad-4ae2-a086-a84487f10b20', '', '29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', '01e7042e-e468-4c63-b4ba-3a5949300751', 't.txt', 'System', 1, 0, '2024-03-15 16:25:08');
INSERT INTO `message` VALUES ('e0e4bbb4-d95d-46c9-bd4e-d61488b6c295', '', '619323ff-2df3-4485-9c97-cb2f08a67c6d', '', 'hi', 'Human', 1, 0, '2024-03-15 16:16:26');
INSERT INTO `message` VALUES ('e545c1fd-f6f2-4232-8722-7dbf3faaf18a', 'e0e4bbb4-d95d-46c9-bd4e-d61488b6c295', '619323ff-2df3-4485-9c97-cb2f08a67c6d', '', '', 'Assistant', 0, 0, '2024-03-15 16:16:26');
INSERT INTO `message` VALUES ('f03cef9e-e345-4429-bed6-d273c7d0fd49', '', '29e9b787-f7df-4c79-9b0c-f9ecf98e8d45', '063c0126-665b-45e7-88d9-9fffae43b92f', 'Fin-AIGC产品简介与AI辅助编程使用分享.pdf', 'System', 1, 0, '2024-03-13 15:40:58');

-- ----------------------------
-- Table structure for prompt
-- ----------------------------
DROP TABLE IF EXISTS `prompt`;
CREATE TABLE `prompt`  (
  `prompt_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`prompt_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prompt
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort` int NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员', 'admin', 1, 0, '超级管理员', 'admin', 'admin', '2021-11-02 10:37:56', '2023-11-14 17:15:19');
INSERT INTO `role` VALUES (2, '客人', 'guest', 2, 0, '客人', 'admin', 'admin', '2021-11-02 10:38:34', '2023-11-14 17:15:29');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (1, 1);
INSERT INTO `role_menu` VALUES (1, 2);
INSERT INTO `role_menu` VALUES (1, 3);
INSERT INTO `role_menu` VALUES (1, 4);
INSERT INTO `role_menu` VALUES (1, 5);
INSERT INTO `role_menu` VALUES (1, 7);
INSERT INTO `role_menu` VALUES (1, 8);
INSERT INTO `role_menu` VALUES (1, 9);
INSERT INTO `role_menu` VALUES (1, 10);
INSERT INTO `role_menu` VALUES (1, 11);
INSERT INTO `role_menu` VALUES (1, 12);
INSERT INTO `role_menu` VALUES (1, 13);
INSERT INTO `role_menu` VALUES (1, 14);
INSERT INTO `role_menu` VALUES (1, 15);
INSERT INTO `role_menu` VALUES (1, 16);
INSERT INTO `role_menu` VALUES (1, 18);
INSERT INTO `role_menu` VALUES (1, 21);
INSERT INTO `role_menu` VALUES (1, 22);
INSERT INTO `role_menu` VALUES (1, 23);
INSERT INTO `role_menu` VALUES (1, 24);
INSERT INTO `role_menu` VALUES (1, 25);
INSERT INTO `role_menu` VALUES (1, 26);
INSERT INTO `role_menu` VALUES (1, 27);
INSERT INTO `role_menu` VALUES (1, 28);
INSERT INTO `role_menu` VALUES (1, 29);
INSERT INTO `role_menu` VALUES (1, 30);
INSERT INTO `role_menu` VALUES (1, 31);
INSERT INTO `role_menu` VALUES (1, 32);
INSERT INTO `role_menu` VALUES (1, 33);
INSERT INTO `role_menu` VALUES (1, 34);
INSERT INTO `role_menu` VALUES (1, 35);
INSERT INTO `role_menu` VALUES (1, 36);
INSERT INTO `role_menu` VALUES (1, 37);
INSERT INTO `role_menu` VALUES (1, 38);
INSERT INTO `role_menu` VALUES (1, 39);
INSERT INTO `role_menu` VALUES (2, 12);

-- ----------------------------
-- Table structure for role_user
-- ----------------------------
DROP TABLE IF EXISTS `role_user`;
CREATE TABLE `role_user`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_user
-- ----------------------------
INSERT INTO `role_user` VALUES (1, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nick_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `login_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `login_date` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '超级管理员', 'admin@lmc.com', '12345678901', '1', '', '$2b$10$bgJ1x5CdyFAbt13v4.efFOT51F2Gxeg/C7xdfrdciDkgeayZPzl2K', '127.0.0.1', '2021-10-22 09:54:19', 0, '超级管理员', 'admin', 'admin', '2021-10-22 09:54:19', '2022-05-30 16:06:27');

SET FOREIGN_KEY_CHECKS = 1;
