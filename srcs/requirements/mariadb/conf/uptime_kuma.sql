-- Adminer 5.3.0 MariaDB 11.8.6-MariaDB-0+deb13u1 from Debian dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE TABLE `api_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `api_key_user_id_foreign` (`user_id`),
  CONSTRAINT `api_key_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `docker_host` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `docker_daemon` varchar(255) DEFAULT NULL,
  `docker_type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `docker_host` (`id`, `user_id`, `docker_daemon`, `docker_type`, `name`) VALUES
(1,	1,	'/var/run/docker.sock',	'socket',	'socket');

CREATE TABLE `domain_expiry` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `last_check` datetime DEFAULT NULL,
  `domain` varchar(255) NOT NULL,
  `expiry` datetime DEFAULT NULL,
  `last_expiry_notification_sent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_expiry_domain_unique` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `public` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `weight` int(11) NOT NULL DEFAULT 1000,
  `status_page_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `heartbeat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `important` tinyint(1) NOT NULL DEFAULT 0,
  `monitor_id` int(10) unsigned NOT NULL,
  `status` smallint(6) NOT NULL,
  `msg` text DEFAULT NULL,
  `time` datetime NOT NULL,
  `ping` bigint(20) DEFAULT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `down_count` int(11) NOT NULL DEFAULT 0,
  `end_time` datetime DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT 0,
  `response` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `heartbeat_important_index` (`important`),
  KEY `monitor_time_index` (`monitor_id`,`time`),
  KEY `heartbeat_monitor_id_index` (`monitor_id`),
  KEY `monitor_important_time_index` (`monitor_id`,`important`,`time`),
  CONSTRAINT `heartbeat_monitor_id_foreign` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `heartbeat` (`id`, `important`, `monitor_id`, `status`, `msg`, `time`, `ping`, `duration`, `down_count`, `end_time`, `retries`, `response`) VALUES
(1,	1,	1,	1,	'PONG',	'2026-07-08 14:11:15',	136,	0,	0,	'2026-07-08 14:11:15',	0,	NULL),
(2,	0,	1,	1,	'PONG',	'2026-07-08 14:11:45',	5,	0,	0,	'2026-07-08 14:11:45',	0,	NULL),
(3,	0,	1,	1,	'PONG',	'2026-07-08 14:12:15',	6,	0,	0,	'2026-07-08 14:12:15',	0,	NULL),
(4,	0,	1,	1,	'PONG',	'2026-07-08 14:12:45',	2,	0,	0,	'2026-07-08 14:12:45',	0,	NULL),
(5,	0,	1,	1,	'PONG',	'2026-07-08 14:13:15',	5,	0,	0,	'2026-07-08 14:13:15',	0,	NULL),
(6,	0,	1,	1,	'PONG',	'2026-07-08 14:13:45',	8,	0,	0,	'2026-07-08 14:13:45',	0,	NULL),
(7,	0,	1,	1,	'PONG',	'2026-07-08 14:14:15',	2,	0,	0,	'2026-07-08 14:14:15',	0,	NULL),
(8,	0,	1,	1,	'PONG',	'2026-07-08 14:14:45',	6,	0,	0,	'2026-07-08 14:14:45',	0,	NULL),
(9,	0,	1,	1,	'PONG',	'2026-07-08 14:15:15',	4,	0,	0,	'2026-07-08 14:15:15',	0,	NULL),
(10,	0,	1,	1,	'PONG',	'2026-07-08 14:15:45',	4,	0,	0,	'2026-07-08 14:15:45',	0,	NULL),
(11,	0,	1,	1,	'PONG',	'2026-07-08 14:16:15',	4,	0,	0,	'2026-07-08 14:16:15',	0,	NULL),
(12,	1,	2,	0,	'Request failed with status code 404',	'2026-07-08 14:16:36',	NULL,	0,	0,	'2026-07-08 14:16:37',	1,	'G0AAQIzUYM2YY+nmUpXRDWIymapBEBEPr+fhBA45cDi05XEeiAcbY2cJvgrKAwyG805kPKOY7Mq7nklZZX703R8='),
(13,	0,	1,	1,	'PONG',	'2026-07-08 14:16:45',	2,	0,	0,	'2026-07-08 14:16:45',	0,	NULL),
(14,	0,	2,	0,	'Request failed with status code 404',	'2026-07-08 14:16:56',	NULL,	0,	0,	'2026-07-08 14:16:56',	2,	'G0AAQIzUYM2YY+nmUpXRDWIymapBEBEPr+fhBA45cDi05XEeiAcbY2cJvgrKAwyG805kPKOY7Mq7nklZZX703R8='),
(15,	0,	1,	1,	'PONG',	'2026-07-08 14:17:15',	2,	0,	0,	'2026-07-08 14:17:15',	0,	NULL),
(16,	1,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:17:16',	NULL,	0,	0,	'2026-07-08 14:17:16',	0,	NULL),
(17,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:17:36',	NULL,	0,	0,	'2026-07-08 14:17:36',	0,	NULL),
(18,	0,	1,	1,	'PONG',	'2026-07-08 14:17:45',	4,	0,	0,	'2026-07-08 14:17:45',	0,	NULL),
(19,	1,	2,	0,	'Container State is exited',	'2026-07-08 14:17:56',	NULL,	0,	0,	'2026-07-08 14:17:56',	1,	NULL),
(20,	0,	1,	1,	'PONG',	'2026-07-08 14:18:15',	4,	0,	0,	'2026-07-08 14:18:15',	0,	NULL),
(21,	0,	2,	0,	'Container State is exited',	'2026-07-08 14:18:16',	NULL,	0,	0,	'2026-07-08 14:18:16',	2,	NULL),
(22,	0,	2,	0,	'Container State is exited',	'2026-07-08 14:18:36',	NULL,	0,	0,	'2026-07-08 14:18:36',	3,	NULL),
(23,	0,	1,	1,	'PONG',	'2026-07-08 14:18:45',	2,	0,	0,	'2026-07-08 14:18:45',	0,	NULL),
(24,	1,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:18:56',	NULL,	0,	0,	'2026-07-08 14:18:56',	0,	NULL),
(25,	0,	1,	1,	'PONG',	'2026-07-08 14:19:15',	2,	0,	0,	'2026-07-08 14:19:15',	0,	NULL),
(26,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:19:16',	NULL,	0,	0,	'2026-07-08 14:19:16',	0,	NULL),
(27,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:19:36',	NULL,	0,	0,	'2026-07-08 14:19:36',	0,	NULL),
(28,	0,	1,	1,	'PONG',	'2026-07-08 14:19:45',	5,	0,	0,	'2026-07-08 14:19:45',	0,	NULL),
(29,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:19:56',	NULL,	0,	0,	'2026-07-08 14:19:56',	0,	NULL),
(30,	0,	1,	1,	'PONG',	'2026-07-08 14:20:15',	1,	0,	0,	'2026-07-08 14:20:15',	0,	NULL),
(31,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:20:16',	NULL,	0,	0,	'2026-07-08 14:20:16',	0,	NULL),
(32,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:20:36',	NULL,	0,	0,	'2026-07-08 14:20:36',	0,	NULL),
(33,	0,	1,	1,	'PONG',	'2026-07-08 14:20:45',	4,	0,	0,	'2026-07-08 14:20:45',	0,	NULL),
(34,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:20:56',	NULL,	0,	0,	'2026-07-08 14:20:56',	0,	NULL),
(35,	0,	1,	1,	'PONG',	'2026-07-08 14:21:15',	2,	0,	0,	'2026-07-08 14:21:15',	0,	NULL),
(36,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:21:16',	NULL,	0,	0,	'2026-07-08 14:21:16',	0,	NULL),
(37,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:21:36',	NULL,	0,	0,	'2026-07-08 14:21:36',	0,	NULL),
(38,	0,	1,	1,	'PONG',	'2026-07-08 14:21:45',	2,	0,	0,	'2026-07-08 14:21:45',	0,	NULL),
(39,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:21:56',	NULL,	0,	0,	'2026-07-08 14:21:56',	0,	NULL),
(40,	0,	1,	1,	'PONG',	'2026-07-08 14:22:15',	6,	0,	0,	'2026-07-08 14:22:15',	0,	NULL),
(41,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:22:16',	NULL,	0,	0,	'2026-07-08 14:22:16',	0,	NULL),
(42,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:22:36',	NULL,	0,	0,	'2026-07-08 14:22:36',	0,	NULL),
(43,	0,	1,	1,	'PONG',	'2026-07-08 14:22:45',	2,	0,	0,	'2026-07-08 14:22:45',	0,	NULL),
(44,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:22:56',	NULL,	0,	0,	'2026-07-08 14:22:56',	0,	NULL),
(45,	0,	1,	1,	'PONG',	'2026-07-08 14:23:15',	3,	0,	0,	'2026-07-08 14:23:15',	0,	NULL),
(46,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:23:16',	NULL,	0,	0,	'2026-07-08 14:23:16',	0,	NULL),
(47,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:23:36',	NULL,	0,	0,	'2026-07-08 14:23:36',	0,	NULL),
(48,	0,	1,	1,	'PONG',	'2026-07-08 14:23:45',	4,	0,	0,	'2026-07-08 14:23:45',	0,	NULL),
(49,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:23:56',	NULL,	0,	0,	'2026-07-08 14:23:56',	0,	NULL),
(50,	0,	1,	1,	'PONG',	'2026-07-08 14:24:15',	3,	0,	0,	'2026-07-08 14:24:15',	0,	NULL),
(51,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:24:16',	NULL,	0,	0,	'2026-07-08 14:24:16',	0,	NULL),
(52,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:24:36',	NULL,	0,	0,	'2026-07-08 14:24:36',	0,	NULL),
(53,	0,	1,	1,	'PONG',	'2026-07-08 14:24:45',	5,	0,	0,	'2026-07-08 14:24:45',	0,	NULL),
(54,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:24:56',	NULL,	0,	0,	'2026-07-08 14:24:56',	0,	NULL),
(55,	0,	1,	1,	'PONG',	'2026-07-08 14:25:15',	2,	0,	0,	'2026-07-08 14:25:15',	0,	NULL),
(56,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:25:16',	NULL,	0,	0,	'2026-07-08 14:25:16',	0,	NULL),
(57,	0,	2,	1,	'Container has not reported health and is currently running. As it is running, it is considered UP. Consider adding a health check for better service visibility',	'2026-07-08 14:25:36',	NULL,	0,	0,	'2026-07-08 14:25:36',	0,	NULL);

CREATE TABLE `incident` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `style` varchar(30) NOT NULL DEFAULT 'warning',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated_date` datetime DEFAULT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `status_page_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `knex_migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `batch` int(11) DEFAULT NULL,
  `migration_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `knex_migrations` (`id`, `name`, `batch`, `migration_time`) VALUES
(1,	'2023-08-16-0000-create-uptime.js',	1,	'2026-07-08 14:05:18'),
(2,	'2023-08-18-0301-heartbeat.js',	1,	'2026-07-08 14:05:18'),
(3,	'2023-09-29-0000-heartbeat-retires.js',	1,	'2026-07-08 14:05:18'),
(4,	'2023-10-08-0000-mqtt-query.js',	1,	'2026-07-08 14:05:18'),
(5,	'2023-10-11-1915-push-token-to-32.js',	1,	'2026-07-08 14:05:18'),
(6,	'2023-10-16-0000-create-remote-browsers.js',	1,	'2026-07-08 14:05:18'),
(7,	'2023-12-20-0000-alter-status-page.js',	1,	'2026-07-08 14:05:19'),
(8,	'2023-12-21-0000-stat-ping-min-max.js',	1,	'2026-07-08 14:05:19'),
(9,	'2023-12-22-0000-hourly-uptime.js',	1,	'2026-07-08 14:05:19'),
(10,	'2024-01-22-0000-stats-extras.js',	1,	'2026-07-08 14:05:19'),
(11,	'2024-04-26-0000-snmp-monitor.js',	1,	'2026-07-08 14:05:19'),
(12,	'2024-08-24-000-add-cache-bust.js',	1,	'2026-07-08 14:05:19'),
(13,	'2024-08-24-0000-conditions.js',	1,	'2026-07-08 14:05:19'),
(14,	'2024-10-1315-rabbitmq-monitor.js',	1,	'2026-07-08 14:05:19'),
(15,	'2024-10-31-0000-fix-snmp-monitor.js',	1,	'2026-07-08 14:05:19'),
(16,	'2024-11-27-1927-fix-info-json-data-type.js',	1,	'2026-07-08 14:05:20'),
(17,	'2025-01-01-0000-add-smtp.js',	1,	'2026-07-08 14:05:20'),
(18,	'2025-02-15-2312-add-wstest.js',	1,	'2026-07-08 14:05:20'),
(19,	'2025-02-17-2142-generalize-analytics.js',	1,	'2026-07-08 14:05:20'),
(20,	'2025-03-04-0000-ping-advanced-options.js',	1,	'2026-07-08 14:05:20'),
(21,	'2025-03-25-0127-fix-5721.js',	1,	'2026-07-08 14:05:20'),
(22,	'2025-05-09-0000-add-custom-url.js',	1,	'2026-07-08 14:05:21'),
(23,	'2025-06-03-0000-add-ip-family.js',	1,	'2026-07-08 14:05:21'),
(24,	'2025-06-11-0000-add-manual-monitor.js',	1,	'2026-07-08 14:05:21'),
(25,	'2025-06-13-0000-maintenance-add-last-start.js',	1,	'2026-07-08 14:05:21'),
(26,	'2025-06-15-0001-manual-monitor-fix.js',	1,	'2026-07-08 14:05:21'),
(27,	'2025-06-24-0000-add-audience-to-oauth.js',	1,	'2026-07-08 14:05:21'),
(28,	'2025-07-17-0000-mqtt-websocket-path.js',	1,	'2026-07-08 14:05:21'),
(29,	'2025-09-02-0000-add-domain-expiry.js',	1,	'2026-07-08 14:05:21'),
(30,	'2025-10-14-0000-add-ip-family-fix.js',	1,	'2026-07-08 14:05:21'),
(31,	'2025-10-15-0000-stat-table-fix.js',	1,	'2026-07-08 14:05:22'),
(32,	'2025-10-15-0001-add-monitor-response-config.js',	1,	'2026-07-08 14:05:22'),
(33,	'2025-10-15-0002-add-response-to-heartbeat.js',	1,	'2026-07-08 14:05:22'),
(34,	'2025-10-24-0000-show-only-last-heartbeat.js',	1,	'2026-07-08 14:05:22'),
(35,	'2025-12-09-0000-add-system-service-monitor.js',	1,	'2026-07-08 14:05:22'),
(36,	'2025-12-17-0000-add-globalping-monitor.js',	1,	'2026-07-08 14:05:22'),
(37,	'2025-12-22-0121-optimize-important-indexes.js',	1,	'2026-07-08 14:05:22'),
(38,	'2025-12-29-0000-remove-line-notify.js',	1,	'2026-07-08 14:05:22'),
(39,	'2025-12-31-2143-add-snmp-v3-username.js',	1,	'2026-07-08 14:05:22'),
(40,	'2026-01-02-0551-dns-last-result-to-text.js',	1,	'2026-07-08 14:05:22'),
(41,	'2026-01-02-0713-gamedig-v4-to-v5.js',	1,	'2026-07-08 14:05:22'),
(42,	'2026-01-05-0000-add-rss-title.js',	1,	'2026-07-08 14:05:22'),
(43,	'2026-01-05-0000-add-tls-monitor.js',	1,	'2026-07-08 14:05:23'),
(44,	'2026-01-06-0000-fix-domain-expiry-column-type.js',	1,	'2026-07-08 14:05:23'),
(45,	'2026-01-10-0000-convert-float-precision.js',	1,	'2026-07-08 14:05:23'),
(46,	'2026-01-15-0000-add-json-query-retry-only-status-code.js',	1,	'2026-07-08 14:05:23'),
(47,	'2026-01-16-0000-add-screenshot-delay.js',	1,	'2026-07-08 14:05:23'),
(48,	'2026-02-07-0000-disable-domain-expiry-unsupported-tlds.js',	1,	'2026-07-08 14:05:23'),
(49,	'2026-05-20-0000-add-bearer-token.js',	1,	'2026-07-08 14:05:23'),
(50,	'2026-05-25-0000-add-gamedig-token.js',	1,	'2026-07-08 14:05:23'),
(51,	'2026-06-19-1411-add-rybbit-analytics-type.js',	1,	'2026-07-08 14:05:23'),
(52,	'2026-06-19-1412-analytics-type-to-string.js',	1,	'2026-07-08 14:05:24');

CREATE TABLE `knex_migrations_lock` (
  `index` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_locked` int(11) DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `knex_migrations_lock` (`index`, `is_locked`) VALUES
