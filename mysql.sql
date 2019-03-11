CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `permissions` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `is_ignored` tinyint(1) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `is_super_admin` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_users_username` (`username`),
  UNIQUE KEY `ix_users_email` (`email`),
  KEY `role_id` (`role_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `content` text,
  `last_content` text,
  `week_count` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `ix_reports_created_at` (`created_at`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `departments` (`id`,`name`) VALUES (3,'产品开发部');
INSERT INTO `departments` (`id`,`name`) VALUES (1,'人事行政部');
INSERT INTO `departments` (`id`,`name`) VALUES (2,'软件测试部');

INSERT INTO `roles` (`id`,`name`,`permissions`) VALUES (1,'QUIT',0);
INSERT INTO `roles` (`id`,`name`,`permissions`) VALUES (2,'EMPLOYEE',1);
INSERT INTO `roles` (`id`,`name`,`permissions`) VALUES (3,'MANAGER',11);
INSERT INTO `roles` (`id`,`name`,`permissions`) VALUES (4,'HR',7);
INSERT INTO `roles` (`id`,`name`,`permissions`) VALUES (5,'ADMINISTRATOR',255);