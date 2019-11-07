/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : 0705erp

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2018-11-10 09:01:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bus_customer
-- ----------------------------
DROP TABLE IF EXISTS `bus_customer`;
CREATE TABLE `bus_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customername` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `connectionperson` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `bank` varchar(255) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bus_customer
-- ----------------------------
INSERT INTO `bus_customer` VALUES ('1', '小张超市', '111', '武汉', '027-9123131', '张大明', '13812312312321312', '中国银行', '654431331343413', '213123@sina.com', '430000', '1');
INSERT INTO `bus_customer` VALUES ('2', '小明超市', '222', '深圳', '0755-9123131', '张小明', '13812312312321312', '中国银行', '654431331343413', '213123@sina.com', '430000', '1');
INSERT INTO `bus_customer` VALUES ('3', '快七超市', '430000', '武汉', '027-11011011', '雷生', '13434134131', '招商银行', '6543123341334133', '6666@66.com', '545341', '1');

-- ----------------------------
-- Table structure for bus_goods
-- ----------------------------
DROP TABLE IF EXISTS `bus_goods`;
CREATE TABLE `bus_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodsname` varchar(255) DEFAULT NULL,
  `produceplace` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `goodspackage` varchar(255) DEFAULT NULL,
  `productcode` varchar(255) DEFAULT NULL,
  `promitcode` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `dangernum` int(11) DEFAULT NULL,
  `goodsimg` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL,
  `providerid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sq0btr2v2lq8gt8b4gb8tlk0i` (`providerid`),
  CONSTRAINT `FK_sq0btr2v2lq8gt8b4gb8tlk0i` FOREIGN KEY (`providerid`) REFERENCES `bus_provider` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bus_goods
-- ----------------------------
INSERT INTO `bus_goods` VALUES ('1', '娃哈哈', '武汉', '120ML', '瓶', 'PH12345', 'PZ1234', '小孩子都爱的', '2', '400', '10', '../resources/images/userface1.jpg', '1', '3');
INSERT INTO `bus_goods` VALUES ('2', '旺旺雪饼[小包]', '仙桃', '包', '袋', 'PH12312312', 'PZ12312', '好吃不上火', '4', '1100', '10', '../resources/images/userface2.jpg', '1', '1');
INSERT INTO `bus_goods` VALUES ('3', '旺旺大礼包', '仙桃', '盒', '盒', '11', '11', '111', '28', '1021', '100', '../resources/images/userface3.jpg', '1', '1');
INSERT INTO `bus_goods` VALUES ('4', '娃哈哈', '武汉', '200ML', '瓶', '11', '111', '12321', '3', '1000', '10', '../resources/images/userface4.jpg', '1', '3');
INSERT INTO `bus_goods` VALUES ('5', '娃哈哈', '武汉', '300ML', '瓶', '1234', '12321', '', '3', '1000', '100', '../resources/images/userface5.jpg', '1', '3');
INSERT INTO `bus_goods` VALUES ('7', '123123', '123123', '12312', '3123', '12312', '312312', '231312', '312321', '312312', '3123', '../upload/2018-11-09/20181109155159470_2403.jpg', '1', '1');

