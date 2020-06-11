/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : web

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 11/06/2020 14:30:58
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
) ENGINE = MyISAM AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
-- Table structure for garage
-- ----------------------------
DROP TABLE IF EXISTS `garage`;
CREATE TABLE `garage`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `village_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of garage
-- ----------------------------
INSERT INTO `garage` VALUES (1, '3号车库', 7, 1);
INSERT INTO `garage` VALUES (3, '1号车库', 0, 1);

-- ----------------------------
-- Table structure for manger_message
-- ----------------------------
DROP TABLE IF EXISTS `manger_message`;
CREATE TABLE `manger_message`  (
  `manger_message_id` int(11) NOT NULL AUTO_INCREMENT,
  `manger_id` int(11) NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ctime` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`manger_message_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manger_message
-- ----------------------------
INSERT INTO `manger_message` VALUES (1, 1, '10点小区停电', 1590718853);
INSERT INTO `manger_message` VALUES (2, 1, '11点小区停水', 1590718867);

-- ----------------------------
-- Table structure for manger_village
-- ----------------------------
DROP TABLE IF EXISTS `manger_village`;
CREATE TABLE `manger_village`  (
  `manger_id` int(11) NOT NULL,
  `village_id` int(11) NOT NULL,
  `manger_village_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`manger_village_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of manger_village
-- ----------------------------
INSERT INTO `manger_village` VALUES (1, 1, 1);
INSERT INTO `manger_village` VALUES (3, 2, 14);
INSERT INTO `manger_village` VALUES (2, 3, 13);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mess
-- ----------------------------
INSERT INTO `mess` VALUES (1, '你好，想咨询一下', 40, 78, 1549680009, 0);
INSERT INTO `mess` VALUES (2, '你什么时候有空', 40, 78, 1549680119, 0);
INSERT INTO `mess` VALUES (3, '老师，请问报报什么时候交？', 78, 40, 1549680119, 0);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `manger_message_id` int(11) NULL DEFAULT NULL,
  `message_from` int(11) NULL DEFAULT NULL,
  `village_id` int(11) NULL DEFAULT NULL,
  `message_to` int(255) NULL DEFAULT NULL,
  `type` tinyint(2) NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(2) NULL DEFAULT NULL,
  `ctime` int(11) NULL DEFAULT NULL,
  `owner_message_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (34, 2, 1, 1, 3, 0, '11点小区停水', 0, 1590718867, NULL);
