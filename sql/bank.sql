/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50642
 Source Host           : localhost:3306
 Source Schema         : bank

 Target Server Type    : MySQL
 Target Server Version : 50642
 File Encoding         : 65001

 Date: 28/06/2019 18:33:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gurt_bank
-- ----------------------------
DROP TABLE IF EXISTS `gurt_bank`;
CREATE TABLE `gurt_bank`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bankName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_bank
-- ----------------------------
INSERT INTO `gurt_bank` VALUES (1, '福田分行');
INSERT INTO `gurt_bank` VALUES (2, '龙华分行');

-- ----------------------------
-- Table structure for gurt_category
-- ----------------------------
DROP TABLE IF EXISTS `gurt_category`;
CREATE TABLE `gurt_category`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类目名称',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注说明',
  `create_user_id` bigint(11) NOT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除(0 否; 1 是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目基础资料' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_category
-- ----------------------------
INSERT INTO `gurt_category` VALUES (0, '默认', '默认使用', 1, '2019-06-24 14:38:22', 0);
INSERT INTO `gurt_category` VALUES (34, '测试类目1', NULL, 1, NULL, 0);

-- ----------------------------
-- Table structure for gurt_guarantee
-- ----------------------------
DROP TABLE IF EXISTS `gurt_guarantee`;
CREATE TABLE `gurt_guarantee`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `guarantee_file_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '保函文件路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '保函' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_guarantee
-- ----------------------------
INSERT INTO `gurt_guarantee` VALUES (1, '保函一', '备注', '');
INSERT INTO `gurt_guarantee` VALUES (2, '保函二', '备注', '');
INSERT INTO `gurt_guarantee` VALUES (3, '保函三', '备注', '');
INSERT INTO `gurt_guarantee` VALUES (4, '保函五', '备注', 'http://localhost/profile/upload/2019/06/21/ff30e59e3d8da7eebd603ac0a962a47d.xls');
INSERT INTO `gurt_guarantee` VALUES (6, '保函四', '备注', 'http://localhost/profile/upload/2019/06/21/d0f8cc9220dec8a5e8b585d11fbe01d6.docx');

-- ----------------------------
-- Table structure for gurt_invite_commission
-- ----------------------------
DROP TABLE IF EXISTS `gurt_invite_commission`;
CREATE TABLE `gurt_invite_commission`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(11) NOT NULL,
  `commission_amount` bigint(255) NOT NULL DEFAULT 0,
  `status` bigint(20) NOT NULL DEFAULT 0 COMMENT '状态(0 未支付; 1 已支付)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_gurt_invite_commission_gurt_order_1`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邀请提成' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_invite_commission
-- ----------------------------
INSERT INTO `gurt_invite_commission` VALUES (1, 1, 30, 0);
INSERT INTO `gurt_invite_commission` VALUES (20, 30, 2400, 0);
INSERT INTO `gurt_invite_commission` VALUES (21, 18, 5850, 0);

-- ----------------------------
-- Table structure for gurt_order
-- ----------------------------
DROP TABLE IF EXISTS `gurt_order`;
CREATE TABLE `gurt_order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `warrantee` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '被保证人',
  `beneficiary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '受益人',
  `project_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目编号',
  `project_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  `closing_time` datetime(0) NOT NULL COMMENT '截标日期',
  `guarantee_amount` bigint(20) NOT NULL COMMENT '担保金额',
  `validity_deadline` datetime(6) NOT NULL COMMENT '有效期',
  `guarantee_id` bigint(20) NOT NULL COMMENT '保函格式',
  `bank_id` bigint(20) NOT NULL COMMENT '贷款银行',
  `project_type_id` bigint(20) NOT NULL COMMENT '项目分类',
  `amount` bigint(20) NOT NULL DEFAULT 0 COMMENT '应付金额',
  `create_user_id` bigint(11) NOT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `bank_submission_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `status` bigint(20) NOT NULL DEFAULT 0 COMMENT '订单状态(0 待提交; 1 待接收; 2 待处理; 3 已提交银行; 4 已撤销)',
  `need_invoice` bigint(20) NOT NULL DEFAULT 0 COMMENT '是否需要开发票(0 否, 1 是)',
  `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tax_number` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bank_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bank_account` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `company_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone_number` bigint(20) NULL DEFAULT NULL,
  `invoice_file_download_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发票文件下载地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_gurt_order_gurt_guarantee_1`(`guarantee_id`) USING BTREE,
  INDEX `ab`(`project_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_order
-- ----------------------------
INSERT INTO `gurt_order` VALUES (18, '测试客户1有邀请人1提成', '测试', '测试', '测试', '2012-01-01 00:00:00', 21000, '2012-02-01 00:00:00.000000', 1, 1, 10, 1500, 2, '2019-06-28 18:23:29', '2019-06-28 18:33:08', 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gurt_order` VALUES (19, '测试客户1有邀请人1无提成	', '测试', '测试', '测试', '2012-01-01 00:00:00', 1000, '2012-02-01 00:00:00.000000', 1, 1, 10, 1000, 1, '2019-06-28 18:03:04', '2019-06-28 18:04:26', 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gurt_order` VALUES (23, '文件', '文件1', '文件', '文件', '2012-01-01 00:00:00', 1000, '2012-02-01 00:00:00.000000', 2, 2, 10, 1000, 1, '2019-06-28 16:04:28', '2019-06-28 16:04:40', 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gurt_order` VALUES (24, '123', '231', '123', '213', '2012-01-01 00:00:00', 1000, '2012-02-01 00:00:00.000000', 1, 1, 10, 1000, 1, '2019-06-28 16:04:28', '2019-06-28 16:04:41', 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gurt_order` VALUES (25, '测试文件', '测试文件', '文件', '测试文件', '2012-01-01 00:00:00', 10001, '2012-02-01 00:00:00.000000', 1, 1, 10, 800, 1, '2019-06-28 16:04:28', '2019-06-28 16:04:41', 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gurt_order` VALUES (26, '已收金额测试', '已收金额测试', '已收金额测试', '已收金额测试', '2012-01-01 00:00:00', 20001, '2012-02-01 00:00:00.000000', 3, 2, 11, 450, 1, '2019-06-28 16:04:29', '2019-06-28 16:04:42', 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gurt_order` VALUES (29, '测试152', '测试152', '测试152', '测试152', '2012-01-01 00:00:00', 1000, '2012-02-01 00:00:00.000000', 1, 1, 10, 1000, 98, '2019-06-28 16:04:29', '2019-06-28 16:04:42', 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gurt_order` VALUES (30, '123', '123', '123', '123', '2012-01-01 00:00:00', 9000, '2012-02-01 00:00:00.000000', 2, 1, 10, 1000, 98, '2019-06-28 18:32:39', '2019-06-28 18:32:50', 3, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for gurt_order_file
-- ----------------------------
DROP TABLE IF EXISTS `gurt_order_file`;
CREATE TABLE `gurt_order_file`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_user_id` bigint(20) NOT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `file_download_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `deleted` bigint(20) NOT NULL DEFAULT 0,
  `order_id` bigint(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_gurt_order_file_gurt_order_1`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_order_file
-- ----------------------------
INSERT INTO `gurt_order_file` VALUES (9, '2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx', 1, NULL, 'http://localhost/profile/upload/2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx', 0, 12);
INSERT INTO `gurt_order_file` VALUES (10, '2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx', 1, NULL, 'http://localhost/profile/upload/2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx', 0, 12);
INSERT INTO `gurt_order_file` VALUES (11, '2019/06/25/fef651dad4c66416a1cd0eb81c499b62.png', 1, NULL, 'http://localhost/profile/upload/2019/06/25/fef651dad4c66416a1cd0eb81c499b62.png', 0, 13);
INSERT INTO `gurt_order_file` VALUES (12, '2019/06/25/41fa36fd47167d526a0bbaa3f0666c62.xls', 1, NULL, 'http://localhost/profile/upload/2019/06/25/41fa36fd47167d526a0bbaa3f0666c62.xls', 0, 14);
INSERT INTO `gurt_order_file` VALUES (13, '2019/06/25/31c8dc5b2e4ea9f2cfeebbf72838d95a.png', 1, NULL, 'http://localhost/profile/upload/2019/06/25/31c8dc5b2e4ea9f2cfeebbf72838d95a.png', 0, 15);
INSERT INTO `gurt_order_file` VALUES (14, '2019/06/25/5fc982b066a5cd58176ff9625bc01011.png', 1, NULL, 'http://localhost/profile/upload/2019/06/25/5fc982b066a5cd58176ff9625bc01011.png', 0, 16);
INSERT INTO `gurt_order_file` VALUES (15, '2019/06/25/07e50ba9bea0e157103923feb4bae8d1.png', 1, NULL, 'http://localhost/profile/upload/2019/06/25/07e50ba9bea0e157103923feb4bae8d1.png', 0, 17);
INSERT INTO `gurt_order_file` VALUES (16, '2019/06/25/eb7b6641b365cd9fa7d4e51289c77d26.docx', 1, NULL, 'http://localhost/profile/upload/2019/06/25/eb7b6641b365cd9fa7d4e51289c77d26.docx', 0, 17);
INSERT INTO `gurt_order_file` VALUES (17, '2019/06/25/b334bc6acd9a8d2bb7459dfbd0fef43b.xls', 1, NULL, 'http://localhost/profile/upload/2019/06/25/b334bc6acd9a8d2bb7459dfbd0fef43b.xls', 0, 17);
INSERT INTO `gurt_order_file` VALUES (19, '2019/06/25/24d299e5bda6daee51a316c8d146e570.png', 2, NULL, 'http://localhost/profile/upload/2019/06/25/24d299e5bda6daee51a316c8d146e570.png', 0, 18);
INSERT INTO `gurt_order_file` VALUES (20, '2019/06/25/4e8d0633c8bd332153184359ca5373ba.docx', 1, NULL, 'http://localhost/profile/upload/2019/06/25/4e8d0633c8bd332153184359ca5373ba.docx', 0, 19);
INSERT INTO `gurt_order_file` VALUES (21, 'file', 1, NULL, 'http://localhost/profile/upload/2019/06/26/d5b116500a79bbcdd8ed69ba9ff5195b.xlsx', 0, 20);
INSERT INTO `gurt_order_file` VALUES (22, 'file', 1, NULL, 'http://localhost/profile/upload/2019/06/26/8f609649a0a98bfb9805576a0af61901.png', 0, 21);
INSERT INTO `gurt_order_file` VALUES (23, 'file', 1, NULL, 'http://localhost/profile/upload/2019/06/26/e9259d2bef235ec71da0ff075f361ee7.xls', 0, 21);
INSERT INTO `gurt_order_file` VALUES (24, '加班申请及打卡规则.docx', 1, NULL, 'http://localhost/profile/upload/2019/06/26/2d8a11ace46a312b5d4f9e6107fb7701.docx', 0, 21);
INSERT INTO `gurt_order_file` VALUES (25, '问题.xlsx', 1, NULL, 'http://localhost/profile/upload/2019/06/26/7b2cb73359e6d5b58f7eff4f74d057cf.xlsx', 0, 22);
INSERT INTO `gurt_order_file` VALUES (26, '名片-0626_画板 1 副本.png', 1, NULL, 'http://localhost/profile/upload/2019/06/26/ee1c5b337b6559dd0d7471a1e1107cfd.png', 0, 22);
INSERT INTO `gurt_order_file` VALUES (27, '保函格式十三份_2_.docx', 1, NULL, 'http://localhost/profile/upload/2019/06/26/2c9faa22ee545a9626dc5a25467d1507.docx', 0, 23);
INSERT INTO `gurt_order_file` VALUES (28, '1', 1, NULL, '1', 0, 0);
INSERT INTO `gurt_order_file` VALUES (29, '', 0, NULL, '', 0, 0);
INSERT INTO `gurt_order_file` VALUES (30, '#{name}', 0, '2019-06-26 09:40:08', '#{fileDownLoadUrl}', 0, 0);
INSERT INTO `gurt_order_file` VALUES (31, '个人所得税通知.docx', 1, '2019-06-26 09:41:24', 'http://localhost/profile/upload/2019/06/26/50898428a10fa12ad3eeb424a88cec73.docx', 0, 24);
INSERT INTO `gurt_order_file` VALUES (45, '加班申请及打卡规则.docx', 1, '2019-06-26 16:25:25', 'http://localhost/profile/upload/2019/06/26/ce11dde8fd4673009fbc7e13b9fa9b0a.docx', 0, 26);
INSERT INTO `gurt_order_file` VALUES (46, '名片-0626_画板 1 副本.png', 1, '2019-06-26 16:25:38', 'http://localhost/profile/upload/2019/06/26/0b11cf70b58b552d07f1d8fe83d5ebe3.png', 0, 26);
INSERT INTO `gurt_order_file` VALUES (47, '问题.xlsx', 1, '2019-06-26 16:25:38', 'http://localhost/profile/upload/2019/06/26/d92bae45bd27a42f5a6983b7297ef18a.xlsx', 0, 26);
INSERT INTO `gurt_order_file` VALUES (62, '名片-0626_画板 1 副本.png', 1, '2019-06-27 09:43:06', 'http://localhost/profile/upload/2019/06/27/6e57e0e0dc27010f9b5a016bfe6add1b.png', 0, 25);
INSERT INTO `gurt_order_file` VALUES (63, '后台样式0516.xls', 1, '2019-06-27 09:43:06', 'http://localhost/profile/upload/2019/06/27/8b41ff451bbe9e4c93741897b8caa84e.xls', 0, 25);
INSERT INTO `gurt_order_file` VALUES (64, '问题.xlsx', 1, '2019-06-27 09:43:06', 'http://localhost/profile/upload/2019/06/27/a2a164a3b14ffa6c724221c88e224a84.xlsx', 0, 25);
INSERT INTO `gurt_order_file` VALUES (65, '个人所得税通知.docx', 1, '2019-06-27 09:43:06', 'http://localhost/profile/upload/2019/06/27/2fa9483c3612d819ebacf23439d17868.docx', 0, 25);
INSERT INTO `gurt_order_file` VALUES (71, '后台样式0516.xls', 98, '2019-06-28 14:46:16', 'http://localhost/profile/upload/2019/06/28/047249863c4ad228f0fd05044c4465cb.xls', 0, 29);
INSERT INTO `gurt_order_file` VALUES (72, '名片-0626_画板 1 副本.png', 98, '2019-06-28 14:46:16', 'http://localhost/profile/upload/2019/06/28/a2534a3240270f46906e41bcddafa2a1.png', 0, 29);
INSERT INTO `gurt_order_file` VALUES (73, '问题.xlsx', 98, '2019-06-28 14:46:16', 'http://localhost/profile/upload/2019/06/28/59c252c2374e6df4edd2aaee14a3a5e3.xlsx', 0, 29);
INSERT INTO `gurt_order_file` VALUES (74, '加班申请及打卡规则.docx', 98, '2019-06-28 14:46:16', 'http://localhost/profile/upload/2019/06/28/b1b48fb446f844941471ccbd5c463d90.docx', 0, 29);
INSERT INTO `gurt_order_file` VALUES (75, '问题.xlsx', 98, '2019-06-28 18:29:51', 'http://localhost/profile/upload/2019/06/28/e54eb38fefb80ba68817e47832e1b37c.xlsx', 0, 30);

-- ----------------------------
-- Table structure for gurt_order_payment_record
-- ----------------------------
DROP TABLE IF EXISTS `gurt_order_payment_record`;
CREATE TABLE `gurt_order_payment_record`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(11) NOT NULL,
  `paid_amount` bigint(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_gurt_order_payment_record_gurt_order_1`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_order_payment_record
-- ----------------------------
INSERT INTO `gurt_order_payment_record` VALUES (1, 12, 100);
INSERT INTO `gurt_order_payment_record` VALUES (2, 13, 11);
INSERT INTO `gurt_order_payment_record` VALUES (3, 14, 3);
INSERT INTO `gurt_order_payment_record` VALUES (4, 15, 1);
INSERT INTO `gurt_order_payment_record` VALUES (5, 16, 1111);
INSERT INTO `gurt_order_payment_record` VALUES (6, 17, 100);
INSERT INTO `gurt_order_payment_record` VALUES (39, 26, 1000);
INSERT INTO `gurt_order_payment_record` VALUES (40, 26, 2000);
INSERT INTO `gurt_order_payment_record` VALUES (41, 26, 300);
INSERT INTO `gurt_order_payment_record` VALUES (42, 26, 400);
INSERT INTO `gurt_order_payment_record` VALUES (43, 25, 100);
INSERT INTO `gurt_order_payment_record` VALUES (44, 18, 100);
INSERT INTO `gurt_order_payment_record` VALUES (45, 18, 200);

-- ----------------------------
-- Table structure for gurt_project_type
-- ----------------------------
DROP TABLE IF EXISTS `gurt_project_type`;
CREATE TABLE `gurt_project_type`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类目名称',
  `category_id` bigint(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `asdass`(`category_id`) USING BTREE,
  CONSTRAINT `asdass` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目名称' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_project_type
-- ----------------------------
INSERT INTO `gurt_project_type` VALUES (10, '市政', 0);
INSERT INTO `gurt_project_type` VALUES (11, '交通', 0);

-- ----------------------------
-- Table structure for gurt_project_type_cost_config
-- ----------------------------
DROP TABLE IF EXISTS `gurt_project_type_cost_config`;
CREATE TABLE `gurt_project_type_cost_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_type_id` bigint(20) NOT NULL,
  `starting_amount` bigint(20) NOT NULL,
  `ending_amount` bigint(20) NOT NULL,
  `single_payment_cost` bigint(20) NOT NULL,
  `single_payment_count_type` tinyint(2) NOT NULL DEFAULT 0 COMMENT '成本计算方式(0 元, 1 %)',
  `multiple_payment_cost` bigint(20) NOT NULL,
  `multiple_payment_count_type` tinyint(2) NOT NULL DEFAULT 0 COMMENT '成本计算方式(0 元, 1 %)',
  `category_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `a`(`category_id`) USING BTREE,
  INDEX `b`(`project_type_id`) USING BTREE,
  CONSTRAINT `a` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `b` FOREIGN KEY (`project_type_id`) REFERENCES `gurt_project_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目分类' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_project_type_cost_config
-- ----------------------------
INSERT INTO `gurt_project_type_cost_config` VALUES (22, 10, 0, 10000, 1000, 0, 350, 0, 0);
INSERT INTO `gurt_project_type_cost_config` VALUES (23, 11, 0, 10000, 400, 0, 350, 0, 0);
INSERT INTO `gurt_project_type_cost_config` VALUES (24, 11, 20000, 30000, 450, 0, 400, 0, 0);
INSERT INTO `gurt_project_type_cost_config` VALUES (25, 11, 30000, 40000, 500, 0, 450, 0, 0);
INSERT INTO `gurt_project_type_cost_config` VALUES (26, 10, 0, 10000, 500, 0, 350, 0, 34);
INSERT INTO `gurt_project_type_cost_config` VALUES (27, 11, 0, 10000, 400, 0, 350, 0, 34);
INSERT INTO `gurt_project_type_cost_config` VALUES (28, 11, 20000, 30000, 450, 0, 400, 0, 34);
INSERT INTO `gurt_project_type_cost_config` VALUES (29, 11, 30000, 40000, 500, 0, 450, 0, 34);
INSERT INTO `gurt_project_type_cost_config` VALUES (30, 10, 20000, 30000, 1500, 0, 1000, 0, 0);
INSERT INTO `gurt_project_type_cost_config` VALUES (31, 10, 10000, 20000, 800, 0, 700, 0, 0);

-- ----------------------------
-- Table structure for gurt_shezhi
-- ----------------------------
DROP TABLE IF EXISTS `gurt_shezhi`;
CREATE TABLE `gurt_shezhi`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cb` double(11, 1) NULL DEFAULT NULL,
  `starttime` datetime(0) NULL DEFAULT NULL,
  `endtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_shezhi
-- ----------------------------
INSERT INTO `gurt_shezhi` VALUES (13, 0.3, '0000-00-00 08:00:00', '0000-00-00 10:00:00');
INSERT INTO `gurt_shezhi` VALUES (14, 0.3, '0000-00-00 14:00:00', '0000-00-00 16:00:00');
INSERT INTO `gurt_shezhi` VALUES (15, 0.3, '0000-00-00 18:00:00', '0000-00-00 22:00:00');

-- ----------------------------
-- Table structure for gurt_status
-- ----------------------------
DROP TABLE IF EXISTS `gurt_status`;
CREATE TABLE `gurt_status`  (
  `id` int(11) NOT NULL,
  `statusName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_status
-- ----------------------------
INSERT INTO `gurt_status` VALUES (0, '待提交');
INSERT INTO `gurt_status` VALUES (1, '待接收');
INSERT INTO `gurt_status` VALUES (2, '待处理');
INSERT INTO `gurt_status` VALUES (3, '已提交银行');
INSERT INTO `gurt_status` VALUES (4, '已撤销');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `blob_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200094C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000A6D6574686F644E616D6571007E00094C000C6D6574686F64506172616D7371007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001622CDE29E078707400007070707400013174000E302F3130202A202A202A202A203F740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC897372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000174000672795461736B74000A72794E6F506172616D7374000074000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200094C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000A6D6574686F644E616D6571007E00094C000C6D6574686F64506172616D7371007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001622CDE29E078707400007070707400013174000E302F3230202A202A202A202A203F740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC897372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000274000672795461736B7400087279506172616D73740002727974000133740001317800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'SC-2019013111271561717859467', 1561718001590, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `int_prop_1` int(11) NULL DEFAULT NULL,
  `int_prop_2` int(11) NULL DEFAULT NULL,
  `long_prop_1` bigint(20) NULL DEFAULT NULL,
  `long_prop_2` bigint(20) NULL DEFAULT NULL,
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_fire_time` bigint(13) NULL DEFAULT NULL,
  `prev_fire_time` bigint(13) NULL DEFAULT NULL,
  `priority` int(11) NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint(2) NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1561717860000, -1, 5, 'PAUSED', 'CRON', 1561717859000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1561717860000, -1, 5, 'PAUSED', 'CRON', 1561717859000, 0, NULL, 2, '');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '初始化密码 123456');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统默认是');
INSERT INTO `sys_dict_data` VALUES (11, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统默认否');
INSERT INTO `sys_dict_data` VALUES (12, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知');
INSERT INTO `sys_dict_data` VALUES (13, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '公告');
INSERT INTO `sys_dict_data` VALUES (14, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES (15, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '关闭状态');
INSERT INTO `sys_dict_data` VALUES (16, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '新增操作');
INSERT INTO `sys_dict_data` VALUES (17, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '修改操作');
INSERT INTO `sys_dict_data` VALUES (18, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '删除操作');
INSERT INTO `sys_dict_data` VALUES (19, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '授权操作');
INSERT INTO `sys_dict_data` VALUES (20, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '导出操作');
INSERT INTO `sys_dict_data` VALUES (21, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '导入操作');
INSERT INTO `sys_dict_data` VALUES (22, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '强退操作');
INSERT INTO `sys_dict_data` VALUES (23, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '生成操作');
INSERT INTO `sys_dict_data` VALUES (24, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '清空操作');
INSERT INTO `sys_dict_data` VALUES (25, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '正常状态');
INSERT INTO `sys_dict_data` VALUES (26, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '系统是否', 'sys_yes_no', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (6, '通知类型', 'sys_notice_type', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知状态', 'sys_notice_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (8, '操作类型', 'sys_oper_type', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (9, '系统状态', 'sys_common_status', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务组名',
  `method_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '任务方法',
  `method_params` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法参数',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, 'ryTask', '系统默认（无参）', 'ryNoParams', '', '0/10 * * * * ?', '3', '1', '1', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_job` VALUES (2, 'ryTask', '系统默认（有参）', 'ryParams', 'ry', '0/20 * * * * ?', '3', '1', '1', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `method_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务方法',
  `method_params` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法参数',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `ipaddr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 547 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-26 17:46:37');
INSERT INTO `sys_logininfor` VALUES (2, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-26 17:58:59');
INSERT INTO `sys_logininfor` VALUES (3, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-26 17:59:03');
INSERT INTO `sys_logininfor` VALUES (4, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-26 18:00:38');
INSERT INTO `sys_logininfor` VALUES (5, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-26 18:03:28');
INSERT INTO `sys_logininfor` VALUES (6, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-26 18:09:10');
INSERT INTO `sys_logininfor` VALUES (7, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-26 18:16:15');
INSERT INTO `sys_logininfor` VALUES (8, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-26 18:16:17');
INSERT INTO `sys_logininfor` VALUES (9, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-26 18:48:24');
INSERT INTO `sys_logininfor` VALUES (10, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-26 18:50:49');
INSERT INTO `sys_logininfor` VALUES (11, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-26 18:50:53');
INSERT INTO `sys_logininfor` VALUES (12, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 09:08:12');
INSERT INTO `sys_logininfor` VALUES (13, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 09:08:21');
INSERT INTO `sys_logininfor` VALUES (14, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:12:11');
INSERT INTO `sys_logininfor` VALUES (15, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:12:12');
INSERT INTO `sys_logininfor` VALUES (16, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:12:13');
INSERT INTO `sys_logininfor` VALUES (17, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:12:15');
INSERT INTO `sys_logininfor` VALUES (18, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 09:12:20');
INSERT INTO `sys_logininfor` VALUES (19, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:12:25');
INSERT INTO `sys_logininfor` VALUES (20, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:12:26');
INSERT INTO `sys_logininfor` VALUES (21, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:40:30');
INSERT INTO `sys_logininfor` VALUES (22, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 09:40:33');
INSERT INTO `sys_logininfor` VALUES (23, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 09:55:07');
INSERT INTO `sys_logininfor` VALUES (24, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:55:10');
INSERT INTO `sys_logininfor` VALUES (25, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 09:55:12');
INSERT INTO `sys_logininfor` VALUES (26, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:56:01');
INSERT INTO `sys_logininfor` VALUES (27, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 09:56:04');
INSERT INTO `sys_logininfor` VALUES (28, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 09:56:08');
INSERT INTO `sys_logininfor` VALUES (29, 'admin', '192.168.43.1', '内网IP', 'Chrome Mobile', 'Android Mobile', '0', '登录成功', '2019-06-27 10:13:54');
INSERT INTO `sys_logininfor` VALUES (30, 'admin', '192.168.43.1', '内网IP', 'Chrome Mobile', 'Android Mobile', '0', '退出成功', '2019-06-27 10:14:29');
INSERT INTO `sys_logininfor` VALUES (31, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 10:15:32');
INSERT INTO `sys_logininfor` VALUES (32, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 10:15:35');
INSERT INTO `sys_logininfor` VALUES (33, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 10:22:25');
INSERT INTO `sys_logininfor` VALUES (34, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 11:07:05');
INSERT INTO `sys_logininfor` VALUES (35, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 11:16:20');
INSERT INTO `sys_logininfor` VALUES (36, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 11:16:23');
INSERT INTO `sys_logininfor` VALUES (37, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 11:17:40');
INSERT INTO `sys_logininfor` VALUES (38, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 11:17:41');
INSERT INTO `sys_logininfor` VALUES (39, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 11:19:58');
INSERT INTO `sys_logininfor` VALUES (40, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 11:20:03');
INSERT INTO `sys_logininfor` VALUES (41, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 11:26:17');
INSERT INTO `sys_logininfor` VALUES (42, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 11:36:59');
INSERT INTO `sys_logininfor` VALUES (43, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 11:37:01');
INSERT INTO `sys_logininfor` VALUES (44, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 11:37:42');
INSERT INTO `sys_logininfor` VALUES (45, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 11:37:44');
INSERT INTO `sys_logininfor` VALUES (46, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 11:40:34');
INSERT INTO `sys_logininfor` VALUES (47, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 11:40:37');
INSERT INTO `sys_logininfor` VALUES (48, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 11:40:39');
INSERT INTO `sys_logininfor` VALUES (49, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 11:40:41');
INSERT INTO `sys_logininfor` VALUES (50, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 11:42:21');
INSERT INTO `sys_logininfor` VALUES (51, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 11:42:23');
INSERT INTO `sys_logininfor` VALUES (52, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:44:23');
INSERT INTO `sys_logininfor` VALUES (53, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:46:20');
INSERT INTO `sys_logininfor` VALUES (54, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 13:47:09');
INSERT INTO `sys_logininfor` VALUES (55, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:47:17');
INSERT INTO `sys_logininfor` VALUES (56, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 13:47:21');
INSERT INTO `sys_logininfor` VALUES (57, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:47:24');
INSERT INTO `sys_logininfor` VALUES (58, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:47:46');
INSERT INTO `sys_logininfor` VALUES (59, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 13:48:18');
INSERT INTO `sys_logininfor` VALUES (60, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:48:23');
INSERT INTO `sys_logininfor` VALUES (61, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 13:49:40');
INSERT INTO `sys_logininfor` VALUES (62, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:49:41');
INSERT INTO `sys_logininfor` VALUES (63, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 13:49:53');
INSERT INTO `sys_logininfor` VALUES (64, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:49:58');
INSERT INTO `sys_logininfor` VALUES (65, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:50:36');
INSERT INTO `sys_logininfor` VALUES (66, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 13:53:56');
INSERT INTO `sys_logininfor` VALUES (67, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:02:48');
INSERT INTO `sys_logininfor` VALUES (68, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:02:50');
INSERT INTO `sys_logininfor` VALUES (69, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:04:10');
INSERT INTO `sys_logininfor` VALUES (70, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:04:24');
INSERT INTO `sys_logininfor` VALUES (71, 'admin', '192.168.43.60', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:12:04');
INSERT INTO `sys_logininfor` VALUES (72, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:13:51');
INSERT INTO `sys_logininfor` VALUES (73, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:28:07');
INSERT INTO `sys_logininfor` VALUES (74, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:34:52');
INSERT INTO `sys_logininfor` VALUES (75, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:36:54');
INSERT INTO `sys_logininfor` VALUES (76, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:36:55');
INSERT INTO `sys_logininfor` VALUES (77, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:38:29');
INSERT INTO `sys_logininfor` VALUES (78, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:38:31');
INSERT INTO `sys_logininfor` VALUES (79, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:40:54');
INSERT INTO `sys_logininfor` VALUES (80, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:46:31');
INSERT INTO `sys_logininfor` VALUES (81, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:46:56');
INSERT INTO `sys_logininfor` VALUES (82, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:47:24');
INSERT INTO `sys_logininfor` VALUES (83, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:47:24');
INSERT INTO `sys_logininfor` VALUES (84, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:47:25');
INSERT INTO `sys_logininfor` VALUES (85, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:47:28');
INSERT INTO `sys_logininfor` VALUES (86, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:47:31');
INSERT INTO `sys_logininfor` VALUES (87, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:47:34');
INSERT INTO `sys_logininfor` VALUES (88, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:47:37');
INSERT INTO `sys_logininfor` VALUES (89, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:47:49');
INSERT INTO `sys_logininfor` VALUES (90, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:47:56');
INSERT INTO `sys_logininfor` VALUES (91, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:48:12');
INSERT INTO `sys_logininfor` VALUES (92, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:48:15');
INSERT INTO `sys_logininfor` VALUES (93, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:48:28');
INSERT INTO `sys_logininfor` VALUES (94, '1', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:48:38');
INSERT INTO `sys_logininfor` VALUES (95, '1', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:48:41');
INSERT INTO `sys_logininfor` VALUES (96, '1', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:48:43');
INSERT INTO `sys_logininfor` VALUES (97, '1', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 14:48:44');
INSERT INTO `sys_logininfor` VALUES (98, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:49:39');
INSERT INTO `sys_logininfor` VALUES (99, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:49:41');
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:49:43');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:50:40');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:50:42');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-27 14:50:48');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:52:39');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:52:40');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:52:42');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:52:44');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:53:01');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:53:04');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:53:17');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:53:24');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:53:44');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 14:53:47');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 14:53:54');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:54:18');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:54:25');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:54:27');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 14:59:27');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 15:01:46');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 15:03:47');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-27 15:10:54');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:14:24');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:20:53');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:21:00');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:21:07');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-27 15:21:10');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误2次', '2019-06-27 15:21:12');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:21:14');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:21:36');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 15:23:04');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:25:03');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:32:43');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:33:27');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:33:31');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:35:07');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:35:14');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:38:12');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:38:52');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:39:01');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:39:03');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:41:13');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:41:19');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:41:21');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:41:43');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:42:13');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:42:28');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:42:32');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:42:38');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:42:49');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:43:36');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:43:40');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:43:42');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:43:48');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:44:30');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:48:01');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:48:07');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:48:15');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:49:48');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:49:57');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:50:04');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:50:48');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:51:27');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:51:31');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:51:34');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:51:42');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:51:50');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:52:09');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:52:45');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:53:04');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:53:54');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:54:29');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:54:35');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:55:02');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:55:18');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-27 15:55:32');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:56:03');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:56:11');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:57:26');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 15:57:45');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:58:07');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 15:58:24');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:58:33');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 15:59:50');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 15:59:53');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-27 15:59:55');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误2次', '2019-06-27 15:59:56');
INSERT INTO `sys_logininfor` VALUES (187, 'admin3', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 15:59:58');
INSERT INTO `sys_logininfor` VALUES (188, 'admin3', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 16:00:00');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 16:00:32');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 16:04:04');
INSERT INTO `sys_logininfor` VALUES (191, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 16:04:07');
INSERT INTO `sys_logininfor` VALUES (192, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 16:04:11');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 16:04:12');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 16:09:54');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 16:14:31');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 16:15:23');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 16:17:41');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 16:19:29');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 16:23:16');
INSERT INTO `sys_logininfor` VALUES (200, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:12:26');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:13:55');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:14:01');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:14:14');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:14:35');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:14:40');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:15:25');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:15:27');
INSERT INTO `sys_logininfor` VALUES (208, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:15:34');
INSERT INTO `sys_logininfor` VALUES (209, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:16:05');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:16:07');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:16:12');
INSERT INTO `sys_logininfor` VALUES (212, 'manager', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:16:16');
INSERT INTO `sys_logininfor` VALUES (213, 'manager', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:16:20');
INSERT INTO `sys_logininfor` VALUES (214, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:16:26');
INSERT INTO `sys_logininfor` VALUES (215, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:17:00');
INSERT INTO `sys_logininfor` VALUES (216, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:17:03');
INSERT INTO `sys_logininfor` VALUES (217, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:19:35');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:19:38');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:19:57');
INSERT INTO `sys_logininfor` VALUES (220, 'ry', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:19:59');
INSERT INTO `sys_logininfor` VALUES (221, 'ry', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:20:09');
INSERT INTO `sys_logininfor` VALUES (222, 'ma', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 17:20:12');
INSERT INTO `sys_logininfor` VALUES (223, 'manager', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:20:14');
INSERT INTO `sys_logininfor` VALUES (224, 'manager', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:20:19');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:20:22');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:21:27');
INSERT INTO `sys_logininfor` VALUES (227, 'manager', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:21:31');
INSERT INTO `sys_logininfor` VALUES (228, 'manager', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:21:37');
INSERT INTO `sys_logininfor` VALUES (229, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:21:43');
INSERT INTO `sys_logininfor` VALUES (230, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:21:50');
INSERT INTO `sys_logininfor` VALUES (231, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:21:53');
INSERT INTO `sys_logininfor` VALUES (232, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:24:29');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:24:40');
INSERT INTO `sys_logininfor` VALUES (234, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:24:43');
INSERT INTO `sys_logininfor` VALUES (235, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:27:02');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:27:36');
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:27:48');
INSERT INTO `sys_logininfor` VALUES (238, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:27:51');
INSERT INTO `sys_logininfor` VALUES (239, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:31:57');
INSERT INTO `sys_logininfor` VALUES (240, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:32:16');
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:32:22');
INSERT INTO `sys_logininfor` VALUES (242, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:32:25');
INSERT INTO `sys_logininfor` VALUES (243, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:32:32');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:38:28');
INSERT INTO `sys_logininfor` VALUES (245, '444', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 17:38:39');
INSERT INTO `sys_logininfor` VALUES (246, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:39:07');
INSERT INTO `sys_logininfor` VALUES (247, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:39:09');
INSERT INTO `sys_logininfor` VALUES (248, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:39:34');
INSERT INTO `sys_logininfor` VALUES (249, '123123', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:39:41');
INSERT INTO `sys_logininfor` VALUES (250, '123123', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:40:08');
INSERT INTO `sys_logininfor` VALUES (251, '111111', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:40:27');
INSERT INTO `sys_logininfor` VALUES (252, '111111', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:40:30');
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:41:13');
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:43:45');
INSERT INTO `sys_logininfor` VALUES (255, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:45:09');
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:45:22');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:49:32');
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:49:43');
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:49:50');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:49:55');
INSERT INTO `sys_logininfor` VALUES (261, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:50:00');
INSERT INTO `sys_logininfor` VALUES (262, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 17:50:03');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:50:20');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:51:03');
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:51:34');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:52:25');
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:52:58');
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:58:57');
INSERT INTO `sys_logininfor` VALUES (269, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 17:59:42');
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:01:04');
INSERT INTO `sys_logininfor` VALUES (271, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:01:10');
INSERT INTO `sys_logininfor` VALUES (272, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:02:40');
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:03:05');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:03:18');
INSERT INTO `sys_logininfor` VALUES (275, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:05:32');
INSERT INTO `sys_logininfor` VALUES (276, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:06:00');
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:06:18');
INSERT INTO `sys_logininfor` VALUES (278, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:06:24');
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:06:54');
INSERT INTO `sys_logininfor` VALUES (280, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:07:03');
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:07:11');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:07:31');
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:07:39');
INSERT INTO `sys_logininfor` VALUES (284, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:07:41');
INSERT INTO `sys_logininfor` VALUES (285, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:08:08');
INSERT INTO `sys_logininfor` VALUES (286, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:09:02');
INSERT INTO `sys_logininfor` VALUES (287, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:09:26');
INSERT INTO `sys_logininfor` VALUES (288, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:09:30');
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:10:14');
INSERT INTO `sys_logininfor` VALUES (290, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:10:41');
INSERT INTO `sys_logininfor` VALUES (291, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:10:48');
INSERT INTO `sys_logininfor` VALUES (292, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:10:59');
INSERT INTO `sys_logininfor` VALUES (293, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:11:18');
INSERT INTO `sys_logininfor` VALUES (294, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:11:25');
INSERT INTO `sys_logininfor` VALUES (295, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:11:30');
INSERT INTO `sys_logininfor` VALUES (296, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:11:35');
INSERT INTO `sys_logininfor` VALUES (297, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:11:39');
INSERT INTO `sys_logininfor` VALUES (298, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 18:18:39');
INSERT INTO `sys_logininfor` VALUES (299, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:19:27');
INSERT INTO `sys_logininfor` VALUES (300, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:20:07');
INSERT INTO `sys_logininfor` VALUES (301, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:21:27');
INSERT INTO `sys_logininfor` VALUES (302, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:22:45');
INSERT INTO `sys_logininfor` VALUES (303, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:22:50');
INSERT INTO `sys_logininfor` VALUES (304, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:23:20');
INSERT INTO `sys_logininfor` VALUES (305, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 18:24:13');
INSERT INTO `sys_logininfor` VALUES (306, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:24:54');
INSERT INTO `sys_logininfor` VALUES (307, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:25:06');
INSERT INTO `sys_logininfor` VALUES (308, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:25:10');
INSERT INTO `sys_logininfor` VALUES (309, '4555555', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:25:22');
INSERT INTO `sys_logininfor` VALUES (310, '121414124', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:25:37');
INSERT INTO `sys_logininfor` VALUES (311, '6666666666666', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:26:11');
INSERT INTO `sys_logininfor` VALUES (312, '123123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:26:47');
INSERT INTO `sys_logininfor` VALUES (313, '54645656', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:27:01');
INSERT INTO `sys_logininfor` VALUES (314, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:46:01');
INSERT INTO `sys_logininfor` VALUES (315, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:46:21');
INSERT INTO `sys_logininfor` VALUES (316, '1412412', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:46:31');
INSERT INTO `sys_logininfor` VALUES (317, '12312344', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:46:44');
INSERT INTO `sys_logininfor` VALUES (318, '444444', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:47:40');
INSERT INTO `sys_logininfor` VALUES (319, '1214342', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:47:55');
INSERT INTO `sys_logininfor` VALUES (320, '1214342', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:48:05');
INSERT INTO `sys_logininfor` VALUES (321, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:54:20');
INSERT INTO `sys_logininfor` VALUES (322, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:54:30');
INSERT INTO `sys_logininfor` VALUES (323, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:54:42');
INSERT INTO `sys_logininfor` VALUES (324, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:54:53');
INSERT INTO `sys_logininfor` VALUES (325, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:54:57');
INSERT INTO `sys_logininfor` VALUES (326, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '* 必须填写', '2019-06-27 18:54:59');
INSERT INTO `sys_logininfor` VALUES (327, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:55:18');
INSERT INTO `sys_logininfor` VALUES (328, '421412412', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:55:25');
INSERT INTO `sys_logininfor` VALUES (329, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:56:23');
INSERT INTO `sys_logininfor` VALUES (330, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:56:52');
INSERT INTO `sys_logininfor` VALUES (331, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:57:11');
INSERT INTO `sys_logininfor` VALUES (332, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:57:28');
INSERT INTO `sys_logininfor` VALUES (333, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:57:31');
INSERT INTO `sys_logininfor` VALUES (334, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:57:35');
INSERT INTO `sys_logininfor` VALUES (335, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:57:37');
INSERT INTO `sys_logininfor` VALUES (336, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:57:39');
INSERT INTO `sys_logininfor` VALUES (337, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:57:43');
INSERT INTO `sys_logininfor` VALUES (338, '666666', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:58:26');
INSERT INTO `sys_logininfor` VALUES (339, '666666', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:58:29');
INSERT INTO `sys_logininfor` VALUES (340, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:58:34');
INSERT INTO `sys_logininfor` VALUES (341, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:58:36');
INSERT INTO `sys_logininfor` VALUES (342, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 18:58:44');
INSERT INTO `sys_logininfor` VALUES (343, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 18:58:50');
INSERT INTO `sys_logininfor` VALUES (344, '15273011111', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:00:20');
INSERT INTO `sys_logininfor` VALUES (345, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:00:41');
INSERT INTO `sys_logininfor` VALUES (346, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:00:43');
INSERT INTO `sys_logininfor` VALUES (347, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:00:46');
INSERT INTO `sys_logininfor` VALUES (348, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '* 必须填写', '2019-06-27 19:00:49');
INSERT INTO `sys_logininfor` VALUES (349, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:00:51');
INSERT INTO `sys_logininfor` VALUES (350, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:00:56');
INSERT INTO `sys_logininfor` VALUES (351, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:01:04');
INSERT INTO `sys_logininfor` VALUES (352, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:01:11');
INSERT INTO `sys_logininfor` VALUES (353, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-27 19:01:15');
INSERT INTO `sys_logininfor` VALUES (354, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误2次', '2019-06-27 19:01:21');
INSERT INTO `sys_logininfor` VALUES (355, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:13:29');
INSERT INTO `sys_logininfor` VALUES (356, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:13:34');
INSERT INTO `sys_logininfor` VALUES (357, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:13:44');
INSERT INTO `sys_logininfor` VALUES (358, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:13:46');
INSERT INTO `sys_logininfor` VALUES (359, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:13:49');
INSERT INTO `sys_logininfor` VALUES (360, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:13:52');
INSERT INTO `sys_logininfor` VALUES (361, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:16:57');
INSERT INTO `sys_logininfor` VALUES (362, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:16:59');
INSERT INTO `sys_logininfor` VALUES (363, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:17:07');
INSERT INTO `sys_logininfor` VALUES (364, '12434234', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:17:22');
INSERT INTO `sys_logininfor` VALUES (365, '12434234', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:17:26');
INSERT INTO `sys_logininfor` VALUES (366, '44444444', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:17:52');
INSERT INTO `sys_logininfor` VALUES (367, '44444444', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:18:00');
INSERT INTO `sys_logininfor` VALUES (368, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:18:03');
INSERT INTO `sys_logininfor` VALUES (369, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:18:05');
INSERT INTO `sys_logininfor` VALUES (370, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:18:10');
INSERT INTO `sys_logininfor` VALUES (371, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:18:19');
INSERT INTO `sys_logininfor` VALUES (372, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-27 19:18:21');
INSERT INTO `sys_logininfor` VALUES (373, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:18:26');
INSERT INTO `sys_logininfor` VALUES (374, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:18:27');
INSERT INTO `sys_logininfor` VALUES (375, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-27 19:18:29');
INSERT INTO `sys_logininfor` VALUES (376, '121414', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误2次', '2019-06-27 19:18:32');
INSERT INTO `sys_logininfor` VALUES (377, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:23:47');
INSERT INTO `sys_logininfor` VALUES (378, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:23:59');
INSERT INTO `sys_logininfor` VALUES (379, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-27 19:24:40');
INSERT INTO `sys_logininfor` VALUES (380, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误2次', '2019-06-27 19:24:43');
INSERT INTO `sys_logininfor` VALUES (381, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误3次', '2019-06-27 19:24:46');
INSERT INTO `sys_logininfor` VALUES (382, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误4次', '2019-06-27 19:24:56');
INSERT INTO `sys_logininfor` VALUES (383, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误5次', '2019-06-27 19:25:00');
INSERT INTO `sys_logininfor` VALUES (384, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2019-06-27 19:25:04');
INSERT INTO `sys_logininfor` VALUES (385, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2019-06-27 19:25:07');
INSERT INTO `sys_logininfor` VALUES (386, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:28:44');
INSERT INTO `sys_logininfor` VALUES (387, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:28:56');
INSERT INTO `sys_logininfor` VALUES (388, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:29:01');
INSERT INTO `sys_logininfor` VALUES (389, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:29:05');
INSERT INTO `sys_logininfor` VALUES (390, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:29:09');
INSERT INTO `sys_logininfor` VALUES (391, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:29:35');
INSERT INTO `sys_logininfor` VALUES (392, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:30:35');
INSERT INTO `sys_logininfor` VALUES (393, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:30:44');
INSERT INTO `sys_logininfor` VALUES (394, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:30:57');
INSERT INTO `sys_logininfor` VALUES (395, '152730116361', '192.168.0.80', '内网IP', 'Internet Explorer 11', 'Windows 10', '0', '登录成功', '2019-06-27 19:31:52');
INSERT INTO `sys_logininfor` VALUES (396, '152730116361', '192.168.0.80', '内网IP', 'Internet Explorer 11', 'Windows 10', '0', '退出成功', '2019-06-27 19:31:59');
INSERT INTO `sys_logininfor` VALUES (397, 'admin', '192.168.0.80', '内网IP', 'Internet Explorer 11', 'Windows 10', '1', '密码输入错误1次', '2019-06-27 19:32:04');
INSERT INTO `sys_logininfor` VALUES (398, 'admin', '192.168.0.80', '内网IP', 'Internet Explorer 11', 'Windows 10', '0', '登录成功', '2019-06-27 19:32:11');
INSERT INTO `sys_logininfor` VALUES (399, 'admin', '192.168.0.80', '内网IP', 'Internet Explorer 11', 'Windows 10', '0', '退出成功', '2019-06-27 19:32:30');
INSERT INTO `sys_logininfor` VALUES (400, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:33:18');
INSERT INTO `sys_logininfor` VALUES (401, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:33:29');
INSERT INTO `sys_logininfor` VALUES (402, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:41:58');
INSERT INTO `sys_logininfor` VALUES (403, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:42:47');
INSERT INTO `sys_logininfor` VALUES (404, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:43:50');
INSERT INTO `sys_logininfor` VALUES (405, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:44:59');
INSERT INTO `sys_logininfor` VALUES (406, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:45:09');
INSERT INTO `sys_logininfor` VALUES (407, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:45:16');
INSERT INTO `sys_logininfor` VALUES (408, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:46:36');
INSERT INTO `sys_logininfor` VALUES (409, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:46:49');
INSERT INTO `sys_logininfor` VALUES (410, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:46:52');
INSERT INTO `sys_logininfor` VALUES (411, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:47:03');
INSERT INTO `sys_logininfor` VALUES (412, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:49:54');
INSERT INTO `sys_logininfor` VALUES (413, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:52:33');
INSERT INTO `sys_logininfor` VALUES (414, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:52:49');
INSERT INTO `sys_logininfor` VALUES (415, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:52:55');
INSERT INTO `sys_logininfor` VALUES (416, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:52:59');
INSERT INTO `sys_logininfor` VALUES (417, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:53:04');
INSERT INTO `sys_logininfor` VALUES (418, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:53:34');
INSERT INTO `sys_logininfor` VALUES (419, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:53:57');
INSERT INTO `sys_logininfor` VALUES (420, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:54:00');
INSERT INTO `sys_logininfor` VALUES (421, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:54:11');
INSERT INTO `sys_logininfor` VALUES (422, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:54:48');
INSERT INTO `sys_logininfor` VALUES (423, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-27 19:54:53');
INSERT INTO `sys_logininfor` VALUES (424, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:54:59');
INSERT INTO `sys_logininfor` VALUES (425, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 19:55:23');
INSERT INTO `sys_logininfor` VALUES (426, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:58:38');
INSERT INTO `sys_logininfor` VALUES (427, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:59:27');
INSERT INTO `sys_logininfor` VALUES (428, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 19:59:45');
INSERT INTO `sys_logininfor` VALUES (429, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 20:00:53');
INSERT INTO `sys_logininfor` VALUES (430, 'admin', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 20:08:36');
INSERT INTO `sys_logininfor` VALUES (431, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 20:08:50');
INSERT INTO `sys_logininfor` VALUES (432, '', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '* 必须填写', '2019-06-27 20:09:05');
INSERT INTO `sys_logininfor` VALUES (433, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 20:10:10');
INSERT INTO `sys_logininfor` VALUES (434, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-27 20:11:03');
INSERT INTO `sys_logininfor` VALUES (435, '15273011636', '192.168.0.80', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-27 20:13:11');
INSERT INTO `sys_logininfor` VALUES (436, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 09:04:32');
INSERT INTO `sys_logininfor` VALUES (437, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 09:04:42');
INSERT INTO `sys_logininfor` VALUES (438, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 09:04:46');
INSERT INTO `sys_logininfor` VALUES (439, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-28 09:04:49');
INSERT INTO `sys_logininfor` VALUES (440, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-28 09:04:53');
INSERT INTO `sys_logininfor` VALUES (441, '123123', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-28 09:04:57');
INSERT INTO `sys_logininfor` VALUES (442, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 09:05:03');
INSERT INTO `sys_logininfor` VALUES (443, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 09:05:08');
INSERT INTO `sys_logininfor` VALUES (444, '152730116361', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-28 09:05:11');
INSERT INTO `sys_logininfor` VALUES (445, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 09:21:09');
INSERT INTO `sys_logininfor` VALUES (446, '15273011636', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 09:21:16');
INSERT INTO `sys_logininfor` VALUES (447, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 09:21:18');
INSERT INTO `sys_logininfor` VALUES (448, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 09:25:16');
INSERT INTO `sys_logininfor` VALUES (449, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '* 必须填写', '2019-06-28 09:35:12');
INSERT INTO `sys_logininfor` VALUES (450, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 09:36:10');
INSERT INTO `sys_logininfor` VALUES (451, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 10:14:09');
INSERT INTO `sys_logininfor` VALUES (452, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 10:21:32');
INSERT INTO `sys_logininfor` VALUES (453, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 10:22:04');
INSERT INTO `sys_logininfor` VALUES (454, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 10:23:06');
INSERT INTO `sys_logininfor` VALUES (455, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 10:23:08');
INSERT INTO `sys_logininfor` VALUES (456, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 10:23:52');
INSERT INTO `sys_logininfor` VALUES (457, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 10:26:53');
INSERT INTO `sys_logininfor` VALUES (458, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-28 10:27:12');
INSERT INTO `sys_logininfor` VALUES (459, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误2次', '2019-06-28 10:27:45');
INSERT INTO `sys_logininfor` VALUES (460, 'admin1', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-28 10:27:48');
INSERT INTO `sys_logininfor` VALUES (461, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 10:44:27');
INSERT INTO `sys_logininfor` VALUES (462, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 10:44:32');
INSERT INTO `sys_logininfor` VALUES (463, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 10:51:31');
INSERT INTO `sys_logininfor` VALUES (464, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 10:52:29');
INSERT INTO `sys_logininfor` VALUES (465, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 10:58:16');
INSERT INTO `sys_logininfor` VALUES (466, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 10:58:19');
INSERT INTO `sys_logininfor` VALUES (467, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 11:04:55');
INSERT INTO `sys_logininfor` VALUES (468, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 11:04:57');
INSERT INTO `sys_logininfor` VALUES (469, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 11:05:15');
INSERT INTO `sys_logininfor` VALUES (470, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 11:05:17');
INSERT INTO `sys_logininfor` VALUES (471, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 11:05:30');
INSERT INTO `sys_logininfor` VALUES (472, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 11:05:33');
INSERT INTO `sys_logininfor` VALUES (473, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 11:05:41');
INSERT INTO `sys_logininfor` VALUES (474, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 11:05:44');
INSERT INTO `sys_logininfor` VALUES (475, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 11:07:26');
INSERT INTO `sys_logininfor` VALUES (476, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 11:07:29');
INSERT INTO `sys_logininfor` VALUES (477, NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '* 必须填写', '2019-06-28 11:12:16');
INSERT INTO `sys_logininfor` VALUES (478, NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '* 必须填写', '2019-06-28 11:27:20');
INSERT INTO `sys_logininfor` VALUES (479, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 11:53:39');
INSERT INTO `sys_logininfor` VALUES (480, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 11:53:51');
INSERT INTO `sys_logininfor` VALUES (481, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 11:53:56');
INSERT INTO `sys_logininfor` VALUES (482, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 11:53:59');
INSERT INTO `sys_logininfor` VALUES (483, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 11:57:25');
INSERT INTO `sys_logininfor` VALUES (484, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 12:02:42');
INSERT INTO `sys_logininfor` VALUES (485, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 13:52:35');
INSERT INTO `sys_logininfor` VALUES (486, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 13:53:33');
INSERT INTO `sys_logininfor` VALUES (487, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:23:21');
INSERT INTO `sys_logininfor` VALUES (488, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:25:06');
INSERT INTO `sys_logininfor` VALUES (489, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:26:28');
INSERT INTO `sys_logininfor` VALUES (490, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:38:41');
INSERT INTO `sys_logininfor` VALUES (491, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:41:18');
INSERT INTO `sys_logininfor` VALUES (492, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:41:29');
INSERT INTO `sys_logininfor` VALUES (493, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:44:26');
INSERT INTO `sys_logininfor` VALUES (494, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:44:27');
INSERT INTO `sys_logininfor` VALUES (495, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:44:36');
INSERT INTO `sys_logininfor` VALUES (496, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:45:57');
INSERT INTO `sys_logininfor` VALUES (497, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:46:21');
INSERT INTO `sys_logininfor` VALUES (498, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:46:23');
INSERT INTO `sys_logininfor` VALUES (499, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:48:07');
INSERT INTO `sys_logininfor` VALUES (500, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:48:30');
INSERT INTO `sys_logininfor` VALUES (501, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:48:31');
INSERT INTO `sys_logininfor` VALUES (502, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:48:58');
INSERT INTO `sys_logininfor` VALUES (503, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:48:59');
INSERT INTO `sys_logininfor` VALUES (504, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:50:50');
INSERT INTO `sys_logininfor` VALUES (505, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:51:53');
INSERT INTO `sys_logininfor` VALUES (506, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 14:52:02');
INSERT INTO `sys_logininfor` VALUES (507, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:52:03');
INSERT INTO `sys_logininfor` VALUES (508, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 14:57:25');
INSERT INTO `sys_logininfor` VALUES (509, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:01:01');
INSERT INTO `sys_logininfor` VALUES (510, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 15:01:03');
INSERT INTO `sys_logininfor` VALUES (511, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:04:03');
INSERT INTO `sys_logininfor` VALUES (512, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 15:04:05');
INSERT INTO `sys_logininfor` VALUES (513, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:04:44');
INSERT INTO `sys_logininfor` VALUES (514, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 15:04:46');
INSERT INTO `sys_logininfor` VALUES (515, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 15:07:54');
INSERT INTO `sys_logininfor` VALUES (516, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 15:09:08');
INSERT INTO `sys_logininfor` VALUES (517, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:09:23');
INSERT INTO `sys_logininfor` VALUES (518, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:09:35');
INSERT INTO `sys_logininfor` VALUES (519, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 15:09:41');
INSERT INTO `sys_logininfor` VALUES (520, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:10:09');
INSERT INTO `sys_logininfor` VALUES (521, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:10:23');
INSERT INTO `sys_logininfor` VALUES (522, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 15:10:25');
INSERT INTO `sys_logininfor` VALUES (523, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:10:32');
INSERT INTO `sys_logininfor` VALUES (524, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:10:44');
INSERT INTO `sys_logininfor` VALUES (525, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 15:10:45');
INSERT INTO `sys_logininfor` VALUES (526, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 15:22:55');
INSERT INTO `sys_logininfor` VALUES (527, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 15:22:57');
INSERT INTO `sys_logininfor` VALUES (528, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 16:03:43');
INSERT INTO `sys_logininfor` VALUES (529, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 16:12:43');
INSERT INTO `sys_logininfor` VALUES (530, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 17:19:44');
INSERT INTO `sys_logininfor` VALUES (531, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 17:23:25');
INSERT INTO `sys_logininfor` VALUES (532, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 17:29:01');
INSERT INTO `sys_logininfor` VALUES (533, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 17:38:29');
INSERT INTO `sys_logininfor` VALUES (534, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 17:40:03');
INSERT INTO `sys_logininfor` VALUES (535, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 17:42:32');
INSERT INTO `sys_logininfor` VALUES (536, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 17:55:23');
INSERT INTO `sys_logininfor` VALUES (537, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 17:59:33');
INSERT INTO `sys_logininfor` VALUES (538, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 17:59:35');
INSERT INTO `sys_logininfor` VALUES (539, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 18:02:55');
INSERT INTO `sys_logininfor` VALUES (540, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 18:16:04');
INSERT INTO `sys_logininfor` VALUES (541, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 18:21:07');
INSERT INTO `sys_logininfor` VALUES (542, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 18:23:24');
INSERT INTO `sys_logininfor` VALUES (543, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 18:29:08');
INSERT INTO `sys_logininfor` VALUES (544, '', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-28 18:29:54');
INSERT INTO `sys_logininfor` VALUES (545, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 18:29:57');
INSERT INTO `sys_logininfor` VALUES (546, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-28 18:31:08');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '请求地址',
  `target` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '打开方式（menuItem页签 menuBlank新窗口）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2062 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (3, '保函系统', 0, 3, '#', '', 'M', '0', '', 'fa fa-bars', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '账号管理', 3, 1, '/system/user', '', 'C', '0', 'system:user:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 3, 2, '/system/role', '', 'C', '0', 'system:role:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, '/system/menu', '', 'C', '0', 'system:menu:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, '/system/dept', '', 'C', '0', 'system:dept:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, '/system/post', '', 'C', '0', 'system:post:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, '/system/dict', '', 'C', '0', 'system:dict:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, '/system/config', '', 'C', '0', 'system:config:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, '/system/notice', '', 'C', '0', 'system:notice:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, '#', '', 'M', '0', '', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, '/monitor/online', '', 'C', '0', 'monitor:online:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, '/monitor/job', '', 'C', '0', 'monitor:job:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, '/monitor/data', '', 'C', '0', 'monitor:data:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 3, '/monitor/server', '', 'C', '0', 'monitor:server:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '服务监控菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, '/monitor/operlog', '', 'C', '0', 'monitor:operlog:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, '/monitor/logininfor', '', 'C', '0', 'monitor:logininfor:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '#', '', 'F', '0', 'system:user:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '#', '', 'F', '0', 'system:user:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '#', '', 'F', '0', 'system:user:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '#', '', 'F', '0', 'system:user:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '#', '', 'F', '0', 'system:user:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '#', '', 'F', '0', 'system:user:import', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '#', '', 'F', '0', 'system:user:resetPwd', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '#', '', 'F', '0', 'system:role:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '#', '', 'F', '0', 'system:role:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '#', '', 'F', '0', 'system:role:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '#', '', 'F', '0', 'system:role:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '#', '', 'F', '0', 'system:role:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '#', '', 'F', '0', 'system:menu:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '#', '', 'F', '0', 'system:menu:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '#', '', 'F', '0', 'system:menu:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '#', '', 'F', '0', 'system:menu:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '#', '', 'F', '0', 'system:dept:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '#', '', 'F', '0', 'system:dept:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '#', '', 'F', '0', 'system:dept:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '#', '', 'F', '0', 'system:dept:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '#', '', 'F', '0', 'system:post:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '#', '', 'F', '0', 'system:post:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '#', '', 'F', '0', 'system:post:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '#', '', 'F', '0', 'system:post:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '#', '', 'F', '0', 'system:post:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', 'F', '0', 'system:dict:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', 'F', '0', 'system:dict:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', 'F', '0', 'system:dict:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', 'F', '0', 'system:dict:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', 'F', '0', 'system:dict:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', 'F', '0', 'system:config:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', 'F', '0', 'system:config:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', 'F', '0', 'system:config:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', 'F', '0', 'system:config:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', 'F', '0', 'system:config:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', 'F', '0', 'system:notice:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', 'F', '0', 'system:notice:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', 'F', '0', 'system:notice:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', 'F', '0', 'system:notice:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', 'F', '0', 'monitor:operlog:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', 'F', '0', 'monitor:operlog:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1041, '详细信息', 500, 3, '#', '', 'F', '0', 'monitor:operlog:detail', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', 'F', '0', 'monitor:operlog:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', 'F', '0', 'monitor:logininfor:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', 'F', '0', 'monitor:logininfor:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', 'F', '0', 'monitor:logininfor:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', 'F', '0', 'monitor:online:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', 'F', '0', 'monitor:online:batchForceLogout', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', 'F', '0', 'monitor:online:forceLogout', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', 'F', '0', 'monitor:job:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', 'F', '0', 'monitor:job:add', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', 'F', '0', 'monitor:job:edit', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', 'F', '0', 'monitor:job:remove', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', 'F', '0', 'monitor:job:changeStatus', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1054, '任务详细', 110, 6, '#', '', 'F', '0', 'monitor:job:detail', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1055, '任务导出', 110, 7, '#', '', 'F', '0', 'monitor:job:export', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1056, '生成查询', 114, 1, '#', '', 'F', '0', 'tool:gen:list', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (1057, '生成代码', 114, 2, '#', '', 'F', '0', 'tool:gen:code', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_menu` VALUES (2030, '订单管理', 3, 1, '/baohan/gurtOrder', '', 'C', '0', 'baohan:gurtOrder:view', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '订单菜单');
INSERT INTO `sys_menu` VALUES (2031, '订单查询', 2030, 1, '#', '', 'F', '0', 'baohan:gurtOrder:list', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2032, '订单新增', 2030, 2, '#', '', 'F', '0', 'baohan:gurtOrder:add', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2033, '订单修改', 2030, 3, '#', '', 'F', '0', 'baohan:gurtOrder:edit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2034, '订单删除', 2030, 4, '#', '', 'F', '0', 'baohan:gurtOrder:remove', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2035, '保函列表', 3, 1, '/baohan/gurtGuarantee', '', 'C', '0', 'baohan:gurtGuarantee:view', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '保函菜单');
INSERT INTO `sys_menu` VALUES (2036, '保函查询', 2035, 1, '#', '', 'F', '0', 'baohan:gurtGuarantee:list', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2037, '保函新增', 2035, 2, '#', '', 'F', '0', 'baohan:gurtGuarantee:add', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2038, '保函修改', 2035, 3, '#', '', 'F', '0', 'baohan:gurtGuarantee:edit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2039, '保函删除', 2035, 4, '#', '', 'F', '0', 'baohan:gurtGuarantee:remove', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2042, '客户管理', 3, 1, '/baohan/user', '', 'C', '0', 'baohan:user:view', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '用户菜单');
INSERT INTO `sys_menu` VALUES (2043, '用户查询', 2042, 1, '#', '', 'F', '0', 'baohan:user:list', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2044, '用户新增', 2042, 2, '#', '', 'F', '0', 'baohan:user:add', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2045, '用户修改', 2042, 3, '#', '', 'F', '0', 'baohan:user:edit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2046, '用户删除', 2042, 4, '#', '', 'F', '0', 'baohan:user:remove', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2047, '邀请提成', 3, 1, '/baohan/gurtInviteCommission', '', 'C', '0', 'baohan:gurtInviteCommission:view', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '邀请提成菜单');
INSERT INTO `sys_menu` VALUES (2048, '邀请提成查询', 2047, 1, '#', '', 'F', '0', 'baohan:gurtInviteCommission:list', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2049, '邀请提成新增', 2047, 2, '#', '', 'F', '0', 'baohan:gurtInviteCommission:add', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2050, '邀请提成修改', 2047, 3, '#', '', 'F', '0', 'baohan:gurtInviteCommission:edit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2051, '邀请提成删除', 2047, 4, '#', '', 'F', '0', 'baohan:gurtInviteCommission:remove', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2052, '项目基础资料', 3, 1, '/baohan/gurtCategory', '', 'C', '0', 'baohan:gurtCategory:view', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '项目基础资料菜单');
INSERT INTO `sys_menu` VALUES (2053, '项目基础资料查询', 2052, 1, '#', '', 'F', '0', 'baohan:gurtCategory:list', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2054, '项目基础资料新增', 2052, 2, '#', '', 'F', '0', 'baohan:gurtCategory:add', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2055, '项目基础资料修改', 2052, 3, '#', '', 'F', '0', 'baohan:gurtCategory:edit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2056, '项目基础资料删除', 2052, 4, '#', '', 'F', '0', 'baohan:gurtCategory:remove', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2057, '提交', 2030, 5, '#', '', 'F', '0', 'baohan:gurtOrder:submit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');
INSERT INTO `sys_menu` VALUES (2059, '撤销', 2030, 6, '#', '', 'F', '0', 'baohan:gurtOrder:exit', '#', 'admin', NULL, 'ry', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '我的邀请码', 3, 1, '/baohan/gurtma', '', 'C', '0', 'baohan:gurtma:view', '#', 'admin', NULL, 'ry', NULL, '我的邀请码');
INSERT INTO `sys_menu` VALUES (2061, '基础设置', 3, 1, '/baohan/gurtshezhi', '', 'C', '0', 'baohan:gurtshezhi:view', '#', 'admin', NULL, 'ry', NULL, '基础设置');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', '新版本内容', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', '维护内容', '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 408 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_guarantee', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 10:26:22');
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_guarantee', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 10:28:52');
INSERT INTO `sys_oper_log` VALUES (102, '演示任务', 1, 'com.ruoyi.demo.controller.TodoController.addSave()', 1, 'admin', '研发部门', '/demo/todo/add', '127.0.0.1', '内网IP', '{\r\n  \"title\" : [ \"11\" ],\r\n  \"content\" : [ \"1\" ],\r\n  \"startTime\" : [ \"\" ],\r\n  \"state\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-14 13:50:35');
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_order', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 14:16:37');
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_order', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 14:37:51');
INSERT INTO `sys_oper_log` VALUES (105, '订单', 1, 'com.ruoyi.web.controller.system.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/system/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"1\" ],\r\n  \"amount\" : [ \"1\" ],\r\n  \"createUserId\" : [ \"1\" ],\r\n  \"createTime\" : [ \"\" ],\r\n  \"bankSubmissionTime\" : [ \"\" ],\r\n  \"status\" : [ \"\" ],\r\n  \"needInvoice\" : [ \"\" ],\r\n  \"companyName\" : [ \"\" ],\r\n  \"taxNumber\" : [ \"\" ],\r\n  \"bankName\" : [ \"\" ],\r\n  \"bankAccount\" : [ \"\" ],\r\n  \"companyAddress\" : [ \"\" ],\r\n  \"phoneNumber\" : [ \"\" ],\r\n  \"invoiceFileDownloadUrl\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.system.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,        guarantee_amount,        guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,        ?,        ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-14 14:46:17');
INSERT INTO `sys_oper_log` VALUES (106, '订单', 1, 'com.ruoyi.web.controller.system.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/system/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"1\" ],\r\n  \"guaranteeId\" : [ \"\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"1\" ],\r\n  \"amount\" : [ \"1\" ],\r\n  \"createUserId\" : [ \"1\" ],\r\n  \"createTime\" : [ \"\" ],\r\n  \"bankSubmissionTime\" : [ \"\" ],\r\n  \"status\" : [ \"\" ],\r\n  \"needInvoice\" : [ \"\" ],\r\n  \"companyName\" : [ \"\" ],\r\n  \"taxNumber\" : [ \"\" ],\r\n  \"bankName\" : [ \"\" ],\r\n  \"bankAccount\" : [ \"\" ],\r\n  \"companyAddress\" : [ \"\" ],\r\n  \"phoneNumber\" : [ \"\" ],\r\n  \"invoiceFileDownloadUrl\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.system.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,        guarantee_amount,            bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,        ?,            ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-14 14:46:21');
INSERT INTO `sys_oper_log` VALUES (107, '订单', 1, 'com.ruoyi.web.controller.system.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/system/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"1\" ],\r\n  \"amount\" : [ \"1\" ],\r\n  \"createUserId\" : [ \"1\" ],\r\n  \"createTime\" : [ \"1\" ],\r\n  \"bankSubmissionTime\" : [ \"1\" ],\r\n  \"status\" : [ \"1\" ],\r\n  \"needInvoice\" : [ \"1\" ],\r\n  \"companyName\" : [ \"1\" ],\r\n  \"taxNumber\" : [ \"\" ],\r\n  \"bankName\" : [ \"\" ],\r\n  \"bankAccount\" : [ \"\" ],\r\n  \"companyAddress\" : [ \"\" ],\r\n  \"phoneNumber\" : [ \"\" ],\r\n  \"invoiceFileDownloadUrl\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.system.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,        guarantee_amount,        guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id,            status,    need_invoice,    company_name,                        invoice_file_download_url )           values ( ?,    ?,    ?,    ?,        ?,        ?,    ?,    ?,    ?,    ?,            ?,    ?,    ?,                        ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-14 14:48:12');
INSERT INTO `sys_oper_log` VALUES (108, '订单', 2, 'com.ruoyi.web.controller.system.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/system/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"1\" ],\r\n  \"warrantee\" : [ \"张三1\" ],\r\n  \"beneficiary\" : [ \"李四\" ],\r\n  \"projectNumber\" : [ \"A\" ],\r\n  \"projectName\" : [ \"A\" ],\r\n  \"closingTime\" : [ \"Thu Jun 13 14:49:24 CST 2019\" ],\r\n  \"guaranteeAmount\" : [ \"200\" ],\r\n  \"validityDeadline\" : [ \"Wed Jun 19 14:50:20 CST 2019\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"1\" ],\r\n  \"amount\" : [ \"1\" ],\r\n  \"createUserId\" : [ \"1\" ],\r\n  \"createTime\" : [ \"\" ],\r\n  \"bankSubmissionTime\" : [ \"\" ],\r\n  \"status\" : [ \"1\" ],\r\n  \"needInvoice\" : [ \"1\" ],\r\n  \"companyName\" : [ \"\" ],\r\n  \"taxNumber\" : [ \"\" ],\r\n  \"bankName\" : [ \"\" ],\r\n  \"bankAccount\" : [ \"\" ],\r\n  \"companyAddress\" : [ \"\" ],\r\n  \"phoneNumber\" : [ \"\" ],\r\n  \"invoiceFileDownloadUrl\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-14 14:51:57');
INSERT INTO `sys_oper_log` VALUES (109, '订单', 2, 'com.ruoyi.system.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/system/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"1\" ],\r\n  \"warrantee\" : [ \"张三1123\" ],\r\n  \"beneficiary\" : [ \"李四\" ],\r\n  \"projectNumber\" : [ \"A\" ],\r\n  \"projectName\" : [ \"A\" ],\r\n  \"closingTime\" : [ \"Thu Jun 13 14:49:24 CST 2019\" ],\r\n  \"guaranteeAmount\" : [ \"200\" ],\r\n  \"validityDeadline\" : [ \"Wed Jun 19 14:50:20 CST 2019\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"1\" ],\r\n  \"amount\" : [ \"1\" ],\r\n  \"createUserId\" : [ \"1\" ],\r\n  \"createTime\" : [ \"\" ],\r\n  \"bankSubmissionTime\" : [ \"\" ],\r\n  \"status\" : [ \"1\" ],\r\n  \"needInvoice\" : [ \"1\" ],\r\n  \"companyName\" : [ \"\" ],\r\n  \"taxNumber\" : [ \"\" ],\r\n  \"bankName\" : [ \"\" ],\r\n  \"bankAccount\" : [ \"\" ],\r\n  \"companyAddress\" : [ \"\" ],\r\n  \"phoneNumber\" : [ \"\" ],\r\n  \"invoiceFileDownloadUrl\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-14 14:59:52');
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_order', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 15:03:10');
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_order', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 15:06:09');
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_guarantee', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 15:07:55');
INSERT INTO `sys_oper_log` VALUES (113, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.changeStatus()', 1, 'admin', '研发部门', '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"2\" ],\r\n  \"status\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-14 15:25:01');
INSERT INTO `sys_oper_log` VALUES (114, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.changeStatus()', 1, 'admin', '研发部门', '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-14 15:25:02');
INSERT INTO `sys_oper_log` VALUES (115, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/sys_user', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 15:44:33');
INSERT INTO `sys_oper_log` VALUES (116, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_invite_commission', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 16:02:41');
INSERT INTO `sys_oper_log` VALUES (117, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_category', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-14 16:18:49');
INSERT INTO `sys_oper_log` VALUES (118, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"moeny\" : [ \"\" ],\r\n  \"moeny2\" : [ \"\" ],\r\n  \"danbi\" : [ \"\", \"\" ],\r\n  \"fang\" : [ \"on\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-17 15:36:39');
INSERT INTO `sys_oper_log` VALUES (119, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave1()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add1', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-17 15:44:42');
INSERT INTO `sys_oper_log` VALUES (120, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"remark\" : [ \"123123\" ],\r\n  \"projectName\" : [ \"444\" ],\r\n  \"moeny\" : [ \"11\" ],\r\n  \"moeny2\" : [ \"11\" ],\r\n  \"moneyType\" : [ \"%\" ],\r\n  \"danbi\" : [ \"1\" ],\r\n  \"fang\" : [ \"on\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-17 15:44:43');
INSERT INTO `sys_oper_log` VALUES (121, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"123\" ],\r\n  \"remark\" : [ \"123\" ],\r\n  \"projectName\" : [ \"123\" ],\r\n  \"moeny\" : [ \"123\" ],\r\n  \"moeny2\" : [ \"\" ],\r\n  \"moneyType\" : [ \"%\" ],\r\n  \"danbi\" : [ \"\" ],\r\n  \"fang\" : [ \"on\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-17 15:47:52');
INSERT INTO `sys_oper_log` VALUES (122, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1123\" ],\r\n  \"remark\" : [ \"123213\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"moeny\" : [ \"34\" ],\r\n  \"moeny2\" : [ \"44\" ],\r\n  \"moneyType\" : [ \"%\" ],\r\n  \"danbi\" : [ \"\" ],\r\n  \"fang\" : [ \"on\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-17 16:02:08');
INSERT INTO `sys_oper_log` VALUES (123, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1\" ],\r\n  \"remark\" : [ \"2\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"money\" : [ \"3\", \"4\" ],\r\n  \"moneyType\" : [ \"%\" ],\r\n  \"danbi\" : [ \"\" ],\r\n  \"fang\" : [ \"on\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-17 16:03:50');
INSERT INTO `sys_oper_log` VALUES (124, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1\" ],\r\n  \"remark\" : [ \"2\" ],\r\n  \"projectName\" : [ \"3\" ],\r\n  \"starting_amount\" : [ \"4\" ],\r\n  \"ending_amount\" : [ \"5\" ],\r\n  \"single_payment_cost\" : [ \"6\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"moneyType\" : [ \"1\" ],\r\n  \"multiple_payment_cost\" : [ \"7\" ],\r\n  \"multiple_payment_count_type\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-17 16:13:22');
INSERT INTO `sys_oper_log` VALUES (125, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"11\", \"22\" ],\r\n  \"ending_amount\" : [ \"111\", \"222\" ],\r\n  \"single_payment_cost\" : [ \"\", \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\", \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-17 16:15:27');
INSERT INTO `sys_oper_log` VALUES (126, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\", \"\" ],\r\n  \"ending_amount\" : [ \"\", \"\" ],\r\n  \"single_payment_cost\" : [ \"1,2\", \"1,2\" ],\r\n  \"multiple_payment_cost\" : [ \"\", \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_count_type\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-17 16:37:55');
INSERT INTO `sys_oper_log` VALUES (127, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\", \"\" ],\r\n  \"ending_amount\" : [ \"\", \"\" ],\r\n  \"single_payment_cost\" : [ \"\", \"\" ],\r\n  \"multiple_payment_cost\" : [ \"\", \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_count_type\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-17 16:38:56');
INSERT INTO `sys_oper_log` VALUES (128, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\", \"\" ],\r\n  \"ending_amount\" : [ \"\", \"\" ],\r\n  \"single_payment_cost\" : [ \"\", \"\" ],\r\n  \"multiple_payment_cost\" : [ \"\", \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_count_type\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-17 16:45:21');
INSERT INTO `sys_oper_log` VALUES (129, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"1,2\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\", \"\" ],\r\n  \"ending_amount\" : [ \"\", \"\" ],\r\n  \"single_payment_cost\" : [ \"\", \"\" ],\r\n  \"multiple_payment_cost\" : [ \"\", \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_count_type\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( remark )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-17 16:46:56');
INSERT INTO `sys_oper_log` VALUES (130, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\", \"\" ],\r\n  \"ending_amount\" : [ \"\", \"\" ],\r\n  \"single_payment_cost\" : [ \"\", \"\" ],\r\n  \"multiple_payment_cost\" : [ \"\", \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_count_type\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-17 16:48:28');
INSERT INTO `sys_oper_log` VALUES (131, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\", \"\" ],\r\n  \"ending_amount\" : [ \"\", \"\" ],\r\n  \"single_payment_cost\" : [ \"\", \"\" ],\r\n  \"multiple_payment_cost\" : [ \"\", \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_count_type\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-17 16:50:01');
INSERT INTO `sys_oper_log` VALUES (132, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"type\" : [ \"0,0,1,0,1,1\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"0\", \"1000\", \"2200\" ],\r\n  \"ending_amount\" : [ \"1000\", \"2200\", \"5000\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"500\", \"600\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"430\", \"500\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ],\r\n  \"2/\" : [ \"1\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"1\" ],\r\n  \"31000/\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-17 17:46:36');
INSERT INTO `sys_oper_log` VALUES (133, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"type\" : [ \"1,0,0,1\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\", \"\" ],\r\n  \"ending_amount\" : [ \"\", \"\" ],\r\n  \"single_payment_cost\" : [ \"\", \"\" ],\r\n  \"single_payment_count_type\" : [ \"1\" ],\r\n  \"multiple_payment_cost\" : [ \"\", \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"21000/\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-17 17:48:06');
INSERT INTO `sys_oper_log` VALUES (134, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_project_type_cost_config', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-17 17:49:42');
INSERT INTO `sys_oper_log` VALUES (135, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"3\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\n; Field \'create_user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value', '2019-06-17 18:15:10');
INSERT INTO `sys_oper_log` VALUES (136, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"2\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\n; Field \'create_user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value', '2019-06-17 18:29:01');
INSERT INTO `sys_oper_log` VALUES (137, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"12\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"3\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( id,    name,    remark )           values ( ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value\n; Field \'create_user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_user_id\' doesn\'t have a default value', '2019-06-17 18:54:38');
INSERT INTO `sys_oper_log` VALUES (138, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"12\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( name,    remark,    create_user_id )           values ( ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\n; Field \'create_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_time\' doesn\'t have a default value', '2019-06-17 18:56:35');
INSERT INTO `sys_oper_log` VALUES (139, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"1\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-17 18:59:00');
INSERT INTO `sys_oper_log` VALUES (140, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"4\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"412\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-17 18:59:58');
INSERT INTO `sys_oper_log` VALUES (141, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"12312321\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 1, 'nested exception is org.apache.ibatis.executor.ExecutorException: Error selecting key or setting result to parameter object. Cause: org.apache.ibatis.reflection.ReflectionException: Could not set property \'id\' of \'class com.ruoyi.baohan.domain.GurtCategory\' with value \'6\' Cause: java.lang.IllegalArgumentException: argument type mismatch', '2019-06-17 19:04:20');
INSERT INTO `sys_oper_log` VALUES (142, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"44\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"444\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-17 19:05:47');
INSERT INTO `sys_oper_log` VALUES (143, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"55\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"66\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-17 19:06:55');
INSERT INTO `sys_oper_log` VALUES (144, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"66\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"6\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-17 19:11:32');
INSERT INTO `sys_oper_log` VALUES (145, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A04\" ],\r\n  \"type\" : [ \"0,0,0,0,0,0\" ],\r\n  \"remark\" : [ \"客户经理3\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\", \"100000\", \"\" ],\r\n  \"ending_amount\" : [ \"100000\", \"200000\", \"\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"450\", \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\", \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"0\" ],\r\n  \"31000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-17 19:14:35');
INSERT INTO `sys_oper_log` VALUES (146, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.genCode()', 1, 'admin', '研发部门', '/tool/gen/genCode/gurt_project_type', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-17 19:53:50');
INSERT INTO `sys_oper_log` VALUES (147, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A03\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"A03\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-17 20:14:26');
INSERT INTO `sys_oper_log` VALUES (148, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A04\" ],\r\n  \"type\" : [ \"0,0,1,1\" ],\r\n  \"remark\" : [ \"A04\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\", \"100000\" ],\r\n  \"ending_amount\" : [ \"100000\", \"200000\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"450\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ],\r\n  \"2/\" : [ \"1\" ],\r\n  \"21000/\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeCostConfigMapper.insertGurtProjectTypeCostConfig-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type_cost_config    ( project_type_id,    starting_amount,    ending_amount,    single_payment_cost,    single_payment_count_type,    multiple_payment_cost,    multiple_payment_count_type,    category_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-17 20:15:21');
INSERT INTO `sys_oper_log` VALUES (149, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A04\" ],\r\n  \"type\" : [ \"0,0,1,1\" ],\r\n  \"remark\" : [ \"A04\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\", \"100000\" ],\r\n  \"ending_amount\" : [ \"100000\", \"200000\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"450\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ],\r\n  \"2/\" : [ \"1\" ],\r\n  \"21000/\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-17 20:15:40');
INSERT INTO `sys_oper_log` VALUES (150, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A04\" ],\r\n  \"type\" : [ \"0,0,1,1\" ],\r\n  \"remark\" : [ \"客户经理3\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\", \"100000\" ],\r\n  \"ending_amount\" : [ \"100000\", \"200000\" ],\r\n  \"single_payment_cost\" : [ \"450\", \"500\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"400\", \"450\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ],\r\n  \"2/\" : [ \"1\" ],\r\n  \"21000/\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-17 20:17:33');
INSERT INTO `sys_oper_log` VALUES (151, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A05\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"项目经理5\" ],\r\n  \"projectName\" : [ \"市政1\" ],\r\n  \"starting_amount\" : [ \"50\" ],\r\n  \"ending_amount\" : [ \"5000\" ],\r\n  \"single_payment_cost\" : [ \"10\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"5\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-17 20:19:41');
INSERT INTO `sys_oper_log` VALUES (152, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A07\" ],\r\n  \"type\" : [ \"0,0,1,1,0,0\" ],\r\n  \"remark\" : [ \"项目经理7\" ],\r\n  \"projectName\" : [ \"市政3\" ],\r\n  \"starting_amount\" : [ \"10\", \"20\", \"30\" ],\r\n  \"ending_amount\" : [ \"100\", \"200\", \"300\" ],\r\n  \"single_payment_cost\" : [ \"5\", \"5\", \"1\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\", \"1\", \"1\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ],\r\n  \"2/\" : [ \"1\" ],\r\n  \"21000/\" : [ \"1\" ],\r\n  \"3/\" : [ \"0\" ],\r\n  \"31000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-17 20:20:41');
INSERT INTO `sys_oper_log` VALUES (153, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A10\" ],\r\n  \"type\" : [ \"0,0,0,0,1,1\" ],\r\n  \"remark\" : [ \"项目经理10\" ],\r\n  \"projectName\" : [ \"市政5\" ],\r\n  \"starting_amount\" : [ \"0\", \"100\", \"500\" ],\r\n  \"ending_amount\" : [ \"100\", \"200\", \"1000\" ],\r\n  \"single_payment_cost\" : [ \"5\", \"10\", \"2\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\", \"5\", \"1\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"1\" ],\r\n  \"31000/\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-17 20:22:46');
INSERT INTO `sys_oper_log` VALUES (154, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A011\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"洒水\" ],\r\n  \"projectName\" : [ \"市政3\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( name )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'category_id\' doesn\'t have a default value', '2019-06-18 11:47:20');
INSERT INTO `sys_oper_log` VALUES (155, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A011\" ],\r\n  \"type\" : [ \"1,1\" ],\r\n  \"remark\" : [ \"洒水\" ],\r\n  \"projectName\" : [ \"市政3\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"11000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"single_payment_count_type\" : [ \"1\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"multiple_payment_count_type\" : [ \"1\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( name )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'category_id\' doesn\'t have a default value', '2019-06-18 11:47:52');
INSERT INTO `sys_oper_log` VALUES (156, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A101\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"Asadas \" ],\r\n  \"projectName\" : [ \"市政4\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-18 11:52:27');
INSERT INTO `sys_oper_log` VALUES (157, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( create_user_id )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\n; Field \'name\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'name\' doesn\'t have a default value', '2019-06-18 15:50:14');
INSERT INTO `sys_oper_log` VALUES (158, '重置密码', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 1, 'admin', '研发部门', '/system/user/resetPwd/1', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-18 15:57:31');
INSERT INTO `sys_oper_log` VALUES (159, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( create_user_id )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\n; Field \'name\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'name\' doesn\'t have a default value', '2019-06-18 17:20:57');
INSERT INTO `sys_oper_log` VALUES (160, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.insertGurtCategory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_category    ( create_user_id )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\n; Field \'name\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'name\' doesn\'t have a default value', '2019-06-18 17:21:00');
INSERT INTO `sys_oper_log` VALUES (161, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A111\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"测试1号\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"single_payment_count_type\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"multiple_payment_count_type\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-18 17:46:02');
INSERT INTO `sys_oper_log` VALUES (162, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\", \"1000000\", \"1000000\" ],\r\n  \"ending_amount\" : [ \"1000000\", \"2000000\", \"2000000\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"450\", \"5\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\", \"1\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"0\" ],\r\n  \"31000/\" : [ \"0\" ],\r\n  \"4/\" : [ \"1\" ],\r\n  \"41000/\" : [ \"1\" ]\r\n}', 1, '', '2019-06-18 18:25:18');
INSERT INTO `sys_oper_log` VALUES (163, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '', '2019-06-18 18:28:17');
INSERT INTO `sys_oper_log` VALUES (164, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '', '2019-06-18 18:30:04');
INSERT INTO `sys_oper_log` VALUES (165, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '', '2019-06-18 18:46:08');
INSERT INTO `sys_oper_log` VALUES (166, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政111\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '', '2019-06-18 19:22:59');
INSERT INTO `sys_oper_log` VALUES (167, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, 'Index: 0, Size: 0', '2019-06-18 19:28:41');
INSERT INTO `sys_oper_log` VALUES (168, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, 'Index: 0, Size: 0', '2019-06-18 19:29:06');
INSERT INTO `sys_oper_log` VALUES (169, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, 'Index: 0, Size: 0', '2019-06-18 19:29:40');
INSERT INTO `sys_oper_log` VALUES (170, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-18 19:32:37');
INSERT INTO `sys_oper_log` VALUES (171, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"1000000\" ],\r\n  \"ending_amount\" : [ \"2000000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"400\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-18 19:33:31');
INSERT INTO `sys_oper_log` VALUES (172, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,1,1\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"1000000\", \"200000000\" ],\r\n  \"ending_amount\" : [ \"20000000\", \"2000000000\" ],\r\n  \"single_payment_cost\" : [ \"1000\", \"5\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"500\", \"3\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"1\" ],\r\n  \"31000/\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-18 19:34:14');
INSERT INTO `sys_oper_log` VALUES (173, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"3\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"100000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-18 19:43:56');
INSERT INTO `sys_oper_log` VALUES (174, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"1\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-18 19:44:31');
INSERT INTO `sys_oper_log` VALUES (175, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"1\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"1000000\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-18 19:47:42');
INSERT INTO `sys_oper_log` VALUES (176, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"1\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"1000000\" ],\r\n  \"ending_amount\" : [ \"1000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-18 19:53:31');
INSERT INTO `sys_oper_log` VALUES (177, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"1\" ],\r\n  \"projectName\" : [ \"市政1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"100000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"50\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-18 19:53:49');
INSERT INTO `sys_oper_log` VALUES (178, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"1,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"1000000\" ],\r\n  \"ending_amount\" : [ \"20000000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"1\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 09:41:01');
INSERT INTO `sys_oper_log` VALUES (179, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 09:47:43');
INSERT INTO `sys_oper_log` VALUES (180, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,1\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"1000000\" ],\r\n  \"ending_amount\" : [ \"1000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"50\" ],\r\n  \"21000/\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-19 09:48:30');
INSERT INTO `sys_oper_log` VALUES (181, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0,0,0,1,1,1,0,0,0,0,1\" ],\r\n  \"gurtProjectTypeid\" : [ \"11\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"9\", \"10\", \"11\", \"12\", \"18\", \"19\", \"20\" ],\r\n  \"starting_amount\" : [ \"0\", \"1000000\", \"1000000\", \"200000000\", \"1000000\", \"0\", \"1000000\" ],\r\n  \"ending_amount\" : [ \"1000000\", \"2000000\", \"20000000\", \"2000000000\", \"20000000\", \"1000\", \"1000\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"450\", \"1000\", \"5\", \"450\", \"400\", \"450\" ],\r\n  \"9\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\", \"500\", \"3\", \"350\", \"350\", \"50\" ],\r\n  \"10009\" : [ \"0\" ],\r\n  \"10\" : [ \"0\" ],\r\n  \"10010\" : [ \"0\" ],\r\n  \"11\" : [ \"0\" ],\r\n  \"10011\" : [ \"0\" ],\r\n  \"12\" : [ \"1\" ],\r\n  \"10012\" : [ \"1\" ],\r\n  \"18\" : [ \"1\" ],\r\n  \"10018\" : [ \"0\" ],\r\n  \"19\" : [ \"0\" ],\r\n  \"10019\" : [ \"0\" ],\r\n  \"20\" : [ \"0\" ],\r\n  \"10020\" : [ \"1\" ]\r\n}', 1, '', '2019-06-19 10:20:10');
INSERT INTO `sys_oper_log` VALUES (182, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0,0,0,1,1,1,0,0,0,0,1\" ],\r\n  \"gurtProjectTypeid\" : [ \"11\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"9\", \"10\", \"11\", \"12\", \"18\", \"19\", \"20\" ],\r\n  \"starting_amount\" : [ \"0\", \"1000000\", \"1000000\", \"200000000\", \"1000000\", \"0\", \"1000000\" ],\r\n  \"ending_amount\" : [ \"1000000\", \"2000000\", \"20000000\", \"2000000000\", \"20000000\", \"1000\", \"1000\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"450\", \"1000\", \"5\", \"450\", \"400\", \"450\" ],\r\n  \"9\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\", \"500\", \"3\", \"350\", \"350\", \"50\" ],\r\n  \"10009\" : [ \"0\" ],\r\n  \"10\" : [ \"0\" ],\r\n  \"10010\" : [ \"0\" ],\r\n  \"11\" : [ \"0\" ],\r\n  \"10011\" : [ \"0\" ],\r\n  \"12\" : [ \"1\" ],\r\n  \"10012\" : [ \"1\" ],\r\n  \"18\" : [ \"1\" ],\r\n  \"10018\" : [ \"0\" ],\r\n  \"19\" : [ \"0\" ],\r\n  \"10019\" : [ \"0\" ],\r\n  \"20\" : [ \"0\" ],\r\n  \"10020\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-19 10:24:07');
INSERT INTO `sys_oper_log` VALUES (183, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0,1,1\" ],\r\n  \"gurtProjectTypeid\" : [ \"9\" ],\r\n  \"name\" : [ \"市政56\" ],\r\n  \"id\" : [ \"6\", \"7\", \"8\" ],\r\n  \"starting_amount\" : [ \"0\", \"100\", \"500\" ],\r\n  \"ending_amount\" : [ \"100\", \"200\", \"1000\" ],\r\n  \"single_payment_cost\" : [ \"5\", \"10\", \"2\" ],\r\n  \"6\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\", \"5\", \"1\" ],\r\n  \"10006\" : [ \"0\" ],\r\n  \"7\" : [ \"0\" ],\r\n  \"10007\" : [ \"0\" ],\r\n  \"8\" : [ \"1\" ],\r\n  \"10008\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-19 10:27:42');
INSERT INTO `sys_oper_log` VALUES (184, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"1,1,1,1,1,0\" ],\r\n  \"gurtProjectTypeid\" : [ \"9\" ],\r\n  \"name\" : [ \"市政566\" ],\r\n  \"id\" : [ \"6\", \"7\", \"8\" ],\r\n  \"starting_amount\" : [ \"01\", \"100\", \"500\" ],\r\n  \"ending_amount\" : [ \"100\", \"200\", \"1000\" ],\r\n  \"single_payment_cost\" : [ \"5\", \"10\", \"2\" ],\r\n  \"6\" : [ \"1\" ],\r\n  \"multiple_payment_cost\" : [ \"1\", \"5\", \"1\" ],\r\n  \"10006\" : [ \"1\" ],\r\n  \"7\" : [ \"1\" ],\r\n  \"10007\" : [ \"1\" ],\r\n  \"8\" : [ \"1\" ],\r\n  \"10008\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 10:28:18');
INSERT INTO `sys_oper_log` VALUES (185, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0,0,0,1,1,1,0,1,1,1,1\" ],\r\n  \"gurtProjectTypeid\" : [ \"11\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"9\", \"10\", \"11\", \"12\", \"18\", \"19\", \"20\" ],\r\n  \"starting_amount\" : [ \"0\", \"1000000\", \"1000000\", \"200000000\", \"1000000\", \"0\", \"1000000\" ],\r\n  \"ending_amount\" : [ \"1000000\", \"2000000\", \"20000000\", \"2000000000\", \"20000000\", \"1000000000\", \"10000000\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"450\", \"1000\", \"5\", \"450\", \"400\", \"450\" ],\r\n  \"9\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\", \"500\", \"3\", \"350\", \"350\", \"50\" ],\r\n  \"10009\" : [ \"0\" ],\r\n  \"10\" : [ \"0\" ],\r\n  \"10010\" : [ \"0\" ],\r\n  \"11\" : [ \"0\" ],\r\n  \"10011\" : [ \"0\" ],\r\n  \"12\" : [ \"1\" ],\r\n  \"10012\" : [ \"1\" ],\r\n  \"18\" : [ \"1\" ],\r\n  \"10018\" : [ \"0\" ],\r\n  \"19\" : [ \"1\" ],\r\n  \"10019\" : [ \"1\" ],\r\n  \"20\" : [ \"1\" ],\r\n  \"10020\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-19 10:28:53');
INSERT INTO `sys_oper_log` VALUES (186, '项目基础资料', 2, 'com.ruoyi.baohan.controller.GurtCategoryController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/modify', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"17\" ],\r\n  \"name\" : [ \"A10\" ],\r\n  \"remark\" : [ \"项目经理10\" ]\r\n}', 0, NULL, '2019-06-19 10:45:02');
INSERT INTO `sys_oper_log` VALUES (187, '项目基础资料', 2, 'com.ruoyi.baohan.controller.GurtCategoryController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/modify', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"17\" ],\r\n  \"name\" : [ \"A10\" ],\r\n  \"remark\" : [ \"项目经理101\" ]\r\n}', 0, NULL, '2019-06-19 10:45:12');
INSERT INTO `sys_oper_log` VALUES (188, '项目分类', 3, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.remove()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/del/9', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-19 10:55:07');
INSERT INTO `sys_oper_log` VALUES (189, '项目分类', 3, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.remove()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/del/13', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-19 10:57:48');
INSERT INTO `sys_oper_log` VALUES (190, '项目分类', 3, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.remove()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/del/12', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-19 11:00:39');
INSERT INTO `sys_oper_log` VALUES (191, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"1\" ],\r\n  \"projectName\" : [ \"市政1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 11:04:00');
INSERT INTO `sys_oper_log` VALUES (192, '项目分类', 3, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.remove()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/del/14', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-19 11:04:06');
INSERT INTO `sys_oper_log` VALUES (193, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1123\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"项目经理101\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 11:04:57');
INSERT INTO `sys_oper_log` VALUES (194, '项目基础资料', 3, 'com.ruoyi.baohan.controller.GurtCategoryController.remove()', 1, 'admin', '研发部门', '/baohan/gurtCategory/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"18\" ]\r\n}', 0, NULL, '2019-06-19 11:05:13');
INSERT INTO `sys_oper_log` VALUES (195, '项目基础资料', 3, 'com.ruoyi.baohan.controller.GurtCategoryController.remove()', 1, 'admin', '研发部门', '/baohan/gurtCategory/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-19 11:07:53');
INSERT INTO `sys_oper_log` VALUES (196, '项目基础资料', 3, 'com.ruoyi.baohan.controller.GurtCategoryController.remove()', 1, 'admin', '研发部门', '/baohan/gurtCategory/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"1,3\" ]\r\n}', 0, NULL, '2019-06-19 11:08:06');
INSERT INTO `sys_oper_log` VALUES (197, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"1\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 11:08:11');
INSERT INTO `sys_oper_log` VALUES (198, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"19\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"50\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 11:08:59');
INSERT INTO `sys_oper_log` VALUES (199, '项目基础资料', 3, 'com.ruoyi.baohan.controller.GurtCategoryController.remove()', 1, 'admin', '研发部门', '/baohan/gurtCategory/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"19\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`bank`.`gurt_project_type_cost_config`, CONSTRAINT `a` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`))\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.deleteGurtCategoryByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from gurt_category where id in           (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`bank`.`gurt_project_type_cost_config`, CONSTRAINT `a` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`bank`.`gurt_project_type_cost_config`, CONSTRAINT `a` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`bank`.`gurt_project_type_cost_config`, CONSTRAINT `a` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`))', '2019-06-19 11:09:09');
INSERT INTO `sys_oper_log` VALUES (200, '项目基础资料', 3, 'com.ruoyi.baohan.controller.GurtCategoryController.remove()', 1, 'admin', '研发部门', '/baohan/gurtCategory/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"19\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`bank`.`gurt_project_type_cost_config`, CONSTRAINT `a` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`))\r\n### The error may involve com.ruoyi.baohan.mapper.GurtCategoryMapper.deleteGurtCategoryByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from gurt_category where id in           (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`bank`.`gurt_project_type_cost_config`, CONSTRAINT `a` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`bank`.`gurt_project_type_cost_config`, CONSTRAINT `a` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`bank`.`gurt_project_type_cost_config`, CONSTRAINT `a` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`))', '2019-06-19 11:09:17');
INSERT INTO `sys_oper_log` VALUES (201, '项目基础资料', 3, 'com.ruoyi.baohan.controller.GurtCategoryController.remove()', 1, 'admin', '研发部门', '/baohan/gurtCategory/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"19\" ]\r\n}', 0, NULL, '2019-06-19 11:16:52');
INSERT INTO `sys_oper_log` VALUES (202, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"100000\" ],\r\n  \"single_payment_cost\" : [ \"1000\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"50\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 11:19:01');
INSERT INTO `sys_oper_log` VALUES (203, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"3\" ],\r\n  \"starting_amount\" : [ \"1000000\" ],\r\n  \"ending_amount\" : [ \"2000000\" ],\r\n  \"single_payment_cost\" : [ \"1000\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"50\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 11:19:16');
INSERT INTO `sys_oper_log` VALUES (204, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"市政3\" ],\r\n  \"starting_amount\" : [ \"01\" ],\r\n  \"ending_amount\" : [ \"2000000\" ],\r\n  \"single_payment_cost\" : [ \"1000\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 11:19:31');
INSERT INTO `sys_oper_log` VALUES (205, '角色管理', 4, 'com.ruoyi.web.controller.system.SysRoleController.cancelAuthUser()', 1, 'ry', '测试部门', '/system/role/authUser/cancel', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"2\" ],\r\n  \"userId\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-19 11:38:23');
INSERT INTO `sys_oper_log` VALUES (206, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1123\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"项目经理101\" ],\r\n  \"projectName\" : [ \"市政1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000\" ],\r\n  \"single_payment_cost\" : [ \"1000\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-19 11:39:19');
INSERT INTO `sys_oper_log` VALUES (207, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'ry', '测试部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"ac\" ],\r\n  \"deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"15244443333\" ],\r\n  \"email\" : [ \"importjant@163.com\" ],\r\n  \"loginName\" : [ \"ac\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"\" ],\r\n  \"postIds\" : [ \"4\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'4\' for key \'PRIMARY\'\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.insertUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user(            dept_id,       login_name,       user_name,       email,       phonenumber,       sex,       password,       salt,       status,       create_by,            create_time    )values(            ?,       ?,       ?,       ?,       ?,       ?,       ?,       ?,       ?,       ?,            sysdate()    )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'4\' for key \'PRIMARY\'\n; Duplicate entry \'4\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'4\' for key \'PRIMARY\'', '2019-06-19 14:04:41');
INSERT INTO `sys_oper_log` VALUES (208, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'ry', '测试部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"ac\" ],\r\n  \"deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"15244443333\" ],\r\n  \"email\" : [ \"importjant@163.com\" ],\r\n  \"loginName\" : [ \"ac\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"role\" : [ \"2\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"2\" ],\r\n  \"postIds\" : [ \"4\" ]\r\n}', 0, NULL, '2019-06-19 14:04:46');
INSERT INTO `sys_oper_log` VALUES (209, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"5\" ],\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"ac\" ],\r\n  \"dept.deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"15244443333\" ],\r\n  \"email\" : [ \"importjant@163.com\" ],\r\n  \"loginName\" : [ \"ac\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"role\" : [ \"1\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1\" ],\r\n  \"postIds\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-19 14:12:08');
INSERT INTO `sys_oper_log` VALUES (210, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"5\" ],\r\n  \"deptId\" : [ \"103\" ],\r\n  \"userName\" : [ \"ac\" ],\r\n  \"dept.deptName\" : [ \"研发部门\" ],\r\n  \"phonenumber\" : [ \"15244443333\" ],\r\n  \"email\" : [ \"importjant@163.com\" ],\r\n  \"loginName\" : [ \"ac\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"role\" : [ \"1\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1\" ],\r\n  \"postIds\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-19 14:12:36');
INSERT INTO `sys_oper_log` VALUES (211, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 14:14:17');
INSERT INTO `sys_oper_log` VALUES (212, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"5\" ],\r\n  \"deptId\" : [ \"103\" ],\r\n  \"userName\" : [ \"ac\" ],\r\n  \"dept.deptName\" : [ \"研发部门\" ],\r\n  \"phonenumber\" : [ \"15244443333\" ],\r\n  \"email\" : [ \"importjant@163.com\" ],\r\n  \"loginName\" : [ \"ac\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"role\" : [ \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-19 14:15:21');
INSERT INTO `sys_oper_log` VALUES (213, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"1\" ],\r\n  \"roleName\" : [ \"管理员\" ],\r\n  \"roleKey\" : [ \"admin\" ],\r\n  \"roleSort\" : [ \"1\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"管理员\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 14:15:45');
INSERT INTO `sys_oper_log` VALUES (214, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'ac', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 14:20:26');
INSERT INTO `sys_oper_log` VALUES (215, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'ac', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 14:20:46');
INSERT INTO `sys_oper_log` VALUES (216, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"109\" ],\r\n  \"userName\" : [ \"1123\" ],\r\n  \"deptName\" : [ \"财务部门\" ],\r\n  \"phonenumber\" : [ \"15244443332\" ],\r\n  \"email\" : [ \"importj3nt@163.com\" ],\r\n  \"loginName\" : [ \"啊231\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"cat\" : [ \"20\" ],\r\n  \"role\" : [ \"1\", \"2\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1,2\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-19 14:53:31');
INSERT INTO `sys_oper_log` VALUES (217, '重置密码', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 1, 'admin', '研发部门', '/system/user/resetPwd/6', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-19 14:53:34');
INSERT INTO `sys_oper_log` VALUES (218, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 1, 'admin', '研发部门', '/system/user/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"6\" ]\r\n}', 0, NULL, '2019-06-19 14:53:39');
INSERT INTO `sys_oper_log` VALUES (219, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"1123\" ],\r\n  \"deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"15211113332\" ],\r\n  \"email\" : [ \"3nt@163.com\" ],\r\n  \"loginName\" : [ \"啊2312\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"catId\" : [ \"20\" ],\r\n  \"role\" : [ \"2\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"2\" ],\r\n  \"postIds\" : [ \"3\" ]\r\n}', 0, NULL, '2019-06-19 14:55:13');
INSERT INTO `sys_oper_log` VALUES (220, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"65\" ],\r\n  \"deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"18845677894\" ],\r\n  \"email\" : [ \"imporjant@163.com\" ],\r\n  \"loginName\" : [ \"啊2317\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"catId\" : [ \"20\" ],\r\n  \"role\" : [ \"2\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"2\" ],\r\n  \"postIds\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-19 14:58:04');
INSERT INTO `sys_oper_log` VALUES (221, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 1, 'admin', '研发部门', '/system/user/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"7\" ]\r\n}', 0, NULL, '2019-06-19 14:59:03');
INSERT INTO `sys_oper_log` VALUES (222, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"8\" ],\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"65\" ],\r\n  \"dept.deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"18845677894\" ],\r\n  \"email\" : [ \"imporjant@163.com\" ],\r\n  \"loginName\" : [ \"manager\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"role\" : [ \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"3\" ],\r\n  \"postIds\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-19 14:59:11');
INSERT INTO `sys_oper_log` VALUES (223, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"1\" ],\r\n  \"roleName\" : [ \"管理员\" ],\r\n  \"roleKey\" : [ \"admin\" ],\r\n  \"roleSort\" : [ \"1\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"管理员\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 15:59:28');
INSERT INTO `sys_oper_log` VALUES (224, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"1\" ],\r\n  \"roleName\" : [ \"管理员\" ],\r\n  \"roleKey\" : [ \"admin\" ],\r\n  \"roleSort\" : [ \"1\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"管理员\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 16:00:36');
INSERT INTO `sys_oper_log` VALUES (225, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 16:00:46');
INSERT INTO `sys_oper_log` VALUES (226, '重置密码', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 1, 'admin', '研发部门', '/system/user/resetPwd/8', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-19 16:08:37');
INSERT INTO `sys_oper_log` VALUES (227, '重置密码', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwdSave()', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"8\" ],\r\n  \"loginName\" : [ \"manager\" ],\r\n  \"password\" : [ \"123456\" ]\r\n}', 0, NULL, '2019-06-19 16:08:40');
INSERT INTO `sys_oper_log` VALUES (228, '重置密码', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 1, 'admin', '研发部门', '/system/user/resetPwd/8', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-19 16:08:42');
INSERT INTO `sys_oper_log` VALUES (229, '重置密码', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwdSave()', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"8\" ],\r\n  \"loginName\" : [ \"manager\" ],\r\n  \"password\" : [ \"admin123\" ]\r\n}', 0, NULL, '2019-06-19 16:08:51');
INSERT INTO `sys_oper_log` VALUES (230, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'manager', '测试部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 16:09:41');
INSERT INTO `sys_oper_log` VALUES (231, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'manager', '测试部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 16:16:40');
INSERT INTO `sys_oper_log` VALUES (232, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'manager', '测试部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2034,2057,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 16:16:55');
INSERT INTO `sys_oper_log` VALUES (233, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'manager', '测试部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"1,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,1042,501,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,1055,111,112,3,2052,2053,2054,2055,2056,100,1000,1001,1002,1003,1004,1005,1006,113,2030,2031,2032,2033,2034,2057,2035,2036,2037,2038,2039,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,101,1007,1008,1009,1010,1011,114,1056,1057\" ]\r\n}', 0, NULL, '2019-06-19 16:17:16');
INSERT INTO `sys_oper_log` VALUES (234, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"1\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-20 09:25:24');
INSERT INTO `sys_oper_log` VALUES (235, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"1\" ],\r\n  \"projectName\" : [ \"市政1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-20 09:25:38');
INSERT INTO `sys_oper_log` VALUES (236, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"1,1\" ],\r\n  \"catId\" : [ \"1\" ],\r\n  \"projectName\" : [ \"市政1\" ],\r\n  \"starting_amount\" : [ \"10000\" ],\r\n  \"ending_amount\" : [ \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"2\" ],\r\n  \"2/\" : [ \"1\" ],\r\n  \"multiple_payment_cost\" : [ \"2\" ],\r\n  \"21000/\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-20 11:27:49');
INSERT INTO `sys_oper_log` VALUES (237, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"remark\" : [ \"12\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\n; Field \'guarantee_file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value', '2019-06-20 16:43:51');
INSERT INTO `sys_oper_log` VALUES (238, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"remark\" : [ \"4857\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\n; Field \'guarantee_file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value', '2019-06-20 16:45:12');
INSERT INTO `sys_oper_log` VALUES (239, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"remark\" : [ \"4857\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\n; Field \'guarantee_file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value', '2019-06-20 16:45:38');
INSERT INTO `sys_oper_log` VALUES (240, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"remark\" : [ \"4857\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\n; Field \'guarantee_file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value', '2019-06-20 16:45:53');
INSERT INTO `sys_oper_log` VALUES (241, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-20 17:09:21');
INSERT INTO `sys_oper_log` VALUES (242, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-20 17:20:54');
INSERT INTO `sys_oper_log` VALUES (243, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-20 17:44:03');
INSERT INTO `sys_oper_log` VALUES (244, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-20 17:58:06');
INSERT INTO `sys_oper_log` VALUES (245, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-20 18:01:20');
INSERT INTO `sys_oper_log` VALUES (246, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"fileId\" : [ \"105465_名片-0626_画板_1_副本.png\" ],\r\n  \"initialPreview\" : [ \"[]\" ],\r\n  \"initialPreviewConfig\" : [ \"[]\" ],\r\n  \"initialPreviewThumbTags\" : [ \"[]\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-20 18:16:04');
INSERT INTO `sys_oper_log` VALUES (247, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-20 18:24:07');
INSERT INTO `sys_oper_log` VALUES (248, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-20 18:25:01');
INSERT INTO `sys_oper_log` VALUES (249, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A111\" ],\r\n  \"type\" : [ \"0,0,0,0,0,0\" ],\r\n  \"remark\" : [ \"beizhu\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\", \"1000000\", \"1000000\" ],\r\n  \"ending_amount\" : [ \"1000000\", \"20000000\", \"1000000\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"1000\", \"1000\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"50\", \"350\", \"350\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"0\" ],\r\n  \"31000/\" : [ \"0\" ],\r\n  \"4/\" : [ \"0\" ],\r\n  \"41000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-21 09:18:37');
INSERT INTO `sys_oper_log` VALUES (250, '项目基础资料', 2, 'com.ruoyi.baohan.controller.GurtCategoryController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/modify', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"21\" ],\r\n  \"name\" : [ \"A111\" ],\r\n  \"remark\" : [ \"beizhu1\" ]\r\n}', 0, NULL, '2019-06-21 09:18:50');
INSERT INTO `sys_oper_log` VALUES (251, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"3,2030,2031,2032,2033,2034,2057\" ]\r\n}', 0, NULL, '2019-06-21 10:58:17');
INSERT INTO `sys_oper_log` VALUES (252, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"2\" ],\r\n  \"roleName\" : [ \"普通角色\" ],\r\n  \"roleKey\" : [ \"common\" ],\r\n  \"roleSort\" : [ \"3\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"普通角色\" ],\r\n  \"menuIds\" : [ \"3,2030,2031,2032,2033,2034,2057\" ]\r\n}', 0, NULL, '2019-06-21 10:58:27');
INSERT INTO `sys_oper_log` VALUES (253, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-21 11:06:18');
INSERT INTO `sys_oper_log` VALUES (254, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-21 11:06:34');
INSERT INTO `sys_oper_log` VALUES (255, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 1', '2019-06-21 11:11:04');
INSERT INTO `sys_oper_log` VALUES (256, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"7\" ],\r\n  \"remark\" : [ \"8\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\n; Field \'guarantee_file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value', '2019-06-21 11:20:10');
INSERT INTO `sys_oper_log` VALUES (257, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"remark\" : [ \"6565\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\n; Field \'guarantee_file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value', '2019-06-21 11:22:07');
INSERT INTO `sys_oper_log` VALUES (258, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"remark\" : [ \"6565\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\n; Field \'guarantee_file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value', '2019-06-21 11:22:15');
INSERT INTO `sys_oper_log` VALUES (259, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"remark\" : [ \"6565\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\n; Field \'guarantee_file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value', '2019-06-21 11:22:29');
INSERT INTO `sys_oper_log` VALUES (260, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1111111111111\" ],\r\n  \"remark\" : [ \"6565\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtGuaranteeMapper.insertGurtGuarantee-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_guarantee    ( name,    remark )           values ( ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value\n; Field \'guarantee_file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'guarantee_file_path\' doesn\'t have a default value', '2019-06-21 11:22:52');
INSERT INTO `sys_oper_log` VALUES (261, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"guaranteeFilePath\" : [ \"http://localhost/profile/upload/2019/06/21/ff30e59e3d8da7eebd603ac0a962a47d.xls\" ],\r\n  \"name\" : [ \"4\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-21 11:40:38');
INSERT INTO `sys_oper_log` VALUES (262, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"guaranteeFilePath\" : [ \"0\" ],\r\n  \"name\" : [ \"87978\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-21 11:40:49');
INSERT INTO `sys_oper_log` VALUES (263, '保函', 1, 'com.ruoyi.baohan.controller.GurtGuaranteeController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/add', '127.0.0.1', '内网IP', '{\r\n  \"guaranteeFilePath\" : [ \"http://localhost/profile/upload/2019/06/21/d0f8cc9220dec8a5e8b585d11fbe01d6.docx\" ],\r\n  \"name\" : [ \"554\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-21 11:41:59');
INSERT INTO `sys_oper_log` VALUES (264, '保函', 3, 'com.ruoyi.baohan.controller.GurtGuaranteeController.remove()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"5\" ]\r\n}', 0, NULL, '2019-06-21 11:42:12');
INSERT INTO `sys_oper_log` VALUES (265, '保函', 2, 'com.ruoyi.baohan.controller.GurtGuaranteeController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"4\" ],\r\n  \"name\" : [ \"保函五\" ],\r\n  \"remark\" : [ \"备注\" ],\r\n  \"guaranteeFilePath\" : [ \"http://localhost/profile/upload/2019/06/21/ff30e59e3d8da7eebd603ac0a962a47d.xls\" ]\r\n}', 0, NULL, '2019-06-21 11:42:27');
INSERT INTO `sys_oper_log` VALUES (266, '保函', 2, 'com.ruoyi.baohan.controller.GurtGuaranteeController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtGuarantee/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"6\" ],\r\n  \"name\" : [ \"保函四\" ],\r\n  \"remark\" : [ \"备注\" ],\r\n  \"guaranteeFilePath\" : [ \"http://localhost/profile/upload/2019/06/21/d0f8cc9220dec8a5e8b585d11fbe01d6.docx\" ]\r\n}', 0, NULL, '2019-06-21 11:42:38');
INSERT INTO `sys_oper_log` VALUES (267, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"啊\" ],\r\n  \"beneficiary\" : [ \" 啊\" ],\r\n  \"projectNumber\" : [ \"啊\" ],\r\n  \"projectName\" : [ \"啊\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"100000\" ],\r\n  \"validityDeadline\" : [ \"2012-1-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"350\" ],\r\n  \"money1\" : [ \"100\" ],\r\n  \"money2\" : [ \"250\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-21 15:39:50');
INSERT INTO `sys_oper_log` VALUES (268, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"保证人\" ],\r\n  \"beneficiary\" : [ \"受益人\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"日期\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"有效期\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"111\" ],\r\n  \"money1\" : [ \"0101\" ],\r\n  \"money2\" : [ \"010\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,        guarantee_amount,        guarantee_id,    bank_id,    project_type_id,    amount )           values ( ?,    ?,    ?,    ?,        ?,        ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-21 15:46:36');
INSERT INTO `sys_oper_log` VALUES (269, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-3-4\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"257\" ],\r\n  \"money1\" : [ \"123\" ],\r\n  \"money2\" : [ \"134\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2019-06-21 15:48:49');
INSERT INTO `sys_oper_log` VALUES (270, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-3-4\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"257\" ],\r\n  \"money1\" : [ \"123\" ],\r\n  \"money2\" : [ \"134\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\n; Field \'create_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_time\' doesn\'t have a default value', '2019-06-21 15:50:42');
INSERT INTO `sys_oper_log` VALUES (271, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-3-4\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"257\" ],\r\n  \"money1\" : [ \"123\" ],\r\n  \"money2\" : [ \"134\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\n; Field \'create_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_time\' doesn\'t have a default value', '2019-06-21 15:51:28');
INSERT INTO `sys_oper_log` VALUES (272, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-3-4\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"257\" ],\r\n  \"money1\" : [ \"123\" ],\r\n  \"money2\" : [ \"134\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'create_time\' doesn\'t have a default value\n; Field \'create_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_time\' doesn\'t have a default value', '2019-06-21 15:52:57');
INSERT INTO `sys_oper_log` VALUES (273, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-3-4\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"257\" ],\r\n  \"money1\" : [ \"123\" ],\r\n  \"money2\" : [ \"134\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\n; Field \'bank_submission_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value', '2019-06-21 15:53:44');
INSERT INTO `sys_oper_log` VALUES (274, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人：\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"12313\" ],\r\n  \"validityDeadline\" : [ \"2012-1-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"545635\" ],\r\n  \"money1\" : [ \"421421\" ],\r\n  \"money2\" : [ \"124214\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\n; Field \'bank_submission_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value', '2019-06-21 15:56:01');
INSERT INTO `sys_oper_log` VALUES (275, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人：\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"12312\" ],\r\n  \"validityDeadline\" : [ \"2012-1-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money1\" : [ \"\" ],\r\n  \"money2\" : [ \"\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\n; Field \'bank_submission_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value', '2019-06-21 15:58:42');
INSERT INTO `sys_oper_log` VALUES (276, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"123123\" ],\r\n  \"validityDeadline\" : [ \"2011-1-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money1\" : [ \"\" ],\r\n  \"money2\" : [ \"\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\n; Field \'bank_submission_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value', '2019-06-21 16:02:18');
INSERT INTO `sys_oper_log` VALUES (277, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人：\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"2131\" ],\r\n  \"validityDeadline\" : [ \"2122-1-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money1\" : [ \"\" ],\r\n  \"money2\" : [ \"\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( warrantee,    beneficiary,    project_number,    project_name,    closing_time,    guarantee_amount,    validity_deadline,    guarantee_id,    bank_id,    project_type_id,    amount,    create_user_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value\n; Field \'bank_submission_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'bank_submission_time\' doesn\'t have a default value', '2019-06-21 16:04:08');
INSERT INTO `sys_oper_log` VALUES (278, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"被保证人：\" ],\r\n  \"beneficiary\" : [ \"受益人：\" ],\r\n  \"projectNumber\" : [ \"项目编号：\" ],\r\n  \"projectName\" : [ \"项目名称：\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"2131\" ],\r\n  \"validityDeadline\" : [ \"2122-1-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"400\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money1\" : [ \"\" ],\r\n  \"money2\" : [ \"\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-21 16:04:22');
INSERT INTO `sys_oper_log` VALUES (279, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"\" ],\r\n  \"beneficiary\" : [ \"\" ],\r\n  \"projectNumber\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"closingTime\" : [ \"\" ],\r\n  \"guaranteeAmount\" : [ \"\" ],\r\n  \"validityDeadline\" : [ \"\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"money1\" : [ \"\" ],\r\n  \"money2\" : [ \"\" ],\r\n  \"money3\" : [ \"\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'warrantee\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtOrderMapper.insertGurtOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order    ( guarantee_id,    bank_id,    project_type_id,        create_user_id )           values ( ?,    ?,    ?,        ? )\r\n### Cause: java.sql.SQLException: Field \'warrantee\' doesn\'t have a default value\n; Field \'warrantee\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'warrantee\' doesn\'t have a default value', '2019-06-21 16:28:31');
INSERT INTO `sys_oper_log` VALUES (280, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"\" ],\r\n  \"beneficiary\" : [ \"\" ],\r\n  \"projectNumber\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"closingTime\" : [ \"\" ],\r\n  \"guaranteeAmount\" : [ \"\" ],\r\n  \"validityDeadline\" : [ \"\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"\" ],\r\n  \"paidamount\" : [ \"12257\" ],\r\n  \"money\" : [ \"44\", \"12213\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/21/e1e59eedf4af96e7df428d27f4d591a8.xlsx\" ],\r\n  \"fileNames\" : [ \"2019/06/21/e1e59eedf4af96e7df428d27f4d591a8.xlsx\" ]\r\n}', 0, NULL, '2019-06-21 18:12:20');
INSERT INTO `sys_oper_log` VALUES (281, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"\" ],\r\n  \"beneficiary\" : [ \"\" ],\r\n  \"projectNumber\" : [ \"\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"closingTime\" : [ \"\" ],\r\n  \"guaranteeAmount\" : [ \"\" ],\r\n  \"validityDeadline\" : [ \"\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"20\" ],\r\n  \"amount\" : [ \"\" ],\r\n  \"paidamount\" : [ \"4165\" ],\r\n  \"money\" : [ \"44\", \"4121\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/21/6cff5e39ce09c2520ee7405588ccb9dc.xlsx\" ],\r\n  \"fileNames\" : [ \"2019/06/21/6cff5e39ce09c2520ee7405588ccb9dc.xlsx\" ]\r\n}', 0, NULL, '2019-06-21 18:12:59');
INSERT INTO `sys_oper_log` VALUES (282, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"656\" ],\r\n  \"type\" : [ \"0,0\" ],\r\n  \"remark\" : [ \"876\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 10:31:00');
INSERT INTO `sys_oper_log` VALUES (283, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 14:17:52');
INSERT INTO `sys_oper_log` VALUES (284, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"22\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( category_id )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\n; Field \'name\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'name\' doesn\'t have a default value', '2019-06-24 14:18:44');
INSERT INTO `sys_oper_log` VALUES (285, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,1\" ],\r\n  \"gurtProjectTypeid\" : [ \"2\" ],\r\n  \"name\" : [ \"交通\" ],\r\n  \"id\" : [ \"1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"400\" ],\r\n  \"single_payment_cost\" : [ \"0\" ],\r\n  \"1\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"10001\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-24 14:46:47');
INSERT INTO `sys_oper_log` VALUES (286, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"17\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"\" ],\r\n  \"ending_amount\" : [ \"\" ],\r\n  \"single_payment_cost\" : [ \"\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( category_id )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'name\' doesn\'t have a default value\n; Field \'name\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'name\' doesn\'t have a default value', '2019-06-24 14:48:58');
INSERT INTO `sys_oper_log` VALUES (287, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 15:06:15');
INSERT INTO `sys_oper_log` VALUES (288, '项目基础资料', 3, 'com.ruoyi.baohan.controller.GurtCategoryController.remove()', 1, 'admin', '研发部门', '/baohan/gurtCategory/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-24 15:10:27');
INSERT INTO `sys_oper_log` VALUES (289, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"gurtProjectTypeid\" : [ \"1\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"2\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"10000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"10002\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 15:10:38');
INSERT INTO `sys_oper_log` VALUES (290, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"客户经理1\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"1231\" ]\r\n}', 0, NULL, '2019-06-24 15:25:02');
INSERT INTO `sys_oper_log` VALUES (291, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"A\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"AA\" ]\r\n}', 0, NULL, '2019-06-24 15:28:04');
INSERT INTO `sys_oper_log` VALUES (292, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"12\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"123\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'PRIMARY\'\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeCostConfigMapper.insertGurtProjectTypeCostConfig-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type_cost_config    ( id,    project_type_id,    starting_amount,    ending_amount,    single_payment_cost,    single_payment_count_type,    multiple_payment_cost,    multiple_payment_count_type,    category_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'PRIMARY\'\n; Duplicate entry \'1\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'PRIMARY\'', '2019-06-24 15:30:42');
INSERT INTO `sys_oper_log` VALUES (293, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"124\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"123\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'PRIMARY\'\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeCostConfigMapper.insertGurtProjectTypeCostConfig-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type_cost_config    ( id,    project_type_id,    starting_amount,    ending_amount,    single_payment_cost,    single_payment_count_type,    multiple_payment_cost,    multiple_payment_count_type,    category_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'PRIMARY\'\n; Duplicate entry \'1\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'PRIMARY\'', '2019-06-24 15:31:28');
INSERT INTO `sys_oper_log` VALUES (294, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"4\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"4\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'PRIMARY\'\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeCostConfigMapper.insertGurtProjectTypeCostConfig-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type_cost_config    ( id,    project_type_id,    starting_amount,    ending_amount,    single_payment_cost,    single_payment_count_type,    multiple_payment_cost,    multiple_payment_count_type,    category_id )           values ( ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'PRIMARY\'\n; Duplicate entry \'1\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'PRIMARY\'', '2019-06-24 15:33:38');
INSERT INTO `sys_oper_log` VALUES (295, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"11\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"111\" ]\r\n}', 0, NULL, '2019-06-24 15:34:05');
INSERT INTO `sys_oper_log` VALUES (296, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"gurtProjectTypeid\" : [ \"1\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"2\" ],\r\n  \"starting_amount\" : [ \"01\" ],\r\n  \"ending_amount\" : [ \"10000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"10002\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 15:47:55');
INSERT INTO `sys_oper_log` VALUES (297, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,1\" ],\r\n  \"gurtProjectTypeid\" : [ \"2\" ],\r\n  \"name\" : [ \"交通\" ],\r\n  \"id\" : [ \"1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"4000000\" ],\r\n  \"single_payment_cost\" : [ \"0\" ],\r\n  \"1\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"10001\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-24 15:48:17');
INSERT INTO `sys_oper_log` VALUES (298, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"1213\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"12\" ]\r\n}', 0, NULL, '2019-06-24 16:25:04');
INSERT INTO `sys_oper_log` VALUES (299, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"gurtProjectTypeid\" : [ \"1\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"6\" ],\r\n  \"starting_amount\" : [ \"1\" ],\r\n  \"ending_amount\" : [ \"10444\" ],\r\n  \"single_payment_cost\" : [ \"4540\" ],\r\n  \"6\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"10006\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 16:30:10');
INSERT INTO `sys_oper_log` VALUES (300, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,1\" ],\r\n  \"gurtProjectTypeid\" : [ \"2\" ],\r\n  \"name\" : [ \"交通\" ],\r\n  \"id\" : [ \"1\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"444\" ],\r\n  \"single_payment_cost\" : [ \"0\" ],\r\n  \"1\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"10001\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-24 16:30:30');
INSERT INTO `sys_oper_log` VALUES (301, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"44444\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"2312\" ]\r\n}', 0, NULL, '2019-06-24 16:31:00');
INSERT INTO `sys_oper_log` VALUES (302, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0,0,0\" ],\r\n  \"catId\" : [ \"31\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"444\", \"33\", \"3\" ],\r\n  \"ending_amount\" : [ \"444\", \"3\", \"4\" ],\r\n  \"single_payment_cost\" : [ \"1\", \"3\", \"3\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"21\", \"3\", \"3\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"0\" ],\r\n  \"31000/\" : [ \"0\" ],\r\n  \"4/\" : [ \"0\" ],\r\n  \"41000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 16:31:18');
INSERT INTO `sys_oper_log` VALUES (303, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"1000000\", \"441\" ],\r\n  \"ending_amount\" : [ \"44\", \"23213\" ],\r\n  \"single_payment_cost\" : [ \"1\", \"4\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"421\", \"41\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"0\" ],\r\n  \"31000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 16:34:35');
INSERT INTO `sys_oper_log` VALUES (304, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"4\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"4\" ]\r\n}', 0, NULL, '2019-06-24 16:34:53');
INSERT INTO `sys_oper_log` VALUES (305, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0,0,0\" ],\r\n  \"gurtProjectTypeid\" : [ \"1\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"15\", \"16\", \"17\" ],\r\n  \"starting_amount\" : [ \"1\", \"1000000\", \"441\" ],\r\n  \"ending_amount\" : [ \"10000\", \"44\", \"23213\" ],\r\n  \"single_payment_cost\" : [ \"450\", \"1444\", \"4444\" ],\r\n  \"15\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"144\", \"421\", \"414\" ],\r\n  \"10015\" : [ \"0\" ],\r\n  \"16\" : [ \"0\" ],\r\n  \"10016\" : [ \"0\" ],\r\n  \"17\" : [ \"0\" ],\r\n  \"10017\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 16:35:06');
INSERT INTO `sys_oper_log` VALUES (306, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"123\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"4\" ]\r\n}', 0, NULL, '2019-06-24 16:40:03');
INSERT INTO `sys_oper_log` VALUES (307, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,1\" ],\r\n  \"gurtProjectTypeid\" : [ \"2\" ],\r\n  \"name\" : [ \"交通\" ],\r\n  \"id\" : [ \"18\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"4445\" ],\r\n  \"single_payment_cost\" : [ \"0\" ],\r\n  \"18\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1\" ],\r\n  \"10018\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-24 16:40:55');
INSERT INTO `sys_oper_log` VALUES (308, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\", \"1000\" ],\r\n  \"ending_amount\" : [ \"1000\", \"2000\" ],\r\n  \"single_payment_cost\" : [ \"450\", \"500\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"0\" ],\r\n  \"31000/\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( name )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'category_id\' doesn\'t have a default value', '2019-06-24 16:44:35');
INSERT INTO `sys_oper_log` VALUES (309, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\", \"1000\" ],\r\n  \"ending_amount\" : [ \"1000\", \"2000\" ],\r\n  \"single_payment_cost\" : [ \"450\", \"500\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"0\" ],\r\n  \"31000/\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( name )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'category_id\' doesn\'t have a default value', '2019-06-24 16:44:40');
INSERT INTO `sys_oper_log` VALUES (310, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1100\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( name )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'category_id\' doesn\'t have a default value', '2019-06-24 16:50:17');
INSERT INTO `sys_oper_log` VALUES (311, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1100\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( name )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'category_id\' doesn\'t have a default value', '2019-06-24 16:51:35');
INSERT INTO `sys_oper_log` VALUES (312, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"1100\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( name )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'category_id\' doesn\'t have a default value', '2019-06-24 16:52:53');
INSERT INTO `sys_oper_log` VALUES (313, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"10000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\r\n### The error may involve com.ruoyi.baohan.mapper.GurtProjectTypeMapper.insertGurtProjectType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_project_type    ( `name` )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'category_id\' doesn\'t have a default value\n; Field \'category_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'category_id\' doesn\'t have a default value', '2019-06-24 17:00:13');
INSERT INTO `sys_oper_log` VALUES (314, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"10000\" ],\r\n  \"single_payment_cost\" : [ \"450\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 17:01:50');
INSERT INTO `sys_oper_log` VALUES (315, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0,0,0,0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"交通\" ],\r\n  \"starting_amount\" : [ \"0\", \"20000\", \"30000\" ],\r\n  \"ending_amount\" : [ \"10000\", \"30000\", \"40000\" ],\r\n  \"single_payment_cost\" : [ \"400\", \"450\", \"500\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\", \"400\", \"450\" ],\r\n  \"21000/\" : [ \"0\" ],\r\n  \"3/\" : [ \"0\" ],\r\n  \"31000/\" : [ \"0\" ],\r\n  \"4/\" : [ \"0\" ],\r\n  \"41000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 17:02:56');
INSERT INTO `sys_oper_log` VALUES (316, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtCategory/add', '127.0.0.1', '内网IP', '{\r\n  \"name\" : [ \"测试类目1\" ],\r\n  \"type\" : [ \"\" ],\r\n  \"remark\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-24 17:03:21');
INSERT INTO `sys_oper_log` VALUES (317, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"gurtProjectTypeid\" : [ \"10\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"26\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"10000\" ],\r\n  \"single_payment_cost\" : [ \"10000\" ],\r\n  \"26\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"10026\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-24 17:03:40');
INSERT INTO `sys_oper_log` VALUES (318, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"2012-1-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"3224\" ],\r\n  \"money\" : [ \"11\", \"3213\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/24/e57beb44a84021f489c0a9447b12823e.png,http://localhost/profile/upload/2019/06/24/93a58b2798385db892a7660d0b358735.xlsx\" ],\r\n  \"fileNames\" : [ \"2019/06/24/e57beb44a84021f489c0a9447b12823e.png,2019/06/24/93a58b2798385db892a7660d0b358735.xlsx\" ]\r\n}', 1, 'Invalid bound statement (not found): com.ruoyi.baohan.mapper.GurtOrderMapper.insertOrderFile', '2019-06-24 17:53:34');
INSERT INTO `sys_oper_log` VALUES (319, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"2012-1-1\" ],\r\n  \"guaranteeId\" : [ \"3\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"244\" ],\r\n  \"money\" : [ \"133\", \"111\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/24/249060739e776c3bb2549edad295a26a.docx,http://localhost/profile/upload/2019/06/24/67a0016e28974c64cbbe7a322d077af8.xls\" ],\r\n  \"fileNames\" : [ \"2019/06/24/249060739e776c3bb2549edad295a26a.docx,2019/06/24/67a0016e28974c64cbbe7a322d077af8.xls\" ]\r\n}', 1, 'Invalid bound statement (not found): com.ruoyi.baohan.mapper.GurtOrderMapper.insertOrderFile', '2019-06-24 17:56:43');
INSERT INTO `sys_oper_log` VALUES (320, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"100\" ],\r\n  \"money\" : [ \"100\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,http://localhost/profile/upload/2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ],\r\n  \"fileNames\" : [ \"2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ]\r\n}', 1, 'Invalid bound statement (not found): com.ruoyi.baohan.mapper.GurtOrderMapper.insertOrderFile', '2019-06-24 17:59:31');
INSERT INTO `sys_oper_log` VALUES (321, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"100\" ],\r\n  \"money\" : [ \"100\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,http://localhost/profile/upload/2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ],\r\n  \"fileNames\" : [ \"2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ]\r\n}', 1, 'Invalid bound statement (not found): com.ruoyi.baohan.mapper.GurtOrderMapper.insertOrderFile', '2019-06-24 18:01:16');
INSERT INTO `sys_oper_log` VALUES (322, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"100\" ],\r\n  \"money\" : [ \"100\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,http://localhost/profile/upload/2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ],\r\n  \"fileNames\" : [ \"2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ]\r\n}', 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'orderId\' not found. Available parameters are [arg1, arg0, param1, param2]', '2019-06-24 18:06:34');
INSERT INTO `sys_oper_log` VALUES (323, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"100\" ],\r\n  \"money\" : [ \"100\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,http://localhost/profile/upload/2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ],\r\n  \"fileNames\" : [ \"2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'orderId\' in \'field list\'\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order_file(`orderId`,paid_amount)         value (?,?)\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'orderId\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'orderId\' in \'field list\'', '2019-06-24 18:07:59');
INSERT INTO `sys_oper_log` VALUES (324, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"100\" ],\r\n  \"money\" : [ \"100\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,http://localhost/profile/upload/2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ],\r\n  \"fileNames\" : [ \"2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'paid_amount\' in \'field list\'\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order_file(`order_id`,paid_amount)         value (?,?)\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'paid_amount\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'paid_amount\' in \'field list\'', '2019-06-24 18:09:38');
INSERT INTO `sys_oper_log` VALUES (325, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"100\" ],\r\n  \"money\" : [ \"100\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,http://localhost/profile/upload/2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ],\r\n  \"fileNames\" : [ \"2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'paid_amount\' in \'field list\'\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into gurt_order_file(`order_id`,paid_amount)          value (?,?)\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'paid_amount\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'paid_amount\' in \'field list\'', '2019-06-24 18:10:31');
INSERT INTO `sys_oper_log` VALUES (326, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"1\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"100\" ],\r\n  \"money\" : [ \"100\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,http://localhost/profile/upload/2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ],\r\n  \"fileNames\" : [ \"2019/06/24/3e75a4ba51136c5ac996b70668c78eff.docx,2019/06/24/0135a08dd7721e49313cde0a4fb694c5.docx\" ]\r\n}', 0, NULL, '2019-06-24 18:11:37');
INSERT INTO `sys_oper_log` VALUES (327, '订单', 3, 'com.ruoyi.baohan.controller.GurtOrderController.remove()', 1, 'admin', '研发部门', '/baohan/gurtOrder/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"3\" ]\r\n}', 0, NULL, '2019-06-24 18:12:04');
INSERT INTO `sys_oper_log` VALUES (328, '订单', 3, 'com.ruoyi.baohan.controller.GurtOrderController.remove()', 1, 'admin', '研发部门', '/baohan/gurtOrder/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"1,2\" ]\r\n}', 0, NULL, '2019-06-24 18:12:34');
INSERT INTO `sys_oper_log` VALUES (329, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"2\" ],\r\n  \"roleName\" : [ \"普通角色\" ],\r\n  \"roleKey\" : [ \"common\" ],\r\n  \"roleSort\" : [ \"3\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"普通角色\" ],\r\n  \"menuIds\" : [ \"3,2030,2031,2032,2033,2034\" ]\r\n}', 0, NULL, '2019-06-25 10:17:58');
INSERT INTO `sys_oper_log` VALUES (330, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"3,2030,2031,2032,2033,2034,2057,2059\" ]\r\n}', 0, NULL, '2019-06-25 10:18:05');
INSERT INTO `sys_oper_log` VALUES (331, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"2\" ],\r\n  \"roleName\" : [ \"普通角色\" ],\r\n  \"roleKey\" : [ \"common\" ],\r\n  \"roleSort\" : [ \"3\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"普通角色\" ],\r\n  \"menuIds\" : [ \"3,2030,2031,2032,2033,2034,2057,2059\" ]\r\n}', 0, NULL, '2019-06-25 10:22:18');
INSERT INTO `sys_oper_log` VALUES (332, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"2\" ],\r\n  \"beneficiary\" : [ \"2\" ],\r\n  \"projectNumber\" : [ \"2\" ],\r\n  \"projectName\" : [ \"2\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"11\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"11\" ],\r\n  \"money\" : [ \"11\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/25/fef651dad4c66416a1cd0eb81c499b62.png\" ],\r\n  \"fileNames\" : [ \"2019/06/25/fef651dad4c66416a1cd0eb81c499b62.png\" ]\r\n}', 0, NULL, '2019-06-25 10:26:37');
INSERT INTO `sys_oper_log` VALUES (333, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"3\" ],\r\n  \"beneficiary\" : [ \"3\" ],\r\n  \"projectNumber\" : [ \"3\" ],\r\n  \"projectName\" : [ \"3\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"10000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"\" ],\r\n  \"paidamount\" : [ \"3\" ],\r\n  \"money\" : [ \"3\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/25/41fa36fd47167d526a0bbaa3f0666c62.xls\" ],\r\n  \"fileNames\" : [ \"2019/06/25/41fa36fd47167d526a0bbaa3f0666c62.xls\" ]\r\n}', 0, NULL, '2019-06-25 10:26:51');
INSERT INTO `sys_oper_log` VALUES (334, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"4\" ],\r\n  \"beneficiary\" : [ \"4\" ],\r\n  \"projectNumber\" : [ \"4\" ],\r\n  \"projectName\" : [ \"4\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"10000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"\" ],\r\n  \"paidamount\" : [ \"1\" ],\r\n  \"money\" : [ \"1\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/25/31c8dc5b2e4ea9f2cfeebbf72838d95a.png\" ],\r\n  \"fileNames\" : [ \"2019/06/25/31c8dc5b2e4ea9f2cfeebbf72838d95a.png\" ]\r\n}', 0, NULL, '2019-06-25 10:27:09');
INSERT INTO `sys_oper_log` VALUES (335, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"5\" ],\r\n  \"beneficiary\" : [ \"5\" ],\r\n  \"projectNumber\" : [ \"5\" ],\r\n  \"projectName\" : [ \"5\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"155\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"1111\" ],\r\n  \"money\" : [ \"1111\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/25/5fc982b066a5cd58176ff9625bc01011.png\" ],\r\n  \"fileNames\" : [ \"2019/06/25/5fc982b066a5cd58176ff9625bc01011.png\" ]\r\n}', 0, NULL, '2019-06-25 10:27:23');
INSERT INTO `sys_oper_log` VALUES (336, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"gurtProjectTypeid\" : [ \"10\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"22\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"10000\" ],\r\n  \"single_payment_cost\" : [ \"1000\" ],\r\n  \"22\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"10022\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-25 15:08:47');
INSERT INTO `sys_oper_log` VALUES (337, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"gurtProjectTypeid\" : [ \"10\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"26\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"500\" ],\r\n  \"single_payment_cost\" : [ \"10000\" ],\r\n  \"26\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"10026\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-25 15:09:04');
INSERT INTO `sys_oper_log` VALUES (338, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtProjectTypeCostConfigController.modifyConf()', 1, 'admin', '研发部门', '/baohan/gurtProjectTypeCostConfig/modifyConf', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"gurtProjectTypeid\" : [ \"10\" ],\r\n  \"name\" : [ \"市政\" ],\r\n  \"id\" : [ \"26\" ],\r\n  \"starting_amount\" : [ \"0\" ],\r\n  \"ending_amount\" : [ \"10000\" ],\r\n  \"single_payment_cost\" : [ \"500\" ],\r\n  \"26\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"350\" ],\r\n  \"10026\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-25 15:09:49');
INSERT INTO `sys_oper_log` VALUES (339, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"7\" ],\r\n  \"beneficiary\" : [ \"7\" ],\r\n  \"projectNumber\" : [ \"7\" ],\r\n  \"projectName\" : [ \"7\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"100\" ],\r\n  \"money\" : [ \"100\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/25/07e50ba9bea0e157103923feb4bae8d1.png,http://localhost/profile/upload/2019/06/25/eb7b6641b365cd9fa7d4e51289c77d26.docx,http://localhost/profile/upload/2019/06/25/b334bc6acd9a8d2bb7459dfbd0fef43b.xls\" ],\r\n  \"fileNames\" : [ \"2019/06/25/07e50ba9bea0e157103923feb4bae8d1.png,2019/06/25/eb7b6641b365cd9fa7d4e51289c77d26.docx,2019/06/25/b334bc6acd9a8d2bb7459dfbd0fef43b.xls\" ]\r\n}', 0, NULL, '2019-06-25 15:11:29');
INSERT INTO `sys_oper_log` VALUES (340, '订单', 3, 'com.ruoyi.baohan.controller.GurtOrderController.remove()', 1, 'admin', '研发部门', '/baohan/gurtOrder/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"13,14,15,16,17,12\" ]\r\n}', 0, NULL, '2019-06-25 16:33:40');
INSERT INTO `sys_oper_log` VALUES (341, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'ry', '测试部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"测试客户1有邀请人1提成\" ],\r\n  \"beneficiary\" : [ \"测试\" ],\r\n  \"projectNumber\" : [ \"测试\" ],\r\n  \"projectName\" : [ \"测试\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"300\" ],\r\n  \"money\" : [ \"100\", \"200\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/25/cd390b11b5a90c8814ce6cf648817c60.xlsx,http://localhost/profile/upload/2019/06/25/24d299e5bda6daee51a316c8d146e570.png\" ],\r\n  \"fileNames\" : [ \"2019/06/25/cd390b11b5a90c8814ce6cf648817c60.xlsx,2019/06/25/24d299e5bda6daee51a316c8d146e570.png\" ]\r\n}', 0, NULL, '2019-06-25 16:39:36');
INSERT INTO `sys_oper_log` VALUES (342, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"测试客户1有邀请人1无提成\\t\" ],\r\n  \"beneficiary\" : [ \"测试\" ],\r\n  \"projectNumber\" : [ \"测试\" ],\r\n  \"projectName\" : [ \"测试\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money\" : [ \"\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/25/4e8d0633c8bd332153184359ca5373ba.docx\" ],\r\n  \"fileNames\" : [ \"2019/06/25/4e8d0633c8bd332153184359ca5373ba.docx\" ]\r\n}', 0, NULL, '2019-06-25 16:45:20');
INSERT INTO `sys_oper_log` VALUES (343, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"starting_amount\" : [ \"20000\" ],\r\n  \"ending_amount\" : [ \"30000\" ],\r\n  \"single_payment_cost\" : [ \"1500\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"1000\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-25 17:14:07');
INSERT INTO `sys_oper_log` VALUES (344, '项目基础资料', 1, 'com.ruoyi.baohan.controller.GurtCategoryController.addType()', 1, 'admin', '研发部门', '/baohan/gurtCategory/addType', '127.0.0.1', '内网IP', '{\r\n  \"type\" : [ \"0,0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"projectName\" : [ \"\" ],\r\n  \"starting_amount\" : [ \"10000\" ],\r\n  \"ending_amount\" : [ \"20000\" ],\r\n  \"single_payment_cost\" : [ \"800\" ],\r\n  \"2/\" : [ \"0\" ],\r\n  \"multiple_payment_cost\" : [ \"700\" ],\r\n  \"21000/\" : [ \"0\" ]\r\n}', 0, NULL, '2019-06-25 17:14:48');
INSERT INTO `sys_oper_log` VALUES (345, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"4\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money\" : [ \"\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/d5b116500a79bbcdd8ed69ba9ff5195b.xlsx\" ],\r\n  \"fileNames\" : [ \"file\" ]\r\n}', 0, NULL, '2019-06-26 09:22:55');
INSERT INTO `sys_oper_log` VALUES (346, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', NULL, '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"1\" ],\r\n  \"beneficiary\" : [ \"1\" ],\r\n  \"projectNumber\" : [ \"1\" ],\r\n  \"projectName\" : [ \"市政\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money\" : [ \"\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/8f609649a0a98bfb9805576a0af61901.png,http://localhost/profile/upload/2019/06/26/e9259d2bef235ec71da0ff075f361ee7.xls,http://localhost/profile/upload/2019/06/26/2d8a11ace46a312b5d4f9e6107fb7701.docx\" ],\r\n  \"fileNames\" : [ \"file,file,加班申请及打卡规则.docx\" ]\r\n}', 0, NULL, '2019-06-26 09:27:10');
INSERT INTO `sys_oper_log` VALUES (347, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"2\" ],\r\n  \"beneficiary\" : [ \"2\" ],\r\n  \"projectNumber\" : [ \"2\" ],\r\n  \"projectName\" : [ \"2\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money\" : [ \"\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/7b2cb73359e6d5b58f7eff4f74d057cf.xlsx,http://localhost/profile/upload/2019/06/26/ee1c5b337b6559dd0d7471a1e1107cfd.png\" ],\r\n  \"fileNames\" : [ \"问题.xlsx,名片-0626_画板 1 副本.png\" ]\r\n}', 0, NULL, '2019-06-26 09:28:52');
INSERT INTO `sys_oper_log` VALUES (348, '订单', 3, 'com.ruoyi.baohan.controller.GurtOrderController.remove()', 1, 'admin', '研发部门', '/baohan/gurtOrder/remove', '127.0.0.1', '内网IP', '{\r\n  \"ids\" : [ \"20,21,22\" ]\r\n}', 0, NULL, '2019-06-26 09:29:33');
INSERT INTO `sys_oper_log` VALUES (349, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money\" : [ \"\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/2c9faa22ee545a9626dc5a25467d1507.docx\" ],\r\n  \"fileNames\" : [ \"保函格式十三份_2_.docx\" ]\r\n}', 0, NULL, '2019-06-26 09:30:00');
INSERT INTO `sys_oper_log` VALUES (350, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', NULL, '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"123\" ],\r\n  \"beneficiary\" : [ \"231\" ],\r\n  \"projectNumber\" : [ \"123\" ],\r\n  \"projectName\" : [ \"213\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money\" : [ \"\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/50898428a10fa12ad3eeb424a88cec73.docx\" ],\r\n  \"fileNames\" : [ \"个人所得税通知.docx\" ]\r\n}', 0, NULL, '2019-06-26 09:41:24');
INSERT INTO `sys_oper_log` VALUES (351, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"测试文件\" ],\r\n  \"beneficiary\" : [ \"测试文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"测试文件\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"10001\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"800\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"money\" : [ \"\", \"\", \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/39d8338170a2c47676c172957d999a49.png,http://localhost/profile/upload/2019/06/26/f5c1fd02a9e8bab4b2ffd0961374a9e6.xlsx,http://localhost/profile/upload/2019/06/26/5737e58496d173a8d20c1b4c1fc88384.docx,http://localhost/profile/upload/2019/06/26/66cfcb618376ba1ddf93243c3bd0c94c.xls\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,问题.xlsx,加班申请及打卡规则.docx,后台样式0516.xls\" ]\r\n}', 0, NULL, '2019-06-26 13:59:19');
INSERT INTO `sys_oper_log` VALUES (352, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"10001\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"800\" ],\r\n  \"paidamount\" : [ \"700\" ],\r\n  \"money\" : [ \"400\", \"200\", \"100\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/1631cb0b676c25a3de8ee20671b04ba8.xls,http://localhost/profile/upload/2019/06/26/4e676be1065464574bff7b2bee5f80a9.png,http://localhost/profile/upload/2019/06/26/a5fa9a7a193024a72121db19d787ad0f.xlsx,http://localhost/profile/upload/2019/06/26/f4d033e0ba3b6a4bd5a5efede88ac6c1.docx\" ],\r\n  \"fileNames\" : [ \"后台样式0516.xls,名片-0626_画板 1 副本.png,问题.xlsx,加班申请及打卡规则.docx\" ]\r\n}', 0, NULL, '2019-06-26 14:51:47');
INSERT INTO `sys_oper_log` VALUES (353, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"26\" ],\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1500\" ],\r\n  \"paidamount\" : [ \"700\" ],\r\n  \"money\" : [ \"400\", \"200\", \"100\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-26 16:23:02');
INSERT INTO `sys_oper_log` VALUES (354, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"26\" ],\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"4\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1500\" ],\r\n  \"paidamount\" : [ \"700\" ],\r\n  \"money\" : [ \"400\", \"200\", \"100\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-26 16:23:14');
INSERT INTO `sys_oper_log` VALUES (355, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"26\" ],\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"4\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"11\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"700\" ],\r\n  \"money\" : [ \"400\", \"200\", \"100\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-26 16:23:19');
INSERT INTO `sys_oper_log` VALUES (356, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"26\" ],\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"4\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"11\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"700\" ],\r\n  \"money\" : [ \"400\", \"200\", \"100\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-26 16:23:39');
INSERT INTO `sys_oper_log` VALUES (357, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"26\" ],\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"4\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"11\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"700\" ],\r\n  \"money\" : [ \"400\", \"200\", \"100\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/b42f22849f2e10077fb6a9769f714b39.png,http://localhost/profile/upload/2019/06/26/50e68ae1c8a31dda6e5a43216020521f.xlsx\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,问题.xlsx\" ]\r\n}', 0, NULL, '2019-06-26 16:23:52');
INSERT INTO `sys_oper_log` VALUES (358, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"26\" ],\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"4\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"11\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"1000\" ],\r\n  \"money\" : [ \"100\", \"200\", \"300\", \"400\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-26 16:24:18');
INSERT INTO `sys_oper_log` VALUES (359, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"26\" ],\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"3\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1500\" ],\r\n  \"paidamount\" : [ \"1900\" ],\r\n  \"money\" : [ \"1000\", \"200\", \"300\", \"400\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-26 16:24:40');
INSERT INTO `sys_oper_log` VALUES (360, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"26\" ],\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"3\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1500\" ],\r\n  \"paidamount\" : [ \"1900\" ],\r\n  \"money\" : [ \"1000\", \"200\", \"300\", \"400\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/e62c92124c7f951d4c269852f9815b11.png,http://localhost/profile/upload/2019/06/26/235ab8c34d6781e2f1869f87663a903d.xlsx,http://localhost/profile/upload/2019/06/26/c81032b7120277ce0a61721d59b2374a.xls,http://localhost/profile/upload/2019/06/26/ce11dde8fd4673009fbc7e13b9fa9b0a.docx\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,问题.xlsx,后台样式0516.xls,加班申请及打卡规则.docx\" ]\r\n}', 0, NULL, '2019-06-26 16:25:25');
INSERT INTO `sys_oper_log` VALUES (361, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"26\" ],\r\n  \"warrantee\" : [ \"已收金额测试\" ],\r\n  \"beneficiary\" : [ \"已收金额测试\" ],\r\n  \"projectNumber\" : [ \"已收金额测试\" ],\r\n  \"projectName\" : [ \"已收金额测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"3\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"11\" ],\r\n  \"amount\" : [ \"450\" ],\r\n  \"paidamount\" : [ \"3700\" ],\r\n  \"money\" : [ \"1000\", \"2000\", \"300\", \"400\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/26/0b11cf70b58b552d07f1d8fe83d5ebe3.png,http://localhost/profile/upload/2019/06/26/d92bae45bd27a42f5a6983b7297ef18a.xlsx\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,问题.xlsx\" ]\r\n}', 0, NULL, '2019-06-26 16:25:38');
INSERT INTO `sys_oper_log` VALUES (362, '岗位管理', 5, 'com.ruoyi.web.controller.system.SysPostController.export()', 1, 'admin', '研发部门', '/system/post/export', '127.0.0.1', '内网IP', '{\r\n  \"postCode\" : [ \"\" ],\r\n  \"postName\" : [ \"\" ],\r\n  \"status\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-26 17:02:20');
INSERT INTO `sys_oper_log` VALUES (363, '岗位管理', 5, 'com.ruoyi.web.controller.system.SysPostController.export()', 1, 'admin', '研发部门', '/system/post/export', '127.0.0.1', '内网IP', '{\r\n  \"postCode\" : [ \"\" ],\r\n  \"postName\" : [ \"\" ],\r\n  \"status\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-26 17:02:41');
INSERT INTO `sys_oper_log` VALUES (364, '岗位管理', 5, 'com.ruoyi.web.controller.system.SysPostController.export()', 1, 'admin', '研发部门', '/system/post/export', '127.0.0.1', '内网IP', '{\r\n  \"postCode\" : [ \"\" ],\r\n  \"postName\" : [ \"\" ],\r\n  \"status\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-26 17:03:05');
INSERT INTO `sys_oper_log` VALUES (365, '登陆日志', 9, 'com.ruoyi.web.controller.monitor.SysLogininforController.clean()', 1, 'admin', '研发部门', '/monitor/logininfor/clean', '127.0.0.1', '内网IP', '{ }', 0, NULL, '2019-06-26 17:21:27');
INSERT INTO `sys_oper_log` VALUES (366, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"23\" ],\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 1, '', '2019-06-27 09:41:45');
INSERT INTO `sys_oper_log` VALUES (367, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"23\" ],\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/27/7dde767b3ca4927d6e9ffb55d50ebb2a.png,http://localhost/profile/upload/2019/06/27/edc577fca983fc9ce37b88a6f2049674.xlsx,http://localhost/profile/upload/2019/06/27/96ca6ba5d5d34048144cbfd86d0a54ad.xls,http://localhost/profile/upload/2019/06/27/2423bc2d548b55b870fc473b8f5de2c7.docx\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,问题.xlsx,后台样式0516.xls,加班申请及打卡规则.docx\" ]\r\n}', 1, '', '2019-06-27 09:41:55');
INSERT INTO `sys_oper_log` VALUES (368, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"25\" ],\r\n  \"warrantee\" : [ \"测试文件\" ],\r\n  \"beneficiary\" : [ \"测试文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"测试文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"10001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"800\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/27/6e57e0e0dc27010f9b5a016bfe6add1b.png,http://localhost/profile/upload/2019/06/27/8b41ff451bbe9e4c93741897b8caa84e.xls,http://localhost/profile/upload/2019/06/27/a2a164a3b14ffa6c724221c88e224a84.xlsx,http://localhost/profile/upload/2019/06/27/2fa9483c3612d819ebacf23439d17868.docx,http://localhost/profile/upload/2019/06/27/c4acc8d178d1875e0c96a5c4a26da194.docx\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,后台样式0516.xls,问题.xlsx,个人所得税通知.docx,加班申请及打卡规则.docx\" ]\r\n}', 1, '', '2019-06-27 09:42:36');
INSERT INTO `sys_oper_log` VALUES (369, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"25\" ],\r\n  \"warrantee\" : [ \"测试文件\" ],\r\n  \"beneficiary\" : [ \"测试文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"测试文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"10001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"800\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/27/6e57e0e0dc27010f9b5a016bfe6add1b.png,http://localhost/profile/upload/2019/06/27/8b41ff451bbe9e4c93741897b8caa84e.xls,http://localhost/profile/upload/2019/06/27/a2a164a3b14ffa6c724221c88e224a84.xlsx,http://localhost/profile/upload/2019/06/27/2fa9483c3612d819ebacf23439d17868.docx,http://localhost/profile/upload/2019/06/27/c4acc8d178d1875e0c96a5c4a26da194.docx\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,后台样式0516.xls,问题.xlsx,个人所得税通知.docx,加班申请及打卡规则.docx\" ]\r\n}', 1, '', '2019-06-27 09:42:45');
INSERT INTO `sys_oper_log` VALUES (370, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"25\" ],\r\n  \"warrantee\" : [ \"测试文件\" ],\r\n  \"beneficiary\" : [ \"测试文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"测试文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"10001\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"800\" ],\r\n  \"paidamount\" : [ \"100\" ],\r\n  \"money\" : [ \"100\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/27/6e57e0e0dc27010f9b5a016bfe6add1b.png,http://localhost/profile/upload/2019/06/27/8b41ff451bbe9e4c93741897b8caa84e.xls,http://localhost/profile/upload/2019/06/27/a2a164a3b14ffa6c724221c88e224a84.xlsx,http://localhost/profile/upload/2019/06/27/2fa9483c3612d819ebacf23439d17868.docx,http://localhost/profile/upload/2019/06/27/c4acc8d178d1875e0c96a5c4a26da194.docx\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,后台样式0516.xls,问题.xlsx,个人所得税通知.docx,加班申请及打卡规则.docx\" ]\r\n}', 0, NULL, '2019-06-27 09:43:06');
INSERT INTO `sys_oper_log` VALUES (371, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"23\" ],\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 1, '', '2019-06-27 09:54:24');
INSERT INTO `sys_oper_log` VALUES (372, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"23\" ],\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 1, '', '2019-06-27 09:55:22');
INSERT INTO `sys_oper_log` VALUES (373, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"23\" ],\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 1, '', '2019-06-27 09:56:14');
INSERT INTO `sys_oper_log` VALUES (374, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"23\" ],\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 1, '', '2019-06-27 09:57:15');
INSERT INTO `sys_oper_log` VALUES (375, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"23\" ],\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-27 09:58:03');
INSERT INTO `sys_oper_log` VALUES (376, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"23\" ],\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-27 09:58:09');
INSERT INTO `sys_oper_log` VALUES (377, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"23\" ],\r\n  \"warrantee\" : [ \"文件\" ],\r\n  \"beneficiary\" : [ \"文件1\" ],\r\n  \"projectNumber\" : [ \"文件\" ],\r\n  \"projectName\" : [ \"文件\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"2\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-27 09:58:16');
INSERT INTO `sys_oper_log` VALUES (378, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"104\" ],\r\n  \"userName\" : [ \"二维码测试1\" ],\r\n  \"deptName\" : [ \"市场部门\" ],\r\n  \"phonenumber\" : [ \"15241423434\" ],\r\n  \"email\" : [ \"impor1nt@163.com\" ],\r\n  \"loginName\" : [ \"啊2314\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"role\" : [ \"1\", \"2\", \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1,2,3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 10:27:13');
INSERT INTO `sys_oper_log` VALUES (379, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"109\" ],\r\n  \"userName\" : [ \"4\" ],\r\n  \"deptName\" : [ \"财务部门\" ],\r\n  \"phonenumber\" : [ \"15241423432\" ],\r\n  \"email\" : [ \"importjant3@163.com\" ],\r\n  \"loginName\" : [ \"啊2311213\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"catId\" : [ \"34\" ],\r\n  \"role\" : [ \"1\", \"2\", \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1,2,3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:07:36');
INSERT INTO `sys_oper_log` VALUES (380, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"108\" ],\r\n  \"userName\" : [ \"1123\" ],\r\n  \"deptName\" : [ \"市场部门\" ],\r\n  \"phonenumber\" : [ \"15241423434\" ],\r\n  \"email\" : [ \"importj3nt@163.com\" ],\r\n  \"loginName\" : [ \"啊2312\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"role\" : [ \"1\", \"2\", \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1,2,3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:10:25');
INSERT INTO `sys_oper_log` VALUES (381, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"108\" ],\r\n  \"userName\" : [ \"1123\" ],\r\n  \"deptName\" : [ \"市场部门\" ],\r\n  \"phonenumber\" : [ \"15241423434\" ],\r\n  \"email\" : [ \"importjant@163.com\" ],\r\n  \"loginName\" : [ \"啊231\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"role\" : [ \"1\", \"2\", \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1,2,3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:17:21');
INSERT INTO `sys_oper_log` VALUES (382, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"1123\" ],\r\n  \"deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"15241423434\" ],\r\n  \"email\" : [ \"importj3nt@163.com\" ],\r\n  \"loginName\" : [ \"啊231\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"role\" : [ \"1\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:18:58');
INSERT INTO `sys_oper_log` VALUES (383, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"106\" ],\r\n  \"userName\" : [ \"1123\" ],\r\n  \"deptName\" : [ \"财务部门\" ],\r\n  \"phonenumber\" : [ \"15244443332\" ],\r\n  \"email\" : [ \"importjant@163.com\" ],\r\n  \"loginName\" : [ \"啊2312\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"role\" : [ \"1\", \"2\", \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1,2,3\" ],\r\n  \"postIds\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-27 11:21:22');
INSERT INTO `sys_oper_log` VALUES (384, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', '研发部门', '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"1123\" ],\r\n  \"deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"15241423434\" ],\r\n  \"email\" : [ \"impor1ant@163.com\" ],\r\n  \"loginName\" : [ \"啊23121\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"role\" : [ \"1\", \"2\", \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1,2,3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:26:45');
INSERT INTO `sys_oper_log` VALUES (385, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', NULL, '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"106\" ],\r\n  \"userName\" : [ \"1123\" ],\r\n  \"deptName\" : [ \"财务部门\" ],\r\n  \"phonenumber\" : [ \"15241423434\" ],\r\n  \"email\" : [ \"3nt@163.com\" ],\r\n  \"loginName\" : [ \"啊2317\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"role\" : [ \"2\", \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"2,3\" ],\r\n  \"postIds\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-27 11:28:53');
INSERT INTO `sys_oper_log` VALUES (386, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', NULL, '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"103\" ],\r\n  \"userName\" : [ \"65\" ],\r\n  \"deptName\" : [ \"研发部门\" ],\r\n  \"phonenumber\" : [ \"15244443332\" ],\r\n  \"email\" : [ \"importj3nt@163.com\" ],\r\n  \"loginName\" : [ \"啊2312\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"2\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"role\" : [ \"1\", \"2\", \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1,2,3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:32:27');
INSERT INTO `sys_oper_log` VALUES (387, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.addSave()', 1, 'admin', NULL, '/system/user/add', '127.0.0.1', '内网IP', '{\r\n  \"deptId\" : [ \"104\" ],\r\n  \"userName\" : [ \"1123\" ],\r\n  \"deptName\" : [ \"市场部门\" ],\r\n  \"phonenumber\" : [ \"15244443132\" ],\r\n  \"email\" : [ \"imporja1nt@163.com\" ],\r\n  \"loginName\" : [ \"啊231\" ],\r\n  \"password\" : [ \"123456\" ],\r\n  \"sex\" : [ \"0\" ],\r\n  \"catId\" : [ \"0\" ],\r\n  \"role\" : [ \"2\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"2\" ],\r\n  \"postIds\" : [ \"3\" ]\r\n}', 0, NULL, '2019-06-27 11:33:58');
INSERT INTO `sys_oper_log` VALUES (388, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"8\" ],\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"65\" ],\r\n  \"dept.deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"18845677894\" ],\r\n  \"email\" : [ \"imporjant@163.com\" ],\r\n  \"loginName\" : [ \"manager\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"role\" : [ \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:37:21');
INSERT INTO `sys_oper_log` VALUES (389, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"8\" ],\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"65\" ],\r\n  \"dept.deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"18845677894\" ],\r\n  \"email\" : [ \"imporjant@163.com\" ],\r\n  \"loginName\" : [ \"manager\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"role\" : [ \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:38:26');
INSERT INTO `sys_oper_log` VALUES (390, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"8\" ],\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"65\" ],\r\n  \"dept.deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"18845677894\" ],\r\n  \"email\" : [ \"imporjant@163.com\" ],\r\n  \"loginName\" : [ \"manager\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"role\" : [ \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:39:37');
INSERT INTO `sys_oper_log` VALUES (391, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"8\" ],\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"65\" ],\r\n  \"dept.deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"18845677894\" ],\r\n  \"email\" : [ \"imporjant@163.com\" ],\r\n  \"loginName\" : [ \"manager\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"role\" : [ \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'http://localhost/profile/upload/pLVzl15KYznP.jpg\',\n 			update_time = sysdate() \' at line 16\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET dept_id = ?,     login_name = ?,     user_name = ?,     email = ?,     phonenumber = ?,     sex = ?,                    status = ?,               update_by = ?,         ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'http://localhost/profile/upload/pLVzl15KYznP.jpg\',\n 			update_time = sysdate() \' at line 16\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'http://localhost/profile/upload/pLVzl15KYznP.jpg\',\n 			update_time = sysdate() \' at line 16', '2019-06-27 11:40:53');
INSERT INTO `sys_oper_log` VALUES (392, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"8\" ],\r\n  \"deptId\" : [ \"105\" ],\r\n  \"userName\" : [ \"65\" ],\r\n  \"dept.deptName\" : [ \"测试部门\" ],\r\n  \"phonenumber\" : [ \"18845677894\" ],\r\n  \"email\" : [ \"imporjant@163.com\" ],\r\n  \"loginName\" : [ \"manager\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"role\" : [ \"3\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"3\" ],\r\n  \"postIds\" : [ \"2\" ]\r\n}', 0, NULL, '2019-06-27 11:42:37');
INSERT INTO `sys_oper_log` VALUES (393, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"1\" ],\r\n  \"deptId\" : [ \"103\" ],\r\n  \"userName\" : [ \"若依\" ],\r\n  \"dept.deptName\" : [ \"研发部门\" ],\r\n  \"phonenumber\" : [ \"15888888888\" ],\r\n  \"email\" : [ \"ry@163.com\" ],\r\n  \"loginName\" : [ \"admin\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"role\" : [ \"1\" ],\r\n  \"remark\" : [ \"管理员\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1\" ],\r\n  \"postIds\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-27 13:47:03');
INSERT INTO `sys_oper_log` VALUES (394, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.editSave()', 1, 'admin', '研发部门', '/system/user/edit', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"1\" ],\r\n  \"deptId\" : [ \"103\" ],\r\n  \"userName\" : [ \"若依\" ],\r\n  \"dept.deptName\" : [ \"研发部门\" ],\r\n  \"phonenumber\" : [ \"15888888888\" ],\r\n  \"email\" : [ \"ry@163.com\" ],\r\n  \"loginName\" : [ \"admin\" ],\r\n  \"sex\" : [ \"1\" ],\r\n  \"role\" : [ \"1\", \"2\", \"3\" ],\r\n  \"remark\" : [ \"管理员\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"roleIds\" : [ \"1,2,3\" ],\r\n  \"postIds\" : [ \"1\" ]\r\n}', 0, NULL, '2019-06-27 13:47:07');
INSERT INTO `sys_oper_log` VALUES (395, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '127.0.0.1', '内网IP', '{\r\n  \"roleId\" : [ \"3\" ],\r\n  \"roleName\" : [ \"客户经理\" ],\r\n  \"roleKey\" : [ \"manager\" ],\r\n  \"roleSort\" : [ \"2\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"\" ],\r\n  \"menuIds\" : [ \"3,2060,2030,2031,2032,2033,2034,2057,2059\" ]\r\n}', 0, NULL, '2019-06-27 13:48:15');
INSERT INTO `sys_oper_log` VALUES (396, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.editSave()', 1, 'admin', '研发部门', '/system/role/edit', '192.168.0.80', '内网IP', '{\r\n  \"roleId\" : [ \"2\" ],\r\n  \"roleName\" : [ \"普通角色\" ],\r\n  \"roleKey\" : [ \"common\" ],\r\n  \"roleSort\" : [ \"3\" ],\r\n  \"status\" : [ \"0\" ],\r\n  \"remark\" : [ \"普通角色\" ],\r\n  \"menuIds\" : [ \"3,2030,2031,2032,2033,2034,2057,2059\" ]\r\n}', 0, NULL, '2019-06-27 17:21:09');
INSERT INTO `sys_oper_log` VALUES (397, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.authDataScopeSave()', 1, 'admin', '研发部门', '/system/role/authDataScope', '192.168.0.80', '内网IP', '{\r\n  \"roleId\" : [ \"2\" ],\r\n  \"roleName\" : [ \"普通角色\" ],\r\n  \"roleKey\" : [ \"common\" ],\r\n  \"dataScope\" : [ \"1\" ],\r\n  \"deptIds\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-27 17:21:17');
INSERT INTO `sys_oper_log` VALUES (398, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.authDataScopeSave()', 1, 'admin', '研发部门', '/system/role/authDataScope', '192.168.0.80', '内网IP', '{\r\n  \"roleId\" : [ \"2\" ],\r\n  \"roleName\" : [ \"普通角色\" ],\r\n  \"roleKey\" : [ \"common\" ],\r\n  \"dataScope\" : [ \"1\" ],\r\n  \"deptIds\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-27 17:22:17');
INSERT INTO `sys_oper_log` VALUES (399, '重置密码', 2, 'com.ruoyi.web.controller.system.SysProfileController.resetPwd()', 1, '121414', NULL, '/system/user/profile/resetPwd', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"88\" ],\r\n  \"loginName\" : [ \"121414\" ],\r\n  \"oldPassword\" : [ \"121414\" ],\r\n  \"newPassword\" : [ \"1214141\" ],\r\n  \"confirm\" : [ \"1214141\" ]\r\n}', 0, NULL, '2019-06-27 19:18:16');
INSERT INTO `sys_oper_log` VALUES (400, '重置密码', 2, 'com.ruoyi.web.controller.system.SysProfileController.resetPwd()', 1, 'admin', '研发部门', '/system/user/profile/resetPwd', '127.0.0.1', '内网IP', '{\r\n  \"userId\" : [ \"1\" ],\r\n  \"loginName\" : [ \"admin\" ],\r\n  \"oldPassword\" : [ \"admin123\" ],\r\n  \"newPassword\" : [ \"admin\" ],\r\n  \"confirm\" : [ \"admin\" ]\r\n}', 0, NULL, '2019-06-27 19:23:56');
INSERT INTO `sys_oper_log` VALUES (401, '重置密码', 2, 'com.ruoyi.web.controller.system.SysProfileController.resetPwd()', 1, 'admin', '研发部门', '/system/user/profile/resetPwd', '192.168.0.80', '内网IP', '{\r\n  \"userId\" : [ \"1\" ],\r\n  \"loginName\" : [ \"admin\" ],\r\n  \"oldPassword\" : [ \"admin\" ],\r\n  \"newPassword\" : [ \"admin123\" ],\r\n  \"confirm\" : [ \"admin123\" ]\r\n}', 0, NULL, '2019-06-27 19:32:26');
INSERT INTO `sys_oper_log` VALUES (402, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, '', NULL, '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"测试用户152\" ],\r\n  \"beneficiary\" : [ \"测试用户152\" ],\r\n  \"projectNumber\" : [ \"测试用户152\" ],\r\n  \"projectName\" : [ \"测试用户152\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"3\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/28/53f163b8ecd1a4808b2cc0c26dd84df6.png,http://localhost/profile/upload/2019/06/28/8f801f325a8cdd4486a6a0365eb2bef0.xlsx,http://localhost/profile/upload/2019/06/28/2546abe183d129f19c0d21c166b19596.docx\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,问题.xlsx,加班申请及打卡规则.docx\" ]\r\n}', 1, '', '2019-06-28 14:43:27');
INSERT INTO `sys_oper_log` VALUES (403, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, '', NULL, '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"测试152\" ],\r\n  \"beneficiary\" : [ \"测试152\" ],\r\n  \"projectNumber\" : [ \"测试152\" ],\r\n  \"projectName\" : [ \"测试152\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/28/c4d152f39aa92e57eef19f7d369f4c09.png,http://localhost/profile/upload/2019/06/28/948ea050a96a9b4402912a1380f7c5e9.xlsx\" ],\r\n  \"fileNames\" : [ \"名片-0626_画板 1 副本.png,问题.xlsx\" ]\r\n}', 1, '', '2019-06-28 14:45:08');
INSERT INTO `sys_oper_log` VALUES (404, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, '', NULL, '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"测试152\" ],\r\n  \"beneficiary\" : [ \"测试152\" ],\r\n  \"projectNumber\" : [ \"测试152\" ],\r\n  \"projectName\" : [ \"测试152\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"1000\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/28/047249863c4ad228f0fd05044c4465cb.xls,http://localhost/profile/upload/2019/06/28/a2534a3240270f46906e41bcddafa2a1.png,http://localhost/profile/upload/2019/06/28/59c252c2374e6df4edd2aaee14a3a5e3.xlsx,http://localhost/profile/upload/2019/06/28/b1b48fb446f844941471ccbd5c463d90.docx\" ],\r\n  \"fileNames\" : [ \"后台样式0516.xls,名片-0626_画板 1 副本.png,问题.xlsx,加班申请及打卡规则.docx\" ]\r\n}', 0, NULL, '2019-06-28 14:46:16');
INSERT INTO `sys_oper_log` VALUES (405, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"18\" ],\r\n  \"warrantee\" : [ \"测试客户1有邀请人1提成\" ],\r\n  \"beneficiary\" : [ \"测试\" ],\r\n  \"projectNumber\" : [ \"测试\" ],\r\n  \"projectName\" : [ \"测试\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"21000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"1\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1500\" ],\r\n  \"paidamount\" : [ \"300\" ],\r\n  \"money\" : [ \"100\", \"200\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-28 18:17:09');
INSERT INTO `sys_oper_log` VALUES (406, '订单', 1, 'com.ruoyi.baohan.controller.GurtOrderController.addSave()', 1, '', NULL, '/baohan/gurtOrder/add', '127.0.0.1', '内网IP', '{\r\n  \"warrantee\" : [ \"123\" ],\r\n  \"beneficiary\" : [ \"123\" ],\r\n  \"projectNumber\" : [ \"123\" ],\r\n  \"projectName\" : [ \"123\" ],\r\n  \"closingTime\" : [ \"2012-1-1\" ],\r\n  \"guaranteeAmount\" : [ \"20001\" ],\r\n  \"validityDeadline\" : [ \"2012-2-1\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1500\" ],\r\n  \"paidamount\" : [ \"\" ],\r\n  \"fileUrls\" : [ \"http://localhost/profile/upload/2019/06/28/e54eb38fefb80ba68817e47832e1b37c.xlsx\" ],\r\n  \"fileNames\" : [ \"问题.xlsx\" ]\r\n}', 0, NULL, '2019-06-28 18:29:51');
INSERT INTO `sys_oper_log` VALUES (407, '订单', 2, 'com.ruoyi.baohan.controller.GurtOrderController.editSave()', 1, 'admin', '研发部门', '/baohan/gurtOrder/edit', '127.0.0.1', '内网IP', '{\r\n  \"id\" : [ \"30\" ],\r\n  \"warrantee\" : [ \"123\" ],\r\n  \"beneficiary\" : [ \"123\" ],\r\n  \"projectNumber\" : [ \"123\" ],\r\n  \"projectName\" : [ \"123\" ],\r\n  \"closingTime\" : [ \"2012-01-01 00:00:00\" ],\r\n  \"guaranteeAmount\" : [ \"9000\" ],\r\n  \"validityDeadline\" : [ \"2012-02-01 00:00:00\" ],\r\n  \"guaranteeId\" : [ \"2\" ],\r\n  \"bankId\" : [ \"1\" ],\r\n  \"projectTypeId\" : [ \"10\" ],\r\n  \"amount\" : [ \"1000\" ],\r\n  \"paidamount\" : [ \"0\" ],\r\n  \"fileUrls\" : [ \"\" ],\r\n  \"fileNames\" : [ \"\" ]\r\n}', 0, NULL, '2019-06-28 18:32:39');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', 'admin', 1, '1', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2019-06-19 16:00:36', '管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 3, '1', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2019-06-27 17:22:17', '普通角色');
INSERT INTO `sys_role` VALUES (3, '客户经理', 'manager', 2, '1', '0', '0', 'admin', NULL, 'admin', '2019-06-27 13:48:15', '');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1);
INSERT INTO `sys_role_menu` VALUES (1, 2);
INSERT INTO `sys_role_menu` VALUES (1, 3);
INSERT INTO `sys_role_menu` VALUES (1, 100);
INSERT INTO `sys_role_menu` VALUES (1, 101);
INSERT INTO `sys_role_menu` VALUES (1, 102);
INSERT INTO `sys_role_menu` VALUES (1, 103);
INSERT INTO `sys_role_menu` VALUES (1, 104);
INSERT INTO `sys_role_menu` VALUES (1, 105);
INSERT INTO `sys_role_menu` VALUES (1, 106);
INSERT INTO `sys_role_menu` VALUES (1, 107);
INSERT INTO `sys_role_menu` VALUES (1, 108);
INSERT INTO `sys_role_menu` VALUES (1, 109);
INSERT INTO `sys_role_menu` VALUES (1, 110);
INSERT INTO `sys_role_menu` VALUES (1, 111);
INSERT INTO `sys_role_menu` VALUES (1, 112);
INSERT INTO `sys_role_menu` VALUES (1, 113);
INSERT INTO `sys_role_menu` VALUES (1, 114);
INSERT INTO `sys_role_menu` VALUES (1, 500);
INSERT INTO `sys_role_menu` VALUES (1, 501);
INSERT INTO `sys_role_menu` VALUES (1, 1000);
INSERT INTO `sys_role_menu` VALUES (1, 1001);
INSERT INTO `sys_role_menu` VALUES (1, 1002);
INSERT INTO `sys_role_menu` VALUES (1, 1003);
INSERT INTO `sys_role_menu` VALUES (1, 1004);
INSERT INTO `sys_role_menu` VALUES (1, 1005);
INSERT INTO `sys_role_menu` VALUES (1, 1006);
INSERT INTO `sys_role_menu` VALUES (1, 1007);
INSERT INTO `sys_role_menu` VALUES (1, 1008);
INSERT INTO `sys_role_menu` VALUES (1, 1009);
INSERT INTO `sys_role_menu` VALUES (1, 1010);
INSERT INTO `sys_role_menu` VALUES (1, 1011);
INSERT INTO `sys_role_menu` VALUES (1, 1012);
INSERT INTO `sys_role_menu` VALUES (1, 1013);
INSERT INTO `sys_role_menu` VALUES (1, 1014);
INSERT INTO `sys_role_menu` VALUES (1, 1015);
INSERT INTO `sys_role_menu` VALUES (1, 1016);
INSERT INTO `sys_role_menu` VALUES (1, 1017);
INSERT INTO `sys_role_menu` VALUES (1, 1018);
INSERT INTO `sys_role_menu` VALUES (1, 1019);
INSERT INTO `sys_role_menu` VALUES (1, 1020);
INSERT INTO `sys_role_menu` VALUES (1, 1021);
INSERT INTO `sys_role_menu` VALUES (1, 1022);
INSERT INTO `sys_role_menu` VALUES (1, 1023);
INSERT INTO `sys_role_menu` VALUES (1, 1024);
INSERT INTO `sys_role_menu` VALUES (1, 1025);
INSERT INTO `sys_role_menu` VALUES (1, 1026);
INSERT INTO `sys_role_menu` VALUES (1, 1027);
INSERT INTO `sys_role_menu` VALUES (1, 1028);
INSERT INTO `sys_role_menu` VALUES (1, 1029);
INSERT INTO `sys_role_menu` VALUES (1, 1030);
INSERT INTO `sys_role_menu` VALUES (1, 1031);
INSERT INTO `sys_role_menu` VALUES (1, 1032);
INSERT INTO `sys_role_menu` VALUES (1, 1033);
INSERT INTO `sys_role_menu` VALUES (1, 1034);
INSERT INTO `sys_role_menu` VALUES (1, 1035);
INSERT INTO `sys_role_menu` VALUES (1, 1036);
INSERT INTO `sys_role_menu` VALUES (1, 1037);
INSERT INTO `sys_role_menu` VALUES (1, 1038);
INSERT INTO `sys_role_menu` VALUES (1, 1039);
INSERT INTO `sys_role_menu` VALUES (1, 1040);
INSERT INTO `sys_role_menu` VALUES (1, 1041);
INSERT INTO `sys_role_menu` VALUES (1, 1042);
INSERT INTO `sys_role_menu` VALUES (1, 1043);
INSERT INTO `sys_role_menu` VALUES (1, 1044);
INSERT INTO `sys_role_menu` VALUES (1, 1045);
INSERT INTO `sys_role_menu` VALUES (1, 1046);
INSERT INTO `sys_role_menu` VALUES (1, 1047);
INSERT INTO `sys_role_menu` VALUES (1, 1048);
INSERT INTO `sys_role_menu` VALUES (1, 1049);
INSERT INTO `sys_role_menu` VALUES (1, 1050);
INSERT INTO `sys_role_menu` VALUES (1, 1051);
INSERT INTO `sys_role_menu` VALUES (1, 1052);
INSERT INTO `sys_role_menu` VALUES (1, 1053);
INSERT INTO `sys_role_menu` VALUES (1, 1054);
INSERT INTO `sys_role_menu` VALUES (1, 1055);
INSERT INTO `sys_role_menu` VALUES (1, 1056);
INSERT INTO `sys_role_menu` VALUES (1, 1057);
INSERT INTO `sys_role_menu` VALUES (1, 2030);
INSERT INTO `sys_role_menu` VALUES (1, 2031);
INSERT INTO `sys_role_menu` VALUES (1, 2032);
INSERT INTO `sys_role_menu` VALUES (1, 2033);
INSERT INTO `sys_role_menu` VALUES (1, 2034);
INSERT INTO `sys_role_menu` VALUES (1, 2035);
INSERT INTO `sys_role_menu` VALUES (1, 2036);
INSERT INTO `sys_role_menu` VALUES (1, 2037);
INSERT INTO `sys_role_menu` VALUES (1, 2038);
INSERT INTO `sys_role_menu` VALUES (1, 2039);
INSERT INTO `sys_role_menu` VALUES (1, 2042);
INSERT INTO `sys_role_menu` VALUES (1, 2043);
INSERT INTO `sys_role_menu` VALUES (1, 2044);
INSERT INTO `sys_role_menu` VALUES (1, 2045);
INSERT INTO `sys_role_menu` VALUES (1, 2046);
INSERT INTO `sys_role_menu` VALUES (1, 2047);
INSERT INTO `sys_role_menu` VALUES (1, 2048);
INSERT INTO `sys_role_menu` VALUES (1, 2049);
INSERT INTO `sys_role_menu` VALUES (1, 2050);
INSERT INTO `sys_role_menu` VALUES (1, 2051);
INSERT INTO `sys_role_menu` VALUES (1, 2052);
INSERT INTO `sys_role_menu` VALUES (1, 2053);
INSERT INTO `sys_role_menu` VALUES (1, 2054);
INSERT INTO `sys_role_menu` VALUES (1, 2055);
INSERT INTO `sys_role_menu` VALUES (1, 2056);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 2030);
INSERT INTO `sys_role_menu` VALUES (2, 2031);
INSERT INTO `sys_role_menu` VALUES (2, 2032);
INSERT INTO `sys_role_menu` VALUES (2, 2033);
INSERT INTO `sys_role_menu` VALUES (2, 2034);
INSERT INTO `sys_role_menu` VALUES (2, 2057);
INSERT INTO `sys_role_menu` VALUES (2, 2059);
INSERT INTO `sys_role_menu` VALUES (3, 3);
INSERT INTO `sys_role_menu` VALUES (3, 2030);
INSERT INTO `sys_role_menu` VALUES (3, 2031);
INSERT INTO `sys_role_menu` VALUES (3, 2032);
INSERT INTO `sys_role_menu` VALUES (3, 2033);
INSERT INTO `sys_role_menu` VALUES (3, 2034);
INSERT INTO `sys_role_menu` VALUES (3, 2057);
INSERT INTO `sys_role_menu` VALUES (3, 2059);
INSERT INTO `sys_role_menu` VALUES (3, 2060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `login_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录账号',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像路径',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '盐加密',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登陆IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `invite_user_id` bigint(20) NULL DEFAULT NULL,
  `category_id` bigint(20) NULL DEFAULT NULL,
  `inviteurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '超级管理员', '00', 'ry@163.com', '15888888888', '1', '', '4b9e4c48c6d8b7d9c7f62c10c8b846da', '5439f8', '0', '0', '127.0.0.1', '2019-06-28 18:31:09', 'admin', '2018-03-16 11:33:00', 'ry', '2019-06-28 18:31:08', '管理员', NULL, NULL, 'http://localhost/profile/upload/pLVzl15KYznP.jpg');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '8e6d98b90472783cc73c17047ddccf36', '222222', '0', '0', '192.168.0.80', '2019-06-27 17:20:00', 'admin', '2018-03-16 11:33:00', 'ry', '2019-06-27 17:19:59', '测试员', 8, NULL, NULL);
INSERT INTO `sys_user` VALUES (8, 105, 'manager', '65', '00', 'imporjant@163.com', '18845677894', '1', '', '49cb00fe63426bc35c40f7f453ac7e9a', '1fc636', '0', '0', '127.0.0.1', '2019-06-28 15:09:41', 'admin', '2019-06-19 14:58:04', 'admin', '2019-06-28 15:09:41', '', NULL, 34, 'http://localhost/profile/upload/q5N0iMaH30fc.jpg');
INSERT INTO `sys_user` VALUES (17, 103, '啊2312', '65', '00', 'importj3nt@163.com', '15244443332', '2', '', '6232da4ba83f3d9b632f8ee99081fcc1', '670aed', '0', '0', '', NULL, 'admin', '2019-06-27 11:32:27', '', NULL, '', NULL, NULL, 'http://localhost/profile/upload/y8y6yY774bA1.jpg');
INSERT INTO `sys_user` VALUES (18, 104, '啊231', '1123', '00', 'imporja1nt@163.com', '15244443132', '0', '', '9289ad407a7adfb9782d94430643d68b', '09a11d', '0', '0', '', NULL, 'admin', '2019-06-27 11:33:58', '', NULL, '', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (98, NULL, '', '', '00', '', '15273011636', '0', '', '', '', '0', '0', '', NULL, '', NULL, '', NULL, '', 8, NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online`  (
  `sessionId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户会话id',
  `login_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `ipaddr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '在线状态on_line在线off_line离线',
  `start_timestamp` datetime(0) NULL DEFAULT NULL COMMENT 'session创建时间',
  `last_access_time` datetime(0) NULL DEFAULT NULL COMMENT 'session最后访问时间',
  `expire_time` int(5) NULL DEFAULT 0 COMMENT '超时时间，单位为分钟',
  PRIMARY KEY (`sessionId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '在线用户记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------
INSERT INTO `sys_user_online` VALUES ('32f49174-92f1-45d8-9967-40d6ad8efe2f', 'admin', '研发部门', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', 'on_line', '2019-06-28 18:29:55', '2019-06-28 18:32:16', 1800000);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (5, 2);
INSERT INTO `sys_user_post` VALUES (6, 2);
INSERT INTO `sys_user_post` VALUES (7, 3);
INSERT INTO `sys_user_post` VALUES (8, 2);
INSERT INTO `sys_user_post` VALUES (9, 2);
INSERT INTO `sys_user_post` VALUES (10, 2);
INSERT INTO `sys_user_post` VALUES (11, 2);
INSERT INTO `sys_user_post` VALUES (12, 2);
INSERT INTO `sys_user_post` VALUES (13, 2);
INSERT INTO `sys_user_post` VALUES (15, 2);
INSERT INTO `sys_user_post` VALUES (17, 2);
INSERT INTO `sys_user_post` VALUES (18, 3);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (5, 3);
INSERT INTO `sys_user_role` VALUES (6, 1);
INSERT INTO `sys_user_role` VALUES (7, 2);
INSERT INTO `sys_user_role` VALUES (8, 3);
INSERT INTO `sys_user_role` VALUES (9, 1);
INSERT INTO `sys_user_role` VALUES (9, 2);
INSERT INTO `sys_user_role` VALUES (9, 3);
INSERT INTO `sys_user_role` VALUES (10, 1);
INSERT INTO `sys_user_role` VALUES (10, 2);
INSERT INTO `sys_user_role` VALUES (10, 3);
INSERT INTO `sys_user_role` VALUES (11, 1);
INSERT INTO `sys_user_role` VALUES (11, 2);
INSERT INTO `sys_user_role` VALUES (11, 3);
INSERT INTO `sys_user_role` VALUES (12, 1);
INSERT INTO `sys_user_role` VALUES (12, 2);
INSERT INTO `sys_user_role` VALUES (12, 3);
INSERT INTO `sys_user_role` VALUES (13, 1);
INSERT INTO `sys_user_role` VALUES (14, 1);
INSERT INTO `sys_user_role` VALUES (14, 2);
INSERT INTO `sys_user_role` VALUES (14, 3);
INSERT INTO `sys_user_role` VALUES (15, 1);
INSERT INTO `sys_user_role` VALUES (15, 2);
INSERT INTO `sys_user_role` VALUES (15, 3);
INSERT INTO `sys_user_role` VALUES (16, 2);
INSERT INTO `sys_user_role` VALUES (16, 3);
INSERT INTO `sys_user_role` VALUES (17, 1);
INSERT INTO `sys_user_role` VALUES (17, 2);
INSERT INTO `sys_user_role` VALUES (17, 3);
INSERT INTO `sys_user_role` VALUES (18, 2);
INSERT INTO `sys_user_role` VALUES (19, 2);
INSERT INTO `sys_user_role` VALUES (60, 2);
INSERT INTO `sys_user_role` VALUES (98, 2);

SET FOREIGN_KEY_CHECKS = 1;
