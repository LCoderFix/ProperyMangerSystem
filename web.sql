/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : 127.0.0.1:3306
 Source Schema         : web

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 19/05/2020 15:07:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NULL DEFAULT NULL,
  `book_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`book_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (28, 1, '6666');
INSERT INTO `book` VALUES (5, 1, 'C++语言');
INSERT INTO `book` VALUES (6, 1, '离散数学');
INSERT INTO `book` VALUES (7, 1, '计算机网络');
INSERT INTO `book` VALUES (10, 1, '中国经济学');
INSERT INTO `book` VALUES (11, 1, 'PHP基础');

-- ----------------------------
-- Table structure for book_type
-- ----------------------------
DROP TABLE IF EXISTS `book_type`;
CREATE TABLE `book_type`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_type
-- ----------------------------
INSERT INTO `book_type` VALUES (1, '计算机类1');
INSERT INTO `book_type` VALUES (9, '计算机');
INSERT INTO `book_type` VALUES (11, '游戏类');

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置的key键名',
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置的val值',
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置分组',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'smtp_server', 'smtp.qq.com111', 'smtp');
INSERT INTO `config` VALUES (2, 'smtp_port', '465', 'smtp');
INSERT INTO `config` VALUES (3, 'smtp_user', '331549185@qq.com', 'smtp');
INSERT INTO `config` VALUES (4, 'smtp_pwd', '12017700', 'smtp');
INSERT INTO `config` VALUES (5, 'regis_smtp_enable', '1', 'smtp');
INSERT INTO `config` VALUES (6, 'email_id', '11', 'smtp');

-- ----------------------------
-- Table structure for mess
-- ----------------------------
DROP TABLE IF EXISTS `mess`;
CREATE TABLE `mess`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mess` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `send_id` int(11) NULL DEFAULT NULL,
  `to_id` int(11) NULL DEFAULT NULL,
  `send_time` int(11) NULL DEFAULT NULL,
  `read` tinyint(255) NULL DEFAULT 0 COMMENT '0 未读  1已读',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mess
-- ----------------------------
INSERT INTO `mess` VALUES (1, '你好，想咨询一下', 40, 78, 1549680009, 0);
INSERT INTO `mess` VALUES (2, '你什么时候有空', 40, 78, 1549680119, 0);
INSERT INTO `mess` VALUES (3, '老师，请问报报什么时候交？', 78, 40, 1549680119, 0);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  `status` tinyint(2) NULL DEFAULT 1 COMMENT '1 正常 2至顶  0 隐藏',
  `views` int(11) NULL DEFAULT 0 COMMENT '阅读次数',
  PRIMARY KEY (`news_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (87, 1, NULL, '社会新闻1', '<p>asdfasdfasfd</p><p>asdfasdfasfd</p><p style=\"line-height: 16px;\"><img src=\"http://mytp.com/static/ueditor/dialogs/attachment/fileTypeImages/icon_doc.gif\"/><a style=\"font-size:12px; color:#0066cc;\" href=\"/uploads/20200329/1585489452524431.docx\" title=\"2016版毕业要求.docx\">2016版毕业要求.docx</a></p><p><br/></p>', 1586414643, 1, 0);
INSERT INTO `news` VALUES (88, 18, NULL, '经济新闻1', '<p>asdf00</p><p>asdfasdfasdf</p><p>asdfasdfasdf</p>', 1586414594, 2, 0);
INSERT INTO `news` VALUES (89, 18, NULL, '经济新闻1', '<p>asdfasdfasfd1</p><p>asdfasdfasfd</p><p style=\"line-height: 16px;\"><img src=\"http://mytp.com/static/ueditor/dialogs/attachment/fileTypeImages/icon_doc.gif\"/><a style=\"font-size:12px; color:#0066cc;\" href=\"/uploads/20200329/1585489452524431.docx\" title=\"2016版毕业要求.docx\">2016版毕业要求.docx</a></p><p><br/></p>', 1586414632, 0, 0);
INSERT INTO `news` VALUES (92, 2, NULL, '体育新闻1', '<p>99</p>', 1586414575, 1, 0);

