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

 Date: 19/01/2024 19:59:57
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
INSERT INTO `conversation` VALUES ('331da542-e7a9-4d9d-b0eb-135834a6b8de', '新建对话', 'admin', 'GPT-3.5', 0.5, 0, '2024-01-17 11:18:59', '2024-01-17 11:19:04');
INSERT INTO `conversation` VALUES ('48af64c2-d07a-439c-9837-01f9d925c786', '新建对话', 'admin', 'ChatGLM3', 0.3, 0, '2023-12-22 16:15:26', '2023-12-26 15:39:01');
INSERT INTO `conversation` VALUES ('5504bb80-87fc-4cac-b1f3-7613ae89d7f0', '新建对话', 'admin', 'ChatGLM3', 0.3, 0, '2023-12-22 16:40:32', '2023-12-26 15:39:04');
INSERT INTO `conversation` VALUES ('ac6d8c6a-4ac4-4b0b-a39e-b12d17c5009e', '新建对话5', 'admin', 'ChatGLM3', 0.5, 0, '2023-12-26 16:41:01', '2023-12-28 10:20:09');
INSERT INTO `conversation` VALUES ('ccdd9bf0-e580-4f22-86bb-f87003d36b4c', '新建对话3', 'admin', 'ChatGLM3', 0.5, 0, '2023-12-26 15:41:53', '2023-12-28 10:20:00');
INSERT INTO `conversation` VALUES ('e5838af5-a378-41b6-9e60-8cd9b6de32c5', '新建对话2新建对话2新建对话2新建对话2新建对话2', 'admin', 'GPT-3.5', 0.5, 0, '2023-12-26 15:40:47', '2024-01-19 19:59:47');
INSERT INTO `conversation` VALUES ('e691a5fe-0c13-4d31-b057-4463b4449838', '新建对话4', 'admin', 'ChatGLM3', 0.5, 0, '2023-12-26 16:22:50', '2023-12-28 10:20:04');
INSERT INTO `conversation` VALUES ('efc59f74-e0dc-4dbc-8d8a-fbeb247c13cb', '新建对话1', 'admin', 'ChatGLM3', 0.3, 0, '2023-12-25 10:14:40', '2023-12-26 15:39:13');

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
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `message_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `previous_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `conversation_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
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
INSERT INTO `message` VALUES ('030d36dc-776c-48b9-9553-68a97b3f0f91', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '你是？', 'Human', 1, 0, '2024-01-17 15:34:52');
INSERT INTO `message` VALUES ('04b53827-0c42-41b5-a03a-3b82c099dc8c', '1276cee1-0a41-4893-ae03-8e1048de1b65', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '', 'Assistant', 0, 0, '2024-01-19 17:17:58');
INSERT INTO `message` VALUES ('09d4915a-7b43-438a-a047-09a28e897155', 'c1c68b85-aa92-436a-a9c6-75710f30ea4b', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '作为资深前端专家，我有多年的前端开发经验，并且对前端技术有着深入的了解。我熟悉HTML、CSS和JavaScript，并且能够使用各种前端框架和库来开发高效、可靠的前端应用程序。\n\n作为资深前端专家，我能够设计和实现用户友好的界面，确保网站或应用程序的可用性和易用性。我能够优化前端性能，减少加载时间和提高响应速度，从而提供更好的用户体验。\n\n我还熟悉跨浏览器和跨平台开发，能够确保我的前端代码在不同的浏览器和设备上都能正常运行。我了解前端开发的最佳实践，并且能够应用这些实践来提高代码的可维护性和可扩展性。\n\n作为资深前端专家，我还能够与后端开发人员和设计师紧密合作，确保前端与后端的无缝集成，并且实现设计师提供的界面设计。\n\n总之，作为资深前端专家，我具备广泛的前端开发经验和技能，能够为团队提供高质量的前端解决方案。', 'Assistant', 1, 0, '2024-01-19 16:40:26');
INSERT INTO `message` VALUES ('0ee88808-745b-4810-81c5-7bd1918915aa', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '你是？', 'Human', 1, 0, '2024-01-17 16:05:15');
INSERT INTO `message` VALUES ('1276cee1-0a41-4893-ae03-8e1048de1b65', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'hi', 'Human', 1, 0, '2024-01-19 17:17:58');
INSERT INTO `message` VALUES ('12dbe8ec-22c3-476b-b52c-cd0d49746514', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '1', 'Human', 1, 0, '2024-01-19 16:20:29');
INSERT INTO `message` VALUES ('1d67ebaf-27a5-4df2-aa78-1882b3589145', 'b9a391f1-0e45-484f-a188-cfe397b67954', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '', 'Assistant', 0, 0, '2024-01-18 14:31:43');
INSERT INTO `message` VALUES ('21b33286-385f-426c-8e58-326cf28e3d94', '985f4e79-8317-438e-9cf4-edb5a4ef23e2', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '', 'Assistant', 0, 0, '2024-01-17 15:32:56');
INSERT INTO `message` VALUES ('22a8ada8-c19c-4f0d-9dda-e2da1c8a96e0', 'c2f8a614-3f8e-4b81-a4fa-636a8e840cef', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '助你的吗？', 'Assistant', 1, 0, '2024-01-19 16:10:25');
INSERT INTO `message` VALUES ('24204d34-d429-4c5f-8acf-97253f86524a', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '优化上面代码', 'Human', 1, 0, '2024-01-19 16:41:14');
INSERT INTO `message` VALUES ('266e359a-5da0-430b-b366-0b55e43f5080', '997fed75-004a-4e0b-ba23-6035c93afd7b', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '你好！有什么可以帮助你的吗？', 'Assistant', 1, 0, '2024-01-19 16:09:43');
INSERT INTO `message` VALUES ('2aa1d6bf-3c31-4d8d-b670-ade191840de7', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'hi', 'Human', 1, 0, '2024-01-17 15:38:38');
INSERT INTO `message` VALUES ('36345c9c-60d4-42d7-9a65-1970f29989a0', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '你是？', 'Human', 1, 0, '2024-01-19 16:39:21');
INSERT INTO `message` VALUES ('38361c61-f244-49d5-8afb-c02478d3f4dd', '24204d34-d429-4c5f-8acf-97253f86524a', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '以下是对上面代码的优化建议：\n\n1. 使用更具描述性的变量名：将`a`改为`num1`，`b`改为`num2`，`c`改为`num3`，`max_num`改为`max_number`，`min_num`改为`min_number`，`sum`改为`total`。\n\n2. 使用更简洁的条件判断语句：可以使用`max()`和`min()`函数来找到最大值和最小值，而不需要使用多个`if`语句。\n\n3. 使用`sum()`函数来计算总和：可以使用`sum([num1, num2, num3])`来计算三个数的总和，而不需要使用`+`运算符。\n\n4. 使用列表推导式来简化代码：可以使用列表推导式来生成输入的三个数，而不需要使用多个变量。\n\n综上所述，优化后的代码如下所示：\n\n```python\n# 输入三个数\nnumbers = [int(input(\"请输入第{}个数：\".format(i+1))) for i in range(3)]\n\n# 计算最大值、最小值和总和\nmax_number = max(numbers)\nmin_number = min(numbers)\ntotal = sum(numbers)\n\n# 输出结果\nprint(\"最大值为：\", max_number)\nprint(\"最小值为：\", min_number)\nprint(\"总和为：\", total)\n```', 'Assistant', 1, 0, '2024-01-19 16:41:38');
INSERT INTO `message` VALUES ('38f9ffe6-0413-4253-a4bc-87f5a4631c0e', 'a6cce69f-8947-4125-a7ca-318cbfca0d66', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '你好！有什么我可以帮助你的吗？', 'Assistant', 1, 0, '2024-01-19 16:09:54');
INSERT INTO `message` VALUES ('3b2d13b5-3540-446b-8578-6ee69cd266d4', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '1', 'Human', 1, 0, '2024-01-17 16:04:17');
INSERT INTO `message` VALUES ('402906c2-1dc5-41e4-908c-7055531bb459', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'hi', 'Human', 1, 0, '2024-01-17 15:39:04');
INSERT INTO `message` VALUES ('4cb863cc-c780-4cc8-8e8e-19adcb09c7e5', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '哪个公司开发的', 'Human', 1, 0, '2024-01-17 16:05:45');
INSERT INTO `message` VALUES ('4e058a5a-1918-4e8b-bd6a-7e4358bddd18', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '1', 'Human', 1, 0, '2024-01-17 15:33:30');
INSERT INTO `message` VALUES ('5ec63725-57db-402b-b035-cd286c0a1a5d', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'answer.value.messageText += new TextDecoder().decode(value);', 'Human', 1, 0, '2024-01-19 16:39:42');
INSERT INTO `message` VALUES ('5ff39484-ba67-4a21-917d-84b288ee5b19', '6118a297-2924-41ff-ac58-a549592b6e3f', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '', 'Assistant', 0, 0, '2024-01-19 17:16:57');
INSERT INTO `message` VALUES ('6118a297-2924-41ff-ac58-a549592b6e3f', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'hi', 'Human', 1, 0, '2024-01-19 17:16:57');
INSERT INTO `message` VALUES ('6894189c-6274-44ec-9f0c-feafdfbc69d8', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '那你为啥是谷歌助手', 'Human', 1, 0, '2024-01-17 15:35:38');
INSERT INTO `message` VALUES ('6b130387-c46d-4e30-9e03-108e501fee09', 'eb8f8226-9f3a-4601-a4bc-1fce632e8ddd', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'Hello! How can I assist you today?', 'Assistant', 1, 0, '2024-01-19 17:30:50');
INSERT INTO `message` VALUES ('70d6a9e1-946d-4995-b601-cb967d7e002d', '030d36dc-776c-48b9-9553-68a97b3f0f91', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '我是谷歌助手，一个人工智能虚拟助手。', 'Assistant', 1, 0, '2024-01-17 15:34:54');
INSERT INTO `message` VALUES ('72208e15-f3a3-4830-b55e-4e20e3c53257', '12dbe8ec-22c3-476b-b52c-cd0d49746514', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'I\'m sorry, but I\'m not sure what you\'re asking. Could you please provide more information or clarify your question?', 'Assistant', 1, 0, '2024-01-19 16:20:32');
INSERT INTO `message` VALUES ('76c4eaff-ca81-480d-8867-b1e22c694071', '78094a23-b563-4813-b4d3-95d5f3b8cf3d', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '这个问题无法确定一个具体的开发者，因为没有提供任何上下文或具体的项目或产品名称。请提供更多信息以帮助我更好地回答您的问题。', 'Assistant', 1, 0, '2024-01-17 16:05:30');
INSERT INTO `message` VALUES ('78094a23-b563-4813-b4d3-95d5f3b8cf3d', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '谁开发的？', 'Human', 1, 0, '2024-01-17 16:05:27');
INSERT INTO `message` VALUES ('7e5ac6f7-e2b6-4220-a5b8-d2273f79934e', '4cb863cc-c780-4cc8-8e8e-19adcb09c7e5', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '很抱歉，你提到的是一个开发不明确的情况，请提供更多信息。', 'Assistant', 1, 0, '2024-01-17 16:05:47');
INSERT INTO `message` VALUES ('9153b641-5e53-4ddb-9953-1f0bf0ab9096', 'b982b30d-58cc-40fe-a781-b113bbaa39cc', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '你好！有什么我可以帮助你的吗？', 'Assistant', 1, 0, '2024-01-19 16:28:09');
INSERT INTO `message` VALUES ('91b1c4df-e464-4f17-bb9a-6fbed35e64e1', '4e058a5a-1918-4e8b-bd6a-7e4358bddd18', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '', 'Assistant', 1, 0, '2024-01-17 15:33:32');
INSERT INTO `message` VALUES ('92e83ae6-107a-4264-b595-271bbed70afb', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '你是哪个公司开发的', 'Human', 1, 0, '2024-01-17 16:05:58');
INSERT INTO `message` VALUES ('985f4e79-8317-438e-9cf4-edb5a4ef23e2', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '1', 'Human', 1, 0, '2024-01-17 15:32:56');
INSERT INTO `message` VALUES ('997fed75-004a-4e0b-ba23-6035c93afd7b', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '1', 'Human', 1, 0, '2024-01-19 16:09:41');
INSERT INTO `message` VALUES ('a221d8db-8101-4cc4-b52d-af0572f5a145', '2aa1d6bf-3c31-4d8d-b670-ade191840de7', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '', 'Assistant', 0, 0, '2024-01-17 15:38:38');
INSERT INTO `message` VALUES ('a630c121-3be4-45b1-9714-5db9a772b2e1', 'ae4e8115-b2ad-4119-866d-1a0cfd8c1c6d', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '我是OpenAI的GPT-3模型。', 'Assistant', 1, 0, '2024-01-17 15:35:24');
INSERT INTO `message` VALUES ('a6cce69f-8947-4125-a7ca-318cbfca0d66', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '2', 'Human', 1, 0, '2024-01-19 16:09:52');
INSERT INTO `message` VALUES ('a9e88746-2f2e-43da-a863-aa532e4deb6c', '402906c2-1dc5-41e4-908c-7055531bb459', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '', 'Assistant', 0, 0, '2024-01-17 15:39:04');
INSERT INTO `message` VALUES ('ae4e8115-b2ad-4119-866d-1a0cfd8c1c6d', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '你的大模型是？', 'Human', 1, 0, '2024-01-17 15:35:23');
INSERT INTO `message` VALUES ('b982b30d-58cc-40fe-a781-b113bbaa39cc', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '你好啊', 'Human', 1, 0, '2024-01-19 16:28:02');
INSERT INTO `message` VALUES ('b9a391f1-0e45-484f-a188-cfe397b67954', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'hi', 'Human', 1, 0, '2024-01-18 14:31:43');
INSERT INTO `message` VALUES ('c1c68b85-aa92-436a-a9c6-75710f30ea4b', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '假设你是资深前端专家', 'Human', 1, 0, '2024-01-19 16:40:00');
INSERT INTO `message` VALUES ('c2f8a614-3f8e-4b81-a4fa-636a8e840cef', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '3', 'Human', 1, 0, '2024-01-19 16:10:23');
INSERT INTO `message` VALUES ('cb0181d6-baf9-4e60-996f-b1694ae2d142', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '1', 'Human', 1, 0, '2024-01-18 10:02:09');
INSERT INTO `message` VALUES ('d9506795-7031-430f-89f0-9e862a3a0d7b', '5ec63725-57db-402b-b035-cd286c0a1a5d', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'This line of code appends the decoded value to the existing message text in the answer object.', 'Assistant', 1, 0, '2024-01-19 16:39:44');
INSERT INTO `message` VALUES ('ddf7ae7d-2117-44bf-9c2c-21f08146c143', '0ee88808-745b-4810-81c5-7bd1918915aa', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '我是人工智能助手，请问有什么我可以帮助您的？', 'Assistant', 1, 0, '2024-01-17 16:05:17');
INSERT INTO `message` VALUES ('e227c139-2959-44b5-a696-7d4913e993c1', '6894189c-6274-44ec-9f0c-feafdfbc69d8', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '因为我是一个由谷歌公司开发的聊天机器人，被称为谷歌助手。我可以回答用户的问题，提供信息和建议，并帮助他们完成各种任务。', 'Assistant', 1, 0, '2024-01-17 15:35:43');
INSERT INTO `message` VALUES ('e2fc8d43-f43a-4918-a8e6-eb7aaf55985a', '92e83ae6-107a-4264-b595-271bbed70afb', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '我是由OpenAI开发的。', 'Assistant', 1, 0, '2024-01-17 16:05:59');
INSERT INTO `message` VALUES ('eb8f8226-9f3a-4601-a4bc-1fce632e8ddd', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'hi', 'Human', 1, 0, '2024-01-19 17:30:48');
INSERT INTO `message` VALUES ('ec380a4f-c807-4491-8516-fb1aca86cd19', '36345c9c-60d4-42d7-9a65-1970f29989a0', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '我是一个AI助手，可以回答你的问题和提供帮助。', 'Assistant', 1, 0, '2024-01-19 16:39:23');
INSERT INTO `message` VALUES ('f1b356b3-daf5-4cce-a21d-fbe5a85eeeb5', '3b2d13b5-3540-446b-8578-6ee69cd266d4', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'I can help with that! What specific question do you have about the number 1?', 'Assistant', 1, 0, '2024-01-17 16:04:19');
INSERT INTO `message` VALUES ('f2c31b26-69e1-458e-9aec-456b918140a2', 'f34181aa-0302-40e4-a49f-9ae7e2a2e59e', '331da542-e7a9-4d9d-b0eb-135834a6b8de', 'This line of code decodes the given value using the TextDecoder() function and adds the decoded text to the existing messageText property of the answer object.', 'Assistant', 1, 0, '2024-01-19 16:41:06');
INSERT INTO `message` VALUES ('f34181aa-0302-40e4-a49f-9ae7e2a2e59e', '', '331da542-e7a9-4d9d-b0eb-135834a6b8de', ' answer.value.messageText += new TextDecoder().decode(value);', 'Human', 1, 0, '2024-01-19 16:41:03');
INSERT INTO `message` VALUES ('fd436a48-76ca-4e7d-9fa5-28c749c2bda1', 'cb0181d6-baf9-4e60-996f-b1694ae2d142', '331da542-e7a9-4d9d-b0eb-135834a6b8de', '', 'Assistant', 1, 0, '2024-01-18 10:02:13');

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
INSERT INTO `prompt` VALUES ('0bb3e2ba-f692-4f32-ab55-61f251400724', '5', '你是前端开发', 'admin', 0, '2023-12-27 16:37:21');
INSERT INTO `prompt` VALUES ('3c89299d-37ac-4c22-ab16-4485119475af', '4', '4', 'admin', 1, '2023-12-27 16:35:47');
INSERT INTO `prompt` VALUES ('4c385fd5-157b-47f9-889a-5967dda0a157', '3', '3', 'admin', 1, '2024-01-09 19:44:10');
INSERT INTO `prompt` VALUES ('6cedde56-c213-45ee-891a-c8be54cdbb92', '5', '6', 'admin', 1, '2023-12-27 16:35:42');
INSERT INTO `prompt` VALUES ('a224b6a9-d0f5-4a89-9cf2-848c09907dcd', '2', '2', 'admin', 0, '2023-12-27 14:29:20');
INSERT INTO `prompt` VALUES ('d98531ee-3691-460e-94cc-0cb43ebe5c47', '1', '1', 'admin', 0, '2023-12-27 10:21:20');

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
INSERT INTO `role` VALUES (3, 'test2', 'test', 3, 0, 'test', 'admin', 'admin', '2021-11-02 17:17:12', '2023-11-13 15:39:20');
INSERT INTO `role` VALUES (16, 'test', 'test2', 4, 0, 'test2', 'admin', 'admin', '2023-11-14 17:15:44', '2023-11-14 17:15:44');
INSERT INTO `role` VALUES (17, '0', '0', 0, -1, '', 'admin', 'admin', '2023-11-14 17:18:43', '2023-11-14 20:02:41');

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
INSERT INTO `role_user` VALUES (2, 1);
INSERT INTO `role_user` VALUES (3, 2);
INSERT INTO `role_user` VALUES (3, 3);

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
INSERT INTO `user` VALUES (2, 'ouyangguoling', '欧阳国灵', 'ouyangguoling@lingmengcan.tech', '18026927766', '1', '', '$2b$10$HSLQgyJdfKYo0EhVpx2PgOU.r0qLtTFeuARlo.3LF6hzhuAM4t4se', '', '2022-05-30 16:10:55', 0, '', 'admin', 'admin', '2022-05-30 16:10:55', '2023-12-28 14:40:03');
INSERT INTO `user` VALUES (3, 'test', '测试1', 'test@lingmengcan.tech', '12345678902', '0', '', '$2b$10$CJ/2mrG1m/zZCz9xb8lKQ.7hwNLBTT284s4u3cMivFItM95fBJU9y', '', '2022-05-30 17:23:33', 1, 's', 'admin', 'admin', '2022-05-30 17:23:33', '2023-12-28 18:44:38');
INSERT INTO `user` VALUES (4, '1', '1', 'gionouyang@qq.com', '18026927766', '1', '', '$2b$10$lEu2Cd8CQ/0Ac2svc4i11u81C//ERlKg3TN2jkCwKADOT0XlOawAC', '', '2023-12-28 19:24:39', 0, '1', 'admin', 'admin', '2023-12-28 19:24:39', '2023-12-28 20:09:44');

SET FOREIGN_KEY_CHECKS = 1;
