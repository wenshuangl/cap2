/*
SQLyog Trial v13.1.8 (64 bit)
MySQL - 8.0.40 : Database - cpa_ad_management
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`cpa_ad_management` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `cpa_ad_management`;

/*Table structure for table `app_info` */

DROP TABLE IF EXISTS `app_info`;

CREATE TABLE `app_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `media_type` varchar(50) DEFAULT NULL,
  `monitor_link` varchar(255) DEFAULT NULL,
  `report_ratio` float DEFAULT '1',
  `download_link` varchar(255) DEFAULT NULL,
  `app_id` varchar(50) DEFAULT NULL,
  `cooperation_company` varchar(255) DEFAULT NULL,
  `cooperation_media` varchar(255) DEFAULT NULL,
  `cooperation_price` float DEFAULT NULL,
  `cooperation_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `app_info` */

insert  into `app_info`(`id`,`name`,`media_type`,`monitor_link`,`report_ratio`,`download_link`,`app_id`,`cooperation_company`,`cooperation_media`,`cooperation_price`,`cooperation_time`) values 
(1,'App1','游戏','https://monitor.link/app1',1,'https://download.link/app1','app1','Company A','Media X',1000,'2023-10-01 10:00:00'),
(2,'App2','社交','https://monitor.link/app2',0.9,'https://download.link/app2','app2','Company B','Media Y',1500,'2023-10-02 11:00:00'),
(3,'App3','工具','https://monitor.link/app3',1.1,'https://download.link/app3','app3','Company C','Media Z',2000,'2023-10-03 12:00:00'),
(4,'App1','游戏',NULL,1,'https://download.link/app1','app1','Company A','Media X',1000,'2023-10-01 10:00:00'),
(5,'App2','社交',NULL,1,'https://download.link/app2','app2','Company B','Media Y',1500,'2023-10-02 11:00:00'),
(6,'App3','工具',NULL,1,'https://download.link/app3','app3','Company C','Media Z',2000,'2023-10-03 12:00:00');

/*Table structure for table `callback_config` */

DROP TABLE IF EXISTS `callback_config`;

CREATE TABLE `callback_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_id` int DEFAULT NULL,
  `callback_amount` int DEFAULT NULL,
  `callback_fields` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `callback_config` */

/*Table structure for table `event_type` */

DROP TABLE IF EXISTS `event_type`;