-- ----------------------------
-- Table structure for news_type
-- ----------------------------
DROP TABLE IF EXISTS `news_type`;
CREATE TABLE `news_type`  (
  `type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news_type
-- ----------------------------
INSERT INTO `news_type` VALUES (1, '社会新闻');
INSERT INTO `news_type` VALUES (2, '体育新闻');
INSERT INTO `news_type` VALUES (18, '经济新闻');
INSERT INTO `news_type` VALUES (20, '娱乐新闻');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `param` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `ctime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '[系统] 操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (49, 7, '3', '用户管理', '/admin/user/index.html', '{\"page\":\"1\",\"limit\":\"10\"}', '', '127.0.0.1', 1555514460);
INSERT INTO `sys_log` VALUES (51, 7, '3', '新闻管理', '/admin/news/index.html', '{\"page\":\"1\",\"limit\":\"10\"}', '', '127.0.0.1', 1556027796);
INSERT INTO `sys_log` VALUES (53, 7, '3', '类别管理', '/admin/news/type.html', '[]', '', '127.0.0.1', 1556028294);
INSERT INTO `sys_log` VALUES (54, 7, '3', '类别管理', '/admin/news/type.html', '{\"page\":\"1\",\"limit\":\"10\"}', '', '127.0.0.1', 1556028294);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `url` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `parent_id` int(5) NOT NULL DEFAULT 0 COMMENT '父栏目ID',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `visible` tinyint(1) NULL DEFAULT 1 COMMENT '是否可见',
  `open` tinyint(1) NULL DEFAULT 1 COMMENT '1',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '', '系统功能', 'layui-icon-set', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (2, '/admin/menu/index', '菜单管理', '', 1, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (9, '/admin/role/index', '角色管理', '', 1, 3, 1, 1);
INSERT INTO `sys_menu` VALUES (6, '/admin/user/index', '用户管理', 'layui-icon-home', 1, 2, 1, 1);
INSERT INTO `sys_menu` VALUES (25, '/admin/news/index', '新闻列表', '', 24, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (24, '', '新闻管理', 'layui-icon-date', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (26, '/admin/news_type/index', '新闻类别', '', 24, 2, 1, 1);
INSERT INTO `sys_menu` VALUES (38, '', '图书管理', 'layui-icon-read', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (39, '/w1/books/index', '图书列表', '', 38, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (40, '/w1/books/type', '图书类别', '', 38, 2, 1, 1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `role_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', '1,2,9,6,21,24,25,26');
INSERT INTO `sys_role` VALUES (2, '老师', 'teacher', '1,2,9');
INSERT INTO `sys_role` VALUES (13, '管理员', 'manager', '38,39,40,');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `role_id` mediumint(8) NULL DEFAULT NULL COMMENT '角色ID',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `realname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `gender` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `login_time` int(11) NULL DEFAULT NULL COMMENT '最后登录时间',
  `status` tinyint(2) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `user_username`(`username`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 68 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '1', 'c4ca4238a0b923820dcc509a6f75849b', 1, '41', '曾辉', '男', '/uploads/20200428/ebb1190bf15a21bca984b097f1ca2e38.jpg', '241', 1589422701, 1);
INSERT INTO `sys_user` VALUES (58, 'zh1', 'c4ca4238a0b923820dcc509a6f75849b', 2, NULL, '曾辉', '', NULL, NULL, 1586738157, 1);
INSERT INTO `sys_user` VALUES (66, 'zh', 'c4ca4238a0b923820dcc509a6f75849b', 13, NULL, '', '', NULL, NULL, 1589869453, 1);

SET FOREIGN_KEY_CHECKS = 1;