-- ----------------------------
-- Table structure for bus_inport
-- ----------------------------
DROP TABLE IF EXISTS `bus_inport`;
CREATE TABLE `bus_inport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paytype` varchar(255) DEFAULT NULL,
  `inporttime` varchar(255) DEFAULT NULL,
  `operateperson` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `inportprice` double DEFAULT NULL,
  `providerid` int(11) DEFAULT NULL,
  `goodsid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_1o4bujsyd2kl4iqw48fie224v` (`providerid`),
  KEY `FK_ho29poeu4o2dxu4rg1ammeaql` (`goodsid`),
  CONSTRAINT `FK_1o4bujsyd2kl4iqw48fie224v` FOREIGN KEY (`providerid`) REFERENCES `bus_provider` (`id`),
  CONSTRAINT `FK_ho29poeu4o2dxu4rg1ammeaql` FOREIGN KEY (`goodsid`) REFERENCES `bus_goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bus_inport
-- ----------------------------
INSERT INTO `bus_inport` VALUES ('1', '微信', '2018-05-07', '张三', '100', '备注', '3.5', '1', '1');
INSERT INTO `bus_inport` VALUES ('2', '支付宝', '2018-05-07', '张三', '1000', '无', '2.5', '3', '3');
INSERT INTO `bus_inport` VALUES ('3', '银联', '2018-05-07', '张三', '100', '1231', '111', '3', '3');
INSERT INTO `bus_inport` VALUES ('4', '银联', '2018-05-07', '张三', '1000', '无', '2', '3', '1');
INSERT INTO `bus_inport` VALUES ('5', '银联', '2018-05-07', '张三', '100', '无', '1', '3', '1');
INSERT INTO `bus_inport` VALUES ('6', '银联', '2018-05-07', '张三', '100', '1231', '2.5', '1', '2');
INSERT INTO `bus_inport` VALUES ('8', '支付宝', '2018-05-07', '张三', '100', '', '1', '3', '1');
INSERT INTO `bus_inport` VALUES ('10', '支付宝', '2018-8-7 17:17:57', '超级管理员', '100', 'sadfasfdsa', '1.5', '3', '1');
INSERT INTO `bus_inport` VALUES ('11', '支付宝', '2018-9-17 16:12:25', '超级管理员', '21', '21', '21', '1', '3');

-- ----------------------------
-- Table structure for bus_provider
-- ----------------------------
DROP TABLE IF EXISTS `bus_provider`;
CREATE TABLE `bus_provider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `providername` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `connectionperson` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `bank` varchar(255) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bus_provider
-- ----------------------------
INSERT INTO `bus_provider` VALUES ('1', '旺旺食品', '434000', '仙桃', '0728-4124312', '小明', '13413441141', '中国农业银行', '654124345131', '12312321@sina.com', '5123123', '1');
INSERT INTO `bus_provider` VALUES ('2', '达利园食品', '430000', '汉川', '0728-4124312', '大明', '13413441141', '中国农业银行', '654124345131', '12312321@sina.com', '5123123', '1');
INSERT INTO `bus_provider` VALUES ('3', '娃哈哈集团', '513131', '杭州', '21312', '小晨', '12312', '建设银行', '512314141541', '123131', '312312', '1');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `open` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT '0' COMMENT '1父节点  0 子节点',
  `remark` varchar(255) DEFAULT NULL,
  `loc` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL COMMENT '状态【0不可用1可用】',
  `ordernum` int(11) DEFAULT NULL COMMENT '排序码【为了调事显示顺序】',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '0', '总经办', '1', '1', '大BOSS', '深圳', '1', '1');
INSERT INTO `sys_dept` VALUES ('2', '1', '开发部', '1', '1', '程序员屌丝', '武汉', '1', '2');
INSERT INTO `sys_dept` VALUES ('3', '1', '运营部', '1', '1', '无', '武汉', '1', '3');
INSERT INTO `sys_dept` VALUES ('4', '1', '市场部', '1', '1', '无', '武汉', '1', '4');
INSERT INTO `sys_dept` VALUES ('5', '2', '开发一部', '1', '0', '主管JAVA开发', '武汉', '1', '5');
INSERT INTO `sys_dept` VALUES ('6', '2', '开发二部', '1', '0', '主管.NET开发', '武汉', '1', '6');
INSERT INTO `sys_dept` VALUES ('7', '3', '运营一部', '1', '0', '商城项目的运营', '武汉', '1', '7');
INSERT INTO `sys_dept` VALUES ('8', '2', '开发三部', '1', '0', '111', '11', '1', '8');
INSERT INTO `sys_dept` VALUES ('9', '2', '开发四部', '1', '0', '222', '222', '1', '9');
INSERT INTO `sys_dept` VALUES ('10', '2', '开发五部', '1', '0', '333', '33', '1', '10');
INSERT INTO `sys_dept` VALUES ('14', '3', '112', '0', '0', '112', '112', '1', '11');

-- ----------------------------
-- Table structure for sys_leavebill
-- ----------------------------
DROP TABLE IF EXISTS `sys_leavebill`;
CREATE TABLE `sys_leavebill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `days` double(255,0) DEFAULT NULL,
  `leavetime` datetime DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL COMMENT '1,新建  2，已提交   3，审批中  4，审批完成',
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_leavebill
-- ----------------------------
INSERT INTO `sys_leavebill` VALUES ('1', '请假', '回家', '5', '2018-08-13 14:12:43', '0', '5');
INSERT INTO `sys_leavebill` VALUES ('2', '请假', '回家', '5', '2018-08-13 14:12:43', '1', '5');
INSERT INTO `sys_leavebill` VALUES ('3', '请假', '回家', '5', '2018-08-13 14:12:43', '2', '5');
INSERT INTO `sys_leavebill` VALUES ('4', '请假', '回家', '5', '2018-08-13 14:12:43', '3', '5');

-- ----------------------------
-- Table structure for sys_log_login
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_login`;
CREATE TABLE `sys_log_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(255) DEFAULT NULL,
  `loginip` varchar(255) DEFAULT NULL,
  `logintime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=744 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_log_login
