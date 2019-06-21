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

 Date: 21/06/2019 18:41:00
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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目基础资料' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_category
-- ----------------------------
INSERT INTO `gurt_category` VALUES (1, 'A01', 'C端客户使用', 1, NULL, 0);
INSERT INTO `gurt_category` VALUES (17, 'A10', '项目经理101', 1, '2019-06-19 10:45:12', 0);
INSERT INTO `gurt_category` VALUES (20, '1123', '项目经理101', 1, NULL, 0);
INSERT INTO `gurt_category` VALUES (21, 'A111', 'beizhu1', 1, '2019-06-21 09:18:50', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邀请提成' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_invite_commission
-- ----------------------------
INSERT INTO `gurt_invite_commission` VALUES (1, 1, 30, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_order
-- ----------------------------
INSERT INTO `gurt_order` VALUES (1, '张三1123', '李四', 'A', 'A', '2019-06-13 14:49:24', 200, '2019-06-19 14:50:20.000000', 1, 1, 1, 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gurt_order` VALUES (2, '啊', '1', '23', '3', '0000-00-00 00:00:00', 11, '0000-00-00 00:00:00.000000', 1, 1, 1, 1, 1, '2019-06-21 16:01:31', '0000-00-00 00:00:00', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gurt_order` VALUES (3, '被保证人：', '受益人：', '项目编号：', '项目名称：', '2012-01-01 00:00:00', 2131, '2122-01-01 00:00:00.000000', 1, 1, 20, 400, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for gurt_project_type
-- ----------------------------
DROP TABLE IF EXISTS `gurt_project_type`;
CREATE TABLE `gurt_project_type`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类目名称',
  `category_id` bigint(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `asdass`(`category_id`) USING BTREE,
  CONSTRAINT `asdass` FOREIGN KEY (`category_id`) REFERENCES `gurt_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目名称' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_project_type
-- ----------------------------
INSERT INTO `gurt_project_type` VALUES (1, '项目1', 17);
INSERT INTO `gurt_project_type` VALUES (11, '市政', 17);
INSERT INTO `gurt_project_type` VALUES (16, '市政1', 17);
INSERT INTO `gurt_project_type` VALUES (17, '3', 17);
INSERT INTO `gurt_project_type` VALUES (18, '市政3', 17);
INSERT INTO `gurt_project_type` VALUES (19, '市政1', 20);
INSERT INTO `gurt_project_type` VALUES (20, '市政', 1);
INSERT INTO `gurt_project_type` VALUES (21, '市政1', 1);
INSERT INTO `gurt_project_type` VALUES (22, '市政', 21);

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
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目分类' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gurt_project_type_cost_config
-- ----------------------------
INSERT INTO `gurt_project_type_cost_config` VALUES (9, 11, 0, 1000000, 400, 0, 350, 0, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (10, 11, 1000000, 2000000, 450, 0, 400, 0, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (11, 11, 1000000, 20000000, 1000, 0, 500, 0, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (12, 11, 200000000, 2000000000, 5, 1, 3, 1, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (18, 11, 1000000, 20000000, 450, 1, 350, 0, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (19, 11, 0, 1000000000, 400, 1, 350, 1, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (20, 11, 1000000, 10000000, 450, 1, 50, 1, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (23, 16, 0, 100000, 1000, 0, 50, 0, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (24, 17, 1000000, 2000000, 1000, 0, 50, 0, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (25, 18, 1, 2000000, 1000, 0, 350, 0, 17);
INSERT INTO `gurt_project_type_cost_config` VALUES (26, 19, 0, 1000, 1000, 0, 1, 0, 20);
INSERT INTO `gurt_project_type_cost_config` VALUES (27, 20, 0, 1000000, 400, 0, 350, 0, 1);
INSERT INTO `gurt_project_type_cost_config` VALUES (28, 21, 0, 1000, 450, 0, 1, 0, 1);
INSERT INTO `gurt_project_type_cost_config` VALUES (29, 21, 10000, 1000000, 2, 1, 2, 1, 1);
INSERT INTO `gurt_project_type_cost_config` VALUES (30, 22, 0, 1000000, 400, 0, 50, 0, 21);
INSERT INTO `gurt_project_type_cost_config` VALUES (31, 22, 1000000, 20000000, 1000, 0, 350, 0, 21);
INSERT INTO `gurt_project_type_cost_config` VALUES (32, 22, 1000000, 1000000, 1000, 0, 350, 0, 21);

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
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'SC-2019013111271561111898680', 1561112774885, 15000);

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
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1561111900000, -1, 5, 'PAUSED', 'CRON', 1561111898000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1561111900000, -1, 5, 'PAUSED', 'CRON', 1561111899000, 0, NULL, 2, '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 231 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-14 11:19:27');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 11:19:30');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-14 11:19:34');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 11:19:37');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-14 15:11:49');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-14 15:11:54');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-14 15:11:56');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-14 15:11:59');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-14 15:12:03');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-14 15:12:06');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-14 15:12:11');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-14 15:12:14');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 15:12:16');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-14 15:15:57');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 15:16:00');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 15:16:37');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 15:20:07');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 15:21:02');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 15:28:56');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 15:46:05');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 16:02:32');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-14 16:04:10');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-17 19:26:32');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-17 19:26:37');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 11:32:12');
INSERT INTO `sys_logininfor` VALUES (125, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:32:20');
INSERT INTO `sys_logininfor` VALUES (126, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 11:32:30');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 11:32:33');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:32:38');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 11:32:41');
INSERT INTO `sys_logininfor` VALUES (130, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:32:46');
INSERT INTO `sys_logininfor` VALUES (131, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 11:36:48');
INSERT INTO `sys_logininfor` VALUES (132, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 11:36:56');
INSERT INTO `sys_logininfor` VALUES (133, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:36:58');
INSERT INTO `sys_logininfor` VALUES (134, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 11:38:48');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 11:38:51');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:38:54');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 11:46:51');
INSERT INTO `sys_logininfor` VALUES (138, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 11:46:55');
INSERT INTO `sys_logininfor` VALUES (139, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:46:58');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 11:49:36');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:49:39');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 11:49:43');
INSERT INTO `sys_logininfor` VALUES (143, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:49:50');
INSERT INTO `sys_logininfor` VALUES (144, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 11:50:58');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:51:02');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 11:53:50');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 11:54:00');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 11:54:03');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 11:54:07');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 11:54:11');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 11:54:14');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 13:54:32');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 13:54:44');
INSERT INTO `sys_logininfor` VALUES (154, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-19 13:57:46');
INSERT INTO `sys_logininfor` VALUES (155, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误2次', '2019-06-19 13:58:02');
INSERT INTO `sys_logininfor` VALUES (156, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-19 13:58:18');
INSERT INTO `sys_logininfor` VALUES (157, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 13:58:46');
INSERT INTO `sys_logininfor` VALUES (158, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-19 13:58:48');
INSERT INTO `sys_logininfor` VALUES (159, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误2次', '2019-06-19 13:58:50');
INSERT INTO `sys_logininfor` VALUES (160, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误3次', '2019-06-19 13:59:00');
INSERT INTO `sys_logininfor` VALUES (161, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 13:59:45');
INSERT INTO `sys_logininfor` VALUES (162, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 13:59:47');
INSERT INTO `sys_logininfor` VALUES (163, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误4次', '2019-06-19 13:59:49');
INSERT INTO `sys_logininfor` VALUES (164, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误5次', '2019-06-19 13:59:57');
INSERT INTO `sys_logininfor` VALUES (165, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:00:49');
INSERT INTO `sys_logininfor` VALUES (166, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:00:51');
INSERT INTO `sys_logininfor` VALUES (167, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2019-06-19 14:00:55');
INSERT INTO `sys_logininfor` VALUES (168, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 14:01:03');
INSERT INTO `sys_logininfor` VALUES (169, 'aicheng', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2019-06-19 14:01:07');
INSERT INTO `sys_logininfor` VALUES (170, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-19 14:01:44');
INSERT INTO `sys_logininfor` VALUES (171, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:01:55');
INSERT INTO `sys_logininfor` VALUES (172, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:04:51');
INSERT INTO `sys_logininfor` VALUES (173, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:04:55');
INSERT INTO `sys_logininfor` VALUES (174, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:07:44');
INSERT INTO `sys_logininfor` VALUES (175, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 14:07:48');
INSERT INTO `sys_logininfor` VALUES (176, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-19 14:07:51');
INSERT INTO `sys_logininfor` VALUES (177, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:07:57');
INSERT INTO `sys_logininfor` VALUES (178, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:08:39');
INSERT INTO `sys_logininfor` VALUES (179, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:08:46');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:09:50');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:09:55');
INSERT INTO `sys_logininfor` VALUES (182, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:10:02');
INSERT INTO `sys_logininfor` VALUES (183, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:10:05');
INSERT INTO `sys_logininfor` VALUES (184, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:10:13');
INSERT INTO `sys_logininfor` VALUES (185, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:10:29');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:10:32');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:11:27');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:14:33');
INSERT INTO `sys_logininfor` VALUES (189, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:14:54');
INSERT INTO `sys_logininfor` VALUES (190, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:15:02');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:15:05');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 14:15:49');
INSERT INTO `sys_logininfor` VALUES (193, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 14:15:56');
INSERT INTO `sys_logininfor` VALUES (194, 'ac', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:15:59');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:45:49');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 14:47:43');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 16:00:15');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 16:00:18');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 16:00:53');
INSERT INTO `sys_logininfor` VALUES (200, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误1次', '2019-06-19 16:00:59');
INSERT INTO `sys_logininfor` VALUES (201, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '用户不存在/密码错误', '2019-06-19 16:01:09');
INSERT INTO `sys_logininfor` VALUES (202, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误2次', '2019-06-19 16:01:38');
INSERT INTO `sys_logininfor` VALUES (203, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '密码输入错误3次', '2019-06-19 16:01:43');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 16:01:57');
INSERT INTO `sys_logininfor` VALUES (205, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 16:09:10');
INSERT INTO `sys_logininfor` VALUES (206, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 16:10:22');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 16:10:25');
INSERT INTO `sys_logininfor` VALUES (208, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 16:10:27');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 16:15:59');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-19 16:16:19');
INSERT INTO `sys_logininfor` VALUES (211, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 16:16:26');
INSERT INTO `sys_logininfor` VALUES (212, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 16:16:28');
INSERT INTO `sys_logininfor` VALUES (213, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 16:19:42');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 16:43:56');
INSERT INTO `sys_logininfor` VALUES (215, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-19 16:57:34');
INSERT INTO `sys_logininfor` VALUES (216, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 16:57:38');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-19 17:48:52');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-20 09:19:51');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-20 09:31:49');
INSERT INTO `sys_logininfor` VALUES (220, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-20 09:31:56');
INSERT INTO `sys_logininfor` VALUES (221, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-20 09:38:40');
INSERT INTO `sys_logininfor` VALUES (222, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-20 09:45:33');
INSERT INTO `sys_logininfor` VALUES (223, 'manager', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-20 09:48:50');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-20 09:48:54');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-21 10:58:30');
INSERT INTO `sys_logininfor` VALUES (226, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-21 10:58:36');
INSERT INTO `sys_logininfor` VALUES (227, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '1', '验证码错误', '2019-06-21 10:58:38');
INSERT INTO `sys_logininfor` VALUES (228, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-21 10:58:40');
INSERT INTO `sys_logininfor` VALUES (229, 'ry', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2019-06-21 10:58:50');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2019-06-21 10:58:59');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2058 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, '#', '', 'M', '0', '', 'fa fa-gear', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, '#', '', 'M', '0', '', 'fa fa-video-camera', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, '#', '', 'M', '0', '', 'fa fa-bars', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '系统工具目录');
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
INSERT INTO `sys_menu` VALUES (113, '表单构建', 3, 1, '/tool/build', '', 'C', '0', 'tool:build:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '表单构建菜单');
INSERT INTO `sys_menu` VALUES (114, '代码生成', 3, 2, '/tool/gen', '', 'C', '0', 'tool:gen:view', '#', 'admin', '2018-03-16 11:33:00', 'ry', '2018-03-16 11:33:00', '代码生成菜单');
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
INSERT INTO `sys_menu` VALUES (2057, '提交订单', 2030, 5, '#', '', 'F', '0', 'baohan:gurtOrder:submit', '#', 'admin', '2018-03-01 00:00:00', 'ry', '2018-03-01 00:00:00', '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 282 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Compact;

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
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 3, '2', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2019-06-21 10:58:27', '普通角色');
INSERT INTO `sys_role` VALUES (3, '客户经理', 'manager', 2, '1', '0', '0', 'admin', NULL, 'admin', '2019-06-21 10:58:17', '');

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
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

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
INSERT INTO `sys_role_menu` VALUES (3, 3);
INSERT INTO `sys_role_menu` VALUES (3, 2030);
INSERT INTO `sys_role_menu` VALUES (3, 2031);
INSERT INTO `sys_role_menu` VALUES (3, 2032);
INSERT INTO `sys_role_menu` VALUES (3, 2033);
INSERT INTO `sys_role_menu` VALUES (3, 2034);
INSERT INTO `sys_role_menu` VALUES (3, 2057);

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
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
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
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '29c67a30398638269fe600f73a054934', '111111', '0', '0', '127.0.0.1', '2019-06-21 10:59:00', 'admin', '2018-03-16 11:33:00', 'ry', '2019-06-21 10:58:59', '管理员', NULL, NULL);
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '8e6d98b90472783cc73c17047ddccf36', '222222', '0', '0', '127.0.0.1', '2019-06-21 10:58:41', 'admin', '2018-03-16 11:33:00', 'ry', '2019-06-21 10:58:40', '测试员', NULL, NULL);
INSERT INTO `sys_user` VALUES (5, 103, 'ac', 'ac', '00', 'importjant@163.com', '15244443333', '0', '', '68ee11d49cd89e7bbec7d671c73f0c27', '9ab909', '0', '0', '127.0.0.1', '2019-06-19 14:15:59', 'ry', '2019-06-19 14:04:46', 'admin', '2019-06-19 14:15:59', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (6, 109, '啊231', '1123', '00', 'importj3nt@163.com', '15244443332', '1', '', 'adf6bde2e65926b8edcad38e50501ef5', 'f64a1f', '0', '2', '', NULL, 'admin', '2019-06-19 14:53:31', '', NULL, '', NULL, NULL);
INSERT INTO `sys_user` VALUES (7, 105, '啊2312', '1123', '00', '3nt@163.com', '15211113332', '1', '', '6cb2d3abbe1d7df11ca8ca3fa006cddd', 'eef429', '0', '2', '', NULL, 'admin', '2019-06-19 14:55:13', '', NULL, '', NULL, NULL);
INSERT INTO `sys_user` VALUES (8, 105, 'manager', '65', '00', 'imporjant@163.com', '18845677894', '1', '', '49cb00fe63426bc35c40f7f453ac7e9a', '1fc636', '0', '0', '127.0.0.1', '2019-06-20 09:45:33', 'admin', '2019-06-19 14:58:04', 'admin', '2019-06-20 09:45:33', '', NULL, 20);

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
INSERT INTO `sys_user_online` VALUES ('dd1fa2ad-53f8-409b-918c-fe947a1835e8', 'admin', '研发部门', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', 'on_line', '2019-06-21 18:12:05', '2019-06-21 18:12:05', 1800000);

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
INSERT INTO `sys_user_role` VALUES (6, 2);
INSERT INTO `sys_user_role` VALUES (7, 2);
INSERT INTO `sys_user_role` VALUES (8, 3);

SET FOREIGN_KEY_CHECKS = 1;
