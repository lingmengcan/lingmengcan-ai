/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : localhost:3306
 Source Schema         : lingmengcan

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 29/11/2023 18:54:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`  (
  `dept_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` bigint NULL DEFAULT NULL,
  `dept_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `leader` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES (1, 0, 's科技', 'lingmengcan', 1, 0, '灵萌灿科技', 'admin', 'admin', '2022-05-23 17:14:13', '2022-05-23 17:28:54');
INSERT INTO `dept` VALUES (2, 1, '研发部', 'lingmengcan', 1, 0, '负责研发', 'admin', 'admin', '2022-05-23 17:31:31', '2022-08-15 17:20:53');
INSERT INTO `dept` VALUES (3, 0, '测试', 'test', 2, 0, '', 'admin', 'admin', '2022-07-11 10:23:51', '2022-07-12 10:32:26');

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict`  (
  `dict_id` bigint UNSIGNED NOT NULL,
  `dict_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `dict_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `dict_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dict
-- ----------------------------

-- ----------------------------
-- Table structure for dict_type
-- ----------------------------
DROP TABLE IF EXISTS `dict_type`;
CREATE TABLE `dict_type`  (
  `dict_type_id` bigint UNSIGNED NOT NULL,
  `dict_type_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `dict_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dict_type_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dict_type
-- ----------------------------

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
  `status` tinyint NULL DEFAULT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 0, '系统设置', 'system', 'admin', 'system', '', 'user', '', 'contents', 0, 0, 'SettingsOutline', 3, 0, '系统管理目录', 'admin', 'admin', '2021-09-26 14:42:01', '2023-11-29 15:39:46');