(1,	0);

CREATE TABLE `maintenance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `strategy` varchar(50) NOT NULL DEFAULT 'single',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `weekdays` varchar(250) DEFAULT '[]',
  `days_of_month` text DEFAULT '[]',
  `interval_day` int(11) DEFAULT NULL,
  `cron` text DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `last_start_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `maintenance_active_index` (`active`),
  KEY `manual_active` (`strategy`,`active`),
  KEY `maintenance_user_id` (`user_id`),
  CONSTRAINT `maintenance_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `maintenance_status_page` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_page_id` int(10) unsigned NOT NULL,
  `maintenance_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `maintenance_status_page_maintenance_id_foreign` (`maintenance_id`),
  KEY `maintenance_status_page_status_page_id_foreign` (`status_page_id`),
  CONSTRAINT `maintenance_status_page_maintenance_id_foreign` FOREIGN KEY (`maintenance_id`) REFERENCES `maintenance` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `maintenance_status_page_status_page_id_foreign` FOREIGN KEY (`status_page_id`) REFERENCES `status_page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `monitor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `user_id` int(10) unsigned DEFAULT NULL,
  `interval` int(11) NOT NULL DEFAULT 20,
  `url` text DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `weight` int(11) DEFAULT 2000,
  `hostname` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `keyword` varchar(255) DEFAULT NULL,
  `maxretries` int(11) NOT NULL DEFAULT 0,
  `ignore_tls` tinyint(1) NOT NULL DEFAULT 0,
  `upside_down` tinyint(1) NOT NULL DEFAULT 0,
  `maxredirects` int(11) NOT NULL DEFAULT 10,
  `accepted_statuscodes_json` text NOT NULL DEFAULT '["200-299"]',
  `dns_resolve_type` varchar(5) DEFAULT NULL,
  `dns_resolve_server` varchar(255) DEFAULT NULL,
  `dns_last_result` text DEFAULT NULL,
  `retry_interval` int(11) NOT NULL DEFAULT 0,
  `push_token` varchar(32) DEFAULT NULL,
  `method` text NOT NULL DEFAULT 'GET',
  `body` text DEFAULT NULL,
  `headers` text DEFAULT NULL,
  `basic_auth_user` text DEFAULT NULL,
  `basic_auth_pass` text DEFAULT NULL,
  `docker_host` int(10) unsigned DEFAULT NULL,
  `docker_container` varchar(255) DEFAULT NULL,
  `proxy_id` int(10) unsigned DEFAULT NULL,
  `expiry_notification` tinyint(1) DEFAULT 1,
  `mqtt_topic` text DEFAULT NULL,
  `mqtt_success_message` varchar(255) DEFAULT NULL,
  `mqtt_username` varchar(255) DEFAULT NULL,
  `mqtt_password` varchar(255) DEFAULT NULL,
  `database_connection_string` varchar(2000) DEFAULT NULL,
  `database_query` text DEFAULT NULL,
  `auth_method` varchar(250) DEFAULT NULL,
  `auth_domain` text DEFAULT NULL,
  `auth_workstation` text DEFAULT NULL,
  `grpc_url` varchar(255) DEFAULT NULL,
  `grpc_protobuf` text DEFAULT NULL,
  `grpc_body` text DEFAULT NULL,
  `grpc_metadata` text DEFAULT NULL,
  `grpc_method` text DEFAULT NULL,
  `grpc_service_name` text DEFAULT NULL,
  `grpc_enable_tls` tinyint(1) NOT NULL DEFAULT 0,
  `radius_username` varchar(255) DEFAULT NULL,
  `radius_password` varchar(255) DEFAULT NULL,
  `radius_calling_station_id` varchar(50) DEFAULT NULL,
  `radius_called_station_id` varchar(50) DEFAULT NULL,
  `radius_secret` varchar(255) DEFAULT NULL,
  `resend_interval` int(11) NOT NULL DEFAULT 0,
  `packet_size` int(11) NOT NULL DEFAULT 56,
  `game` varchar(255) DEFAULT NULL,
  `http_body_encoding` varchar(25) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `tls_ca` text DEFAULT NULL,
  `tls_cert` text DEFAULT NULL,
  `tls_key` text DEFAULT NULL,
  `parent` int(10) unsigned DEFAULT NULL,
  `invert_keyword` tinyint(1) NOT NULL DEFAULT 0,
  `json_path` text DEFAULT NULL,
  `expected_value` varchar(255) DEFAULT NULL,
  `kafka_producer_topic` varchar(255) DEFAULT NULL,
  `kafka_producer_brokers` text DEFAULT NULL,
  `kafka_producer_ssl` tinyint(1) NOT NULL DEFAULT 0,
  `kafka_producer_allow_auto_topic_creation` tinyint(1) NOT NULL DEFAULT 0,
  `kafka_producer_sasl_options` text DEFAULT NULL,
  `kafka_producer_message` text DEFAULT NULL,
  `oauth_client_id` text DEFAULT NULL,
  `oauth_client_secret` text DEFAULT NULL,
  `oauth_token_url` text DEFAULT NULL,
  `oauth_scopes` text DEFAULT NULL,
  `oauth_auth_method` text DEFAULT NULL,
  `timeout` double NOT NULL DEFAULT 0,
  `gamedig_given_port_only` tinyint(1) NOT NULL DEFAULT 1,
  `mqtt_check_type` varchar(255) NOT NULL DEFAULT 'keyword',
  `remote_browser` int(10) unsigned DEFAULT NULL,
  `snmp_oid` varchar(255) DEFAULT NULL,
  `snmp_version` enum('1','2c','3') DEFAULT '2c',
  `json_path_operator` varchar(255) DEFAULT NULL,
  `cache_bust` tinyint(1) NOT NULL DEFAULT 0,
  `conditions` text NOT NULL DEFAULT '[]',
  `rabbitmq_nodes` text DEFAULT NULL,
  `rabbitmq_username` varchar(255) DEFAULT NULL,
  `rabbitmq_password` varchar(255) DEFAULT NULL,
  `smtp_security` varchar(255) DEFAULT NULL,
  `ws_ignore_sec_websocket_accept_header` tinyint(1) NOT NULL DEFAULT 0,
  `ws_subprotocol` varchar(255) NOT NULL DEFAULT '',
  `ping_count` int(11) NOT NULL DEFAULT 1,
  `ping_numeric` tinyint(1) NOT NULL DEFAULT 1,
  `ping_per_request_timeout` int(11) NOT NULL DEFAULT 2,
  `ip_family` varchar(4) DEFAULT NULL,
  `manual_status` smallint(6) DEFAULT NULL,
  `oauth_audience` varchar(255) DEFAULT NULL,
  `mqtt_websocket_path` varchar(255) DEFAULT NULL,
  `domain_expiry_notification` tinyint(1) DEFAULT 0,
  `save_response` tinyint(1) NOT NULL DEFAULT 0,
  `save_error_response` tinyint(1) NOT NULL DEFAULT 1,
  `response_max_length` int(11) NOT NULL DEFAULT 1024,
  `system_service_name` varchar(255) DEFAULT NULL,
  `subtype` varchar(10) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `protocol` varchar(20) DEFAULT NULL,
  `snmp_v3_username` varchar(255) DEFAULT NULL,
  `expected_tls_alert` varchar(50) DEFAULT NULL,
  `retry_only_on_status_code_failure` tinyint(1) NOT NULL DEFAULT 0,
  `screenshot_delay` int(10) unsigned NOT NULL DEFAULT 0,
  `bearer_token` text DEFAULT NULL,
  `gamedig_token` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `monitor_user_id_foreign` (`user_id`),
  KEY `monitor_docker_host_foreign` (`docker_host`),
  KEY `monitor_proxy_id_foreign` (`proxy_id`),
  KEY `monitor_parent_foreign` (`parent`),
  KEY `monitor_remote_browser_index` (`remote_browser`),
  CONSTRAINT `monitor_docker_host_foreign` FOREIGN KEY (`docker_host`) REFERENCES `docker_host` (`id`),
  CONSTRAINT `monitor_parent_foreign` FOREIGN KEY (`parent`) REFERENCES `monitor` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `monitor_proxy_id_foreign` FOREIGN KEY (`proxy_id`) REFERENCES `proxy` (`id`),
  CONSTRAINT `monitor_remote_browser_foreign` FOREIGN KEY (`remote_browser`) REFERENCES `remote_browser` (`id`),
  CONSTRAINT `monitor_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `monitor` (`id`, `name`, `active`, `user_id`, `interval`, `url`, `type`, `weight`, `hostname`, `port`, `created_date`, `keyword`, `maxretries`, `ignore_tls`, `upside_down`, `maxredirects`, `accepted_statuscodes_json`, `dns_resolve_type`, `dns_resolve_server`, `dns_last_result`, `retry_interval`, `push_token`, `method`, `body`, `headers`, `basic_auth_user`, `basic_auth_pass`, `docker_host`, `docker_container`, `proxy_id`, `expiry_notification`, `mqtt_topic`, `mqtt_success_message`, `mqtt_username`, `mqtt_password`, `database_connection_string`, `database_query`, `auth_method`, `auth_domain`, `auth_workstation`, `grpc_url`, `grpc_protobuf`, `grpc_body`, `grpc_metadata`, `grpc_method`, `grpc_service_name`, `grpc_enable_tls`, `radius_username`, `radius_password`, `radius_calling_station_id`, `radius_called_station_id`, `radius_secret`, `resend_interval`, `packet_size`, `game`, `http_body_encoding`, `description`, `tls_ca`, `tls_cert`, `tls_key`, `parent`, `invert_keyword`, `json_path`, `expected_value`, `kafka_producer_topic`, `kafka_producer_brokers`, `kafka_producer_ssl`, `kafka_producer_allow_auto_topic_creation`, `kafka_producer_sasl_options`, `kafka_producer_message`, `oauth_client_id`, `oauth_client_secret`, `oauth_token_url`, `oauth_scopes`, `oauth_auth_method`, `timeout`, `gamedig_given_port_only`, `mqtt_check_type`, `remote_browser`, `snmp_oid`, `snmp_version`, `json_path_operator`, `cache_bust`, `conditions`, `rabbitmq_nodes`, `rabbitmq_username`, `rabbitmq_password`, `smtp_security`, `ws_ignore_sec_websocket_accept_header`, `ws_subprotocol`, `ping_count`, `ping_numeric`, `ping_per_request_timeout`, `ip_family`, `manual_status`, `oauth_audience`, `mqtt_websocket_path`, `domain_expiry_notification`, `save_response`, `save_error_response`, `response_max_length`, `system_service_name`, `subtype`, `location`, `protocol`, `snmp_v3_username`, `expected_tls_alert`, `retry_only_on_status_code_failure`, `screenshot_delay`, `bearer_token`, `gamedig_token`) VALUES
