-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2018-06-13 10:02:42
-- 服务器版本： 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tyxc`
--

-- --------------------------------------------------------

--
-- 表的结构 `employee_system`
--

CREATE TABLE IF NOT EXISTS `employee_system` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(20) NOT NULL,
  `password` varchar(40) NOT NULL,
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `status` int(10) unsigned NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统员工信息' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `employee_system`
--

INSERT INTO `employee_system` (`id`, `account`, `password`, `name`, `sort`, `status`, `create_time`) VALUES
(2, 'zuituzi', '14e1b600b1fd579f47433b88e8d85291', '系统管理员', 0, 1, 1500865568);

-- --------------------------------------------------------

--
-- 表的结构 `photo`
--

CREATE TABLE IF NOT EXISTS `photo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `album_id` int(10) unsigned NOT NULL COMMENT '相册id',
  `url` varchar(500) NOT NULL COMMENT 'url',
  `title` varchar(500) NOT NULL COMMENT '标题',
  `content` varchar(500) NOT NULL COMMENT '内容',
  `address` varchar(500) NOT NULL COMMENT '地址',
  `praise` int(10) unsigned NOT NULL COMMENT '点赞数',
  `praise_id` text NOT NULL COMMENT '点赞人',
  `status_delete` tinyint(1) unsigned NOT NULL COMMENT '逻辑删除',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='图片表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `photo_album`
--

CREATE TABLE IF NOT EXISTS `photo_album` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `other_user_id` text NOT NULL COMMENT '其他用户id',
  `album_class` int(10) unsigned NOT NULL COMMENT '相册类型',
  `name` varchar(250) NOT NULL COMMENT '相册名字',
  `index_photo` varchar(200) NOT NULL COMMENT '首页图片',
  `person_num` int(10) unsigned NOT NULL COMMENT '用户人数',
  `photo_num` int(10) unsigned NOT NULL COMMENT '图片数',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `status_delete` tinyint(1) unsigned NOT NULL COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `wechat_user`
--

CREATE TABLE IF NOT EXISTS `wechat_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `openid` varchar(50) NOT NULL COMMENT 'openid',
  `nickname` varchar(50) NOT NULL COMMENT '昵称',
  `imageurl` varchar(200) NOT NULL COMMENT '头像路径',
  `gender` tinyint(1) unsigned NOT NULL COMMENT '性别',
  `city` varchar(50) NOT NULL COMMENT '城市',
  `province` varchar(50) NOT NULL COMMENT '省份',
  `country` varchar(50) NOT NULL COMMENT '国家',
  `login_time` int(10) unsigned NOT NULL COMMENT '上次登录时间',
  `gold_coin` int(10) unsigned NOT NULL COMMENT '金币数',
  `coupon` varchar(50) NOT NULL COMMENT '优惠券',
  `cash_number` decimal(10,2) unsigned NOT NULL COMMENT '现金',
  `status_delete` tinyint(10) unsigned NOT NULL COMMENT '逻辑删除',
  `status_merchant` int(10) unsigned NOT NULL COMMENT '是否为商户',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30 ;

--
-- 转存表中的数据 `wechat_user`
--

INSERT INTO `wechat_user` (`id`, `openid`, `nickname`, `imageurl`, `gender`, `city`, `province`, `country`, `login_time`, `gold_coin`, `coupon`, `cash_number`, `status_delete`, `status_merchant`, `create_time`) VALUES
(29, 'o9JDS5P5-IessGVr6UwNvtRa2_cQ', '醉..兔子..', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLgibn8eGsvJyRRj1yxXEdAvLnvRJBYxoztk5ibqkdopCNZ8vZfEsrObpnQ8lyJefdgrgg3AiaXicvNfg/0', 1, 'Hangzhou', 'Zhejiang', 'China', 1522823255, 0, '', '0.00', 0, 0, 1522822672);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