INSERT INTO `message` VALUES (33, 2, 1, 1, 2, 0, '11点小区停水', 0, 1590718867, NULL);
INSERT INTO `message` VALUES (30, 1, 1, 1, 2, 0, '10点小区停电', 0, 1590718853, NULL);
INSERT INTO `message` VALUES (29, 1, 1, 1, 1, 0, '10点小区停电', 0, 1590718853, NULL);
INSERT INTO `message` VALUES (32, 2, 1, 1, 1, 0, '11点小区停水', 1, 1590718867, NULL);
INSERT INTO `message` VALUES (31, 1, 1, 1, 3, 0, '10点小区停电', 0, 1590718853, NULL);
INSERT INTO `message` VALUES (35, NULL, 1, 1, 1, 1, '漏水了', 0, 1590718853, 1);

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
-- Table structure for owner
-- ----------------------------
DROP TABLE IF EXISTS `owner`;
CREATE TABLE `owner`  (
  `owner_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `owner_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `owner_tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `owner_village` int(255) NULL DEFAULT NULL,
  `owner_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `owner_certification` tinyint(2) NOT NULL DEFAULT 0,
  `ctime` int(11) NULL DEFAULT NULL,
  `owner_balance` int(11) NOT NULL DEFAULT 0,
  `owner_request` tinyint(2) NOT NULL DEFAULT 1,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`owner_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of owner
-- ----------------------------
INSERT INTO `owner` VALUES (1, '邹涵', '934b535800b1cba8f96a5d72f72f1611', '15238173707', 1, '15栋108', 1, 1555514460, 50, 1, '/uploads/20200530/5b130e9b63976bc93b3ed95a08230209.jpg');
INSERT INTO `owner` VALUES (6, '游客1', '934b535800b1cba8f96a5d72f72f1611', '15238173707', 1, '108', 0, NULL, 0, 1, '/uploads/20200530/fca63a5664af8078c3dc01f3a2def64d.jpg');
INSERT INTO `owner` VALUES (5, '用户1', 'c4ca4238a0b923820dcc509a6f75849b', '13849779372', 1, '108', 1, 1590823169, 0, 1, NULL);

-- ----------------------------
-- Table structure for park
-- ----------------------------
DROP TABLE IF EXISTS `park`;
CREATE TABLE `park`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `village_id` int(11) NULL DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `garage_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of park
-- ----------------------------
INSERT INTO `park` VALUES (1, 1, 0, 3);
INSERT INTO `park` VALUES (5, 1, 1, 1);
INSERT INTO `park` VALUES (6, 1, 1, 1);
INSERT INTO `park` VALUES (15, 1, 1, 1);
INSERT INTO `park` VALUES (14, 1, 0, 1);
INSERT INTO `park` VALUES (11, 1, 0, 1);
INSERT INTO `park` VALUES (12, 1, 0, 1);
INSERT INTO `park` VALUES (13, 1, 0, 1);

-- ----------------------------
-- Table structure for pay
-- ----------------------------
DROP TABLE IF EXISTS `pay`;
CREATE TABLE `pay`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` int(255) NULL DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay
-- ----------------------------
INSERT INTO `pay` VALUES (3, 1, '季度水费', 100, 1, 1590763974);
INSERT INTO `pay` VALUES (4, 1, '季度', 10, 1, 1590773637);

-- ----------------------------
-- Table structure for property_manger
-- ----------------------------
DROP TABLE IF EXISTS `property_manger`;
CREATE TABLE `property_manger`  (
  `manger_id` int(11) NOT NULL AUTO_INCREMENT,
  `manger_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `manger_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `manger_tel` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `manger_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `login_time` int(11) NULL DEFAULT NULL,
  `manger_permission` tinyint(2) NOT NULL DEFAULT 1,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`manger_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of property_manger
-- ----------------------------
INSERT INTO `property_manger` VALUES (1, '刘军东', '934b535800b1cba8f96a5d72f72f1611', '1384977937', '河南省南阳市唐河', 1591714685, 1, '/uploads/20200530/ea69fb1fcef50e801f9139f8e306abe1.jpeg');
INSERT INTO `property_manger` VALUES (3, '李梦洋', '', '13849779372', '108', NULL, 1, NULL);
INSERT INTO `property_manger` VALUES (2, '吴登权', 'c4ca4238a0b923820dcc509a6f75849b', '13849779372', '111', NULL, 1, NULL);

-- ----------------------------
-- Table structure for property_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `property_sys_log`;
CREATE TABLE `property_sys_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manger_id` int(11) NULL DEFAULT NULL,
  `manger_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ctime` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '[系统] 操作日志' ROW_FORMAT = Dynamic;

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
) ENGINE = MyISAM AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `sys_menu` VALUES (41, '', '物业系统管理', 'layui-icon-console', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (42, '/ljd/villages/index', '小区管理', '', 41, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (44, '/ljd/user/index', '用户管理', '', 41, 2, 1, 1);
INSERT INTO `sys_menu` VALUES (45, '/ljd/log/index', '日志管理', '', 41, 3, 1, 1);
INSERT INTO `sys_menu` VALUES (46, '', '物业系统', 'layui-icon-console', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (47, '/wdq/info/index', '物业信息管理', '', 46, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (48, '/wdq/pay/index', '物业费管理', '', 46, 2, 1, 1);
INSERT INTO `sys_menu` VALUES (49, '', '车位系统', 'layui-icon-release', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (50, '/wdq/park/index', '车位信息管理', '', 49, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (51, '/wdq/order/index', '预订管理', '', 49, 2, 1, 1);
INSERT INTO `sys_menu` VALUES (52, '', '用户系统', 'layui-icon-set', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (53, '/wdq/user/index', '用户管理', '', 52, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (54, '/wdq/check/index', '审核管理', '', 52, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (55, '', '信息发布系统', 'layui-icon-circle-dot', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (56, '/wdq/announcement/index', '公告管理', '', 55, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (57, '/wdq/feedback/index', '反馈建议管理', '', 55, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (58, '', '物业系统', 'layui-icon-set', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (59, '', '信息系统', 'layui-icon-circle-dot', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (61, '/zouhan/info/index', '物业信息管理', '', 58, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (62, '/zouhan/pay/index', '物业费管理', '', 58, 2, 1, 1);
INSERT INTO `sys_menu` VALUES (63, '/zouhan/order/index', '车位预订管理', '', 58, 3, 1, 1);
INSERT INTO `sys_menu` VALUES (64, '/zouhan/announce/index', '公告管理', '', 59, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (65, '/zouhan/feedback/index', '反馈建议管理', '', 59, 2, 1, 1);
INSERT INTO `sys_menu` VALUES (66, '', '车位预订', 'layui-icon-release', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (67, '/tourist/order/index', '车位预订管理', '', 66, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (68, '/wdq/garage/index', '车库管理', '', 49, 1, 1, 1);

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
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', '1,2,9,6,21,24,25,26');
INSERT INTO `sys_role` VALUES (2, '老师', 'teacher', '1,2,9');
INSERT INTO `sys_role` VALUES (13, '管理员', 'manager', '38,39,40,');
INSERT INTO `sys_role` VALUES (14, '物业系统管理员', 'system admin', '41,42,44,45,');
INSERT INTO `sys_role` VALUES (15, '小区物业管理员', 'village admin', '46,47,48,49,50,51,68,52,53,54,55,56,57,');
INSERT INTO `sys_role` VALUES (16, '业主', 'owner', '58,61,62,63,59,64,65,');
INSERT INTO `sys_role` VALUES (17, '游客', 'tourist', '66,67,');

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
) ENGINE = MyISAM AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '1', 'c4ca4238a0b923820dcc509a6f75849b', 1, '41', '曾辉', '男', '/uploads/20200428/ebb1190bf15a21bca984b097f1ca2e38.jpg', '241', 1591244641, 1);
INSERT INTO `sys_user` VALUES (58, 'zh1', 'c4ca4238a0b923820dcc509a6f75849b', 2, NULL, '曾辉', '', NULL, NULL, 1586738157, 1);
INSERT INTO `sys_user` VALUES (66, 'zh', 'c4ca4238a0b923820dcc509a6f75849b', 13, NULL, '', '', NULL, NULL, 1590758289, 1);
INSERT INTO `sys_user` VALUES (68, 'ljd', 'c4ca4238a0b923820dcc509a6f75849b', 14, NULL, '刘军东', '', '/uploads/20200530/377656e4da67680481dfaaaa7d1424e6.jpeg', NULL, 1591704928, 1);
INSERT INTO `sys_user` VALUES (69, 'wdq', 'c4ca4238a0b923820dcc509a6f75849b', 15, NULL, '刘军东', '', NULL, NULL, 1590653648, 1);
INSERT INTO `sys_user` VALUES (70, 'zhdd', 'c4ca4238a0b923820dcc509a6f75849b', 16, NULL, '邹涵', '', NULL, NULL, 1590759465, 1);
INSERT INTO `sys_user` VALUES (71, '游客', 'c4ca4238a0b923820dcc509a6f75849b', 17, NULL, '游客', '', NULL, NULL, 1590823842, 1);

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NULL DEFAULT NULL,
  `park_id` int(11) NULL DEFAULT NULL,
  `time` int(11) NULL DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `endtime` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES (1, 1, 1, 1555514499, 1, 1591243559);
INSERT INTO `t_order` VALUES (2, 1, 1, 1555514499, 1, 1591243559);
INSERT INTO `t_order` VALUES (3, 1, 6, 1590768856, 1, 1591243559);
INSERT INTO `t_order` VALUES (4, 1, 1, 1590769104, 1, 1591243559);
INSERT INTO `t_order` VALUES (5, 1, 1, 1590769109, 1, 1591243559);
INSERT INTO `t_order` VALUES (6, 1, 1, 1590769219, 1, 1591243559);
INSERT INTO `t_order` VALUES (7, 1, 5, 1590769224, 1, 1591243559);
INSERT INTO `t_order` VALUES (9, 4, 1, 1590809422, 1, 1591243559);
INSERT INTO `t_order` VALUES (10, 4, 1, 1590809914, 1, 1591243559);
INSERT INTO `t_order` VALUES (11, 4, 1, 1590810140, 1, 1591243559);
INSERT INTO `t_order` VALUES (17, 1, 14, 1591602639, 1, 1591602643);
INSERT INTO `t_order` VALUES (15, 6, 14, 1591602344, 1, 1591243559);
INSERT INTO `t_order` VALUES (16, 6, 14, 1591602357, 1, 1591602411);

-- ----------------------------
-- Table structure for village
-- ----------------------------
DROP TABLE IF EXISTS `village`;
CREATE TABLE `village`  (
  `village_id` int(11) NOT NULL AUTO_INCREMENT,
  `village_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `village_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `village_households_num` int(11) NOT NULL DEFAULT 0,
  `village_parking_num` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`village_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of village
-- ----------------------------
INSERT INTO `village` VALUES (1, '清华园', '河南省南阳市唐河县', 18, 20);
INSERT INTO `village` VALUES (2, '雅典阳光', '河南省南阳市唐河', 20, 20);
INSERT INTO `village` VALUES (3, '港岛', '大唐路110号', 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