INSERT INTO `menu` VALUES (2, 0, 'AI Draw', 'draw', 'layout', 'draw', '', '/draw/generate', 'draw_generate', 'contents', 0, 0, 'BrushOutline', 2, 0, 'AI Draw', 'admin', 'admin', '2021-09-26 14:46:28', '2022-09-06 10:41:04');
INSERT INTO `menu` VALUES (3, 0, 'LLM Chat', 'llm', 'layout', 'chat', NULL, 'index', 'chat_index', 'contents', 0, 0, 'ChatboxOutline', 1, 0, 'LLM Chat', 'admin', 'admin', '2022-06-08 16:46:18', '2023-11-29 15:40:15');
INSERT INTO `menu` VALUES (4, 0, '系统监控', 'monitor', 'layout', 'monitor', NULL, NULL, '', 'contents', 0, 0, 'TvOutline', 4, 0, '系统工具', 'admin', 'admin', '2022-05-19 11:11:06', '2022-08-15 11:13:19');
INSERT INTO `menu` VALUES (5, 0, '仪表盘', 'dashboard', 'layout', 'dashboard', '', '/dashboard/list', 'dashboard_list', 'contents', 0, 0, 'StatsChartOutline', 5, 0, '', 'admin', 'admin', '2022-08-15 11:06:50', '2023-11-24 19:30:15');
INSERT INTO `menu` VALUES (6, 0, '可视化', 'visual', 'canvas', 'visual', '', '', '', 'contents', 0, 1, 'AccessibilityOutline', 7, 1, 'a', 'admin', 'admin', '2022-08-25 17:16:46', '2023-11-21 16:24:42');
INSERT INTO `menu` VALUES (7, 0, 'lingmengcan', 'https://lingmengcan.tech', 'layout', 'lingmengcan', NULL, NULL, '', 'contents', 0, 0, 'DiamondOutline', 6, 0, 'lingmengcan.tech', 'admin', 'admin', '2022-05-19 11:16:45', '2022-08-15 11:13:23');
INSERT INTO `menu` VALUES (8, 1, '用户管理', 'user', '/system/user/index', 'user', '', NULL, 'right:user:list', 'menu', 0, 0, '', 1, 0, '用户管理菜单', 'admin', 'admin', '2021-10-21 10:34:32', '2022-05-23 14:57:59');
INSERT INTO `menu` VALUES (9, 1, '角色管理', 'role', '/system/role/index', 'role', '', '', 'system_role_index', 'menu', 0, 0, '', 2, 0, '角色管理菜单', 'admin', 'admin', '2021-10-21 10:36:49', '2023-11-23 11:11:08');
INSERT INTO `menu` VALUES (10, 1, '菜单管理', 'menu', '/system/menu/index', 'menu', '', NULL, 'system_menu_index', 'menu', 0, 0, '', 3, 0, '菜单管理菜单', 'admin', 'admin', '2021-10-21 10:38:03', '2023-11-23 11:12:12');
INSERT INTO `menu` VALUES (11, 1, '字典管理', 'param', '/system/param/index', 'param', NULL, NULL, 'system_param_index', 'menu', 0, 0, '', 4, 0, '字典管理', 'admin', 'admin', '2022-05-20 11:09:04', '2023-11-22 10:10:02');
INSERT INTO `menu` VALUES (12, 2, '生成', NULL, '/draw/generate', 'generate', '', '', 'draw_generate', 'menu', 0, 0, '', 1, 0, '数据门户列表', 'admin', 'admin', '2022-08-15 17:01:20', '2022-09-06 10:51:55');
INSERT INTO `menu` VALUES (13, 3, '对话', 'chat', '/chat/index', 'index', NULL, NULL, 'chat_index', 'menu', 0, 0, '', 1, 0, 'chat', 'admin', 'admin', '2022-08-25 17:16:46', '2023-11-29 15:41:00');
INSERT INTO `menu` VALUES (14, 4, '日志管理', NULL, '/monitor/log/index', 'log', NULL, NULL, 'monitor:log:index', 'menu', 0, 0, '', 1, 0, '301', 'admin', 'admin', '2022-05-19 11:18:49', '2022-07-12 15:07:32');
INSERT INTO `menu` VALUES (15, 4, '服务运行', NULL, '/monitor/server/index', 'server', '', '', 'monitor:server:index', 'menu', 0, 0, '', 1, 0, '', 'admin', 'admin', '2022-07-04 14:09:38', '2022-07-12 17:14:00');
INSERT INTO `menu` VALUES (16, 5, '仪表盘列表', NULL, '/dashboard/index', 'list', '', '', 'dashboard_list', 'menu', 0, 0, '', 1, 0, '', 'admin', 'admin', '2022-08-15 16:52:15', '2022-08-15 17:15:24');
INSERT INTO `menu` VALUES (17, 6, ' 查看门户', NULL, '/visual/preview/index', 'preview/:spaceId', '', '', 'visual:preview', 'menu', 1, 0, '', 2, 0, '', 'admin', 'admin', '2022-08-19 14:53:20', '2023-11-21 16:28:58');
INSERT INTO `menu` VALUES (18, 3, 'test', 'test', 'test', 'test', '', '', 'llm_test', 'menu', 1, 1, 'AirplaneOutline', 2, 0, 'test', 'admin', 'admin', '2023-11-21 15:38:20', '2023-11-21 15:38:20');
INSERT INTO `menu` VALUES (19, 6, '页面设计', NULL, '/visual/page/index', 'page/:spaceId', '', '', 'visual:page', 'menu', 1, 0, '', 4, 0, '报表设计', 'admin', 'admin', '2022-08-19 15:12:01', '2022-08-30 11:18:40');
INSERT INTO `menu` VALUES (20, 6, '权限管理', NULL, '/visual/permission/index', 'permission/:spaceId', '', '', 'visual:permission', 'menu', 1, 0, '', 5, 0, '', 'admin', 'admin', '2022-08-19 15:14:12', '2022-08-30 11:18:35');
INSERT INTO `menu` VALUES (21, 8, '用户查询', NULL, '', '', NULL, NULL, 'right:user:query', 'button', 0, 0, '', 1, 0, '', 'admin', 'admin', '2022-05-23 14:25:32', '2022-05-23 14:58:40');
INSERT INTO `menu` VALUES (22, 8, '用户新增', NULL, '', '', NULL, NULL, 'right:user:add', 'button', 0, 0, '', 2, 0, '', 'admin', 'admin', '2022-05-23 14:28:27', '2022-05-23 14:58:53');
INSERT INTO `menu` VALUES (23, 8, '用户修改', NULL, '', '', NULL, NULL, 'right:user:edit', 'button', 0, 0, '', 3, 0, '', 'admin', 'admin', '2022-05-23 14:28:45', '2022-05-23 14:59:03');
INSERT INTO `menu` VALUES (24, 8, '用户删除', NULL, '', '', NULL, NULL, 'right:user:delete', 'button', 0, 0, '', 4, 0, '', 'admin', 'admin', '2022-05-23 14:29:14', '2022-05-23 14:59:14');
INSERT INTO `menu` VALUES (25, 9, '角色查询', NULL, '', '', NULL, NULL, 'system_role_query', 'button', 0, 0, '', 3, 0, '', 'admin', 'admin', '2022-06-08 16:44:56', '2022-06-30 11:00:58');
INSERT INTO `menu` VALUES (26, 9, '角色新增', NULL, '', '', NULL, NULL, 'system_role_add', 'button', 0, 0, '', 4, 0, '', 'admin', 'admin', '2022-06-08 16:45:27', '2022-06-30 11:01:26');
INSERT INTO `menu` VALUES (27, 9, '角色修改', NULL, '', '', NULL, NULL, 'system_role_edit', 'button', 0, 0, '', 5, 0, '', 'admin', 'admin', '2022-06-08 16:45:53', '2022-06-30 11:01:34');
INSERT INTO `menu` VALUES (28, 9, '角色删除', NULL, '', '', NULL, NULL, 'system_role_delete', 'button', 0, 0, '', 6, 0, '', 'admin', 'admin', '2022-06-08 16:46:18', '2022-06-30 11:01:44');
INSERT INTO `menu` VALUES (29, 9, '分配用户', NULL, 'system/role/role-user', 'user', NULL, NULL, 'system_role_user', 'action', 1, 0, '', 2, 0, '', 'admin', 'admin', '2022-06-08 16:48:01', '2023-11-23 11:11:39');
INSERT INTO `menu` VALUES (30, 10, '菜单新增', NULL, '', 'list', '', NULL, 'system_menu_add', 'action', 1, 0, '', 1, 0, '', 'admin', 'admin', '2022-06-29 16:19:21', '2023-11-23 11:10:27');
INSERT INTO `menu` VALUES (31, 10, '菜单删除', '', '', '', '', '', 'system_menu_delete', 'action', 0, 0, '', 3, 0, '', 'admin', 'admin', '2023-11-21 21:00:38', '2023-11-23 11:31:55');
INSERT INTO `menu` VALUES (32, 10, '菜单编辑', '', '', '', '', '', 'system_menu_edit', 'action', 0, 0, '', 2, 0, '', 'admin', 'admin', '2023-11-23 11:30:47', '2023-11-23 11:30:47');
INSERT INTO `menu` VALUES (33, 10, '菜单查询', '', '', '', '', '', 'system_menu_query', 'action', 0, 0, '', 4, 0, '', 'admin', 'admin', '2023-11-23 11:33:03', '2023-11-23 11:34:02');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员', 'admin', 1, 0, '超级管理员', 'admin', 'admin', '2021-11-02 10:37:56', '2023-11-14 17:15:19');
INSERT INTO `role` VALUES (2, '客人', 'guest', 2, 0, '客人', 'admin', 'admin', '2021-11-02 10:38:34', '2023-11-14 17:15:29');
INSERT INTO `role` VALUES (3, 'test2', 'test', 3, 0, 'test', 'admin', 'admin', '2021-11-02 17:17:12', '2023-11-13 15:39:20');
INSERT INTO `role` VALUES (16, 'test', 'test2', 4, 0, 'test2', 'admin', 'admin', '2023-11-14 17:15:44', '2023-11-14 17:15:44');
INSERT INTO `role` VALUES (17, '0', '0', 0, -1, '', 'admin', 'admin', '2023-11-14 17:18:43', '2023-11-14 20:02:41');

