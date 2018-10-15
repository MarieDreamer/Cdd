/*
Navicat MySQL Data Transfer

Source Server         : jiangqinli
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : caiduoduo

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2018-06-25 15:28:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for commodity
-- ----------------------------
DROP TABLE IF EXISTS `commodity`;
CREATE TABLE `commodity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL COMMENT '父类',
  `shop_name` varchar(255) NOT NULL COMMENT '商品名称',
  `shop_id` int(10) NOT NULL COMMENT '商品编号',
  `shop_index_image` varchar(255) NOT NULL COMMENT '商品主图',
  `shop_image` varchar(255) NOT NULL COMMENT '商品图片',
  `shop_type` varchar(255) NOT NULL COMMENT '商品类别',
  `shop_num` int(10) NOT NULL COMMENT '商品总数',
  `shop_sale` int(10) NOT NULL COMMENT '已销售商品数',
  `shop_introduce` varchar(255) NOT NULL COMMENT '商品详细',
  `shop_price` int(10) NOT NULL COMMENT '商品价格',
  `status_delete` tinyint(1) NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `shop_id` int(10) NOT NULL COMMENT '商品id',
  `title` varchar(255) NOT NULL COMMENT '优惠券标题',
  `message` varchar(255) NOT NULL COMMENT '优惠券内容',
  `status` tinyint(1) NOT NULL COMMENT '使用状态',
  `effective_start_date` int(10) NOT NULL COMMENT '优惠券开始日期',
  `effective_end_date` int(10) NOT NULL COMMENT '优惠券截止日期',
  `code_url` varchar(255) NOT NULL COMMENT '二维码地址',
  `code` varchar(255) NOT NULL COMMENT '无序码',
  `status_delete` tinyint(1) NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `num` int(10) NOT NULL COMMENT '商品数量',
  `price` int(10) NOT NULL COMMENT '总金额',
  `shop_state` tinyint(1) NOT NULL COMMENT '商品状态（待付款、待发货、待收货、已收货）',
  `is_free` tinyint(1) NOT NULL COMMENT '是否免单',
  `status_delete` tinyint(1) NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) NOT NULL COMMENT '下单时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` int(10) NOT NULL COMMENT '商品id',
  `num` int(10) NOT NULL COMMENT '商品数量',
  `price` int(10) NOT NULL COMMENT '价格',
  `status_delete` tinyint(1) NOT NULL COMMENT '逻辑删除',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for wechat_user
-- ----------------------------
DROP TABLE IF EXISTS `wechat_user`;
CREATE TABLE `wechat_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `openid` varchar(50) NOT NULL COMMENT 'openid',
  `nickname` varchar(50) NOT NULL COMMENT '昵称',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