-- ----------------------------
INSERT INTO `sys_log_login` VALUES ('742', '超级管理员-system', '127.0.0.1', '2018-11-09 15:45:04');
INSERT INTO `sys_log_login` VALUES ('743', '超级管理员-system', '127.0.0.1', '2018-11-09 15:48:09');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `createtime` datetime DEFAULT NULL,
  `opername` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('1', '关于系统V1.3更新公告', '2', '2018-08-07 00:00:00', '管理员');
INSERT INTO `sys_notice` VALUES ('10', '关于系统V1.2更新公告', '12312312<img src=\"http://127.0.0.1:8080/bjsxt/resources/layui/images/face/42.gif\" alt=\"[抓狂]\">', '2018-08-07 00:00:00', '超级管理员');
INSERT INTO `sys_notice` VALUES ('11', '关于系统V1.1更新公告', '21321321321<img src=\"http://127.0.0.1:8080/bjsxt/resources/layui/images/face/18.gif\" alt=\"[右哼哼]\">', '2018-08-07 00:00:00', '超级管理员');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '权限类型[menu/permission]',
  `parent` int(11) DEFAULT '0' COMMENT '0子节点 1父节点',
  `percode` varchar(255) DEFAULT NULL COMMENT '权限编码[只有type= permission才有  user:view]',
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `href` varchar(255) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  `open` int(11) DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  `available` int(11) DEFAULT NULL COMMENT '状态【0不可用1可用】',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('1', '0', 'menu', '1', null, '尚学堂进销存管理系统', '&#xe68e;', '', '', '1', '1', '1');
INSERT INTO `sys_permission` VALUES ('2', '1', 'menu', '1', null, '基础管理', '&#xe857;', '', '', '0', '2', '1');
INSERT INTO `sys_permission` VALUES ('3', '1', 'menu', '1', null, '进货管理', '&#xe645;', '', null, '0', '3', '1');
INSERT INTO `sys_permission` VALUES ('4', '1', 'menu', '1', null, '销售管理', '&#xe611;', '', '', '0', '4', '1');
INSERT INTO `sys_permission` VALUES ('5', '1', 'menu', '1', null, '系统管理', '&#xe614;', '', '', '1', '5', '1');
INSERT INTO `sys_permission` VALUES ('6', '1', 'menu', '1', null, '其它管理', '&#xe628;', '', '', '0', '6', '1');
INSERT INTO `sys_permission` VALUES ('7', '2', 'menu', '0', null, '客户管理', '&#xe651;', '../customer/toCustomerManager.action', '', '0', '7', '1');
INSERT INTO `sys_permission` VALUES ('8', '2', 'menu', '0', null, '供应商管理', '&#xe658;', '../provider/toProviderManager.action', '', '0', '8', '1');
INSERT INTO `sys_permission` VALUES ('9', '2', 'menu', '0', null, '商品管理', '&#xe657;', '../goods/toGoodsManager.action', '', '0', '9', '1');
INSERT INTO `sys_permission` VALUES ('10', '3', 'menu', '0', null, '商品进货', '&#xe756;', '../inport/toInportManager.action', '', '0', '10', '1');
INSERT INTO `sys_permission` VALUES ('11', '3', 'menu', '0', null, '商品退货', '&#xe65a;', '', '', '0', '11', '1');
INSERT INTO `sys_permission` VALUES ('12', '4', 'menu', '0', null, '商品销售', '&#xe65b;', '', '', '0', '12', '1');
INSERT INTO `sys_permission` VALUES ('13', '4', 'menu', '0', null, '销售退货', '&#xe770;', '', '', '0', '13', '1');
INSERT INTO `sys_permission` VALUES ('14', '5', 'menu', '0', null, '部门管理', '&#xe770;', '../dept/toDeptManager.action', '', '0', '14', '1');
INSERT INTO `sys_permission` VALUES ('15', '5', 'menu', '0', null, '菜单管理', '&#xe857;', '../menu/toMenuManager.action', '', '0', '15', '1');
INSERT INTO `sys_permission` VALUES ('16', '5', 'menu', '0', '', '权限管理', '&#xe857;', '../permission/toPermissionManager.action', '', '0', '16', '1');
INSERT INTO `sys_permission` VALUES ('17', '5', 'menu', '0', '', '角色管理', '&#xe650;', '../role/toRoleManager.action', '', '0', '17', '1');
INSERT INTO `sys_permission` VALUES ('18', '5', 'menu', '0', '', '用户管理', '&#xe612;', '../user/toUserManager.action', '', '0', '18', '1');
INSERT INTO `sys_permission` VALUES ('21', '6', 'menu', '0', null, '登陆日志', '&#xe675;', '../logInfo/toLogInfoManager.action', null, '0', '21', '1');
INSERT INTO `sys_permission` VALUES ('22', '6', 'menu', '0', null, '系统公告', '&#xe756;', '../notice/toNoticeManager.action', null, '0', '22', '1');
INSERT INTO `sys_permission` VALUES ('23', '6', 'menu', '0', null, '图标管理', '&#xe670;', '../resources/page/icon.html', null, '0', '23', '1');
INSERT INTO `sys_permission` VALUES ('30', '14', 'permission', '0', 'dept:create', '添加部门', '', null, null, '0', '24', '1');
INSERT INTO `sys_permission` VALUES ('31', '14', 'permission', '0', 'dept:update', '修改部门', '', null, null, '0', '26', '1');
INSERT INTO `sys_permission` VALUES ('32', '14', 'permission', '0', 'dept:delete', '删除部门', '', null, null, '0', '27', '1');
INSERT INTO `sys_permission` VALUES ('33', '14', 'permission', '0', 'dept:batchdelete', '批量删除', '', null, null, '0', '28', '1');
INSERT INTO `sys_permission` VALUES ('34', '15', 'permission', '0', 'menu:create', '添加菜单', '', '', '', '0', '29', '1');
INSERT INTO `sys_permission` VALUES ('35', '15', 'permission', '0', 'menu:update', '修改菜单', '', null, null, '0', '30', '1');
INSERT INTO `sys_permission` VALUES ('36', '15', 'permission', '0', 'menu:delete', '删除菜单', '', null, null, '0', '31', '1');
INSERT INTO `sys_permission` VALUES ('37', '15', 'permission', '0', 'menu:batchdelete', '菜单批量删除', '', null, null, '0', '32', '1');
INSERT INTO `sys_permission` VALUES ('38', '16', 'permission', '0', 'permission:create', '添加权限', '', null, null, '0', '33', '1');
INSERT INTO `sys_permission` VALUES ('39', '16', 'permission', '0', 'permission:update', '修改权限', '', null, null, '0', '34', '1');
INSERT INTO `sys_permission` VALUES ('40', '16', 'permission', '0', 'permission:delete', '删除权限', '', null, null, '0', '35', '1');
INSERT INTO `sys_permission` VALUES ('41', '16', 'permission', '0', 'permission:batchdelete', '权限批量删除', '', null, null, '0', '36', '1');
INSERT INTO `sys_permission` VALUES ('42', '17', 'permission', '0', 'role:create', '添加角色', '', null, null, '0', '37', '1');
INSERT INTO `sys_permission` VALUES ('43', '17', 'permission', '0', 'role:update', '修改角色', '', null, null, '0', '38', '1');
INSERT INTO `sys_permission` VALUES ('44', '17', 'permission', '0', 'role:delete', '删除角色', '', null, null, '0', '39', '1');
INSERT INTO `sys_permission` VALUES ('45', '17', 'permission', '0', 'role:batchdelete', '角色批量删除', '', null, null, '0', '40', '1');
INSERT INTO `sys_permission` VALUES ('46', '17', 'permission', '0', 'role:selectPermission', '分配权限', '', null, null, '0', '41', '1');
INSERT INTO `sys_permission` VALUES ('47', '18', 'permission', '0', 'user:create', '添加用户', '', null, null, '0', '42', '1');
INSERT INTO `sys_permission` VALUES ('48', '18', 'permission', '0', 'user:update', '修改用户', '', null, null, '0', '43', '1');
INSERT INTO `sys_permission` VALUES ('49', '18', 'permission', '0', 'user:delete', '删除用户', '', null, null, '0', '44', '1');
INSERT INTO `sys_permission` VALUES ('50', '18', 'permission', '0', 'user:batchdelete', '用户批量删除', '', null, null, '0', '45', '1');
INSERT INTO `sys_permission` VALUES ('51', '18', 'permission', '0', 'user:selectRole', '用户分配角色', '', null, null, '0', '46', '1');
INSERT INTO `sys_permission` VALUES ('52', '18', 'permission', '0', 'user:resetpwd', '重置密码', null, null, null, '0', '47', '1');
INSERT INTO `sys_permission` VALUES ('53', '14', 'permission', '0', 'dept:view', '部门查询', null, null, null, '0', '48', '1');
INSERT INTO `sys_permission` VALUES ('54', '15', 'permission', '0', 'menu:view', '菜单查询', null, null, null, '0', '49', '1');
INSERT INTO `sys_permission` VALUES ('55', '16', 'permission', '0', 'permission:view', '权限查询', null, null, null, '0', '50', '1');
INSERT INTO `sys_permission` VALUES ('56', '17', 'permission', '0', 'role:view', '角色查询', null, null, null, '0', '51', '1');
INSERT INTO `sys_permission` VALUES ('57', '18', 'permission', '0', 'user:view', '用户查询', null, null, null, '0', '52', '1');
INSERT INTO `sys_permission` VALUES ('58', '1', 'menu', '1', null, '流程管理', '&#xe679;', '', '', '0', '53', '1');
INSERT INTO `sys_permission` VALUES ('59', '58', 'menu', '0', null, '流程管理', '&#xe66e;', '../workFlow/toWorkFlowManager.action', '', '0', '54', '1');
INSERT INTO `sys_permission` VALUES ('60', '58', 'menu', '0', null, '查询历史流程', '&#xe674;', '', '', '0', '55', '1');
INSERT INTO `sys_permission` VALUES ('61', '1', 'menu', '1', null, '审批管理', '&#xe653;', '', '', '0', '56', '1');
INSERT INTO `sys_permission` VALUES ('62', '61', 'menu', '0', null, '请假单管理', '&#xe66a;', '../leaveBill/toLeaveBillManager.action', '', '0', '57', '1');
INSERT INTO `sys_permission` VALUES ('63', '61', 'menu', '0', null, '我的待办任务', '&#xe668;', '', '', '0', '58', '1');
INSERT INTO `sys_permission` VALUES ('64', '61', 'menu', '0', null, '我的审批记录', '&#xe665;', '', '', '0', '59', '1');
INSERT INTO `sys_permission` VALUES ('68', '7', 'permission', '0', 'customer:view', '客户查询', null, null, null, null, '60', '1');
INSERT INTO `sys_permission` VALUES ('69', '7', 'permission', '0', 'customer:create', '客户添加', null, null, null, null, '61', '1');
INSERT INTO `sys_permission` VALUES ('70', '7', 'permission', '0', 'customer:update', '客户修改', null, null, null, null, '62', '1');
INSERT INTO `sys_permission` VALUES ('71', '7', 'permission', '0', 'customer:delete', '客户删除', null, null, null, null, '63', '1');
INSERT INTO `sys_permission` VALUES ('72', '7', 'permission', '0', 'customer:batchdelete', '客户批量删除', null, null, null, null, '64', '1');
INSERT INTO `sys_permission` VALUES ('73', '21', 'permission', '0', 'info:view', '日志查询', null, null, null, null, '65', '1');
INSERT INTO `sys_permission` VALUES ('74', '21', 'permission', '0', 'info:delete', '日志删除', null, null, null, null, '66', '1');
INSERT INTO `sys_permission` VALUES ('75', '21', 'permission', '0', 'info:batchdelete', '日志批量删除', null, null, null, null, '67', '1');
INSERT INTO `sys_permission` VALUES ('76', '22', 'permission', '0', 'notice:view', '公告查询', null, null, null, null, '68', '1');
INSERT INTO `sys_permission` VALUES ('77', '22', 'permission', '0', 'notice:create', '公告添加', null, null, null, null, '69', '1');
INSERT INTO `sys_permission` VALUES ('78', '22', 'permission', '0', 'notice:update', '公告修改', null, null, null, null, '70', '1');
INSERT INTO `sys_permission` VALUES ('79', '22', 'permission', '0', 'notice:delete', '公告删除', null, null, null, null, '71', '1');
INSERT INTO `sys_permission` VALUES ('80', '22', 'permission', '0', 'notice:batchdelete', '公告批量删除', null, null, null, null, '72', '1');
INSERT INTO `sys_permission` VALUES ('81', '8', 'permission', '0', 'provider:view', '供应商查询', null, null, null, null, '73', '1');
INSERT INTO `sys_permission` VALUES ('82', '8', 'permission', '0', 'provider:create', '供应商添加', null, null, null, null, '74', '1');
INSERT INTO `sys_permission` VALUES ('83', '8', 'permission', '0', 'provider:update', '供应商修改', null, null, null, null, '75', '1');
INSERT INTO `sys_permission` VALUES ('84', '8', 'permission', '0', 'provider:delete', '供应商删除', null, null, null, null, '76', '1');
INSERT INTO `sys_permission` VALUES ('85', '8', 'permission', '0', 'provider:batchdelete', '供应商批量删除', null, null, null, null, '77', '1');
INSERT INTO `sys_permission` VALUES ('86', '22', 'permission', '0', 'notice:viewnotice', '公告查看', null, null, null, null, '78', '1');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', '拥有所有菜单权限', '1');
INSERT INTO `sys_role` VALUES ('4', '基础数据管理员', '基础数据管理员', '1');
INSERT INTO `sys_role` VALUES ('5', '仓库管理员', '仓库管理员', '1');
INSERT INTO `sys_role` VALUES ('6', '销售管理员', '销售管理员', '1');
INSERT INTO `sys_role` VALUES ('7', '系统管理员', '系统管理员', '1');
INSERT INTO `sys_role` VALUES ('8', '流程管理权限', '流程管理权限', '1');
INSERT INTO `sys_role` VALUES ('9', '审批权限', '审批权限', '1');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `rid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`pid`,`rid`),
  KEY `FK_tcsr9ucxypb3ce1q5qngsfk33` (`rid`),
  CONSTRAINT `FK_PERMISSION_PID` FOREIGN KEY (`pid`) REFERENCES `sys_permission` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ROLE_RID` FOREIGN KEY (`rid`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('1', '1');
INSERT INTO `sys_role_permission` VALUES ('1', '2');
INSERT INTO `sys_role_permission` VALUES ('1', '3');
INSERT INTO `sys_role_permission` VALUES ('1', '4');
INSERT INTO `sys_role_permission` VALUES ('1', '5');
INSERT INTO `sys_role_permission` VALUES ('1', '6');
INSERT INTO `sys_role_permission` VALUES ('1', '7');
INSERT INTO `sys_role_permission` VALUES ('1', '8');
INSERT INTO `sys_role_permission` VALUES ('1', '9');
INSERT INTO `sys_role_permission` VALUES ('1', '10');
INSERT INTO `sys_role_permission` VALUES ('1', '11');
INSERT INTO `sys_role_permission` VALUES ('1', '12');
INSERT INTO `sys_role_permission` VALUES ('1', '13');
INSERT INTO `sys_role_permission` VALUES ('1', '14');
INSERT INTO `sys_role_permission` VALUES ('1', '15');
INSERT INTO `sys_role_permission` VALUES ('1', '16');
INSERT INTO `sys_role_permission` VALUES ('1', '17');
INSERT INTO `sys_role_permission` VALUES ('1', '18');
INSERT INTO `sys_role_permission` VALUES ('1', '21');
INSERT INTO `sys_role_permission` VALUES ('1', '22');
INSERT INTO `sys_role_permission` VALUES ('1', '23');
INSERT INTO `sys_role_permission` VALUES ('1', '30');
INSERT INTO `sys_role_permission` VALUES ('1', '31');
INSERT INTO `sys_role_permission` VALUES ('1', '32');
INSERT INTO `sys_role_permission` VALUES ('1', '33');
INSERT INTO `sys_role_permission` VALUES ('1', '34');
INSERT INTO `sys_role_permission` VALUES ('1', '35');
INSERT INTO `sys_role_permission` VALUES ('1', '36');
INSERT INTO `sys_role_permission` VALUES ('1', '37');
INSERT INTO `sys_role_permission` VALUES ('1', '38');
INSERT INTO `sys_role_permission` VALUES ('1', '39');
INSERT INTO `sys_role_permission` VALUES ('1', '40');
INSERT INTO `sys_role_permission` VALUES ('1', '41');
INSERT INTO `sys_role_permission` VALUES ('1', '42');
INSERT INTO `sys_role_permission` VALUES ('1', '43');
INSERT INTO `sys_role_permission` VALUES ('1', '44');
INSERT INTO `sys_role_permission` VALUES ('1', '45');
INSERT INTO `sys_role_permission` VALUES ('1', '46');
INSERT INTO `sys_role_permission` VALUES ('1', '47');
INSERT INTO `sys_role_permission` VALUES ('1', '48');
INSERT INTO `sys_role_permission` VALUES ('1', '49');
INSERT INTO `sys_role_permission` VALUES ('1', '50');
INSERT INTO `sys_role_permission` VALUES ('1', '51');
INSERT INTO `sys_role_permission` VALUES ('1', '52');
INSERT INTO `sys_role_permission` VALUES ('1', '53');
INSERT INTO `sys_role_permission` VALUES ('1', '54');
INSERT INTO `sys_role_permission` VALUES ('1', '55');
INSERT INTO `sys_role_permission` VALUES ('1', '56');
INSERT INTO `sys_role_permission` VALUES ('1', '57');
INSERT INTO `sys_role_permission` VALUES ('1', '58');
INSERT INTO `sys_role_permission` VALUES ('1', '59');
INSERT INTO `sys_role_permission` VALUES ('1', '60');
INSERT INTO `sys_role_permission` VALUES ('1', '61');
INSERT INTO `sys_role_permission` VALUES ('1', '62');
INSERT INTO `sys_role_permission` VALUES ('1', '63');
INSERT INTO `sys_role_permission` VALUES ('1', '64');
INSERT INTO `sys_role_permission` VALUES ('1', '68');
INSERT INTO `sys_role_permission` VALUES ('1', '69');
INSERT INTO `sys_role_permission` VALUES ('1', '70');
INSERT INTO `sys_role_permission` VALUES ('1', '71');
INSERT INTO `sys_role_permission` VALUES ('1', '72');
INSERT INTO `sys_role_permission` VALUES ('1', '73');
INSERT INTO `sys_role_permission` VALUES ('1', '74');
INSERT INTO `sys_role_permission` VALUES ('1', '75');
INSERT INTO `sys_role_permission` VALUES ('1', '76');
INSERT INTO `sys_role_permission` VALUES ('1', '77');
INSERT INTO `sys_role_permission` VALUES ('1', '78');
INSERT INTO `sys_role_permission` VALUES ('1', '79');
INSERT INTO `sys_role_permission` VALUES ('1', '80');
INSERT INTO `sys_role_permission` VALUES ('1', '81');
INSERT INTO `sys_role_permission` VALUES ('1', '82');
INSERT INTO `sys_role_permission` VALUES ('1', '83');
INSERT INTO `sys_role_permission` VALUES ('1', '84');
INSERT INTO `sys_role_permission` VALUES ('1', '85');
INSERT INTO `sys_role_permission` VALUES ('1', '86');
INSERT INTO `sys_role_permission` VALUES ('4', '1');
INSERT INTO `sys_role_permission` VALUES ('4', '2');
INSERT INTO `sys_role_permission` VALUES ('4', '7');
INSERT INTO `sys_role_permission` VALUES ('4', '8');
INSERT INTO `sys_role_permission` VALUES ('4', '9');
INSERT INTO `sys_role_permission` VALUES ('4', '68');
INSERT INTO `sys_role_permission` VALUES ('4', '69');
INSERT INTO `sys_role_permission` VALUES ('4', '70');
INSERT INTO `sys_role_permission` VALUES ('4', '71');
INSERT INTO `sys_role_permission` VALUES ('4', '72');
INSERT INTO `sys_role_permission` VALUES ('4', '81');
INSERT INTO `sys_role_permission` VALUES ('4', '82');
INSERT INTO `sys_role_permission` VALUES ('4', '83');
INSERT INTO `sys_role_permission` VALUES ('4', '84');
INSERT INTO `sys_role_permission` VALUES ('4', '85');
INSERT INTO `sys_role_permission` VALUES ('5', '1');
INSERT INTO `sys_role_permission` VALUES ('5', '3');
INSERT INTO `sys_role_permission` VALUES ('5', '10');
INSERT INTO `sys_role_permission` VALUES ('5', '11');
INSERT INTO `sys_role_permission` VALUES ('6', '1');
INSERT INTO `sys_role_permission` VALUES ('6', '4');
INSERT INTO `sys_role_permission` VALUES ('6', '12');
INSERT INTO `sys_role_permission` VALUES ('6', '13');
INSERT INTO `sys_role_permission` VALUES ('7', '1');
INSERT INTO `sys_role_permission` VALUES ('7', '5');
INSERT INTO `sys_role_permission` VALUES ('7', '6');
INSERT INTO `sys_role_permission` VALUES ('7', '14');
INSERT INTO `sys_role_permission` VALUES ('7', '15');
INSERT INTO `sys_role_permission` VALUES ('7', '16');
INSERT INTO `sys_role_permission` VALUES ('7', '17');
INSERT INTO `sys_role_permission` VALUES ('7', '18');
INSERT INTO `sys_role_permission` VALUES ('7', '21');
INSERT INTO `sys_role_permission` VALUES ('7', '22');
INSERT INTO `sys_role_permission` VALUES ('7', '23');
INSERT INTO `sys_role_permission` VALUES ('7', '30');
INSERT INTO `sys_role_permission` VALUES ('7', '31');
INSERT INTO `sys_role_permission` VALUES ('7', '32');
INSERT INTO `sys_role_permission` VALUES ('7', '34');
INSERT INTO `sys_role_permission` VALUES ('7', '35');
INSERT INTO `sys_role_permission` VALUES ('7', '36');
INSERT INTO `sys_role_permission` VALUES ('7', '38');
INSERT INTO `sys_role_permission` VALUES ('7', '39');
INSERT INTO `sys_role_permission` VALUES ('7', '40');
INSERT INTO `sys_role_permission` VALUES ('7', '42');
INSERT INTO `sys_role_permission` VALUES ('7', '46');
INSERT INTO `sys_role_permission` VALUES ('7', '51');
INSERT INTO `sys_role_permission` VALUES ('7', '52');
INSERT INTO `sys_role_permission` VALUES ('7', '53');
INSERT INTO `sys_role_permission` VALUES ('7', '54');
INSERT INTO `sys_role_permission` VALUES ('7', '55');
INSERT INTO `sys_role_permission` VALUES ('7', '56');
INSERT INTO `sys_role_permission` VALUES ('7', '57');
INSERT INTO `sys_role_permission` VALUES ('7', '73');
INSERT INTO `sys_role_permission` VALUES ('7', '74');
INSERT INTO `sys_role_permission` VALUES ('7', '75');
INSERT INTO `sys_role_permission` VALUES ('7', '76');
INSERT INTO `sys_role_permission` VALUES ('7', '77');
INSERT INTO `sys_role_permission` VALUES ('7', '78');
INSERT INTO `sys_role_permission` VALUES ('7', '79');
INSERT INTO `sys_role_permission` VALUES ('7', '80');
INSERT INTO `sys_role_permission` VALUES ('7', '86');
INSERT INTO `sys_role_permission` VALUES ('8', '1');
INSERT INTO `sys_role_permission` VALUES ('8', '58');
INSERT INTO `sys_role_permission` VALUES ('8', '59');
INSERT INTO `sys_role_permission` VALUES ('8', '60');
INSERT INTO `sys_role_permission` VALUES ('9', '1');
INSERT INTO `sys_role_permission` VALUES ('9', '61');
INSERT INTO `sys_role_permission` VALUES ('9', '62');
INSERT INTO `sys_role_permission` VALUES ('9', '63');
INSERT INTO `sys_role_permission` VALUES ('9', '64');

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user` (
  `rid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`uid`,`rid`),
  KEY `FK_203gdpkwgtow7nxlo2oap5jru` (`rid`),
  CONSTRAINT `FK_203gdpkwgtow7nxlo2oap5jru` FOREIGN KEY (`rid`) REFERENCES `sys_role` (`id`),
  CONSTRAINT `FK_rmo144ixp2kul8rgs4sk5j0er` FOREIGN KEY (`uid`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES ('1', '2');
INSERT INTO `sys_role_user` VALUES ('4', '3');
INSERT INTO `sys_role_user` VALUES ('5', '4');
INSERT INTO `sys_role_user` VALUES ('6', '6');
INSERT INTO `sys_role_user` VALUES ('7', '5');
INSERT INTO `sys_role_user` VALUES ('9', '3');
INSERT INTO `sys_role_user` VALUES ('9', '4');
INSERT INTO `sys_role_user` VALUES ('9', '5');
INSERT INTO `sys_role_user` VALUES ('9', '6');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `loginname` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `deptid` int(11) DEFAULT NULL,
  `hiredate` datetime DEFAULT NULL,
  `mgr` int(11) DEFAULT NULL,
  `available` int(11) DEFAULT '1',
  `ordernum` int(11) DEFAULT NULL,
  `type` int(255) DEFAULT NULL COMMENT '用户类型[0超级管理员1，管理员，2普通用户]',
  `imgpath` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_3rrcpvho2w1mx1sfiuuyir1h` (`deptid`),
  CONSTRAINT `FK_3rrcpvho2w1mx1sfiuuyir1h` FOREIGN KEY (`deptid`) REFERENCES `sys_dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '超级管理员', 'system', '系统深处的男人', '1', '超级管理员', 'f925dc3209cd010d6b6388686157d005', '1', '2018-06-25 11:06:34', null, '1', '1', '0', '../resources/images/defaultusertitle.jpg', 'D0B462563046430A8712C1C5A58B3BBD');