-- ----------------------------
-- Table structure for role_dept
-- ----------------------------
DROP TABLE IF EXISTS `role_dept`;
CREATE TABLE `role_dept`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `dept_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`dept_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (1, 1);
INSERT INTO `role_menu` VALUES (1, 2);
INSERT INTO `role_menu` VALUES (1, 3);
INSERT INTO `role_menu` VALUES (1, 4);
INSERT INTO `role_menu` VALUES (1, 5);
INSERT INTO `role_menu` VALUES (1, 6);
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
INSERT INTO `role_menu` VALUES (1, 17);
INSERT INTO `role_menu` VALUES (1, 18);
INSERT INTO `role_menu` VALUES (1, 19);
INSERT INTO `role_menu` VALUES (1, 20);
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
INSERT INTO `role_menu` VALUES (2, 12);

-- ----------------------------
-- Table structure for role_user
-- ----------------------------
DROP TABLE IF EXISTS `role_user`;
CREATE TABLE `role_user`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_user
-- ----------------------------
INSERT INTO `role_user` VALUES (1, 1);
INSERT INTO `role_user` VALUES (2, 1);
INSERT INTO `role_user` VALUES (3, 2);
INSERT INTO `role_user` VALUES (3, 3);

-- ----------------------------
-- Table structure for space
-- ----------------------------
DROP TABLE IF EXISTS `space`;
CREATE TABLE `space`  (
  `space_id` bigint NOT NULL AUTO_INCREMENT,
  `space_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint NOT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`space_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '可视化工作空间' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of space
-- ----------------------------
INSERT INTO `space` VALUES (1, 'a', 0, 'a', 'admin', 'admin', '2022-08-16 18:39:11', '2022-08-16 18:39:11');
INSERT INTO `space` VALUES (2, 'b', -1, '2', 'admin', 'admin', '2022-08-17 10:36:56', '2022-08-17 15:01:30');
INSERT INTO `space` VALUES (3, 'c', -1, 'c', 'admin', 'admin', '2022-08-17 10:40:37', '2022-08-17 15:02:04');
INSERT INTO `space` VALUES (4, 'd', 1, 'd', 'admin', 'admin', '2022-08-17 10:41:00', '2022-08-17 15:55:59');
INSERT INTO `space` VALUES (5, 'e', 0, 'e', 'admin', 'admin', '2022-08-17 10:44:59', '2022-08-17 10:44:59');
INSERT INTO `space` VALUES (6, 'f', 0, 'f', 'admin', 'admin', '2022-08-17 10:45:49', '2022-08-17 10:45:49');
INSERT INTO `space` VALUES (7, 'g', 0, 'g', 'admin', 'admin', '2022-08-17 10:47:05', '2022-08-17 10:47:05');
INSERT INTO `space` VALUES (8, 'h', 0, 'h', 'admin', 'admin', '2022-08-17 10:48:20', '2022-08-17 10:48:20');
INSERT INTO `space` VALUES (9, 'i', 0, 'i', 'admin', 'admin', '2022-08-17 10:48:53', '2022-08-17 10:48:53');
INSERT INTO `space` VALUES (10, 'j', 0, 'j', 'admin', 'admin', '2022-08-17 10:52:26', '2022-08-17 10:52:26');
INSERT INTO `space` VALUES (11, 'k', 0, 'k', 'admin', 'admin', '2022-08-17 10:53:18', '2022-08-17 10:53:18');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `dept_id` bigint NULL DEFAULT NULL,
  `user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `chinese_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `avatar` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `salt` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `login_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `login_date` datetime NOT NULL,
  `status` tinyint NULL DEFAULT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `updated_user` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 1, 'admin', '超级管理员', 'admin@lmc.com', '12345678901', '1', 'admin', '$2b$10$bgJ1x5CdyFAbt13v4.efFOT51F2Gxeg/C7xdfrdciDkgeayZPzl2K', '', '127.0.0.1', '2021-10-22 09:54:19', 0, '超级管理员', 'admin', 'admin', '2021-10-22 09:54:19', '2022-05-30 16:06:27');
INSERT INTO `user` VALUES (2, 2, 'ouyangguoling', '欧阳国灵', 'ouyangguoling@lingmengcan.tech', '18026927766', '1', '', '$2b$10$HSLQgyJdfKYo0EhVpx2PgOU.r0qLtTFeuARlo.3LF6hzhuAM4t4se', NULL, NULL, '2022-05-30 16:10:55', 0, '', 'admin', 'admin', '2022-05-30 16:10:55', '2022-05-30 17:25:29');
INSERT INTO `user` VALUES (3, 2, 'test', '测试1', 'test@lingmengcan.tech', '12345678902', '0', '', '$2b$10$CJ/2mrG1m/zZCz9xb8lKQ.7hwNLBTT284s4u3cMivFItM95fBJU9y', NULL, NULL, '2022-05-30 17:23:33', 0, '', 'admin', 'admin', '2022-05-30 17:23:33', '2022-07-08 18:32:05');

SET FOREIGN_KEY_CHECKS = 1;
