/*
Navicat MySQL Data Transfer

Source Server         : MysqlConnct
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : mint

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2014-12-15 07:08:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_action
-- ----------------------------
DROP TABLE IF EXISTS `t_action`;
CREATE TABLE `t_action` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `operid` int(11) NOT NULL COMMENT '发起人id',
  `opername` varchar(50) DEFAULT '' COMMENT '发起人名称',
  `subject` varchar(255) DEFAULT '' COMMENT '活动主题',
  `content` varchar(1000) DEFAULT '' COMMENT '活动内容',
  `starttime` date COMMENT '发起时间',
  `endsigntime` date COMMENT '报名结束时间',
  `begintime` date COMMENT '活动开始时间',
  `endtime` date COMMENT '活动结束时间',
  `maxcount` int(11) DEFAULT 1 COMMENT '最大参加人数',
  `realcount` int(11) DEFAULT 1 COMMENT '实际参加人数',
  `signcount` int(11) DEFAULT 1 COMMENT '已报名人数',
  `status` varchar(1) DEFAULT 's' COMMENT '活动状态 s 报名中 e 报名结束 p 活动进行中 o 活动已结束',
  `invalid` varchar(1) DEFAULT '1' COMMENT '是否有效 1 有效 0 无效',
  PRIMARY KEY (`aid`),
  KEY `operid` (`operid`),
  CONSTRAINT `t_action_ibfk_1` FOREIGN KEY (`operid`) REFERENCES `t_user` (`usid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_action
-- ----------------------------

-- ----------------------------
-- Table structure for t_address
-- ----------------------------
DROP TABLE IF EXISTS `t_address`;
CREATE TABLE `t_address` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `district` varchar(50) DEFAULT NULL COMMENT '县/区',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_address
-- ----------------------------

-- ----------------------------
-- Table structure for t_awithr
-- ----------------------------
DROP TABLE IF EXISTS `t_awithr`;
CREATE TABLE `t_awithr` (
  `arid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `aid` int(11) NOT NULL COMMENT '活动id',
  `invalid` varchar(1) DEFAULT '1' COMMENT '是否有效',
  `rid` int(11) NOT NULL COMMENT '路线id',
  PRIMARY KEY (`arid`),
  KEY `aid` (`aid`),
  KEY `rid` (`rid`),
  CONSTRAINT `t_awithr_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `t_action` (`aid`),
  CONSTRAINT `t_awithr_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `t_route` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_awithr
-- ----------------------------

-- ----------------------------
-- Table structure for t_awithu
-- ----------------------------
DROP TABLE IF EXISTS `t_awithu`;
CREATE TABLE `t_awithu` (
  `ausid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `usid` int(11) NOT NULL COMMENT '用户id，外键关联到用户的id',
  `aid` int(11) NOT NULL COMMENT '活动id关联到活动',
  `jointime` date  COMMENT '加入时间',
  `rebacktime` date  COMMENT '退出时间',
  `reseaon` varchar(500) DEFAULT NULL COMMENT '退出原因',
  `success` varchar(1) DEFAULT NULL COMMENT '是否成功参与完成一次活动  s：成功，q，中途退出，x，活动中退出',
  `invalid` varchar(1) DEFAULT '1' COMMENT '是否有效 1：有效，0：无效',
  PRIMARY KEY (`ausid`),
  KEY `aid` (`aid`),
  KEY `usid` (`usid`),
  CONSTRAINT `t_awithu_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `t_action` (`aid`),
  CONSTRAINT `t_awithu_ibfk_3` FOREIGN KEY (`usid`) REFERENCES `t_user` (`usid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_awithu
-- ----------------------------

-- ----------------------------
-- Table structure for t_conis
-- ----------------------------
DROP TABLE IF EXISTS `t_conis`;
CREATE TABLE `t_conis` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(100) NOT NULL COMMENT '积分项目名称',
  `unit` int(11) NOT NULL DEFAULT '0' COMMENT '单元积分',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_conis
-- ----------------------------

-- ----------------------------
-- Table structure for t_cwithu
-- ----------------------------
DROP TABLE IF EXISTS `t_cwithu`;
CREATE TABLE `t_cwithu` (
  `ucid` int(11) NOT NULL AUTO_INCREMENT,
  `usid` int(11) NOT NULL COMMENT '用户id',
  `cid` int(11) NOT NULL COMMENT '积分项id',
  `reseans` varchar(255) DEFAULT NULL COMMENT '获取原因',
  `gaintime` date NOT NULL COMMENT '获取时间',
  `invalid` varchar(1)  DEFAULT '1' COMMENT '积分是否有效 1:有效，0，无效',
  PRIMARY KEY (`ucid`),
  KEY `usid` (`usid`),
  KEY `cid` (`cid`),
  CONSTRAINT `t_cwithu_ibfk_1` FOREIGN KEY (`usid`) REFERENCES `t_user` (`usid`),
  CONSTRAINT `t_cwithu_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `t_conis` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cwithu
-- ----------------------------

-- ----------------------------
-- Table structure for t_post
-- ----------------------------
DROP TABLE IF EXISTS `t_post`;
CREATE TABLE `t_post` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '帖子主题',
  `content` varchar(1000) DEFAULT NULL,
  `posttime` date NOT NULL COMMENT '发贴时间',
  `uisd` int(11) NOT NULL COMMENT '发贴人id',
  `postname` varchar(255) NOT NULL DEFAULT '' COMMENT '发贴人姓名',
  `types` varchar(1) DEFAULT NULL COMMENT '帖子类型',
  `invalid` varchar(1) DEFAULT '1' COMMENT '是否有效 1：有效 0：无效',
  PRIMARY KEY (`pid`),
  KEY `usid` (`usid`),
  CONSTRAINT `t_post_ibfk_1` FOREIGN KEY (`usid`) REFERENCES `t_user` (`usid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_post
-- ----------------------------

-- ----------------------------
-- Table structure for t_route
-- ----------------------------
DROP TABLE IF EXISTS `t_route`;
CREATE TABLE `t_route` (
  `lid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `startaddr` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '出发地',
  `destaddr` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '目的地',
  `routes` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '路线信息',
  `mapurl` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '地图信息',
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_route
-- ----------------------------

-- ----------------------------
-- Table structure for t_rpost
-- ----------------------------
DROP TABLE IF EXISTS `t_rpost`;
CREATE TABLE `t_rpost` (
  `rid` int(11) NOT NULL AUTO_INCREMENT COMMENT '回帖id',
  `pid` int(11) NOT NULL COMMENT '主贴id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '回帖内容',
  `retime` date NOT NULL COMMENT '回帖时间',
  `invalid` varchar(255)  DEFAULT '1' COMMENT '是否有效',
  PRIMARY KEY (`rid`),
  KEY `pid` (`pid`),
  CONSTRAINT `t_rpost_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `t_post` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_rpost
-- ----------------------------

-- ----------------------------
-- Table structure for t_rwithu
-- ----------------------------
DROP TABLE IF EXISTS `t_rwithu`;
CREATE TABLE `t_rwithu` (
  `urid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uisd` int(11) NOT NULL COMMENT '发贴人id',
  `rid` int(11) NOT NULL COMMENT '回帖人id',
  `invalid` varchar(1) DEFAULT '1' COMMENT '是否有效用户：1，有效，0，失效',
  PRIMARY KEY (`urid`),
  KEY `usid` (`usid`),
  KEY `rid` (`rid`),
  CONSTRAINT `t_rwithu_ibfk_1` FOREIGN KEY (`uisd`) REFERENCES `t_user` (`uisd`),
  CONSTRAINT `t_rwithu_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `t_rpost` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_rwithu
-- ----------------------------

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `usid` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员id，唯一主键',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `regtime` date NOT NULL  COMMENT '注册时间',
  `ranks` varchar(30) DEFAULT '' COMMENT '等级',
  `periods` varchar(50) DEFAULT '0' COMMENT '在线时长',
  `logintime` date   COMMENT '上线时间',
  `logouttime` date  COMMENT '下线时间',
  `phone` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '邮箱地址',
  `addr` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '地址',
  `comments` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '个人简介',
  `adm` varchar(1) DEFAULT 'n' COMMENT '是否为管理员',
  `conis` int DEFAULT '0' COMMENT '用户金币',
  `invalid` varchar(1) CHARACTER SET utf8 DEFAULT '1' COMMENT '是否有效用户：1，有效，0，失效',
  PRIMARY KEY (`usid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