CREATE TABLE `event_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('click','show') NOT NULL COMMENT '监测类型（click 或 show）',
  `event_type_value` varchar(50) NOT NULL COMMENT '回传字段值（可能是数字或其他类型）',
  `field_description` varchar(255) NOT NULL COMMENT '字段解释（如 激活、注册）',
  `media` varchar(50) NOT NULL COMMENT '所属媒体（如 快手、腾讯）',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `event_type` */

insert  into `event_type`(`id`,`type`,`event_type_value`,`field_description`,`media`,`note`) values 
(1,'click','1','激活','快手','快手激活字段'),
(2,'click','2','注册','快手','快手注册字段'),
(3,'show','3','展示','腾讯','腾讯广告展示字段'),
(4,'show','4','点击','腾讯','腾讯广告点击字段');

/*Table structure for table `media_info` */

DROP TABLE IF EXISTS `media_info`;

CREATE TABLE `media_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) DEFAULT NULL,
  `callback` varchar(255) DEFAULT NULL,
  `ua` varchar(255) DEFAULT NULL,
  `imei` varchar(20) DEFAULT NULL,
  `oaid` varchar(32) DEFAULT NULL,
  `idfa` varchar(32) DEFAULT NULL,
  `caid` varchar(255) DEFAULT NULL,
  `app_id` int DEFAULT NULL,
  `event_type` varchar(20) DEFAULT NULL,
  `event_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_media_app` (`app_id`),
  CONSTRAINT `fk_media_app` FOREIGN KEY (`app_id`) REFERENCES `app_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `media_info` */

/*Table structure for table `monitor_data` */

DROP TABLE IF EXISTS `monitor_data`;

CREATE TABLE `monitor_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_id` int DEFAULT NULL,
  `event_type` varchar(50) DEFAULT NULL,
  `event_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  CONSTRAINT `monitor_data_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `monitor_data` */

insert  into `monitor_data`(`id`,`app_id`,`event_type`,`event_time`) values 
(1,1,'click','2023-10-01 10:05:00'),
(2,1,'install','2023-10-01 10:10:00'),
(3,2,'click','2023-10-02 11:05:00'),
(4,2,'install','2023-10-02 11:15:00'),
(5,3,'click','2023-10-03 12:05:00'),
(6,3,'install','2023-10-03 12:20:00'),
(7,1,'click','2023-10-01 10:05:00'),
(8,1,'install','2023-10-01 10:10:00'),
(9,2,'click','2023-10-02 11:05:00'),
(10,2,'install','2023-10-02 11:15:00'),
(11,3,'click','2023-10-03 12:05:00'),
(12,3,'install','2023-10-03 12:20:00');

/*Table structure for table `monitor_link` */

DROP TABLE IF EXISTS `monitor_link`;

CREATE TABLE `monitor_link` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_id` int DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  CONSTRAINT `monitor_link_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `monitor_link` */

insert  into `monitor_link`(`id`,`app_id`,`link`) values 
(1,1,NULL),
(2,2,NULL),
(3,3,NULL),
(5,1,'https://monitor.link/app1'),
(6,2,'https://monitor.link/app2'),
(7,3,'https://monitor.link/app3');

/*Table structure for table `monitor_link_event_type` */

DROP TABLE IF EXISTS `monitor_link_event_type`;

CREATE TABLE `monitor_link_event_type` (
  `monitor_link_id` int NOT NULL,
  `event_type_id` int NOT NULL,
  PRIMARY KEY (`monitor_link_id`,`event_type_id`),
  KEY `event_type_id` (`event_type_id`),
  CONSTRAINT `monitor_link_event_type_ibfk_1` FOREIGN KEY (`monitor_link_id`) REFERENCES `monitor_link` (`id`) ON DELETE CASCADE,
  CONSTRAINT `monitor_link_event_type_ibfk_2` FOREIGN KEY (`event_type_id`) REFERENCES `event_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `monitor_link_event_type` */

/*Table structure for table `operation_log` */

DROP TABLE IF EXISTS `operation_log`;

CREATE TABLE `operation_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `details` text,
  `log_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `operation_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `operation_log` */

/*Table structure for table `permission` */

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '权限名称（如 add_user、delete_user）',
  `description` varchar(255) DEFAULT NULL COMMENT '权限描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `permission` */

insert  into `permission`(`id`,`name`,`description`) values 
(1,'view_data','查看数据权限'),
(2,'edit_data','编辑数据权限'),
(3,'add_user','添加用户权限'),
(4,'delete_user','删除用户权限'),
(5,'edit_user','修改用户权限'),
(6,'manage_app','管理应用权限'),
(7,'manage_link','管理监测链接权限'),
(9,'管理应用权限1','manage_app1');

/*Table structure for table `permissions` */

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_name` (`permission_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `permissions` */

/*Table structure for table `report_info` */

DROP TABLE IF EXISTS `report_info`;

CREATE TABLE `report_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_id` int DEFAULT NULL,
  `report_time` datetime DEFAULT NULL,
  `event_type` varchar(20) DEFAULT NULL,
  `event_count` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `report_info` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `password` varchar(120) NOT NULL,
  `role` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`role`) values 
(1,'wenshuang','$2a$10$v7dfXFMYdg0UyUcj.u1Q2O0xjPJihUGDwdWHQyPUIbhaylG3LsDP2','admin'),
(2,'admin','$2a$10$v7dfXFMYdg0UyUcj.u1Q2O0xjPJihUGDwdWHQyPUIbhaylG3LsDP2','admin'),
(3,'user1','$2a$10$v7dfXFMYdg0UyUcj.u1Q2O0xjPJihUGDwdWHQyPUIbhaylG3LsDP2','user'),
(4,'user2','$2a$10$v7dfXFMYdg0UyUcj.u1Q2O0xjPJihUGDwdWHQyPUIbhaylG3LsDP2','user');

/*Table structure for table `user_permission` */

DROP TABLE IF EXISTS `user_permission`;

CREATE TABLE `user_permission` (
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`permission_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `user_permission_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user_permission` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
