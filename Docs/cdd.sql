/*
MySQL Data Transfer
Source Host: 59.110.142.107
Source Database: cdd
Target Host: 59.110.142.107
Target Database: cdd
Date: 2018/10/15 22:35:47
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `des` varchar(30) DEFAULT NULL,
  `money` float(10,2) DEFAULT NULL,
  `create_time` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for broadcastimg
-- ----------------------------
DROP TABLE IF EXISTS `broadcastimg`;
CREATE TABLE `broadcastimg` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `img` text NOT NULL COMMENT '图片',
  `url` text,
  `class` int(10) DEFAULT NULL COMMENT '类型',
  `status_delete` int(1) NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `modify_time` int(10) DEFAULT NULL COMMENT '最后·修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `good_id` int(10) DEFAULT NULL,
  `good_num` int(10) DEFAULT NULL,
  `create_time` int(20) DEFAULT NULL,
  `status_delete` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COMMENT='购物车';

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '商品类别名称',
  `category_img` text CHARACTER SET utf8 NOT NULL COMMENT '类别图片',
  `introduce` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '商品类别介绍',
  `status_delete` int(1) NOT NULL DEFAULT '1' COMMENT '逻辑删除',
  `time` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userid` int(10) DEFAULT NULL COMMENT '用户id',
  `commodityid` int(10) DEFAULT NULL COMMENT '商品id',
  `status_delete` int(10) NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) NOT NULL COMMENT '添加时间',
  `shop_name` varchar(255) DEFAULT NULL,
  `shop_index_image` text,
  `shop_price` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for commodity
-- ----------------------------
DROP TABLE IF EXISTS `commodity`;
CREATE TABLE `commodity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL COMMENT '父类',
  `shop_name` varchar(255) NOT NULL COMMENT '商品名称',
  `shop_id` int(10) NOT NULL COMMENT '商品编号',
  `shop_index_image` text NOT NULL COMMENT '商品主图',
  `shop_image` text NOT NULL COMMENT '商品图片',
  `shop_type` int(10) NOT NULL COMMENT '商品类别',
  `shop_num` int(10) NOT NULL COMMENT '库存',
  `shop_sale` int(10) NOT NULL COMMENT '已销售商品数',
  `shop_introduce` varchar(255) NOT NULL COMMENT '商品详细',
  `shop_price` float(10,2) NOT NULL COMMENT '商品价格',
  `last_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '猜中后价格',
  `hot` int(10) DEFAULT NULL COMMENT '热卖',
  `recommend` int(10) DEFAULT NULL COMMENT '推荐',
  `quantity` int(10) NOT NULL COMMENT '限量秒杀',
  `status_delete` tinyint(1) NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `shop_id` int(10) NOT NULL COMMENT '商品id',
  `bonus` varchar(255) NOT NULL COMMENT '优惠券减免金额',
  `message` varchar(255) NOT NULL COMMENT '优惠券内容',
  `status` tinyint(1) NOT NULL COMMENT '使用状态',
  `effective_start_date` int(10) NOT NULL COMMENT '优惠券开始日期',
  `effective_end_date` int(10) NOT NULL COMMENT '优惠券截止日期',
  `code_url` varchar(255) NOT NULL COMMENT '二维码地址',
  `code` varchar(255) NOT NULL COMMENT '无序码',
  `status_delete` tinyint(1) NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for employee_system
-- ----------------------------
DROP TABLE IF EXISTS `employee_system`;
CREATE TABLE `employee_system` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(20) NOT NULL,
  `password` varchar(40) NOT NULL,
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `status` int(10) unsigned NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统员工信息';

-- ----------------------------
-- Table structure for lottery
-- ----------------------------
DROP TABLE IF EXISTS `lottery`;
CREATE TABLE `lottery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `term_number` varchar(255) DEFAULT NULL COMMENT '期号',
  `award_number` varchar(255) DEFAULT NULL COMMENT '开奖号码',
  `opening_time` varchar(255) DEFAULT NULL COMMENT '开奖时间',
  `status_delete` tinyint(1) NOT NULL COMMENT '逻辑删除',
  `free_count` int(10) DEFAULT NULL COMMENT '已免单数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for notify_test
-- ----------------------------
DROP TABLE IF EXISTS `notify_test`;
CREATE TABLE `notify_test` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `value` varchar(256) DEFAULT NULL,
  `key` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `order_number` varchar(255) DEFAULT NULL COMMENT '订单编号',
  `address_consignee` varchar(10) DEFAULT NULL COMMENT '商品id',
  `address_mobile` varchar(11) DEFAULT NULL,
  `address_region` varchar(255) DEFAULT NULL,
  `address_address` varchar(255) DEFAULT NULL,
  `shipping_name` varchar(255) DEFAULT NULL,
  `coupon_id` int(10) DEFAULT NULL,
  `user_note` varchar(255) DEFAULT NULL COMMENT '买家留言',
  `total_num` int(10) DEFAULT NULL COMMENT '商品数量',
  `total_price` float(10,2) DEFAULT NULL COMMENT '总金额',
  `shop_status` tinyint(1) DEFAULT NULL COMMENT '商品状态（0待付款、1待发货、2待收货、3已收货、4取消订单）',
  `is_free` tinyint(1) DEFAULT NULL COMMENT '是否免单(0未开奖1恭喜免单2未免单)',
  `status_delete` tinyint(1) DEFAULT '1' COMMENT '逻辑删除',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `guess_status` tinyint(1) DEFAULT '0' COMMENT '猜奖状态（0未猜奖1已猜奖）',
  `guess_content` tinyint(1) DEFAULT '0' COMMENT '猜奖（1猜单2猜双）',
  `guess_term_number` int(10) DEFAULT '0' COMMENT '猜奖期号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) NOT NULL,
  `shop_id` int(10) NOT NULL COMMENT '商品id',
  `num` int(10) NOT NULL COMMENT '商品数量',
  `status_delete` tinyint(1) NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for refund
-- ----------------------------
DROP TABLE IF EXISTS `refund`;
CREATE TABLE `refund` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `refund_number` varchar(32) DEFAULT NULL COMMENT '款退编号',
  `user_id` int(10) DEFAULT NULL,
  `money` float(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '0待审核1审核通过2审核不通过',
  `note` varchar(255) DEFAULT '' COMMENT '审核备注',
  `create_time` int(20) DEFAULT NULL,
  `review_time` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='退款审核表';

-- ----------------------------
-- Table structure for rule
-- ----------------------------
DROP TABLE IF EXISTS `rule`;
CREATE TABLE `rule` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL COMMENT '内容',
  `status_delete` int(10) NOT NULL COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) DEFAULT NULL COMMENT '用户id',
  `consignee` varchar(255) DEFAULT NULL COMMENT '收货人',
  `mobile` varchar(12) DEFAULT NULL COMMENT '手机号码',
  `region` varchar(255) DEFAULT NULL COMMENT '所在地区',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `is_default` tinyint(1) DEFAULT NULL COMMENT '是否为默认值1是0否',
  `status_delete` tinyint(1) NOT NULL,
  `create_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wechat_user
-- ----------------------------
DROP TABLE IF EXISTS `wechat_user`;
CREATE TABLE `wechat_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `openid` varchar(50) NOT NULL COMMENT 'openid',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `realname` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `balance` float(10,2) unsigned DEFAULT '0.00' COMMENT '余额',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `present_account` varchar(255) DEFAULT NULL COMMENT '提现账户',
  `imageurl` varchar(200) DEFAULT NULL COMMENT '头像路径',
  `gender` tinyint(1) unsigned DEFAULT NULL COMMENT '性别',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `province` varchar(50) DEFAULT NULL COMMENT '省份',
  `country` varchar(50) DEFAULT NULL COMMENT '国家',
  `login_time` int(10) unsigned DEFAULT NULL COMMENT '上次登录时间',
  `coupon` varchar(50) DEFAULT NULL COMMENT '优惠券',
  `status_delete` tinyint(10) unsigned NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `account` VALUES ('1', '15', '收款', '50.00', '1530001067');
INSERT INTO `account` VALUES ('2', '15', '收款', '50.00', '1530001099');
INSERT INTO `broadcastimg` VALUES ('1', 'http://img1.3lian.com/2015/w1/76/d/115.jpg', null, '0', '0', '1529997749', '1529997749');
INSERT INTO `broadcastimg` VALUES ('2', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/29\\/5b3603367bb22.jpg\"]', '空', '22', '0', '1530264517', '1530266425');
INSERT INTO `broadcastimg` VALUES ('3', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/02\\/5b398b9c10f28.png\"]', '空', '0', '0', '1530497951', '1530497951');
INSERT INTO `broadcastimg` VALUES ('4', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/04\\/5b3c590b420d2.jpg\"]', '空', '0', '0', '1530498165', '1530681613');
INSERT INTO `broadcastimg` VALUES ('5', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/04\\/5b3c717b1e5c8.jpg\"]', '空', '0', '0', '1530681704', '1530687867');
INSERT INTO `broadcastimg` VALUES ('6', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b42cb1b0535d.jpg\"]', '空', '0', '1', '1531104054', '1531104054');
INSERT INTO `broadcastimg` VALUES ('7', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b42cb5a20791.jpg\"]', '空', '1', '1', '1531104106', '1531104106');
INSERT INTO `broadcastimg` VALUES ('8', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b42cb86a36ed.jpg\"]', '空', '0', '1', '1531104137', '1531104137');
INSERT INTO `cart` VALUES ('19', '14', '0', '7', '1530235690', '0');
INSERT INTO `cart` VALUES ('20', '15', '10', '2', '1530260656', '0');
INSERT INTO `cart` VALUES ('21', '15', '3', '1', '1530260693', '0');
INSERT INTO `cart` VALUES ('22', '15', '10', '1', '1530586914', '0');
INSERT INTO `cart` VALUES ('23', '14', '2', '2', '1530588201', '0');
INSERT INTO `cart` VALUES ('24', '14', '1', '1', '1530588209', '0');
INSERT INTO `cart` VALUES ('25', '14', '11', '2', '1530588254', '0');
INSERT INTO `cart` VALUES ('26', '15', '11', '1', '1530588389', '0');
INSERT INTO `cart` VALUES ('27', '14', '10', '1', '1530590775', '0');
INSERT INTO `cart` VALUES ('28', '14', '4', '3', '1530591048', '0');
INSERT INTO `cart` VALUES ('29', '14', '8', '1', '1530606262', '0');
INSERT INTO `cart` VALUES ('30', '14', '7', '2', '1530606271', '0');
INSERT INTO `cart` VALUES ('31', '14', '2', '2', '1530606694', '0');
INSERT INTO `cart` VALUES ('32', '14', '7', '1', '1530606706', '0');
INSERT INTO `cart` VALUES ('33', '14', '11', '1', '1530607466', '0');
INSERT INTO `cart` VALUES ('34', '15', '3', '1', '1530671026', '0');
INSERT INTO `cart` VALUES ('35', '15', '4', '3', '1530687090', '0');
INSERT INTO `cart` VALUES ('36', '15', '7', '1', '1530687183', '0');
INSERT INTO `cart` VALUES ('37', '15', '6', '1', '1530687222', '0');
INSERT INTO `cart` VALUES ('38', '15', '6', '2', '1530687312', '0');
INSERT INTO `cart` VALUES ('39', '15', '8', '1', '1530687399', '0');
INSERT INTO `cart` VALUES ('40', '15', '13', '1', '1530687679', '0');
INSERT INTO `cart` VALUES ('41', '15', '10', '1', '1530687819', '0');
INSERT INTO `cart` VALUES ('42', '15', '4', '1', '1530688069', '0');
INSERT INTO `cart` VALUES ('43', '15', '6', '1', '1530688262', '0');
INSERT INTO `cart` VALUES ('44', '15', '4', '1', '1530690098', '0');
INSERT INTO `cart` VALUES ('45', '15', '3', '1', '1530690137', '0');
INSERT INTO `cart` VALUES ('46', '15', '3', '1', '1530690194', '0');
INSERT INTO `cart` VALUES ('47', '15', '3', '1', '1530690615', '0');
INSERT INTO `cart` VALUES ('48', '15', '3', '2', '1530691344', '0');
INSERT INTO `cart` VALUES ('49', '15', '14', '1', '1530691695', '0');
INSERT INTO `cart` VALUES ('50', '15', '14', '1', '1530691825', '0');
INSERT INTO `cart` VALUES ('51', '15', '3', '1', '1530691901', '0');
INSERT INTO `cart` VALUES ('52', '15', '5', '1', '1530691988', '0');
INSERT INTO `cart` VALUES ('53', '15', '3', '1', '1530692169', '0');
INSERT INTO `cart` VALUES ('54', '15', '3', '1', '1530692221', '0');
INSERT INTO `cart` VALUES ('55', '15', '10', '1', '1530692375', '0');
INSERT INTO `cart` VALUES ('56', '15', '10', '1', '1530692488', '0');
INSERT INTO `cart` VALUES ('57', '15', '3', '1', '1530692980', '0');
INSERT INTO `cart` VALUES ('58', '15', '3', '4', '1530695553', '0');
INSERT INTO `cart` VALUES ('59', '29', '4', '1', '1530698777', '0');
INSERT INTO `cart` VALUES ('60', '34', '14', '200147', '1530698973', '0');
INSERT INTO `cart` VALUES ('61', '29', '9', '7', '1530699025', '0');
INSERT INTO `cart` VALUES ('62', '0', '5', '4', '1530699127', '0');
INSERT INTO `cart` VALUES ('63', '33', '10', '1', '1530699149', '0');
INSERT INTO `cart` VALUES ('64', '33', '2', '1', '1530699269', '0');
INSERT INTO `cart` VALUES ('65', '0', '4', '5', '1530699308', '0');
INSERT INTO `cart` VALUES ('66', '0', '2', '1', '1530699327', '0');
INSERT INTO `cart` VALUES ('67', '0', '1', '1', '1530699335', '0');
INSERT INTO `cart` VALUES ('68', '0', '5', '1', '1530699390', '0');
INSERT INTO `cart` VALUES ('69', '15', '10', '1', '1530700107', '0');
INSERT INTO `cart` VALUES ('70', '15', '3', '1', '1530700189', '0');
INSERT INTO `cart` VALUES ('71', '15', '3', '1', '1530700499', '0');
INSERT INTO `cart` VALUES ('72', '0', '9', '4', '1530700837', '1');
INSERT INTO `cart` VALUES ('73', '15', '5', '1', '1530700937', '0');
INSERT INTO `cart` VALUES ('74', '19', '5', '33', '1530757702', '0');
INSERT INTO `cart` VALUES ('75', '15', '3', '1', '1530758100', '1');
INSERT INTO `cart` VALUES ('76', '18', '14', '2', '1530758803', '0');
INSERT INTO `cart` VALUES ('77', '15', '5', '2', '1530763060', '0');
INSERT INTO `cart` VALUES ('78', '30', '15', '5', '1530771577', '1');
INSERT INTO `cart` VALUES ('79', '15', '17', '1', '1530772689', '0');
INSERT INTO `cart` VALUES ('80', '15', '11', '1', '1530772911', '0');
INSERT INTO `cart` VALUES ('81', '18', '16', '2', '1530773505', '0');
INSERT INTO `cart` VALUES ('82', '18', '17', '1', '1530774243', '0');
INSERT INTO `cart` VALUES ('83', '18', '15', '2', '1530775132', '0');
INSERT INTO `cart` VALUES ('84', '32', '3', '1', '1530776815', '0');
INSERT INTO `cart` VALUES ('85', '18', '17', '1', '1530777050', '0');
INSERT INTO `cart` VALUES ('86', '18', '16', '2', '1530777255', '0');
INSERT INTO `cart` VALUES ('87', '32', '3', '1', '1530784220', '0');
INSERT INTO `cart` VALUES ('88', '18', '17', '1', '1530784886', '0');
INSERT INTO `cart` VALUES ('89', '34', '17', '2', '1530784944', '0');
INSERT INTO `cart` VALUES ('90', '32', '3', '1', '1530785123', '0');
INSERT INTO `cart` VALUES ('91', '32', '5', '1', '1530785449', '0');
INSERT INTO `cart` VALUES ('92', '18', '17', '1', '1530787315', '0');
INSERT INTO `cart` VALUES ('93', '18', '17', '1', '1530787822', '0');
INSERT INTO `cart` VALUES ('94', '18', '16', '1', '1530788258', '0');
INSERT INTO `cart` VALUES ('95', '18', '17', '1', '1530788277', '0');
INSERT INTO `cart` VALUES ('96', '32', '17', '1', '1530788345', '0');
INSERT INTO `cart` VALUES ('97', '18', '17', '1', '1530795678', '0');
INSERT INTO `cart` VALUES ('98', '32', '17', '1', '1530797472', '0');
INSERT INTO `cart` VALUES ('99', '32', '16', '1', '1530839711', '0');
INSERT INTO `cart` VALUES ('100', '32', '15', '1', '1530842385', '0');
INSERT INTO `cart` VALUES ('101', '32', '15', '1', '1530842432', '0');
INSERT INTO `cart` VALUES ('102', '32', '15', '1', '1530843504', '0');
INSERT INTO `cart` VALUES ('103', '32', '15', '1', '1530843868', '0');
INSERT INTO `cart` VALUES ('104', '32', '15', '1', '1530844858', '0');
INSERT INTO `cart` VALUES ('105', '32', '15', '1', '1530845649', '0');
INSERT INTO `cart` VALUES ('106', '32', '15', '1', '1530845961', '0');
INSERT INTO `cart` VALUES ('107', '32', '15', '1', '1530845983', '0');
INSERT INTO `cart` VALUES ('108', '31', '15', '1', '1530845993', '0');
INSERT INTO `cart` VALUES ('109', '32', '15', '1', '1530846279', '0');
INSERT INTO `cart` VALUES ('110', '32', '15', '1', '1530847735', '0');
INSERT INTO `cart` VALUES ('111', '34', '16', '1', '1530848397', '0');
INSERT INTO `cart` VALUES ('112', '32', '15', '1', '1530848727', '0');
INSERT INTO `cart` VALUES ('113', '32', '15', '1', '1530849132', '0');
INSERT INTO `cart` VALUES ('114', '36', '9', '1', '1530857105', '0');
INSERT INTO `cart` VALUES ('115', '32', '15', '2', '1530857769', '0');
INSERT INTO `cart` VALUES ('116', '32', '15', '1', '1530858311', '0');
INSERT INTO `cart` VALUES ('117', '32', '15', '1', '1530858420', '0');
INSERT INTO `cart` VALUES ('118', '32', '15', '1', '1530858477', '0');
INSERT INTO `cart` VALUES ('119', '32', '15', '1', '1530859165', '0');
INSERT INTO `cart` VALUES ('120', '32', '15', '1', '1530859229', '0');
INSERT INTO `cart` VALUES ('121', '32', '15', '1', '1530859450', '0');
INSERT INTO `cart` VALUES ('122', '43', '15', '1', '1530860778', '0');
INSERT INTO `cart` VALUES ('123', '43', '15', '1', '1530866220', '0');
INSERT INTO `cart` VALUES ('124', '43', '15', '1', '1530872948', '0');
INSERT INTO `cart` VALUES ('125', '15', '16', '2', '1531101558', '1');
INSERT INTO `cart` VALUES ('126', '17', '16', '1', '1531101612', '0');
INSERT INTO `cart` VALUES ('127', '17', '15', '1', '1531101766', '0');
INSERT INTO `cart` VALUES ('128', '32', '16', '1', '1531102733', '0');
INSERT INTO `cart` VALUES ('129', '15', '17', '1', '1531102750', '1');
INSERT INTO `cart` VALUES ('130', '43', '15', '1', '1531105509', '0');
INSERT INTO `cart` VALUES ('131', '43', '15', '1', '1531106825', '0');
INSERT INTO `cart` VALUES ('132', '17', '18', '1', '1531118823', '0');
INSERT INTO `cart` VALUES ('133', '17', '17', '1', '1531128307', '0');
INSERT INTO `cart` VALUES ('134', '17', '15', '1', '1531128574', '0');
INSERT INTO `cart` VALUES ('135', '17', '15', '1', '1531128902', '0');
INSERT INTO `cart` VALUES ('136', '32', '16', '2', '1531131659', '1');
INSERT INTO `cart` VALUES ('137', '17', '15', '1', '1531186428', '0');
INSERT INTO `cart` VALUES ('138', '32', '17', '1', '1531189664', '1');
INSERT INTO `cart` VALUES ('139', '16', '16', '1', '1534818282', '1');
INSERT INTO `cart` VALUES ('140', '16', '15', '5', '1534818291', '1');
INSERT INTO `category` VALUES ('1', '0', '数码电器', '/Uploads/Tmps/2018/07/04/5b3c6f8ecaa5c.jpg', '0', '1', '1529978253');
INSERT INTO `category` VALUES ('12', '3', '清洁洗护', '.', null, '1', '1529978253');
INSERT INTO `category` VALUES ('13', '4', '手表配饰', '.', null, '1', '1529978253');
INSERT INTO `category` VALUES ('14', '4', '汽车用品', '.', null, '1', '1529978253');
INSERT INTO `category` VALUES ('15', '4', '箱包皮具', '.', null, '1', '1529978253');
INSERT INTO `category` VALUES ('2', '0', '家居日化', '/Uploads/Tmps/2018/07/04/5b3c6f8156306.jpg', '介绍', '1', '1529978253');
INSERT INTO `category` VALUES ('16', '5', '益智玩具', '。', null, '1', '1529978253');
INSERT INTO `category` VALUES ('3', '0', 'ccc', '/Uploads/Tmps/2018/07/04/5b3c5ad0b54b6.jpg', '玩具', '0', '1529981606');
INSERT INTO `category` VALUES ('4', '0', '精选饰品', '/Uploads/Tmps/2018/07/04/5b3c3e98d959a.jpg', '玩具', '0', '1530002823');
INSERT INTO `category` VALUES ('5', '0', '其他分类', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1529988321246&di=c633452d844dcb84f1f323e2fe1e5e5b&imgtype=0&src=http%3A%2F%2Fdesk.fd.zol-img.com.cn%2Ft_s960x600c5%2Fg5%2FM00%2F06%2F09%2FChMkJ1ZXx5-IBG7VAAUOsLjGwGYAAFZlgFLtugABQ7I950.jpg', 'cc', '1', '1530007768');
INSERT INTO `category` VALUES ('11', '3', '彩妆面膜', '.', null, '1', '1529978253');
INSERT INTO `category` VALUES ('6', '1', '数码科技', '/Uploads/Tmps/2018/06/26/5b3210d80294b.jpg', null, '1', '1530061930');
INSERT INTO `category` VALUES ('7', '2', '床用家纺', '/Uploads/Tmps/2018/06/26/5b3210d80294b.jpg', null, '1', '1500061620');
INSERT INTO `category` VALUES ('8', '2', '厨房用品', '/Uploads/Tmps/2018/06/26/5b3210d80294b.jpg', null, '1', '1529978253');
INSERT INTO `category` VALUES ('9', '2', '家用电器', '/Uploads/Tmps/2018/06/26/5b3210d80294b.jpg', null, '1', '1529978253');
INSERT INTO `category` VALUES ('10', '2', '生活百货', '/Uploads/Tmps/2018/06/26/5b3210d80294b.jpg', null, '1', '1530002823');
INSERT INTO `category` VALUES ('23', '0', '42', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b430e4520851.png\"]', '45', '0', '1531121221');
INSERT INTO `category` VALUES ('24', '0', '测试', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b4310f8cdd6f.jpg\"]', '测试', '1', '1531121899');
INSERT INTO `category` VALUES ('22', '0', '321', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b430fb4934a4.jpg\"]', '3213', '0', '1531120465');
INSERT INTO `category` VALUES ('17', '1', '电脑', '/Uploads/Tmps/2018/07/04/5b3c70923a2c3.jpg', 'PC', '1', '1530687754');
INSERT INTO `category` VALUES ('18', '3', '生活家居', '/Uploads/Tmps/2018/07/04/5b3c71bc39983.jpg', '', '1', '1530687933');
INSERT INTO `category` VALUES ('19', '3', '1111', '/Uploads/Tmps/2018/07/04/5b3c76e4e7266.jpg', '', '1', '1530689258');
INSERT INTO `category` VALUES ('20', '2', '卫生用品', '/Uploads/Tmps/2018/07/09/5b42cd2ee11ee.jpg', '', '1', '1531104560');
INSERT INTO `category` VALUES ('21', '0', '152', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b43096e21d71.jpg\"]', '203', '1', '1531120214');
INSERT INTO `collection` VALUES ('1', '16', '15', '1', '1531125701', null, null, null);
INSERT INTO `collection` VALUES ('2', '16', '16', '1', '1531126365', null, null, null);
INSERT INTO `collection` VALUES ('3', '16', '17', '1', '1531126628', null, null, null);
INSERT INTO `collection` VALUES ('4', '43', '17', '1', '1531277289', '', '', '0.00');
INSERT INTO `collection` VALUES ('5', '43', '16', '1', '1531277644', '', '', '0.00');
INSERT INTO `commodity` VALUES ('1', '2', '空气净化器', '1', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b3490811ad1d.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b349083ce840.jpg\"]', '9', '1', '1', '1', '1.00', '0.00', '1', '1', '0', '0', '1529920230');
INSERT INTO `commodity` VALUES ('2', '1', '手表', '3', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b349052e36d8.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b349055ece80.jpg\"]', '13', '5', '6', '7', '8.00', '0.00', '1', '1', '0', '0', '1529996594');
INSERT INTO `commodity` VALUES ('3', '2', '床架', '22', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/04\\/5b3c2c1fa2171.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/04\\/5b3c2c28945f9.jpg\"]', '7', '2', '6', '7', '8.00', '0.00', '1', '1', '0', '0', '1529997641');
INSERT INTO `commodity` VALUES ('4', '1', '床垫', '3213', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348fe18c931.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348fe52cc19.jpg\"]', '7', '213', '213', '131', '3132.00', '0.00', '1', '1', '0', '0', '1530066172');
INSERT INTO `commodity` VALUES ('5', '1', '床单', '2', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348f9fce380.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348fa2d7bd1.jpg\"]', '7', '1', '2', '2', '2.00', '0.00', '1', '1', '0', '0', '1530066776');
INSERT INTO `commodity` VALUES ('6', '1', '杯子', '64', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348f6e2c804.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348f7159365.jpg\"]', '10', '11', '11', '6', '106.00', '0.00', null, null, '0', '0', '1530070056');
INSERT INTO `commodity` VALUES ('7', '1', '牙刷', '63', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348f26d01f2.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348f29ee25a.jpg\"]', '10', '6', '6', '6', '253.00', '0.00', null, null, '0', '0', '1530070083');
INSERT INTO `commodity` VALUES ('8', '1', '毛巾', '62', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348efb5cd84.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348ef771f31.jpg\"]', '10', '63', '63', '6', '78.00', '0.00', null, null, '0', '0', '1530070173');
INSERT INTO `commodity` VALUES ('9', '1', '饰品', '6', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348ec49ef30.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b348ec91be17.jpg\"]', '13', '5', '6', '6', '6.00', '0.00', null, null, '1', '0', '1530070208');
INSERT INTO `commodity` VALUES ('10', '1', 'A7M3', '2147483647', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/27\\/5b334f5be992f.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/06\\/27\\/5b334f5be992f.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/06\\/27\\/5b334f5be992f.jpg\"]', '[\"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2611468614,391729506&fm=27&gp=0.jpg\",\"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2611468614,391729506&fm=27&gp=0.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/06\\/27\\/5b32f4f9a73b9.jpg\"]', '6', '100', '2', '相机', '23000.00', '0.00', '0', null, '0', '0', '1530089492');
INSERT INTO `commodity` VALUES ('11', '1', 'XZ2', '2147483647', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/27\\/5b335057a1c3e.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/27\\/5b33505a47f46.jpg\"]', '6', '1199', '23', '手机', '5000.00', '0.00', null, '0', '0', '0', '1530089569');
INSERT INTO `commodity` VALUES ('12', '1', '菠萝', '2147483647', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/27\\/5b3350942c9de.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/27\\/5b3350969bd81.jpg\"]', '1', '121', '11', '水果', '20.00', '0.00', '0', '0', '0', '0', '1530089626');
INSERT INTO `commodity` VALUES ('13', '1', '3333', '2333', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b3457dbcbc90.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/06\\/28\\/5b3457df76dc4.jpg\"]', '6', '100', '12', 'cpu', '2500.00', '0.00', '1', null, '0', '0', '1530157028');
INSERT INTO `commodity` VALUES ('14', '2', '大大卷', '2222', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/04\\/5b3c3d9fc06b4.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/04\\/5b3c3da716c50.jpg\"]', '10', '200244', '22', '无', '288.00', '0.00', '1', '1', '0', '0', '1530262901');
INSERT INTO `commodity` VALUES ('15', '1', '测试商品1', '1', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db7c74de0b.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db7c74f7c4.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db7c7663b3.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db7d1bc4db.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db7d1c7caf.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db7d1d53bb.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db7d1e228a.jpg\"]', '4', '58', '0', '啦啦啦', '0.01', '0.00', '0', '1', '0', '1', '1530771462');
INSERT INTO `commodity` VALUES ('16', '2', '测试商品2', '2', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db8fca9b7b.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db8fc90fd6.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db8fcae319.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db906316ef.png\"]', '7', '-2', '1', '没有', '30.00', '0.00', '1', '1', '0', '1', '1530771729');
INSERT INTO `commodity` VALUES ('17', '2', '测试商品3', '2', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db8fca9b7b.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db8fc90fd6.jpg\",\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db8fcae319.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/05\\/5b3db906316ef.png\"]', '7', '-2', '1', '没有', '30.00', '0.00', '0', '1', '1', '1', '1530771742');
INSERT INTO `commodity` VALUES ('18', '1', '奥特曼', '110', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b42ceeb68772.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b42cef0eed48.jpg\"]', '6', '9', '0', '玩具', '1.00', '0.00', '0', '0', '0', '1', '1531105068');
INSERT INTO `commodity` VALUES ('19', '2', 'ceshi1', '11101', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b432afaf3264.jpg\"]', '[\"\\/Uploads\\/Tmps\\/2018\\/07\\/09\\/5b432afbe53f2.jpg\"]', '9', '10', '5', 'xxx', '10.00', '0.00', '0', '0', '0', '1', '1531128573');
INSERT INTO `coupon` VALUES ('1', '15', '13', '10', '1', '1', '1530001067', '1530001099', '1', '1', '0', '1530001067');
INSERT INTO `coupon` VALUES ('2', '15', '13', '24', '1', '1', '1530001067', '1530001099', '1', '1', '0', '1530001067');
INSERT INTO `coupon` VALUES ('3', '15', '13', '12', '1', '2', '1530001067', '1530001067', '1', '1', '0', '1530001067');
INSERT INTO `coupon` VALUES ('4', '16', '10', '618', '112', '1', '1529997641', '1529997641', '1529997641', '1529997641', '0', '1530251565');
INSERT INTO `coupon` VALUES ('5', '15', '13', '9', '1', '1', '1530001067', '1532999764', '1', '1', '0', '1530001067');
INSERT INTO `employee_system` VALUES ('2', 'root02', '224cf2b695a5e8ecaecfb9015161fa4b', 'admin', '0', '1', '1500865568');
INSERT INTO `lottery` VALUES ('1', '690975', '08,06,10,07,04,02,03,09,01,05', '2018-07-0414:47', '1', null);
INSERT INTO `lottery` VALUES ('2', '690974', '03,02,01,08,10,09,04,05,06,07', '2018-07-0414:42', '1', null);
INSERT INTO `lottery` VALUES ('3', '690973', '03,05,04,10,06,02,09,07,08,01', '2018-07-0414:37', '1', null);
INSERT INTO `lottery` VALUES ('4', '690972', '08,09,02,03,06,10,07,01,04,05', '2018-07-0414:32', '1', null);
INSERT INTO `lottery` VALUES ('5', '690971', '05,04,01,10,08,09,07,02,03,06', '2018-07-0414:27', '1', null);
INSERT INTO `lottery` VALUES ('6', '690970', '05,10,07,01,02,04,08,06,09,03', '2018-07-0414:22', '1', null);
INSERT INTO `lottery` VALUES ('7', '690969', '04,10,06,01,03,08,02,05,09,07', '2018-07-0414:17', '1', null);
INSERT INTO `lottery` VALUES ('8', '690968', '09,08,07,03,06,04,05,02,10,01', '2018-07-0414:12', '1', null);
INSERT INTO `lottery` VALUES ('9', '690967', '01,05,07,02,03,10,04,06,08,09', '2018-07-0414:07', '1', null);
INSERT INTO `lottery` VALUES ('10', '690966', '04,03,09,10,08,06,05,02,07,01', '2018-07-0414:02', '1', null);
INSERT INTO `lottery` VALUES ('11', '690965', '09,04,08,07,03,05,01,10,02,06', '2018-07-0413:57', '1', null);
INSERT INTO `lottery` VALUES ('12', '690964', '02,07,10,08,01,04,05,06,09,03', '2018-07-0413:52', '1', null);
INSERT INTO `lottery` VALUES ('13', '690963', '07,03,01,04,09,06,08,02,10,05', '2018-07-0413:47', '1', null);
INSERT INTO `lottery` VALUES ('14', '690962', '01,06,02,03,07,10,08,05,04,09', '2018-07-0413:42', '1', null);
INSERT INTO `lottery` VALUES ('15', '690961', '08,07,04,09,06,03,05,01,10,02', '2018-07-0413:37', '1', null);
INSERT INTO `lottery` VALUES ('16', '690960', '09,07,02,10,04,06,01,05,03,08', '2018-07-0413:32', '1', null);
INSERT INTO `lottery` VALUES ('17', '690959', '07,05,04,08,06,02,03,10,01,09', '2018-07-0413:27', '1', null);
INSERT INTO `lottery` VALUES ('18', '690958', '03,10,05,02,06,07,08,09,04,01', '2018-07-0413:22', '1', null);
INSERT INTO `lottery` VALUES ('19', '690957', '01,02,08,10,05,09,04,03,07,06', '2018-07-0413:17', '1', null);
INSERT INTO `lottery` VALUES ('20', '690956', '05,01,10,07,02,08,03,06,04,09', '2018-07-0413:12', '1', null);
INSERT INTO `lottery` VALUES ('21', '690955', '03,02,06,05,09,04,01,08,10,07', '2018-07-0413:07', '1', null);
INSERT INTO `lottery` VALUES ('22', '690954', '02,05,08,03,09,07,06,04,10,01', '2018-07-0413:02', '1', null);
INSERT INTO `lottery` VALUES ('23', '690953', '06,10,08,01,04,03,05,09,02,07', '2018-07-0412:57', '1', null);
INSERT INTO `lottery` VALUES ('24', '690952', '05,02,04,06,07,10,09,01,08,03', '2018-07-0412:52', '1', null);
INSERT INTO `lottery` VALUES ('25', '690951', '05,02,03,09,06,07,01,10,04,08', '2018-07-0412:47', '1', null);
INSERT INTO `lottery` VALUES ('26', '690950', '09,02,04,01,07,03,05,10,08,06', '2018-07-0412:42', '1', null);
INSERT INTO `lottery` VALUES ('27', '690949', '04,08,09,03,05,07,01,02,10,06', '2018-07-0412:37', '1', null);
INSERT INTO `lottery` VALUES ('28', '690948', '09,04,08,01,06,10,02,05,07,03', '2018-07-0412:32', '1', null);
INSERT INTO `lottery` VALUES ('29', '690947', '10,09,05,04,07,08,06,03,01,02', '2018-07-0412:27', '1', null);
INSERT INTO `lottery` VALUES ('30', '690946', '10,04,02,03,07,05,08,09,01,06', '2018-07-0412:22', '1', null);
INSERT INTO `lottery` VALUES ('31', '690977', '04,05,09,08,06,10,03,02,01,07', '2018-07-0414:57', '1', null);
INSERT INTO `lottery` VALUES ('32', '690976', '07,03,04,05,02,09,01,08,10,06', '2018-07-0414:52', '1', null);
INSERT INTO `lottery` VALUES ('33', '690980', '02,05,09,08,06,10,01,03,04,07', '2018-07-0415:12', '1', null);
INSERT INTO `lottery` VALUES ('34', '690979', '03,05,06,02,09,04,10,07,01,08', '2018-07-0415:07', '1', null);
INSERT INTO `lottery` VALUES ('35', '690978', '09,08,03,04,10,01,06,05,02,07', '2018-07-0415:02', '1', null);
INSERT INTO `lottery` VALUES ('36', '690983', '08,10,02,01,06,04,05,03,07,09', '2018-07-0415:27', '1', null);
INSERT INTO `lottery` VALUES ('37', '690982', '07,08,01,02,03,05,09,06,10,04', '2018-07-0415:22', '1', null);
INSERT INTO `lottery` VALUES ('38', '690981', '05,02,10,03,04,06,08,01,09,07', '2018-07-0415:17', '1', null);
INSERT INTO `lottery` VALUES ('39', '690984', '09,06,01,05,04,07,03,10,08,02', '2018-07-0415:32', '1', null);
INSERT INTO `lottery` VALUES ('40', '690992', '02,04,06,08,05,01,07,10,09,03', '2018-07-0416:12', '1', null);
INSERT INTO `lottery` VALUES ('41', '690991', '03,09,04,10,02,06,08,01,07,05', '2018-07-0416:07', '1', null);
INSERT INTO `lottery` VALUES ('42', '690990', '02,04,05,09,07,03,10,01,08,06', '2018-07-0416:02', '1', null);
INSERT INTO `lottery` VALUES ('43', '690989', '03,04,06,05,08,02,07,01,09,10', '2018-07-0415:57', '1', null);
INSERT INTO `lottery` VALUES ('44', '690988', '01,04,08,03,06,05,10,07,02,09', '2018-07-0415:52', '1', null);
INSERT INTO `lottery` VALUES ('45', '690987', '02,07,08,09,10,04,03,05,01,06', '2018-07-0415:47', '1', null);
INSERT INTO `lottery` VALUES ('46', '690986', '10,02,06,09,08,04,03,01,07,05', '2018-07-0415:42', '1', null);
INSERT INTO `lottery` VALUES ('47', '690985', '01,09,05,08,07,03,04,06,02,10', '2018-07-0415:37', '1', null);
INSERT INTO `lottery` VALUES ('48', '691001', '03,02,06,05,07,08,09,01,10,04', '2018-07-0416:57', '1', null);
INSERT INTO `lottery` VALUES ('49', '691000', '09,04,07,05,03,08,06,10,02,01', '2018-07-0416:52', '1', null);
INSERT INTO `lottery` VALUES ('50', '690999', '09,08,07,05,06,10,04,03,02,01', '2018-07-0416:47', '1', null);
INSERT INTO `lottery` VALUES ('51', '690998', '04,01,03,08,07,06,05,09,02,10', '2018-07-0416:42', '1', null);
INSERT INTO `lottery` VALUES ('52', '690997', '01,05,09,10,07,04,02,08,06,03', '2018-07-0416:37', '1', null);
INSERT INTO `lottery` VALUES ('53', '690996', '06,05,02,09,08,04,01,07,10,03', '2018-07-0416:32', '1', null);
INSERT INTO `lottery` VALUES ('54', '690995', '09,05,03,10,06,07,01,02,04,08', '2018-07-0416:27', '1', null);
INSERT INTO `lottery` VALUES ('55', '690994', '07,10,04,06,09,03,02,05,08,01', '2018-07-0416:22', '1', null);
INSERT INTO `lottery` VALUES ('56', '690993', '01,06,02,04,07,05,08,10,09,03', '2018-07-0416:17', '1', null);
INSERT INTO `lottery` VALUES ('59', '691006', '04,05,09,10,08,02,03,06,07,01', '2018-07-0417:22', '1', null);
INSERT INTO `lottery` VALUES ('60', '691005', '07,05,02,03,08,04,01,06,09,10', '2018-07-0417:17', '1', null);
INSERT INTO `lottery` VALUES ('61', '691004', '04,02,05,03,09,01,07,10,08,06', '2018-07-0417:12', '1', null);
INSERT INTO `lottery` VALUES ('63', '691002', '01,04,07,06,09,03,05,02,08,10', '2018-07-0417:02', '1', null);
INSERT INTO `lottery` VALUES ('65', '691003', '04,05,06,08,10,02,09,03,07,01', '2018-07-0417:07', '1', null);
INSERT INTO `lottery` VALUES ('77', '691009', '04,02,07,06,01,09,10,05,08,03', '2018-07-0417:37', '1', null);
INSERT INTO `lottery` VALUES ('78', '691008', '03,04,08,06,01,07,09,05,10,02', '2018-07-0417:32', '1', null);
INSERT INTO `lottery` VALUES ('79', '691007', '05,01,02,08,06,09,10,07,03,04', '2018-07-0417:27', '1', null);
INSERT INTO `lottery` VALUES ('80', '691280', '05,07,03,10,04,01,08,02,09,06', '2018-07-0610:22', '1', null);
INSERT INTO `lottery` VALUES ('81', '691279', '07,05,10,04,01,02,09,08,03,06', '2018-07-0610:17', '1', null);
INSERT INTO `lottery` VALUES ('82', '691278', '09,06,02,10,05,04,08,07,01,03', '2018-07-0610:12', '1', null);
INSERT INTO `lottery` VALUES ('83', '691277', '05,04,01,07,06,03,02,08,10,09', '2018-07-0610:07', '1', null);
INSERT INTO `lottery` VALUES ('84', '691276', '06,10,09,07,04,05,02,03,08,01', '2018-07-0610:02', '1', null);
INSERT INTO `lottery` VALUES ('85', '691275', '07,03,02,04,01,06,09,05,10,08', '2018-07-0609:57', '1', null);
INSERT INTO `lottery` VALUES ('86', '691274', '03,09,05,02,04,10,01,07,06,08', '2018-07-0609:52', '1', null);
INSERT INTO `lottery` VALUES ('87', '691273', '05,06,04,10,01,09,08,02,03,07', '2018-07-0609:47', '1', null);
INSERT INTO `lottery` VALUES ('88', '691272', '01,03,04,09,10,02,05,06,08,07', '2018-07-0609:42', '1', null);
INSERT INTO `lottery` VALUES ('89', '691271', '09,01,04,07,06,05,03,10,08,02', '2018-07-0609:37', '1', null);
INSERT INTO `lottery` VALUES ('90', '691270', '03,04,07,01,02,09,10,06,08,05', '2018-07-0609:32', '1', null);
INSERT INTO `lottery` VALUES ('91', '691269', '06,05,09,02,01,04,03,08,07,10', '2018-07-0609:27', '1', null);
INSERT INTO `lottery` VALUES ('92', '691268', '01,04,03,02,05,06,08,09,10,07', '2018-07-0609:22', '1', null);
INSERT INTO `lottery` VALUES ('93', '691267', '04,10,09,03,08,07,01,02,05,06', '2018-07-0609:17', '1', null);
INSERT INTO `lottery` VALUES ('94', '691266', '02,04,03,06,08,01,05,09,07,10', '2018-07-0609:12', '1', null);
INSERT INTO `lottery` VALUES ('95', '691265', '06,05,04,01,02,08,10,03,07,09', '2018-07-0609:07', '1', null);
INSERT INTO `lottery` VALUES ('96', '691264', '08,04,02,03,01,05,06,10,07,09', '2018-07-0523:57', '1', null);
INSERT INTO `lottery` VALUES ('97', '691263', '05,10,02,06,04,07,03,08,09,01', '2018-07-0523:52', '1', null);
INSERT INTO `lottery` VALUES ('98', '691262', '07,09,08,10,03,02,06,01,04,05', '2018-07-0523:47', '1', null);
INSERT INTO `lottery` VALUES ('99', '691261', '08,02,01,07,06,10,04,09,05,03', '2018-07-0523:42', '1', null);
INSERT INTO `lottery` VALUES ('100', '691260', '09,05,04,01,03,07,08,02,10,06', '2018-07-0523:37', '1', null);
INSERT INTO `lottery` VALUES ('101', '691259', '05,04,07,10,02,09,01,06,03,08', '2018-07-0523:32', '1', null);
INSERT INTO `lottery` VALUES ('102', '691258', '07,05,03,08,06,10,01,02,09,04', '2018-07-0523:27', '1', null);
INSERT INTO `lottery` VALUES ('103', '691257', '03,04,06,01,10,09,08,07,05,02', '2018-07-0523:22', '1', null);
INSERT INTO `lottery` VALUES ('104', '691256', '02,04,10,05,08,07,01,06,09,03', '2018-07-0523:17', '1', null);
INSERT INTO `lottery` VALUES ('105', '691255', '02,07,06,09,10,01,08,04,05,03', '2018-07-0523:12', '1', null);
INSERT INTO `lottery` VALUES ('106', '691254', '08,03,09,02,07,01,04,05,10,06', '2018-07-0523:07', '1', null);
INSERT INTO `lottery` VALUES ('107', '691253', '09,05,06,07,04,08,02,03,01,10', '2018-07-0523:02', '1', null);
INSERT INTO `lottery` VALUES ('108', '691252', '10,09,04,03,02,01,08,07,06,05', '2018-07-0522:57', '1', null);
INSERT INTO `lottery` VALUES ('109', '691251', '09,02,07,01,06,10,05,03,04,08', '2018-07-0522:52', '1', null);
INSERT INTO `lottery` VALUES ('110', '691829', '03,08,09,05,10,04,01,06,07,02', '2018-07-0911:22', '1', null);
INSERT INTO `lottery` VALUES ('111', '691828', '10,08,01,03,05,06,02,07,04,09', '2018-07-0911:17', '1', null);
INSERT INTO `lottery` VALUES ('112', '691827', '09,02,08,03,01,06,10,05,04,07', '2018-07-0911:12', '1', null);
INSERT INTO `lottery` VALUES ('113', '691826', '04,03,08,06,01,09,07,05,10,02', '2018-07-0911:07', '1', null);
INSERT INTO `lottery` VALUES ('114', '691825', '02,03,01,09,04,05,06,07,10,08', '2018-07-0911:02', '1', null);
INSERT INTO `lottery` VALUES ('115', '691824', '01,10,03,09,04,08,06,05,02,07', '2018-07-0910:57', '1', null);
INSERT INTO `lottery` VALUES ('116', '691823', '06,07,02,05,01,04,03,09,10,08', '2018-07-0910:52', '1', null);
INSERT INTO `lottery` VALUES ('117', '691822', '04,10,07,03,02,08,01,05,09,06', '2018-07-0910:47', '1', null);
INSERT INTO `lottery` VALUES ('118', '691821', '07,05,10,08,02,09,06,01,03,04', '2018-07-0910:42', '1', null);
INSERT INTO `lottery` VALUES ('119', '691820', '10,07,08,05,03,01,06,02,09,04', '2018-07-0910:37', '1', null);
INSERT INTO `lottery` VALUES ('120', '691819', '10,02,07,05,06,09,03,04,01,08', '2018-07-0910:32', '1', null);
INSERT INTO `lottery` VALUES ('121', '691818', '01,10,06,07,04,02,09,08,05,03', '2018-07-0910:27', '1', null);
INSERT INTO `lottery` VALUES ('122', '691817', '04,05,09,03,01,08,02,10,07,06', '2018-07-0910:22', '1', null);
INSERT INTO `lottery` VALUES ('123', '691816', '04,10,09,06,08,05,03,01,02,07', '2018-07-0910:17', '1', null);
INSERT INTO `lottery` VALUES ('124', '691815', '09,06,05,02,04,03,10,08,01,07', '2018-07-0910:12', '1', null);
INSERT INTO `lottery` VALUES ('125', '691814', '09,06,05,07,02,04,03,01,08,10', '2018-07-0910:07', '1', null);
INSERT INTO `lottery` VALUES ('126', '691813', '10,03,08,01,09,02,04,07,05,06', '2018-07-0910:02', '1', null);
INSERT INTO `lottery` VALUES ('127', '691812', '03,10,04,05,08,09,07,06,02,01', '2018-07-0909:57', '1', null);
INSERT INTO `lottery` VALUES ('128', '691811', '05,07,03,06,08,09,10,01,02,04', '2018-07-0909:52', '1', null);
INSERT INTO `lottery` VALUES ('129', '691810', '07,01,06,09,05,04,02,03,10,08', '2018-07-0909:47', '1', null);
INSERT INTO `lottery` VALUES ('130', '691809', '02,06,07,10,05,09,01,03,04,08', '2018-07-0909:42', '1', null);
INSERT INTO `lottery` VALUES ('131', '691808', '06,03,04,08,02,09,05,07,10,01', '2018-07-0909:37', '1', null);
INSERT INTO `lottery` VALUES ('132', '691807', '08,03,02,01,04,10,09,05,06,07', '2018-07-0909:32', '1', null);
INSERT INTO `lottery` VALUES ('133', '691806', '10,07,04,01,02,03,05,06,09,08', '2018-07-0909:27', '1', null);
INSERT INTO `lottery` VALUES ('134', '691805', '09,05,10,07,04,06,01,08,02,03', '2018-07-0909:22', '1', null);
INSERT INTO `lottery` VALUES ('135', '691804', '08,05,07,10,03,09,04,01,02,06', '2018-07-0909:17', '1', null);
INSERT INTO `lottery` VALUES ('136', '691803', '05,03,01,09,08,07,04,06,10,02', '2018-07-0909:12', '1', null);
INSERT INTO `lottery` VALUES ('137', '691802', '05,08,07,03,09,01,02,04,10,06', '2018-07-0909:07', '1', null);
INSERT INTO `lottery` VALUES ('138', '691801', '08,03,09,07,05,04,10,06,02,01', '2018-07-0823:57', '1', null);
INSERT INTO `lottery` VALUES ('139', '691800', '08,04,09,07,02,05,01,03,10,06', '2018-07-0823:52', '1', null);
INSERT INTO `lottery` VALUES ('140', '691835', '10,08,05,02,01,03,09,06,07,04', '2018-07-0911:52', '1', null);
INSERT INTO `lottery` VALUES ('141', '691834', '06,04,01,02,03,10,08,07,09,05', '2018-07-0911:47', '1', null);
INSERT INTO `lottery` VALUES ('142', '691833', '06,07,04,10,09,08,05,03,02,01', '2018-07-0911:42', '1', null);
INSERT INTO `lottery` VALUES ('143', '691832', '07,01,03,05,10,06,02,04,09,08', '2018-07-0911:37', '1', null);
INSERT INTO `lottery` VALUES ('144', '691831', '01,07,05,03,09,04,08,10,06,02', '2018-07-0911:32', '1', null);
INSERT INTO `lottery` VALUES ('145', '691830', '01,06,04,03,10,08,05,09,07,02', '2018-07-0911:27', '1', null);
INSERT INTO `lottery` VALUES ('146', '691901', '03,07,01,09,02,05,08,06,10,04', '2018-07-0917:22', '1', null);
INSERT INTO `lottery` VALUES ('147', '691900', '10,05,08,09,06,04,03,01,07,02', '2018-07-0917:17', '1', null);
INSERT INTO `lottery` VALUES ('148', '691899', '05,04,08,07,10,09,06,01,02,03', '2018-07-0917:12', '1', null);
INSERT INTO `lottery` VALUES ('149', '691898', '07,05,09,02,03,10,08,06,04,01', '2018-07-0917:07', '1', null);
INSERT INTO `lottery` VALUES ('150', '691897', '02,03,01,10,06,04,09,05,08,07', '2018-07-0917:02', '1', null);
INSERT INTO `lottery` VALUES ('151', '691896', '08,10,04,03,09,06,01,05,07,02', '2018-07-0916:57', '1', null);
INSERT INTO `lottery` VALUES ('152', '691895', '04,08,02,07,03,01,06,09,10,05', '2018-07-0916:52', '1', null);
INSERT INTO `lottery` VALUES ('153', '691894', '08,09,03,04,02,05,01,06,10,07', '2018-07-0916:47', '1', null);
INSERT INTO `lottery` VALUES ('154', '691893', '02,03,09,10,07,06,08,05,01,04', '2018-07-0916:42', '1', null);
INSERT INTO `lottery` VALUES ('155', '691892', '03,05,10,08,01,02,07,09,06,04', '2018-07-0916:37', '1', null);
INSERT INTO `lottery` VALUES ('156', '691891', '06,05,03,09,10,07,08,01,02,04', '2018-07-0916:32', '1', null);
INSERT INTO `lottery` VALUES ('157', '691890', '06,10,03,09,07,05,02,04,08,01', '2018-07-0916:27', '1', null);
INSERT INTO `lottery` VALUES ('158', '691889', '07,02,05,04,10,01,08,06,03,09', '2018-07-0916:22', '1', null);
INSERT INTO `lottery` VALUES ('159', '691888', '01,10,02,05,09,06,03,07,04,08', '2018-07-0916:17', '1', null);
INSERT INTO `lottery` VALUES ('160', '691887', '06,03,09,10,01,04,07,08,05,02', '2018-07-0916:12', '1', null);
INSERT INTO `lottery` VALUES ('161', '691886', '06,08,05,10,02,07,01,03,09,04', '2018-07-0916:07', '1', null);
INSERT INTO `lottery` VALUES ('162', '691885', '08,04,01,05,07,10,03,09,02,06', '2018-07-0916:02', '1', null);
INSERT INTO `lottery` VALUES ('163', '691884', '07,05,09,02,08,03,10,06,04,01', '2018-07-0915:57', '1', null);
INSERT INTO `lottery` VALUES ('164', '691883', '09,06,08,02,07,05,04,03,10,01', '2018-07-0915:52', '1', null);
INSERT INTO `lottery` VALUES ('165', '691882', '04,09,08,07,02,06,10,03,05,01', '2018-07-0915:47', '1', null);
INSERT INTO `lottery` VALUES ('166', '691881', '07,03,08,09,02,04,05,01,06,10', '2018-07-0915:42', '1', null);
INSERT INTO `lottery` VALUES ('167', '691880', '08,06,04,09,02,01,03,07,05,10', '2018-07-0915:37', '1', null);
INSERT INTO `lottery` VALUES ('168', '691879', '05,03,08,01,10,06,07,04,09,02', '2018-07-0915:32', '1', null);
INSERT INTO `lottery` VALUES ('169', '691878', '01,04,07,05,03,06,02,08,10,09', '2018-07-0915:27', '1', null);
INSERT INTO `lottery` VALUES ('170', '691877', '02,06,04,07,10,08,05,01,09,03', '2018-07-0915:22', '1', null);
INSERT INTO `lottery` VALUES ('171', '691876', '09,05,01,07,02,10,04,06,08,03', '2018-07-0915:17', '1', null);
INSERT INTO `lottery` VALUES ('172', '691875', '06,07,01,08,03,04,09,10,05,02', '2018-07-0915:12', '1', null);
INSERT INTO `lottery` VALUES ('173', '691874', '07,09,08,10,06,01,04,03,02,05', '2018-07-0915:07', '1', null);
INSERT INTO `lottery` VALUES ('174', '691873', '02,05,10,08,04,07,09,01,03,06', '2018-07-0915:02', '1', null);
INSERT INTO `lottery` VALUES ('175', '691872', '10,06,02,07,09,05,03,01,04,08', '2018-07-0914:57', '1', null);
INSERT INTO `lottery` VALUES ('176', '691868', '07,03,10,09,01,08,06,05,02,04', '2018-07-0914:37', '1', null);
INSERT INTO `lottery` VALUES ('177', '691867', '05,06,08,07,03,02,04,09,01,10', '2018-07-0914:32', '1', null);
INSERT INTO `lottery` VALUES ('178', '691866', '05,06,07,10,04,03,08,02,01,09', '2018-07-0914:27', '1', null);
INSERT INTO `lottery` VALUES ('179', '691865', '09,06,02,10,03,04,08,07,05,01', '2018-07-0914:22', '1', null);
INSERT INTO `lottery` VALUES ('180', '691864', '04,01,03,02,09,10,05,07,08,06', '2018-07-0914:17', '1', null);
INSERT INTO `lottery` VALUES ('181', '691863', '01,09,02,08,06,07,05,10,04,03', '2018-07-0914:12', '1', null);
INSERT INTO `lottery` VALUES ('182', '691862', '01,10,05,07,03,06,08,02,04,09', '2018-07-0914:07', '1', null);
INSERT INTO `lottery` VALUES ('183', '691861', '09,02,03,07,10,01,04,05,06,08', '2018-07-0914:02', '1', null);
INSERT INTO `lottery` VALUES ('184', '691860', '08,06,09,01,07,03,02,04,10,05', '2018-07-0913:57', '1', null);
INSERT INTO `lottery` VALUES ('185', '691859', '10,09,07,05,08,06,03,01,04,02', '2018-07-0913:52', '1', null);
INSERT INTO `lottery` VALUES ('186', '691858', '04,06,05,02,03,10,01,07,09,08', '2018-07-0913:47', '1', null);
INSERT INTO `lottery` VALUES ('187', '691857', '08,07,06,02,03,04,10,01,09,05', '2018-07-0913:42', '1', null);
INSERT INTO `lottery` VALUES ('188', '691856', '07,03,06,10,08,09,02,01,05,04', '2018-07-0913:37', '1', null);
INSERT INTO `lottery` VALUES ('189', '691855', '04,06,02,01,07,05,03,08,10,09', '2018-07-0913:32', '1', null);
INSERT INTO `lottery` VALUES ('190', '691854', '10,06,05,09,04,01,07,03,08,02', '2018-07-0913:27', '1', null);
INSERT INTO `lottery` VALUES ('191', '691853', '10,08,09,05,06,01,03,04,07,02', '2018-07-0913:22', '1', null);
INSERT INTO `lottery` VALUES ('192', '691852', '06,08,10,01,03,07,05,04,09,02', '2018-07-0913:17', '1', null);
INSERT INTO `lottery` VALUES ('193', '691851', '01,02,05,06,04,08,03,09,10,07', '2018-07-0913:12', '1', null);
INSERT INTO `lottery` VALUES ('194', '691850', '09,07,01,08,02,10,03,04,06,05', '2018-07-0913:07', '1', null);
INSERT INTO `lottery` VALUES ('195', '691849', '06,07,09,04,10,03,01,08,05,02', '2018-07-0913:02', '1', null);
INSERT INTO `lottery` VALUES ('196', '691848', '10,03,07,02,06,04,01,05,09,08', '2018-07-0912:57', '1', null);
INSERT INTO `lottery` VALUES ('197', '691847', '03,04,07,10,05,01,02,09,08,06', '2018-07-0912:52', '1', null);
INSERT INTO `lottery` VALUES ('198', '691846', '09,04,08,07,10,02,01,05,03,06', '2018-07-0912:47', '1', null);
INSERT INTO `lottery` VALUES ('199', '691845', '02,01,09,05,10,03,07,06,04,08', '2018-07-0912:42', '1', null);
INSERT INTO `lottery` VALUES ('200', '691844', '07,04,10,06,05,01,02,09,08,03', '2018-07-0912:37', '1', null);
INSERT INTO `lottery` VALUES ('201', '691843', '02,10,05,09,07,04,06,03,08,01', '2018-07-0912:32', '1', null);
INSERT INTO `lottery` VALUES ('202', '691842', '04,02,03,08,09,06,07,01,05,10', '2018-07-0912:27', '1', null);
INSERT INTO `lottery` VALUES ('203', '691841', '10,03,08,01,02,05,07,09,04,06', '2018-07-0912:22', '1', null);
INSERT INTO `lottery` VALUES ('204', '691840', '03,04,06,05,02,10,07,08,09,01', '2018-07-0912:17', '1', null);
INSERT INTO `lottery` VALUES ('205', '691839', '08,07,05,01,06,04,03,10,02,09', '2018-07-0912:12', '1', null);
INSERT INTO `lottery` VALUES ('206', '691909', '08,06,10,04,03,01,05,09,02,07', '2018-07-0918:02', '1', null);
INSERT INTO `lottery` VALUES ('207', '691908', '04,08,09,05,02,07,03,10,06,01', '2018-07-0917:57', '1', null);
INSERT INTO `lottery` VALUES ('208', '691907', '03,10,02,04,07,06,01,08,05,09', '2018-07-0917:52', '1', null);
INSERT INTO `lottery` VALUES ('209', '691906', '10,06,09,07,08,03,04,05,02,01', '2018-07-0917:47', '1', null);
INSERT INTO `lottery` VALUES ('210', '691905', '07,08,02,03,10,04,05,06,09,01', '2018-07-0917:42', '1', null);
INSERT INTO `lottery` VALUES ('211', '691904', '02,09,07,03,06,05,01,04,10,08', '2018-07-0917:37', '1', null);
INSERT INTO `lottery` VALUES ('212', '691903', '05,09,07,08,04,01,06,10,03,02', '2018-07-0917:32', '1', null);
INSERT INTO `lottery` VALUES ('213', '691902', '09,01,10,03,07,06,05,02,04,08', '2018-07-0917:27', '1', null);
INSERT INTO `notify_test` VALUES ('73', 'wxa7ec44c182bba215', 'appid');
INSERT INTO `notify_test` VALUES ('74', 'attach', 'attach');
INSERT INTO `notify_test` VALUES ('75', 'CFT', 'bank_type');
INSERT INTO `notify_test` VALUES ('76', '1', 'cash_fee');
INSERT INTO `notify_test` VALUES ('77', 'CNY', 'fee_type');
INSERT INTO `notify_test` VALUES ('78', 'N', 'is_subscribe');
INSERT INTO `notify_test` VALUES ('79', '1495735442', 'mch_id');
INSERT INTO `notify_test` VALUES ('80', '3nvhnik24rmaj03qxpxf1d2cxwqcumn5', 'nonce_str');
INSERT INTO `notify_test` VALUES ('81', 'o9JDS5A8idkjn3iMpkNyYPjlVNbU', 'openid');
INSERT INTO `notify_test` VALUES ('82', '56153084913748', 'out_trade_no');
INSERT INTO `notify_test` VALUES ('83', 'SUCCESS', 'result_code');
INSERT INTO `notify_test` VALUES ('84', 'SUCCESS', 'return_code');
INSERT INTO `notify_test` VALUES ('85', '6BD9479480FFA7D69E2ACC2BD8B5B991', 'sign');
INSERT INTO `notify_test` VALUES ('86', '20180706115226', 'time_end');
INSERT INTO `notify_test` VALUES ('87', '1', 'total_fee');
INSERT INTO `notify_test` VALUES ('88', 'JSAPI', 'trade_type');
INSERT INTO `notify_test` VALUES ('89', '4200000126201807066773119159', 'transaction_id');
INSERT INTO `notify_test` VALUES ('90', 'yes', '校验是否成功');
INSERT INTO `notify_test` VALUES ('91', 'wxa7ec44c182bba215', 'appid');
INSERT INTO `notify_test` VALUES ('92', 'attach', 'attach');
INSERT INTO `notify_test` VALUES ('93', 'CFT', 'bank_type');
INSERT INTO `notify_test` VALUES ('94', '2', 'cash_fee');
INSERT INTO `notify_test` VALUES ('95', 'CNY', 'fee_type');
INSERT INTO `notify_test` VALUES ('96', 'N', 'is_subscribe');
INSERT INTO `notify_test` VALUES ('97', '1495735442', 'mch_id');
INSERT INTO `notify_test` VALUES ('98', 'un9p7kiipx80og8gbi6hxdtm494iymlj', 'nonce_str');
INSERT INTO `notify_test` VALUES ('99', 'o9JDS5A8idkjn3iMpkNyYPjlVNbU', 'openid');
INSERT INTO `notify_test` VALUES ('100', '12153085777583', 'out_trade_no');
INSERT INTO `notify_test` VALUES ('101', 'SUCCESS', 'result_code');
INSERT INTO `notify_test` VALUES ('102', 'SUCCESS', 'return_code');
INSERT INTO `notify_test` VALUES ('103', 'BB73254F8B3F20DF9FE1760DCFAFE37E', 'sign');
INSERT INTO `notify_test` VALUES ('104', '20180706141626', 'time_end');
INSERT INTO `notify_test` VALUES ('105', '2', 'total_fee');
INSERT INTO `notify_test` VALUES ('106', 'JSAPI', 'trade_type');
INSERT INTO `notify_test` VALUES ('107', '4200000113201807068381287465', 'transaction_id');
INSERT INTO `notify_test` VALUES ('108', 'yes', '校验是否成功');
INSERT INTO `notify_test` VALUES ('109', 'wxa7ec44c182bba215', 'appid');
INSERT INTO `notify_test` VALUES ('110', 'attach', 'attach');
INSERT INTO `notify_test` VALUES ('111', 'CFT', 'bank_type');
INSERT INTO `notify_test` VALUES ('112', '1', 'cash_fee');
INSERT INTO `notify_test` VALUES ('113', 'CNY', 'fee_type');
INSERT INTO `notify_test` VALUES ('114', 'N', 'is_subscribe');
INSERT INTO `notify_test` VALUES ('115', '1495735442', 'mch_id');
INSERT INTO `notify_test` VALUES ('116', 'sye0kjnur9pn8y8nxprobchgkiudtb4e', 'nonce_str');
INSERT INTO `notify_test` VALUES ('117', 'o9JDS5A8idkjn3iMpkNyYPjlVNbU', 'openid');
INSERT INTO `notify_test` VALUES ('118', '48153085917375', 'out_trade_no');
INSERT INTO `notify_test` VALUES ('119', 'SUCCESS', 'result_code');
INSERT INTO `notify_test` VALUES ('120', 'SUCCESS', 'return_code');
INSERT INTO `notify_test` VALUES ('121', '0FC5C6E77AA7806EC45E479892FE28B2', 'sign');
INSERT INTO `notify_test` VALUES ('122', '20180706143943', 'time_end');
INSERT INTO `notify_test` VALUES ('123', '1', 'total_fee');
INSERT INTO `notify_test` VALUES ('124', 'JSAPI', 'trade_type');
INSERT INTO `notify_test` VALUES ('125', '4200000116201807068544095506', 'transaction_id');
INSERT INTO `notify_test` VALUES ('126', 'yes', '校验是否成功');
INSERT INTO `notify_test` VALUES ('127', 'wxa7ec44c182bba215', 'appid');
INSERT INTO `notify_test` VALUES ('128', 'attach', 'attach');
INSERT INTO `notify_test` VALUES ('129', 'CFT', 'bank_type');
INSERT INTO `notify_test` VALUES ('130', '1', 'cash_fee');
INSERT INTO `notify_test` VALUES ('131', 'CNY', 'fee_type');
INSERT INTO `notify_test` VALUES ('132', 'N', 'is_subscribe');
INSERT INTO `notify_test` VALUES ('133', '1495735442', 'mch_id');
INSERT INTO `notify_test` VALUES ('134', 'ts5hgvjnh3bzfwh5w6av65x4srr9r00s', 'nonce_str');
INSERT INTO `notify_test` VALUES ('135', 'o9JDS5A8idkjn3iMpkNyYPjlVNbU', 'openid');
INSERT INTO `notify_test` VALUES ('136', '43153085923695', 'out_trade_no');
INSERT INTO `notify_test` VALUES ('137', 'SUCCESS', 'result_code');
INSERT INTO `notify_test` VALUES ('138', 'SUCCESS', 'return_code');
INSERT INTO `notify_test` VALUES ('139', 'F171DD95A44E7DE261EBA6F33E1E908A', 'sign');
INSERT INTO `notify_test` VALUES ('140', '20180706144045', 'time_end');
INSERT INTO `notify_test` VALUES ('141', '1', 'total_fee');
INSERT INTO `notify_test` VALUES ('142', 'JSAPI', 'trade_type');
INSERT INTO `notify_test` VALUES ('143', '4200000115201807063771825390', 'transaction_id');
INSERT INTO `notify_test` VALUES ('144', 'yes', '校验是否成功');
INSERT INTO `notify_test` VALUES ('145', 'wxa7ec44c182bba215', 'appid');
INSERT INTO `notify_test` VALUES ('146', 'attach', 'attach');
INSERT INTO `notify_test` VALUES ('147', 'CFT', 'bank_type');
INSERT INTO `notify_test` VALUES ('148', '1', 'cash_fee');
INSERT INTO `notify_test` VALUES ('149', 'CNY', 'fee_type');
INSERT INTO `notify_test` VALUES ('150', 'N', 'is_subscribe');
INSERT INTO `notify_test` VALUES ('151', '1495735442', 'mch_id');
INSERT INTO `notify_test` VALUES ('152', 'pk0n1xltqm36omveg4ggvur4e4oia1f0', 'nonce_str');
INSERT INTO `notify_test` VALUES ('153', 'o9JDS5Ofeh7HBdinrjTobbtw4VJU', 'openid');
INSERT INTO `notify_test` VALUES ('154', '43153110602779', 'out_trade_no');
INSERT INTO `notify_test` VALUES ('155', 'SUCCESS', 'result_code');
INSERT INTO `notify_test` VALUES ('156', 'SUCCESS', 'return_code');
INSERT INTO `notify_test` VALUES ('157', '92A473315F711F10D60E8D0A1B2DBE26', 'sign');
INSERT INTO `notify_test` VALUES ('158', '20180709111413', 'time_end');
INSERT INTO `notify_test` VALUES ('159', '1', 'total_fee');
INSERT INTO `notify_test` VALUES ('160', 'JSAPI', 'trade_type');
INSERT INTO `notify_test` VALUES ('161', '4200000120201807098690457320', 'transaction_id');
INSERT INTO `notify_test` VALUES ('162', 'yes', '校验是否成功');
INSERT INTO `notify_test` VALUES ('163', 'wxa7ec44c182bba215', 'appid');
INSERT INTO `notify_test` VALUES ('164', 'attach', 'attach');
INSERT INTO `notify_test` VALUES ('165', 'CFT', 'bank_type');
INSERT INTO `notify_test` VALUES ('166', '1', 'cash_fee');
INSERT INTO `notify_test` VALUES ('167', 'CNY', 'fee_type');
INSERT INTO `notify_test` VALUES ('168', 'N', 'is_subscribe');
INSERT INTO `notify_test` VALUES ('169', '1495735442', 'mch_id');
INSERT INTO `notify_test` VALUES ('170', '8up1k8c0gfb963ise991sscss714herd', 'nonce_str');
INSERT INTO `notify_test` VALUES ('171', 'o9JDS5Ofeh7HBdinrjTobbtw4VJU', 'openid');
INSERT INTO `notify_test` VALUES ('172', '32153110685538', 'out_trade_no');
INSERT INTO `notify_test` VALUES ('173', 'SUCCESS', 'result_code');
INSERT INTO `notify_test` VALUES ('174', 'SUCCESS', 'return_code');
INSERT INTO `notify_test` VALUES ('175', '8C41A3F92524D312021690034552567B', 'sign');
INSERT INTO `notify_test` VALUES ('176', '20180709112745', 'time_end');
INSERT INTO `notify_test` VALUES ('177', '1', 'total_fee');
INSERT INTO `notify_test` VALUES ('178', 'JSAPI', 'trade_type');
INSERT INTO `notify_test` VALUES ('179', '4200000133201807094288312244', 'transaction_id');
INSERT INTO `notify_test` VALUES ('180', 'yes', '校验是否成功');
INSERT INTO `notify_test` VALUES ('181', 'wxa7ec44c182bba215', 'appid');
INSERT INTO `notify_test` VALUES ('182', 'attach', 'attach');
INSERT INTO `notify_test` VALUES ('183', 'CFT', 'bank_type');
INSERT INTO `notify_test` VALUES ('184', '1', 'cash_fee');
INSERT INTO `notify_test` VALUES ('185', 'CNY', 'fee_type');
INSERT INTO `notify_test` VALUES ('186', 'N', 'is_subscribe');
INSERT INTO `notify_test` VALUES ('187', '1495735442', 'mch_id');
INSERT INTO `notify_test` VALUES ('188', '099iyl5eh8wm8zrf0mlkf0kuinziink5', 'nonce_str');
INSERT INTO `notify_test` VALUES ('189', 'o9JDS5OyN-0J2PScXEJ6Otq1I-Js', 'openid');
INSERT INTO `notify_test` VALUES ('190', '28153112858633', 'out_trade_no');
INSERT INTO `notify_test` VALUES ('191', 'SUCCESS', 'result_code');
INSERT INTO `notify_test` VALUES ('192', 'SUCCESS', 'return_code');
INSERT INTO `notify_test` VALUES ('193', '3E96CB3A326115D9D8216F309E2CBC70', 'sign');
INSERT INTO `notify_test` VALUES ('194', '20180709173030', 'time_end');
INSERT INTO `notify_test` VALUES ('195', '1', 'total_fee');
INSERT INTO `notify_test` VALUES ('196', 'JSAPI', 'trade_type');
INSERT INTO `notify_test` VALUES ('197', '4200000113201807095888379762', 'transaction_id');
INSERT INTO `notify_test` VALUES ('198', 'yes', '校验是否成功');
INSERT INTO `notify_test` VALUES ('199', 'wxa7ec44c182bba215', 'appid');
INSERT INTO `notify_test` VALUES ('200', 'attach', 'attach');
INSERT INTO `notify_test` VALUES ('201', 'CFT', 'bank_type');
INSERT INTO `notify_test` VALUES ('202', '1', 'cash_fee');
INSERT INTO `notify_test` VALUES ('203', 'CNY', 'fee_type');
INSERT INTO `notify_test` VALUES ('204', 'N', 'is_subscribe');
INSERT INTO `notify_test` VALUES ('205', '1495735442', 'mch_id');
INSERT INTO `notify_test` VALUES ('206', 'a37u0bahtfaka4jt2n9p6y2abjxetqkg', 'nonce_str');
INSERT INTO `notify_test` VALUES ('207', 'o9JDS5OyN-0J2PScXEJ6Otq1I-Js', 'openid');
INSERT INTO `notify_test` VALUES ('208', '34153112890988', 'out_trade_no');
INSERT INTO `notify_test` VALUES ('209', 'SUCCESS', 'result_code');
INSERT INTO `notify_test` VALUES ('210', 'SUCCESS', 'return_code');
INSERT INTO `notify_test` VALUES ('211', '800D75E861638A1969552B92E293FFE0', 'sign');
INSERT INTO `notify_test` VALUES ('212', '20180709173523', 'time_end');
INSERT INTO `notify_test` VALUES ('213', '1', 'total_fee');
INSERT INTO `notify_test` VALUES ('214', 'JSAPI', 'trade_type');
INSERT INTO `notify_test` VALUES ('215', '4200000138201807096784843652', 'transaction_id');
INSERT INTO `notify_test` VALUES ('216', 'yes', '校验是否成功');
INSERT INTO `notify_test` VALUES ('217', 'wxa7ec44c182bba215', 'appid');
INSERT INTO `notify_test` VALUES ('218', 'attach', 'attach');
INSERT INTO `notify_test` VALUES ('219', 'CFT', 'bank_type');
INSERT INTO `notify_test` VALUES ('220', '1', 'cash_fee');
INSERT INTO `notify_test` VALUES ('221', 'CNY', 'fee_type');
INSERT INTO `notify_test` VALUES ('222', 'N', 'is_subscribe');
INSERT INTO `notify_test` VALUES ('223', '1495735442', 'mch_id');
INSERT INTO `notify_test` VALUES ('224', 'bh3zfjnguamy2p3pyotx0n8636b0jkaq', 'nonce_str');
INSERT INTO `notify_test` VALUES ('225', 'o9JDS5OyN-0J2PScXEJ6Otq1I-Js', 'openid');
INSERT INTO `notify_test` VALUES ('226', '15153118691387', 'out_trade_no');
INSERT INTO `notify_test` VALUES ('227', 'SUCCESS', 'result_code');
INSERT INTO `notify_test` VALUES ('228', 'SUCCESS', 'return_code');
INSERT INTO `notify_test` VALUES ('229', '80A59D5285C5E5510D5B2BCC7F3ED828', 'sign');
INSERT INTO `notify_test` VALUES ('230', '20180710094206', 'time_end');
INSERT INTO `notify_test` VALUES ('231', '1', 'total_fee');
INSERT INTO `notify_test` VALUES ('232', 'JSAPI', 'trade_type');
INSERT INTO `notify_test` VALUES ('233', '4200000137201807109069023325', 'transaction_id');
INSERT INTO `notify_test` VALUES ('234', 'yes', '校验是否成功');
INSERT INTO `order` VALUES ('139', '32', '12153085777583', null, null, null, null, '包邮', '0', '', '2', '0.02', '2', '0', '1', '1530857775', '0', '0', '0');
INSERT INTO `order` VALUES ('144', '32', '48153085917375', null, null, null, null, '包邮', '0', '', '1', '0.01', '1', '0', '1', '1530859173', '0', '0', '0');
INSERT INTO `order` VALUES ('145', '32', '43153085923695', '止水', '18979875656', '浙江省 杭州市 江干区', '笕桥街道', '包邮', '0', '', '1', '0.01', '3', '0', '1', '1530859236', '0', '0', '0');
INSERT INTO `order` VALUES ('148', '43', '29153086623170', null, null, null, null, '包邮', '0', '', '1', '0.01', '3', '2', '1', '1530866231', '1', '1', '690967');
INSERT INTO `order` VALUES ('149', '43', '44153087295962', null, null, null, null, '包邮', '0', '', '1', '0.01', '1', '0', '1', '1530872959', '1', '2', '691281');
INSERT INTO `order` VALUES ('150', '32', '64153110284292', null, null, null, null, '包邮', '0', '', '1', '30.00', '0', '0', '1', '1531102842', '0', '0', '0');
INSERT INTO `order` VALUES ('151', '43', '43153110602779', 'asd', '13758724818', '浙江省 杭州市 江干区', '火车东站', '包邮', '0', '', '1', '0.01', '1', '0', '1', '1531106027', '1', '2', '691281');
INSERT INTO `order` VALUES ('152', '43', '32153110685538', 'asd', '13758724818', '浙江省 杭州市 江干区', '火车东站', '包邮', '0', '', '1', '0.01', '1', '2', '1', '1531106855', '1', '1', '691830');
INSERT INTO `order` VALUES ('153', '17', '37153111894977', null, null, null, null, '包邮', '0', '', '3', '31.01', '4', '0', '1', '1531118949', '0', '0', '0');
INSERT INTO `order` VALUES ('154', '17', '28153112858633', null, null, null, null, '包邮', '0', '', '1', '0.01', '1', '0', '1', '1531128586', '1', '1', '691836');
INSERT INTO `order` VALUES ('155', '17', '34153112890988', null, null, null, null, '包邮', '0', '', '1', '0.01', '3', '2', '1', '1531128909', '1', '1', '691902');
INSERT INTO `order` VALUES ('156', '17', '15153118691387', '叶俊强', '15168640943', '', '东亚新干线', '包邮', '0', '', '1', '0.01', '1', '0', '1', '1531186913', '1', '1', '691910');
INSERT INTO `order_details` VALUES ('115', '139', '15', '2', '1', '1530857775');
INSERT INTO `order_details` VALUES ('120', '144', '15', '1', '1', '1530859173');
INSERT INTO `order_details` VALUES ('121', '145', '15', '1', '1', '1530859236');
INSERT INTO `order_details` VALUES ('124', '148', '15', '1', '1', '1530866231');
INSERT INTO `order_details` VALUES ('125', '149', '15', '1', '1', '1530872959');
INSERT INTO `order_details` VALUES ('126', '150', '16', '1', '1', '1531102842');
INSERT INTO `order_details` VALUES ('127', '151', '15', '1', '1', '1531106027');
INSERT INTO `order_details` VALUES ('128', '152', '15', '1', '1', '1531106855');
INSERT INTO `order_details` VALUES ('129', '153', '18', '1', '1', '1531118949');
INSERT INTO `order_details` VALUES ('130', '153', '15', '1', '1', '1531118949');
INSERT INTO `order_details` VALUES ('131', '153', '16', '1', '1', '1531118949');
INSERT INTO `order_details` VALUES ('132', '154', '15', '1', '1', '1531128586');
INSERT INTO `order_details` VALUES ('133', '155', '15', '1', '1', '1531128909');
INSERT INTO `order_details` VALUES ('134', '156', '15', '1', '1', '1531186913');
INSERT INTO `refund` VALUES ('4', '', '15', '1.00', '1', '', '1530071298', '1530106806');
INSERT INTO `refund` VALUES ('5', null, '15', '2.00', '1', '', '1530106806', '1531100509');
INSERT INTO `refund` VALUES ('7', null, '15', '3.00', '1', '', '1530106896', '1530671557');
INSERT INTO `refund` VALUES ('8', '12153110147434', '32', '0.10', '1', '', '1531101474', '1531107597');
INSERT INTO `rule` VALUES ('1', '单或双，二选一，猜中即为中奖！商城 采用 公平、公正、权威的第三方数据（重庆时时彩）相对应档期开奖尾数的单双作为是否中奖的依据（1、3、5、7、9为单，0、2、4、6、8为双）出奖结果非“单”即“双”，中奖几率50%，谁也无法篡改出奖结果。', '1');
INSERT INTO `rule` VALUES ('2', '规则2。。。。。单或双，二选一，猜中即为中奖！商城 采用 公平、公正、权威的第三方数据（重庆时时彩）相对应档期开奖尾数的单双作为是否中奖的依据（1、3、5、7、9为单，0、2、4、6、8为双）出奖结果非“单”即“双”，中奖几率50%，谁也无法篡改出奖结果。', '0');
INSERT INTO `rule` VALUES ('3', '规则3。。。。。单或双，二选一，猜中即为中奖！商城 采用 公平、公正、权威的第三方数据（重庆时时彩）相对应档期开奖尾数的单双作为是否中奖的依据（1、3、5、7、9为单，0、2、4、6、8为双）出奖结果非“单”即“双”，中奖几率50%，谁也无法篡改出奖结果。', '0');
INSERT INTO `rule` VALUES ('4', '98', '0');
INSERT INTO `user_address` VALUES ('1', '14', '我w', '1214537837', '江苏省 市辖区 宣武区', 'adsgadsg ', '0', '0', '1530089520');
INSERT INTO `user_address` VALUES ('19', '14', '啊', '456451353', '江苏省 市辖区 宣武区', 'adsgadsg ', '0', '0', '1530088961');
INSERT INTO `user_address` VALUES ('20', '13', '林某人', '1345678974', '河北省 县 密云县', 'XX路XX幢XX室', '1', '0', '1530071416');
INSERT INTO `user_address` VALUES ('21', '13', '张一山', '1654989794', '河北省 县 密云县', 'XX路XX幢XX室', '0', '0', '1530071416');
INSERT INTO `user_address` VALUES ('23', '13', '冲冲', '1543214147', '山西 太原市 迎泽区', 'XX路XX幢XX室', '0', '0', '1530071666');
INSERT INTO `user_address` VALUES ('24', '13', '季艾莉', '1358748997', '河北省 县 密云县', 'XX路XX幢XX室', '0', '0', '1530071416');
INSERT INTO `user_address` VALUES ('31', '14', '毒瘤', '1654896768', '江苏省 市辖区 宣武区', 'adsgadsg ', '0', '0', '1530088965');
INSERT INTO `user_address` VALUES ('32', '14', '讲', '2147483647', '江苏省 市辖区 宣武区', 'adsgadsg ', '0', '0', '1530088524');
INSERT INTO `user_address` VALUES ('33', '14', 'zxczxc', '123123123', '北京市 市辖区 东城区', '123123123', '0', '0', '1530089512');
INSERT INTO `user_address` VALUES ('34', '14', 'Z ', '1866868686', '北京市 市辖区 东城区', 'zxc', '0', '0', '1530089108');
INSERT INTO `user_address` VALUES ('35', '15', '止水', '1866801619', '浙江省 杭州市 江干区', '笕桥街道', '0', '0', '1530089520');
INSERT INTO `user_address` VALUES ('36', '15', '止水', '1866801619', '天津市 市辖县 静海县', '街道', '0', '0', '1530236971');
INSERT INTO `user_address` VALUES ('37', '15', '花花', '1357525212', '湖南省 长沙市 岳麓区', '街道', '0', '0', '1530237047');
INSERT INTO `user_address` VALUES ('38', '14', '华为', '2147483647', '浙江省 杭州市 江干区', 'XXXXXXX', '1', '1', '1530606380');
INSERT INTO `user_address` VALUES ('39', '29', '你们', '0', '', '9', '1', '1', '1530699400');
INSERT INTO `user_address` VALUES ('40', '15', 'qw', '123456789', '', '123', '1', '1', '1530700130');
INSERT INTO `user_address` VALUES ('41', '30', '12', '13456', '', '134', '1', '1', '1530771598');
INSERT INTO `user_address` VALUES ('42', '43', 'asd', '13758724818', '浙江省 杭州市 江干区', '火车东站', '0', '1', '1531105566');
INSERT INTO `user_address` VALUES ('43', '43', '啊啊啊', '13458724818', '北京市 市辖区 东城区', '新亚大厦', '0', '0', '1531105619');
INSERT INTO `user_address` VALUES ('44', '17', '叶俊强', '15168640943', '', '东亚新干线', '0', '0', '1531130799');
INSERT INTO `user_address` VALUES ('45', '17', '叶俊强', '15168640943', '', '东亚新干线', '1', '1', '1531130886');
INSERT INTO `user_address` VALUES ('46', '43', 'hangzhou', '13758754548', '浙江省杭州市江干区景昙路18-26号', 'afdghafhafdha', '1', '1', '1531189701');
INSERT INTO `user_address` VALUES ('47', '43', 'kkk', '13458751245', '浙江省杭州市江干区景昙路18-26号', 'jdhkhkghkd', '0', '1', '1531188748');
INSERT INTO `user_address` VALUES ('48', '43', 'afhahjafjaj', '13758724818', '浙江省杭州市江干区景昙路18-26号', '788646546', '0', '1', '1531190871');
INSERT INTO `user_address` VALUES ('49', '18', '432', '13333333333', '浙江省杭州市江干区庆春东路1-1号', '432', '0', '1', '1532059575');
INSERT INTO `user_address` VALUES ('50', '18', '565', 'ppppppppppp', '浙江省杭州市江干区庆春东路1-1号', '3+63', '1', '1', '1532068893');
INSERT INTO `wechat_user` VALUES ('16', 'o9JDS5Okzree-2pZ07EJByo1zL4k', 'AM 3:00', null, null, '0.00', null, null, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKGnWWwAdicbKmX3WNsMMOuUhm1ibOYDfkdHL3S6eapJrr74NFfYpLIOrVWx2vABWctWeAmRNKLficog/132', '1', '', '维也纳', '奥地利', '1535512382', '0', '1', '1530182002');
INSERT INTO `wechat_user` VALUES ('17', 'o9JDS5OyN-0J2PScXEJ6Otq1I-Js', '二狗子', null, null, '0.00', null, null, 'https://wx.qlogo.cn/mmopen/vi_32/FUKRt3cj3ibpKBic2gakNBaoUaFjicBekOic13YAG1sIn2E1Zg8A7a4g8GVAqgiaMg4X4BOaISbH3IlMzd6xcBiapWiaQ/132', '1', '绍兴', '浙江', '中国', '1531797678', null, '1', '1530700428');
INSERT INTO `wechat_user` VALUES ('18', 'o9JDS5DOU2VRUqDXj6oU6G_q8uJU', '飞翔的荷兰人号', null, null, '0.00', null, null, 'https://wx.qlogo.cn/mmopen/vi_32/KibvgwBjrsVPLGr0xVtw8q2aEpoF43Wia36ibpp0Z55ckO0vT7M86rH4QUpicLyoOvgHZUoYxOeqTY2WmG6QhYHWeg/132', '1', '杭州', '浙江', '中国', '1533541417', null, '1', '1530700938');
INSERT INTO `wechat_user` VALUES ('28', 'o9JDS5P5-IessGVr6UwNvtRa2_cQ', '醉..兔子..', null, null, '0.00', null, null, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLgibn8eGsvJyRRj1yxXEdAvLnvRJBYxoztk5ibqkdopCNZ8vZfEsrObpnQ8lyJefdgrgg3AiaXicvNfg/132', '1', '杭州', '浙江', '中国', '1537164203', null, '1', '1530763484');
INSERT INTO `wechat_user` VALUES ('32', 'o9JDS5A8idkjn3iMpkNyYPjlVNbU', '止水', null, null, '0.10', null, null, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLj7r4eb4gD8z8qnFmjZOYa2RhPMrml1MIawwibUFyQuogrBce7sdv2h7X1OWkvWbdLnl4tJZFDbRg/132', '2', '杭州', '浙江', '中国', '1534388407', null, '1', '1530776525');
INSERT INTO `wechat_user` VALUES ('43', 'o9JDS5Ofeh7HBdinrjTobbtw4VJU', 'Deciduous-L', null, null, '0.00', null, null, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLScsPCxPurmIqgaianldVZX6bOoUqHiakMkxwmlS8fJzmgHZ8nITw55SmqCIZ8iacKqMUd7B6eOBUDQ/132', '1', '温州', '浙江', '中国', '1531468788', null, '1', '1530859871');
INSERT INTO `wechat_user` VALUES ('44', 'o9JDS5NI9KUN0LYHCRxBDGXyDf5Y', null, null, null, '0.00', null, null, null, null, null, null, null, '1533263381', null, '1', '1532510989');
INSERT INTO `wechat_user` VALUES ('45', 'o9JDS5N-oVeyM469tysgbR730EHw', null, null, null, '0.00', null, null, null, null, null, null, null, '1533739340', null, '1', '1533739340');