INSERT INTO `sys_user` VALUES ('2', '李四', 'ls', '武汉', '0', 'KING', 'b07b848d69e0553b80e601d31571797e', '1', '2018-06-25 11:06:36', null, '1', '2', '1', '../resources/images/defaultusertitle.jpg', 'FC1EE06AE4354D3FBF7FDD15C8FCDA71');
INSERT INTO `sys_user` VALUES ('3', '王五', 'ww', '武汉', '1', '管理员', '3c3f971eae61e097f59d52360323f1c8', '3', '2018-06-25 11:06:38', '2', '1', '3', '1', '../resources/images/defaultusertitle.jpg', '3D5F956E053C4E85B7D2681386E235D2');
INSERT INTO `sys_user` VALUES ('4', '赵六', 'zl', '武汉', '1', '程序员', '2e969742a7ea0c7376e9551d578e05dd', '4', '2018-06-25 11:06:40', '3', '1', '4', '1', '../resources/images/defaultusertitle.jpg', '6480EE1391E34B0886ACADA501E31145');
INSERT INTO `sys_user` VALUES ('5', '孙七', 'sq', '武汉', '1', '程序员', '47b4c1ad6e4b54dd9387a09cb5a03de1', '2', '2018-06-25 11:06:43', '4', '1', '5', '1', '../resources/images/defaultusertitle.jpg', 'FE3476C3E3674E5690C737C269FCBF8E');
INSERT INTO `sys_user` VALUES ('6', '刘八', 'lb', '深圳', '1', '程序员', '3713b5f96b23160b6ee3cce66ee9f209', '4', '2018-08-06 11:21:12', '3', '1', '6', '1', '../resources/images/defaultusertitle.jpg', '9C55340DBF694020A1318D1249191702');
