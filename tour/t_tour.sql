/*
Navicat MariaDB Data Transfer

Source Server         : MariaDB
Source Server Version : 100015
Source Host           : localhost:3306
Source Database       : tour

Target Server Type    : MariaDB
Target Server Version : 100015
File Encoding         : 65001

Date: 2015-01-05 09:26:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_action
-- ----------------------------
DROP TABLE IF EXISTS `t_action`;
CREATE TABLE `t_action` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `operid` int(11) NOT NULL COMMENT '������id',
  `opername` varchar(50) DEFAULT '' COMMENT '����������',
  `subject` varchar(255) DEFAULT '' COMMENT '�����',
  `content` varchar(1000) DEFAULT '' COMMENT '�����',
  `starttime` date DEFAULT NULL COMMENT '����ʱ��',
  `endsigntime` date DEFAULT NULL COMMENT '��������ʱ��',
  `begintime` date DEFAULT NULL COMMENT '���ʼʱ��',
  `endtime` date DEFAULT NULL COMMENT '�����ʱ��',
  `maxcount` int(11) DEFAULT '1' COMMENT '���μ�����',
  `realcount` int(11) DEFAULT '1' COMMENT 'ʵ�ʲμ�����',
  `signcount` int(11) DEFAULT '1' COMMENT '�ѱ�������',
  `status` varchar(1) DEFAULT 's' COMMENT '�״̬ s ������ e �������� p ������� o ��ѽ���',
  `invalid` varchar(1) DEFAULT '1' COMMENT '�Ƿ���Ч 1 ��Ч 0 ��Ч',
  PRIMARY KEY (`aid`),
  KEY `operid` (`operid`),
  CONSTRAINT `t_action_ibfk_1` FOREIGN KEY (`operid`) REFERENCES `t_user` (`usid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û����';

-- ----------------------------
-- Table structure for t_address
-- ----------------------------
DROP TABLE IF EXISTS `t_address`;
CREATE TABLE `t_address` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `province` varchar(50) DEFAULT NULL COMMENT 'ʡ',
  `district` varchar(50) DEFAULT NULL COMMENT '��/��',
  `city` varchar(50) DEFAULT NULL COMMENT '��',
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û���ַ��Ϣ';

-- ----------------------------
-- Table structure for t_awithr
-- ----------------------------
DROP TABLE IF EXISTS `t_awithr`;
CREATE TABLE `t_awithr` (
  `arid` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `aid` int(11) NOT NULL COMMENT '�id',
  `invalid` varchar(1) DEFAULT '1' COMMENT '�Ƿ���Ч',
  `rid` int(11) NOT NULL COMMENT '·��id',
  PRIMARY KEY (`arid`),
  KEY `aid` (`aid`),
  KEY `rid` (`rid`),
  CONSTRAINT `t_awithr_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `t_action` (`aid`),
  CONSTRAINT `t_awithr_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `t_route` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�·�������';

-- ----------------------------
-- Table structure for t_awithu
-- ----------------------------
DROP TABLE IF EXISTS `t_awithu`;
CREATE TABLE `t_awithu` (
  `ausid` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `usid` int(11) NOT NULL COMMENT '�û�id������������û���id',
  `aid` int(11) NOT NULL COMMENT '�id�������',
  `jointime` date DEFAULT NULL COMMENT '����ʱ��',
  `rebacktime` date DEFAULT NULL COMMENT '�˳�ʱ��',
  `reseaon` varchar(500) DEFAULT NULL COMMENT '�˳�ԭ��',
  `success` varchar(1) DEFAULT NULL COMMENT '�Ƿ�ɹ��������һ�λ  s���ɹ���q����;�˳���x������˳�',
  `invalid` varchar(1) DEFAULT '1' COMMENT '�Ƿ���Ч 1����Ч��0����Ч',
  PRIMARY KEY (`ausid`),
  KEY `aid` (`aid`),
  KEY `usid` (`usid`),
  CONSTRAINT `t_awithu_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `t_action` (`aid`),
  CONSTRAINT `t_awithu_ibfk_3` FOREIGN KEY (`usid`) REFERENCES `t_user` (`usid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û�������';

-- ----------------------------
-- Table structure for t_conis
-- ----------------------------
DROP TABLE IF EXISTS `t_conis`;
CREATE TABLE `t_conis` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(100) NOT NULL COMMENT '������Ŀ����',
  `unit` int(11) NOT NULL DEFAULT '0' COMMENT '��Ԫ����',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��ұ�';

-- ----------------------------
-- Table structure for t_cwithu
-- ----------------------------
DROP TABLE IF EXISTS `t_cwithu`;
CREATE TABLE `t_cwithu` (
  `ucid` int(11) NOT NULL AUTO_INCREMENT,
  `usid` int(11) NOT NULL COMMENT '�û�id',
  `cid` int(11) NOT NULL COMMENT '������id',
  `reseans` varchar(255) DEFAULT NULL COMMENT '��ȡԭ��',
  `gaintime` date NOT NULL COMMENT '��ȡʱ��',
  `invalid` varchar(1) DEFAULT '1' COMMENT '�����Ƿ���Ч 1:��Ч��0����Ч',
  PRIMARY KEY (`ucid`),
  KEY `usid` (`usid`),
  KEY `cid` (`cid`),
  CONSTRAINT `t_cwithu_ibfk_1` FOREIGN KEY (`usid`) REFERENCES `t_user` (`usid`),
  CONSTRAINT `t_cwithu_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `t_conis` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û���������';

-- ----------------------------
-- Table structure for t_post
-- ----------------------------
DROP TABLE IF EXISTS `t_post`;
CREATE TABLE `t_post` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '��������',
  `content` varchar(1000) DEFAULT NULL,
  `posttime` date NOT NULL COMMENT '����ʱ��',
  `usid` int(11) NOT NULL COMMENT '������id',
  `postname` varchar(255) NOT NULL DEFAULT '' COMMENT '����������',
  `types` varchar(1) DEFAULT NULL COMMENT '��������',
  `invalid` varchar(1) DEFAULT '1' COMMENT '�Ƿ���Ч 1����Ч 0����Ч',
  `pcount` int(7) DEFAULT '0' COMMENT '�鿴����',
  `rcount` int(7) DEFAULT '0' COMMENT '�ظ�����',
  PRIMARY KEY (`pid`),
  KEY `usid` (`usid`),
  CONSTRAINT `t_post_ibfk_1` FOREIGN KEY (`usid`) REFERENCES `t_user` (`usid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='���ӱ�';

-- ----------------------------
-- Table structure for t_route
-- ----------------------------
DROP TABLE IF EXISTS `t_route`;
CREATE TABLE `t_route` (
  `lid` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `startaddr` varchar(100) NOT NULL COMMENT '������',
  `destaddr` varchar(100) NOT NULL COMMENT 'Ŀ�ĵ�',
  `routes` varchar(255) NOT NULL COMMENT '·����Ϣ',
  `mapurl` varchar(100) DEFAULT NULL COMMENT '��ͼ��Ϣ',
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='·�߱�';

-- ----------------------------
-- Table structure for t_rpost
-- ----------------------------
DROP TABLE IF EXISTS `t_rpost`;
CREATE TABLE `t_rpost` (
  `rid` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `pid` int(11) NOT NULL COMMENT '����id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '��������',
  `usid` int(11) NOT NULL COMMENT '������',
  `retime` date NOT NULL COMMENT '����ʱ��',
  `invalid` varchar(255) DEFAULT '1' COMMENT '�Ƿ���Ч',
  `pcount` int(7) DEFAULT '0' COMMENT '�鿴����',
  PRIMARY KEY (`rid`),
  KEY `pid` (`pid`),
  KEY `t_rpost_ibfk_2` (`usid`),
  CONSTRAINT `t_rpost_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `t_post` (`pid`),
  CONSTRAINT `t_rpost_ibfk_2` FOREIGN KEY (`usid`) REFERENCES `t_user` (`usid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������';

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `usid` int(11) NOT NULL AUTO_INCREMENT COMMENT '��Աid��Ψһ����',
  `status` int(11) NOT NULL DEFAULT '2' COMMENT '�û�״̬ 0 ���� 1 ����  2 ����',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '�û���',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '����',
  `regtime` date DEFAULT NULL COMMENT 'ע��ʱ��',
  `ranks` varchar(30) DEFAULT '1' COMMENT '�ȼ�',
  `periods` varchar(50) DEFAULT '0' COMMENT '����ʱ��',
  `logintime` date DEFAULT NULL COMMENT '����ʱ��',
  `logouttime` date DEFAULT NULL COMMENT '����ʱ��',
  `phone` varchar(50) DEFAULT NULL COMMENT '��ϵ�绰',
  `email` varchar(100) DEFAULT NULL COMMENT '�����ַ',
  `addr` varchar(255) DEFAULT NULL COMMENT '��ַ',
  `comments` varchar(500) DEFAULT NULL COMMENT '���˼��',
  `adm` varchar(1) DEFAULT 'n' COMMENT '�Ƿ�Ϊ����Ա',
  `conis` int(11) DEFAULT '0' COMMENT '�û����',
  `invalid` varchar(1) DEFAULT '1' COMMENT '�Ƿ���Ч�û���1����Ч��0��ʧЧ',
  `iconurl` varchar(50) DEFAULT '' COMMENT 'ͷ��ͼƬ',
  `validemail` varchar(1) DEFAULT 'n' COMMENT '�Ƿ�����֤���� nδ��֤ s�Է��� y����֤',
  `validphone` varchar(1) DEFAULT 'n' COMMENT '�Ƿ�����֤�ֻ� n δ��֤ s�Է��� y����֤',
  PRIMARY KEY (`usid`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='�û���Ϣ��';

-- ----------------------------
-- Table structure for t_uwitha
-- ----------------------------
DROP TABLE IF EXISTS `t_uwitha`;
CREATE TABLE `t_uwitha` (
  `auid` int(11) NOT NULL,
  `usid` int(11) NOT NULL,
  `aid` int(11) NOT NULL,
  PRIMARY KEY (`auid`),
  KEY `usid` (`usid`),
  KEY `aid` (`aid`),
  CONSTRAINT `t_uwitha_ibfk_1` FOREIGN KEY (`usid`) REFERENCES `t_user` (`usid`),
  CONSTRAINT `t_uwitha_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `t_address` (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