(1,	'Redis',	1,	1,	30,	'https://',	'redis',	2000,	NULL,	NULL,	'2026-07-08 14:11:15',	NULL,	0,	0,	0,	10,	'[\"200-299\"]',	'A',	'',	NULL,	30,	NULL,	'GET',	NULL,	NULL,	'',	'',	1,	'',	NULL,	0,	'',	'',	'',	'',	'redis://@redis:6379',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	56,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	'$',	NULL,	NULL,	'[]',	0,	0,	'{\"mechanism\":\"None\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	'client_secret_basic',	24,	1,	'keyword',	NULL,	NULL,	'2c',	'==',	0,	'[]',	'[]',	'',	'',	NULL,	0,	'',	3,	1,	2,	NULL,	NULL,	NULL,	'',	1,	0,	1,	1024,	'',	NULL,	'world',	NULL,	NULL,	NULL,	0,	0,	'',	''),
(2,	'WP',	1,	1,	20,	'https://',	'docker',	2000,	NULL,	NULL,	'2026-07-08 14:16:36',	NULL,	0,	0,	0,	10,	'[\"200-299\"]',	'A',	'',	NULL,	20,	NULL,	'GET',	NULL,	NULL,	'',	'',	1,	'4c3ee18fb436',	NULL,	0,	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	56,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0,	'$',	NULL,	NULL,	'[]',	0,	0,	'{\"mechanism\":\"None\"}',	NULL,	NULL,	NULL,	NULL,	NULL,	'client_secret_basic',	8,	1,	'keyword',	NULL,	NULL,	'2c',	'==',	0,	'[]',	'[]',	'',	'',	NULL,	0,	'',	3,	1,	2,	NULL,	NULL,	NULL,	'',	1,	0,	1,	1024,	'',	NULL,	'world',	NULL,	NULL,	NULL,	0,	0,	'',	'');

CREATE TABLE `monitor_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1000,
  `send_url` tinyint(1) NOT NULL DEFAULT 0,
  `custom_url` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `monitor_group_group_id_foreign` (`group_id`),
  KEY `fk` (`monitor_id`,`group_id`),
  CONSTRAINT `monitor_group_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `monitor_group_monitor_id_foreign` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `monitor_maintenance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned NOT NULL,
  `maintenance_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `maintenance_id_index2` (`maintenance_id`),
  KEY `monitor_id_index` (`monitor_id`),
  CONSTRAINT `monitor_maintenance_maintenance_id_foreign` FOREIGN KEY (`maintenance_id`) REFERENCES `maintenance` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `monitor_maintenance_monitor_id_foreign` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `monitor_notification` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned NOT NULL,
  `notification_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `monitor_notification_notification_id_foreign` (`notification_id`),
  KEY `monitor_notification_index` (`monitor_id`,`notification_id`),
  CONSTRAINT `monitor_notification_monitor_id_foreign` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `monitor_notification_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `monitor_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `monitor_tag_monitor_id_foreign` (`monitor_id`),
  KEY `monitor_tag_tag_id_foreign` (`tag_id`),
  CONSTRAINT `monitor_tag_monitor_id_foreign` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `monitor_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `monitor_tls_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned NOT NULL,
  `info_json` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `monitor_tls_info_monitor_id_foreign` (`monitor_id`),
  CONSTRAINT `monitor_tls_info_monitor_id_foreign` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `notification` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `user_id` int(10) unsigned DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `config` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `notification_sent_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `monitor_id` int(10) unsigned NOT NULL,
  `days` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notification_sent_history_type_monitor_id_days_unique` (`type`,`monitor_id`,`days`),
  KEY `good_index` (`type`,`monitor_id`,`days`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `proxy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `protocol` varchar(10) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` int(11) DEFAULT NULL,
  `auth` tinyint(1) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `default` tinyint(1) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `proxy_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `remote_browser` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `value` text DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `setting` (`id`, `key`, `value`, `type`) VALUES
(1,	'migrateAggregateTableState',	'\"migrated\"',	NULL),
(2,	'jwtSecret',	'$2a$10$cVnp/i0jx5GCyl43p1uZX.BB/OESA5bQcIVqg0nTA7Eob71IZ//qu',	NULL),
(3,	'initServerTimezone',	'true',	NULL),
(4,	'serverTimezone',	'\"Europe/Madrid\"',	'general');

CREATE TABLE `status_page` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(255) NOT NULL,
  `theme` varchar(30) NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 1,
  `search_engine_index` tinyint(1) NOT NULL DEFAULT 1,
  `show_tags` tinyint(1) NOT NULL DEFAULT 0,
  `password` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_date` datetime NOT NULL DEFAULT current_timestamp(),
  `footer_text` text DEFAULT NULL,
  `custom_css` text DEFAULT NULL,
  `show_powered_by` tinyint(1) NOT NULL DEFAULT 1,
  `analytics_id` varchar(255) DEFAULT NULL,
  `show_certificate_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `auto_refresh_interval` int(10) unsigned DEFAULT 300,
  `analytics_script_url` varchar(255) DEFAULT NULL,
  `analytics_type` varchar(255) DEFAULT NULL,
  `show_only_last_heartbeat` tinyint(1) NOT NULL DEFAULT 0,
  `rss_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `status_page_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `status_page_cname` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_page_id` int(10) unsigned DEFAULT NULL,
  `domain` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `status_page_cname_domain_unique` (`domain`),
  KEY `status_page_cname_status_page_id_foreign` (`status_page_id`),
  CONSTRAINT `status_page_cname_status_page_id_foreign` FOREIGN KEY (`status_page_id`) REFERENCES `status_page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `stat_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned NOT NULL,
  `timestamp` int(11) NOT NULL COMMENT 'Unix timestamp rounded down to the nearest day',
  `ping` float(20,2) NOT NULL,
  `up` smallint(6) NOT NULL,
  `down` smallint(6) NOT NULL,
  `ping_min` float(20,2) NOT NULL DEFAULT 0.00,
  `ping_max` float(20,2) NOT NULL DEFAULT 0.00,
  `extras` text DEFAULT NULL COMMENT 'Extra statistics during this time period',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stat_daily_monitor_id_timestamp_unique` (`monitor_id`,`timestamp`),
  CONSTRAINT `stat_daily_monitor_id_foreign` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table contains the daily aggregate statistics for each monitor';

INSERT INTO `stat_daily` (`id`, `monitor_id`, `timestamp`, `ping`, `up`, `down`, `ping_min`, `ping_max`, `extras`) VALUES
(1,	1,	1783468800,	8.17,	29,	0,	1.00,	136.00,	NULL),
(2,	2,	1783468800,	0.00,	23,	5,	0.00,	0.00,	NULL);

CREATE TABLE `stat_hourly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned NOT NULL,
  `timestamp` int(11) NOT NULL COMMENT 'Unix timestamp rounded down to the nearest hour',
  `ping` float(20,2) NOT NULL,
  `ping_min` float(20,2) NOT NULL DEFAULT 0.00,
  `ping_max` float(20,2) NOT NULL DEFAULT 0.00,
  `up` smallint(6) NOT NULL,
  `down` smallint(6) NOT NULL,
  `extras` text DEFAULT NULL COMMENT 'Extra statistics during this time period',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stat_hourly_monitor_id_timestamp_unique` (`monitor_id`,`timestamp`),
  CONSTRAINT `stat_hourly_monitor_id_foreign` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table contains the hourly aggregate statistics for each monitor';

INSERT INTO `stat_hourly` (`id`, `monitor_id`, `timestamp`, `ping`, `ping_min`, `ping_max`, `up`, `down`, `extras`) VALUES
(1,	1,	1783519200,	8.17,	1.00,	136.00,	29,	0,	NULL),
(2,	2,	1783519200,	0.00,	0.00,	0.00,	23,	5,	NULL);

CREATE TABLE `stat_minutely` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned NOT NULL,
  `timestamp` int(11) NOT NULL COMMENT 'Unix timestamp rounded down to the nearest minute',
  `ping` float(20,2) NOT NULL,
  `up` smallint(6) NOT NULL,
  `down` smallint(6) NOT NULL,
  `ping_min` float(20,2) NOT NULL DEFAULT 0.00,
  `ping_max` float(20,2) NOT NULL DEFAULT 0.00,
  `extras` text DEFAULT NULL COMMENT 'Extra statistics during this time period',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stat_minutely_monitor_id_timestamp_unique` (`monitor_id`,`timestamp`),
  CONSTRAINT `stat_minutely_monitor_id_foreign` FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table contains the minutely aggregate statistics for each monitor';

INSERT INTO `stat_minutely` (`id`, `monitor_id`, `timestamp`, `ping`, `up`, `down`, `ping_min`, `ping_max`, `extras`) VALUES
(1,	1,	1783519860,	70.50,	2,	0,	5.00,	136.00,	NULL),
(2,	1,	1783519920,	4.00,	2,	0,	2.00,	6.00,	NULL),
(3,	1,	1783519980,	6.50,	2,	0,	5.00,	8.00,	NULL),
(4,	1,	1783520040,	4.00,	2,	0,	2.00,	6.00,	NULL),
(5,	1,	1783520100,	4.00,	2,	0,	4.00,	4.00,	NULL),
(6,	1,	1783520160,	3.00,	2,	0,	2.00,	4.00,	NULL),
(7,	2,	1783520160,	0.00,	0,	2,	0.00,	0.00,	NULL),
(8,	1,	1783520220,	3.00,	2,	0,	2.00,	4.00,	NULL),
(9,	2,	1783520220,	0.00,	2,	1,	0.00,	0.00,	NULL),
(10,	1,	1783520280,	3.00,	2,	0,	2.00,	4.00,	NULL),
(11,	2,	1783520280,	0.00,	1,	2,	0.00,	0.00,	NULL),
(12,	1,	1783520340,	3.50,	2,	0,	2.00,	5.00,	NULL),
(13,	2,	1783520340,	0.00,	3,	0,	0.00,	0.00,	NULL),
(14,	1,	1783520400,	2.50,	2,	0,	1.00,	4.00,	NULL),
(15,	2,	1783520400,	0.00,	3,	0,	0.00,	0.00,	NULL),
(16,	1,	1783520460,	2.00,	2,	0,	2.00,	2.00,	NULL),
(17,	2,	1783520460,	0.00,	3,	0,	0.00,	0.00,	NULL),
(18,	1,	1783520520,	4.00,	2,	0,	2.00,	6.00,	NULL),
(19,	2,	1783520520,	0.00,	3,	0,	0.00,	0.00,	NULL),
(20,	1,	1783520580,	3.50,	2,	0,	3.00,	4.00,	NULL),
(21,	2,	1783520580,	0.00,	3,	0,	0.00,	0.00,	NULL),
(22,	1,	1783520640,	4.00,	2,	0,	3.00,	5.00,	NULL),
(23,	2,	1783520640,	0.00,	3,	0,	0.00,	0.00,	NULL),
(24,	1,	1783520700,	2.00,	1,	0,	2.00,	2.00,	NULL),
(25,	2,	1783520700,	0.00,	2,	0,	0.00,	0.00,	NULL);

CREATE TABLE `tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `timezone` varchar(150) DEFAULT NULL,
  `twofa_secret` varchar(64) DEFAULT NULL,
  `twofa_status` tinyint(1) NOT NULL DEFAULT 0,
  `twofa_last_token` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_username_unique` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user` (`id`, `username`, `password`, `active`, `timezone`, `twofa_secret`, `twofa_status`, `twofa_last_token`) VALUES
(1,	'alejhern',	'$2a$10$r6YSbZ2yVdlbJIf5S6NRXudSXiTGiuRFgADoUQjiT0VE3CKI8bzF.',	1,	NULL,	NULL,	0,	NULL);
