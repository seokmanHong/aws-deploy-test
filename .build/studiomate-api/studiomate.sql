-- MySQL dump 10.13  Distrib 5.7.12, for Linux (x86_64)
--
-- Host: localhost    Database: studiomate
-- ------------------------------------------------------
-- Server version	5.7.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `_owner_instance_tokens`
--

DROP TABLE IF EXISTS `_owner_instance_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_owner_instance_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner_type` enum('userAccount') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `type` enum('fcm') NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_user_account_profiles`
--

DROP TABLE IF EXISTS `_user_account_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_user_account_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account_id` int(10) unsigned NOT NULL,
  `name` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `causer_id` int(11) DEFAULT NULL,
  `causer_type` varchar(255) DEFAULT NULL,
  `properties` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `amenities`
--

DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amenities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `amenity` varchar(255) NOT NULL,
  `display` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_logs`
--

DROP TABLE IF EXISTS `api_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'account id',
  `host` varchar(255) NOT NULL COMMENT '접속 host',
  `method` varchar(30) NOT NULL COMMENT '접근 방법',
  `path` varchar(255) NOT NULL COMMENT '경로',
  `user_agent` varchar(255) NOT NULL COMMENT 'user agent',
  `type` enum('userAccount','staffAccount') DEFAULT NULL COMMENT '접근자 종류',
  `input` longtext COMMENT '데이터',
  `headers` text COMMENT 'header',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_type` varchar(255) DEFAULT NULL,
  `ref_id` int(10) unsigned DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ref` (`ref_id`,`ref_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendance_codes`
--

DROP TABLE IF EXISTS `attendance_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance_codes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(36) NOT NULL COMMENT '출석 코드',
  `user_ticket_id` int(10) unsigned NOT NULL COMMENT '유저티켓 아이디',
  `lecture_id` int(10) unsigned NOT NULL COMMENT '수업 아이디',
  `user_id` int(10) unsigned NOT NULL COMMENT '유저 아이디',
  `expire_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '유효시간',
  PRIMARY KEY (`id`),
  KEY `attendance_codes_lecture_id_foreign` (`lecture_id`),
  KEY `attendance_codes_user_id_foreign` (`user_id`),
  KEY `attendance_codes_user_ticket_id_foreign` (`user_ticket_id`),
  CONSTRAINT `attendance_codes_lecture_id_foreign` FOREIGN KEY (`lecture_id`) REFERENCES `lectures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendance_codes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendance_codes_user_ticket_id_foreign` FOREIGN KEY (`user_ticket_id`) REFERENCES `user_tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boards`
--

DROP TABLE IF EXISTS `boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `user_type` varchar(255) NOT NULL COMMENT '스테프, 회원 ',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT '부모 글ID',
  `title` varchar(255) NOT NULL,
  `contents` longtext NOT NULL,
  `is_secret` tinyint(1) NOT NULL DEFAULT '0',
  `is_notice` tinyint(1) NOT NULL DEFAULT '0',
  `is_comment` tinyint(1) NOT NULL DEFAULT '0' COMMENT '댓글 사용 여부',
  `is_attachment` tinyint(1) NOT NULL DEFAULT '1' COMMENT '첨부파일 사용 여부',
  `type` enum('notice:client','notice:studio','notice','qna') NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `boards_studio_id_foreign` (`studio_id`),
  KEY `boards_user_id_foreign` (`user_id`),
  CONSTRAINT `boards_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`),
  CONSTRAINT `boards_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `studio_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `booking_histories`
--

DROP TABLE IF EXISTS `booking_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` int(10) unsigned NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_for` varchar(60) DEFAULT NULL COMMENT '예약이력 생성 사유',
  `created_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `booking` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `lecture_id` int(10) unsigned NOT NULL,
  `ticket_id` int(10) unsigned DEFAULT NULL COMMENT '티켓 ID',
  `user_ticket_id` int(10) unsigned NOT NULL,
  `status` enum('booking_waiting','booking_pending','booked','booking_confirmed','attendance','absence','noshow','cancel') DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `updated_for` varchar(60) DEFAULT NULL COMMENT '예약상태 변경 사유',
  `enter_at` timestamp NULL DEFAULT NULL COMMENT '입장시간',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_lecture_id_foreign` (`lecture_id`),
  KEY `bookings_studio_id_foreign` (`studio_id`),
  KEY `bookings_ticket_id_foreign` (`ticket_id`),
  KEY `bookings_user_id_foreign` (`user_id`),
  KEY `bookings_status_index` (`status`),
  KEY `bookings_user_ticket_id_index` (`user_ticket_id`),
  CONSTRAINT `bookings_lecture_id_foreign` FOREIGN KEY (`lecture_id`) REFERENCES `lectures` (`id`),
  CONSTRAINT `bookings_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `bookings_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`),
  CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `change_histories`
--

DROP TABLE IF EXISTS `change_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_model_id` int(10) unsigned NOT NULL COMMENT '대상 아이디',
  `ref_model_type` varchar(30) NOT NULL COMMENT '대상 모델 종류',
  `ref_user_id` int(10) unsigned NOT NULL COMMENT '대상 유저 아이디',
  `ref_user_type` varchar(30) NOT NULL COMMENT '대상 유저 종류',
  `old` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '변경 전 모델 상태',
  `new` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '변경 후 모델 상태',
  `changed` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '변경 내용',
  `title` varchar(255) DEFAULT NULL COMMENT '제목',
  `context` text COMMENT '내용',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ref_model` (`ref_model_id`,`ref_model_type`),
  KEY `ref_user` (`ref_user_id`,`ref_user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `change_logs`
--

DROP TABLE IF EXISTS `change_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `ref_model_id` int(10) unsigned NOT NULL,
  `ref_model_type` varchar(255) NOT NULL,
  `ref_user_id` int(10) unsigned DEFAULT NULL,
  `ref_user_type` varchar(255) DEFAULT NULL,
  `changed` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `change_logs_ref_model_id_ref_model_type_index` (`ref_model_id`,`ref_model_type`),
  KEY `change_logs_ref_user_id_ref_user_type_index` (`ref_user_id`,`ref_user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `command_logs`
--

DROP TABLE IF EXISTS `command_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `command_type` varchar(255) NOT NULL COMMENT 'Command Name',
  `start_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '시작시간',
  `end_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '종료시간',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `board_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `contents` varchar(255) NOT NULL,
  `is_secret` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_board_id_foreign` (`board_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  CONSTRAINT `comments_board_id_foreign` FOREIGN KEY (`board_id`) REFERENCES `boards` (`id`),
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `studio_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_info_types`
--

DROP TABLE IF EXISTS `contact_info_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_info_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `display` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `counseling_channels`
--

DROP TABLE IF EXISTS `counseling_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counseling_channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '시설 아이디',
  `title` varchar(255) NOT NULL COMMENT '메뉴명',
  `context` varchar(255) DEFAULT NULL COMMENT '메뉴 설명',
  `kind` enum('inbound','route','purpose') NOT NULL COMMENT '[인입상태:inbound, 인지경로:route, 목적:purpose]',
  `is_overlap_lecture` tinyint(1) NOT NULL DEFAULT '1' COMMENT '수업과 겹침이 가능한가',
  `order_by` int(11) NOT NULL DEFAULT '999' COMMENT '정렬순서',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `counseling_channels_studio_id_foreign` (`studio_id`),
  CONSTRAINT `counseling_channels_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `counseling_logs`
--

DROP TABLE IF EXISTS `counseling_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counseling_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `gender` enum('F','M') DEFAULT NULL,
  `channel` enum('phone','visit','chat','etc') DEFAULT NULL,
  `inbound_id` int(10) unsigned DEFAULT NULL COMMENT '인입 상태',
  `route_id` int(10) unsigned DEFAULT NULL COMMENT '경로 아이디',
  `purpose_id` int(10) unsigned DEFAULT NULL COMMENT '목적 아이디',
  `purpose` varchar(128) DEFAULT NULL,
  `contents` text,
  `result` enum('registered','non-register','available-register') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `start_on` timestamp NULL DEFAULT NULL,
  `end_on` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `counseling_logs_inbound_id_foreign` (`inbound_id`),
  KEY `counseling_logs_purpose_id_foreign` (`purpose_id`),
  KEY `counseling_logs_route_id_foreign` (`route_id`),
  KEY `counseling_logs_staff_id_foreign` (`staff_id`),
  KEY `counseling_logs_studio_id_foreign` (`studio_id`),
  KEY `counseling_logs_end_on_index` (`end_on`),
  KEY `counseling_logs_start_on_index` (`start_on`),
  CONSTRAINT `counseling_logs_inbound_id_foreign` FOREIGN KEY (`inbound_id`) REFERENCES `counseling_channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `counseling_logs_purpose_id_foreign` FOREIGN KEY (`purpose_id`) REFERENCES `counseling_channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `counseling_logs_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `counseling_channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `counseling_logs_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `counseling_logs_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_schedule`
--

DROP TABLE IF EXISTS `course_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_schedule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(10) unsigned NOT NULL,
  `weekday` tinyint(4) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `course_schedule_course_id_foreign` (`course_id`),
  CONSTRAINT `course_schedule_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  `instructor_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned DEFAULT NULL COMMENT '룸 ID',
  `division_id` int(10) unsigned DEFAULT NULL COMMENT '수업 구분 ID',
  `type` enum('P','G','C') NOT NULL COMMENT 'P : private, G : group, C : course',
  `attendance_type` enum('attendance','absence','noshow') NOT NULL DEFAULT 'attendance' COMMENT '수업 시간 시작시 booking 기본값 설정',
  `is_booking_only` tinyint(1) NOT NULL DEFAULT '1' COMMENT '예약전용',
  `title` varchar(300) NOT NULL,
  `description` text,
  `min_trainee` tinyint(3) unsigned NOT NULL,
  `max_trainee` tinyint(3) unsigned NOT NULL,
  `waiting_trainee_limit` int(11) NOT NULL DEFAULT '0' COMMENT '예약 대기 인원 수',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_process` tinyint(1) NOT NULL DEFAULT '0' COMMENT '연장/폐강 처리 여부',
  `division` varchar(255) DEFAULT NULL,
  `booking_deadline` smallint(5) unsigned NOT NULL DEFAULT '0',
  `cancel_deadline` smallint(5) unsigned NOT NULL DEFAULT '0',
  `daily_booking_change_deadline` smallint(6) NOT NULL DEFAULT '0' COMMENT '당일 예약 변경 제한시간',
  `coupon_deduction` tinyint(1) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `closed_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `autoclose_deadline` int(6) NOT NULL DEFAULT '0' COMMENT '그룹수업 인원미달 폐강시간 시점',
  `rule_type` enum('R','A','RR','AR') DEFAULT 'R',
  `group_booking_cancel_rule_type` enum('A','AR','R','RR') NOT NULL DEFAULT 'R' COMMENT '그륍 취소 예약 룰',
  `private_booking_cancel_rule_type` enum('A','AR','R','RR') NOT NULL DEFAULT 'R' COMMENT '프라이빗 취소 예약 룰',
  `group_booking_rule_type` enum('A','AR','R','RR') NOT NULL DEFAULT 'R' COMMENT '그룹 예약 룰',
  `private_booking_rule_type` enum('A','AR','R','RR') NOT NULL DEFAULT 'R' COMMENT '프라이빗 예약 룰',
  `private_booking_startline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 프라이빗 예약 가능 시작 시간',
  `private_booking_cancel_startline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 프라이빗 취소 가능 시작 시간',
  `group_booking_startline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 그룹 예약 가능 시작 시간',
  `group_booking_cancel_startline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 그룹 취소 가능 시작 시간',
  `private_booking_deadline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 프라이빗 예약 가능 종료 시간',
  `group_booking_deadline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 프라이빗 취소 가능 종료 시간',
  `group_booking_cancel_deadline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 그룹 예약 가능 종료 시간',
  `private_booking_cancel_deadline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 그룹 취소 가능 종료 시간',
  `private_booking_start_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 예약 시작 가능 일',
  `private_booking_start_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 예약 시작 가능 시간',
  `private_booking_end_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 예약 가능 종료 일',
  `private_booking_end_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 예약 가능 종료 시간',
  `private_booking_cancel_start_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 취소 시작 가능 일',
  `private_booking_cancel_start_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 취소 시작 가능 시간',
  `private_booking_cancel_end_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 취소 가능 종료 일',
  `private_booking_cancel_end_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 취소 가능 종료 시간',
  `group_booking_start_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 예약 시작 가능 일',
  `group_booking_start_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 예약 시작 가능 시간',
  `group_booking_end_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 예약 가능 종료 일',
  `group_booking_end_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 예약 가능 종료 시간',
  `enter_start_deadline` int(11) DEFAULT NULL COMMENT '입장 가능 시작 시간',
  `enter_end_deadline` int(11) DEFAULT NULL COMMENT '입장 가능 종료 시간',
  `group_booking_cancel_start_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 취소 시작 가능 일',
  `group_booking_cancel_start_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 취소 시작 가능 시간',
  `group_booking_cancel_end_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 취소 가능 종료 일',
  `group_booking_cancel_end_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 취소 가능 종료 시간',
  PRIMARY KEY (`id`),
  KEY `courses_division_id_foreign` (`division_id`),
  KEY `courses_instructor_id_foreign` (`instructor_id`),
  KEY `courses_room_id_foreign` (`room_id`),
  KEY `courses_studio_id_foreign` (`studio_id`),
  KEY `courses_division_index` (`division`),
  KEY `courses_end_date_index` (`end_date`),
  KEY `courses_facility_id_foreign` (`facility_id`),
  KEY `courses_start_date_index` (`start_date`),
  KEY `courses_type_index` (`type`),
  CONSTRAINT `courses_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `courses_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `courses_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `courses_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `staff_id` int(10) unsigned NOT NULL,
  `token` varchar(255) DEFAULT NULL COMMENT '결제키',
  `card_name` varchar(255) DEFAULT NULL COMMENT '카드명',
  `card_number` varchar(255) DEFAULT NULL COMMENT '번호',
  `email` varchar(255) DEFAULT NULL COMMENT '이메일',
  `status` enum('complete','request','fail') NOT NULL COMMENT '발급상태',
  `message` varchar(255) DEFAULT NULL COMMENT '실패, 성공 및 사유',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `credit_card_staff_id_foreign` (`staff_id`),
  KEY `credit_card_studio_id_foreign` (`studio_id`),
  CONSTRAINT `credit_card_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `studio_users` (`id`),
  CONSTRAINT `credit_card_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily_bookings`
--

DROP TABLE IF EXISTS `daily_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_ticket_id` int(10) unsigned NOT NULL COMMENT '유저 수강권 ID',
  `studio_id` int(10) unsigned NOT NULL COMMENT '스튜디오 ID',
  `updated_by` int(10) unsigned NOT NULL COMMENT '변경 유저 ID',
  `old_lecture_id` int(10) unsigned DEFAULT NULL COMMENT '이전 전 수업 ID',
  `new_lecture_id` int(10) unsigned DEFAULT NULL COMMENT '이전 후 수업 ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `daily_bookings_new_lecture_id_index` (`new_lecture_id`),
  KEY `daily_bookings_old_lecture_id_index` (`old_lecture_id`),
  KEY `daily_bookings_studio_id_index` (`studio_id`),
  KEY `daily_bookings_updated_by_index` (`updated_by`),
  KEY `daily_bookings_user_ticket_id_index` (`user_ticket_id`),
  CONSTRAINT `daily_bookings_new_lecture_id_foreign` FOREIGN KEY (`new_lecture_id`) REFERENCES `lectures` (`id`),
  CONSTRAINT `daily_bookings_old_lecture_id_foreign` FOREIGN KEY (`old_lecture_id`) REFERENCES `lectures` (`id`),
  CONSTRAINT `daily_bookings_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `daily_bookings_user_ticket_id_foreign` FOREIGN KEY (`user_ticket_id`) REFERENCES `user_tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `division_ticket`
--

DROP TABLE IF EXISTS `division_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `division_ticket` (
  `ticket_id` int(10) unsigned NOT NULL COMMENT '티켓 ID',
  `division_id` int(10) unsigned NOT NULL COMMENT '수업구분 ID',
  KEY `division_ticket_division_id_foreign` (`division_id`),
  KEY `division_ticket_ticket_id_foreign` (`ticket_id`),
  CONSTRAINT `division_ticket_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `division_ticket_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `divisions`
--

DROP TABLE IF EXISTS `divisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `divisions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '스튜디오 ID',
  `title` varchar(255) NOT NULL COMMENT '수업 구분명',
  `updated_for` int(10) unsigned DEFAULT NULL COMMENT '수정 강사',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `divisions_studio_id_foreign` (`studio_id`),
  KEY `divisions_updated_for_foreign` (`updated_for`),
  CONSTRAINT `divisions_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `divisions_updated_for_foreign` FOREIGN KEY (`updated_for`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_exceptions`
--

DROP TABLE IF EXISTS `event_exceptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_exceptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `event_id` int(10) unsigned NOT NULL,
  `origin_start_datetime` datetime NOT NULL,
  `is_rescheduled` tinyint(1) NOT NULL,
  `is_cancelled` tinyint(1) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_full_day_event` tinyint(1) NOT NULL,
  `modified_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_exceptions_studio_id_foreign` (`studio_id`),
  CONSTRAINT `event_exceptions_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_recurring_patterns`
--

DROP TABLE IF EXISTS `event_recurring_patterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_recurring_patterns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `event_id` int(10) unsigned NOT NULL,
  `recurring_type_id` int(10) unsigned DEFAULT NULL,
  `separation_count` tinyint(3) unsigned NOT NULL,
  `max_num_of_occurrences` tinyint(3) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `until_date` date DEFAULT NULL,
  `legal_holiday` tinyint(1) NOT NULL,
  `day_of_week` tinyint(3) unsigned DEFAULT NULL,
  `week_of_month` enum('1','2','3','4','5','-1','-2','-3','-4','-5') DEFAULT NULL,
  `day_of_month` tinyint(3) unsigned DEFAULT NULL,
  `month_of_year` enum('1','2','3','4','5','6','7','8','9','10','11','12') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_recurring_patterns_studio_id_foreign` (`studio_id`),
  CONSTRAINT `event_recurring_patterns_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_recurring_types`
--

DROP TABLE IF EXISTS `event_recurring_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_recurring_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `recurring_type` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  `schedule_type` enum('course','lecture','counsel','facilityOpenedHour','staffWorkingHour','facilityClosedHour','staffRestHour') DEFAULT NULL,
  `schedule_id` int(10) unsigned DEFAULT NULL,
  `start_on` timestamp NULL DEFAULT NULL,
  `end_on` timestamp NULL DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_full_day_event` tinyint(1) NOT NULL,
  `is_recurring` tinyint(1) NOT NULL,
  `parent_event_id` int(10) unsigned DEFAULT NULL COMMENT 'max depth : 1',
  `created_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `events_studio_id_foreign` (`studio_id`),
  KEY `events_end_on_index` (`end_on`),
  KEY `events_facility_id_foreign` (`facility_id`),
  KEY `events_schedule_type_schedule_id_index` (`schedule_type`,`schedule_id`),
  KEY `events_start_date_index` (`start_date`),
  KEY `events_start_on_index` (`start_on`),
  CONSTRAINT `events_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facilities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` text,
  `crn` varchar(10) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `tlx_pass_id` varchar(15) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `old_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facilities_studio_id_foreign` (`studio_id`),
  CONSTRAINT `facilities_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_amenities`
--

DROP TABLE IF EXISTS `facility_amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility_amenities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  `amenity_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facility_amenities_studio_id_foreign` (`studio_id`),
  KEY `facility_amenities_facility_id_foreign` (`facility_id`),
  CONSTRAINT `facility_amenities_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_closed_hours`
--

DROP TABLE IF EXISTS `facility_closed_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility_closed_hours` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facility_closed_hours_studio_id_foreign` (`studio_id`),
  KEY `facility_closed_hours_facility_id_foreign` (`facility_id`),
  CONSTRAINT `facility_closed_hours_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_opened_hours`
--

DROP TABLE IF EXISTS `facility_opened_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility_opened_hours` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facility_opened_hours_studio_id_foreign` (`studio_id`),
  KEY `facility_opened_hours_facility_id_foreign` (`facility_id`),
  CONSTRAINT `facility_opened_hours_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_policies`
--

DROP TABLE IF EXISTS `facility_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility_policies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  `booking_deadline` smallint(5) unsigned NOT NULL,
  `booking_cancel_deadline` smallint(5) unsigned NOT NULL,
  `is_ticket_expire_sms_noti` tinyint(1) NOT NULL,
  `is_ticket_expire_push_noti` tinyint(1) NOT NULL,
  `ticket_expire_noti_term` smallint(5) unsigned NOT NULL,
  `is_remainder_coupon_sms_noti` tinyint(1) NOT NULL,
  `is_remainder_coupon_push_noti` tinyint(1) NOT NULL,
  `remainder_coupon_noti_count` smallint(5) unsigned NOT NULL,
  `is_reminder_course_sms_noti` tinyint(1) NOT NULL,
  `is_reminder_course_push_noti` tinyint(1) NOT NULL,
  `reminder_course_noti_term` smallint(5) unsigned NOT NULL,
  `is_reminder_counseling_sms_noti` tinyint(1) NOT NULL,
  `is_reminder_counseling_push_noti` tinyint(1) NOT NULL,
  `reminder_counseling_noti_term` smallint(5) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facility_policies_studio_id_foreign` (`studio_id`),
  KEY `facility_policies_facility_id_foreign` (`facility_id`),
  CONSTRAINT `facility_policies_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_rooms`
--

DROP TABLE IF EXISTS `facility_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `capacity` tinyint(3) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facility_rooms_studio_id_foreign` (`studio_id`),
  KEY `facility_rooms_facility_id_foreign` (`facility_id`),
  CONSTRAINT `facility_rooms_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_messages`
--

DROP TABLE IF EXISTS `group_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '시설 아이디',
  `target_user_count` int(11) NOT NULL DEFAULT '0' COMMENT '대상 유저수',
  `message` text NOT NULL COMMENT 'message 내용',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '보냄 여부',
  `send_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '보내는 시간',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_messages_studio_id_foreign` (`studio_id`),
  CONSTRAINT `group_messages_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kakao_messages`
--

DROP TABLE IF EXISTS `kakao_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kakao_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL COMMENT 'message 내용',
  `cmid` varchar(255) NOT NULL COMMENT 'cmid',
  `result` json DEFAULT NULL COMMENT '결과 등록(1) / 검수요청(2)\n승인(3) / 반려(4) / 승인중단(5)',
  `phone` varchar(30) NOT NULL COMMENT '전화번호',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `lecture_view`
--

DROP TABLE IF EXISTS `lecture_view`;
/*!50001 DROP VIEW IF EXISTS `lecture_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `lecture_view` AS SELECT 
 1 AS `id`,
 1 AS `studio_id`,
 1 AS `course_id`,
 1 AS `instructor_id`,
 1 AS `min_trainee`,
 1 AS `max_trainee`,
 1 AS `current_trainee_count`,
 1 AS `coupon_deduction`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `deleted_at`,
 1 AS `start_on`,
 1 AS `end_on`,
 1 AS `event_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `lectures`
--

DROP TABLE IF EXISTS `lectures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lectures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `type` enum('P','G','C') DEFAULT NULL COMMENT 'P : private, G : group, C : course',
  `title` varchar(300) DEFAULT NULL COMMENT '수업 제목',
  `course_id` int(10) unsigned DEFAULT NULL,
  `instructor_id` int(10) unsigned DEFAULT NULL,
  `room_id` int(10) unsigned DEFAULT NULL COMMENT '룸 ID',
  `booking_closed_at` timestamp NULL DEFAULT NULL COMMENT '예약 마감시간',
  `division_id` int(10) unsigned DEFAULT NULL COMMENT '수업 구분 ID',
  `attendance_type` enum('attendance','absence','noshow') NOT NULL DEFAULT 'attendance' COMMENT '수업 시간 시작시 booking 기본값 설정',
  `is_booking_only` tinyint(1) DEFAULT '1' COMMENT '예약전용',
  `start_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `min_trainee` tinyint(3) unsigned DEFAULT NULL,
  `max_trainee` tinyint(3) unsigned DEFAULT NULL,
  `current_trainee_count` tinyint(3) unsigned NOT NULL,
  `total_current_trainee_count` int(11) NOT NULL DEFAULT '0' COMMENT '노쇼/결석을 포함한 현재 윈원',
  `waiting_trainee_limit` int(11) DEFAULT NULL COMMENT '예약 최대가능 제한',
  `coupon_deduction` tinyint(1) DEFAULT NULL,
  `booking_start_at` timestamp NULL DEFAULT NULL COMMENT '예약 가능 시작 시간',
  `booking_end_at` timestamp NULL DEFAULT NULL COMMENT '예약 가능 종료 시간',
  `enter_start_at` timestamp NULL DEFAULT NULL COMMENT '입장 가능 시작 시간',
  `enter_end_at` timestamp NULL DEFAULT NULL COMMENT '입장 가능 종료 시간',
  `booking_cancel_start_at` timestamp NULL DEFAULT NULL COMMENT '예약 취소 가능 시작 시간',
  `booking_cancel_end_at` timestamp NULL DEFAULT NULL COMMENT '예약 취소 가능 종료 시간',
  `daily_change_booking_end_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '예약 변경 가능 시간',
  `autoclose_at` timestamp NULL DEFAULT NULL COMMENT '폐강시간',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_for` varchar(60) DEFAULT NULL COMMENT '삭제 사유',
  `deleted_by` int(11) DEFAULT NULL COMMENT '삭제 행위자',
  PRIMARY KEY (`id`),
  KEY `lectures_course_id_foreign` (`course_id`),
  KEY `lectures_instructor_id_foreign` (`instructor_id`),
  KEY `lectures_room_id_foreign` (`room_id`),
  KEY `lectures_studio_id_foreign` (`studio_id`),
  KEY `end_on` (`end_on`),
  KEY `lectures_division_id_max_trainee_index` (`division_id`,`max_trainee`),
  CONSTRAINT `lectures_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `lectures_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lectures_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `lectures_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lectures_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lectures_20180927`
--

DROP TABLE IF EXISTS `lectures_20180927`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lectures_20180927` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `course_id` int(10) unsigned NOT NULL,
  `instructor_id` int(10) unsigned DEFAULT NULL,
  `min_trainee` tinyint(3) unsigned DEFAULT NULL,
  `max_trainee` tinyint(3) unsigned DEFAULT NULL,
  `current_trainee_count` tinyint(3) unsigned NOT NULL,
  `coupon_deduction` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `legal_holidays`
--

DROP TABLE IF EXISTS `legal_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `legal_holidays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `legal_holidays_title_date_unique` (`title`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lockers`
--

DROP TABLE IF EXISTS `lockers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lockers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '시설 ID',
  `member_id` int(10) unsigned DEFAULT NULL COMMENT '회원 ID',
  `no` int(11) NOT NULL DEFAULT '0' COMMENT '번호',
  `name` varchar(150) DEFAULT NULL COMMENT '사물함 명',
  `status` enum('USE','REPAIR','IMPOSSIBLE') NOT NULL DEFAULT 'USE' COMMENT '사물함 상태',
  `type` enum('TERM','DAILY') NOT NULL DEFAULT 'DAILY' COMMENT '사물함 종류',
  `etc` varchar(255) NOT NULL COMMENT '비고',
  `start_on` timestamp NULL DEFAULT NULL COMMENT '이용 시작일',
  `end_on` timestamp NULL DEFAULT NULL COMMENT '이용 종료일',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lockers_member_id_foreign` (`member_id`),
  KEY `lockers_studio_id_foreign` (`studio_id`),
  CONSTRAINT `lockers_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `studio_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lockers_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login_histories`
--

DROP TABLE IF EXISTS `login_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_type` enum('staffAccount','userAccount') NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `logined_at` datetime NOT NULL,
  `client_ip` varchar(45) NOT NULL,
  `user_agent` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_account_sync_tokens`
--

DROP TABLE IF EXISTS `member_account_sync_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_account_sync_tokens` (
  `studio_user_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(30) NOT NULL,
  `created_at` datetime NOT NULL,
  UNIQUE KEY `member_account_sync_tokens_studio_user_id_unique` (`studio_user_id`),
  UNIQUE KEY `member_account_sync_tokens_token_unique` (`token`),
  CONSTRAINT `member_account_sync_tokens_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_profiles`
--

DROP TABLE IF EXISTS `member_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `studio_user_id` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `gender` enum('F','M') DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `registered_at` datetime DEFAULT NULL,
  `last_attendance_at` timestamp NULL DEFAULT NULL COMMENT '최근 출석일',
  `memo` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_profiles_studio_id_foreign` (`studio_id`),
  KEY `member_profiles_name_index` (`name`),
  KEY `studio_user_id` (`studio_user_id`),
  CONSTRAINT `member_profiles_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `member_profiles_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `member_view`
--

DROP TABLE IF EXISTS `member_view`;
/*!50001 DROP VIEW IF EXISTS `member_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `member_view` AS SELECT 
 1 AS `id`,
 1 AS `studio_id`,
 1 AS `name`,
 1 AS `studio_name`,
 1 AS `mobile`,
 1 AS `email`,
 1 AS `account_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `member_view_temp`
--

DROP TABLE IF EXISTS `member_view_temp`;
/*!50001 DROP VIEW IF EXISTS `member_view_temp`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `member_view_temp` AS SELECT 
 1 AS `id`,
 1 AS `studio_id`,
 1 AS `name`,
 1 AS `studio_name`,
 1 AS `mobile`,
 1 AS `email`,
 1 AS `account_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `memo`
--

DROP TABLE IF EXISTS `memo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `memo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ref_type` varchar(255) NOT NULL,
  `ref_id` bigint(20) unsigned NOT NULL,
  `studio_user_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `memo` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `memo_studio_user_id_foreign` (`studio_user_id`),
  KEY `memo_ref_type_ref_id_type_index` (`ref_type`,`ref_id`,`type`),
  KEY `ref` (`ref_id`,`ref_type`),
  CONSTRAINT `memo_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices`
--

DROP TABLE IF EXISTS `notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL COMMENT '제목',
  `context` text NOT NULL COMMENT '내용',
  `notag_context` text COMMENT '태그 제거',
  `start_date` date NOT NULL COMMENT '시작일',
  `end_date` date NOT NULL COMMENT '종료일',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '사용여부',
  `is_desktop` tinyint(1) NOT NULL DEFAULT '1',
  `is_mobile` tinyint(1) NOT NULL DEFAULT '1',
  `target` varchar(255) NOT NULL COMMENT '대상자',
  `created_by` varchar(255) NOT NULL COMMENT '작성자',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `product_tag_id` int(10) unsigned NOT NULL,
  `quantity` tinyint(3) unsigned NOT NULL,
  `original_price` mediumint(8) unsigned NOT NULL,
  `actual_price` mediumint(8) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_items_id_unique` (`id`),
  KEY `order_items_order_id_index` (`order_id`),
  KEY `order_items_product_tag_id_index` (`product_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `orderer_id` int(10) unsigned NOT NULL,
  `transactor_id` int(10) unsigned DEFAULT NULL,
  `applied_promotion_id` int(10) unsigned DEFAULT NULL,
  `status` enum('payment_waiting','payment_complete','complete','cancel') NOT NULL,
  `total_price` mediumint(8) unsigned NOT NULL,
  `memo` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_id_unique` (`id`),
  KEY `orders_studio_id_foreign` (`studio_id`),
  KEY `orders_status_index` (`status`),
  CONSTRAINT `orders_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `owner_addresses`
--

DROP TABLE IF EXISTS `owner_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owner_addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `owner_type` enum('studio','member','staff') DEFAULT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `postcode` varchar(5) DEFAULT NULL COMMENT '5자리 우편번호',
  `address` varchar(200) DEFAULT NULL,
  `sido` varchar(15) DEFAULT NULL,
  `sigungu` varchar(20) DEFAULT NULL,
  `roadname` varchar(30) DEFAULT NULL,
  `detail_address` varchar(100) DEFAULT NULL,
  `lat` double(17,14) DEFAULT NULL,
  `lng` double(17,14) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_addresses_studio_id_foreign` (`studio_id`),
  CONSTRAINT `owner_addresses_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `owner_avatars`
--

DROP TABLE IF EXISTS `owner_avatars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owner_avatars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner_type` enum('studio','facility','userAccount','member','staff') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `is_representative` tinyint(1) NOT NULL,
  `image` varchar(200) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `owner_contact_infos`
--

DROP TABLE IF EXISTS `owner_contact_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owner_contact_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner_type` enum('studio','facility','userAccount','member','staff') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `type_id` tinyint(3) unsigned NOT NULL,
  `contact` varchar(255) NOT NULL,
  `is_representative` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_type` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `owner_credit_cards`
--

DROP TABLE IF EXISTS `owner_credit_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owner_credit_cards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `owner_type` enum('studio','member') NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `brand` varchar(200) NOT NULL,
  `last_four` varchar(200) NOT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_credit_cards_studio_id_foreign` (`studio_id`),
  CONSTRAINT `owner_credit_cards_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '구매자',
  `transfer_user_id` int(10) unsigned DEFAULT NULL COMMENT '양도자',
  `order_id` int(10) unsigned NOT NULL,
  `order_no` varchar(255) DEFAULT NULL COMMENT '주문번호',
  `trno` varchar(255) DEFAULT NULL COMMENT 'ksPay 내려주는 고유 id',
  `goods_type` varchar(255) NOT NULL DEFAULT 'user_tickets' COMMENT '상품 종류',
  `goods_id` int(10) unsigned DEFAULT NULL COMMENT '상품 ID',
  `parent_type` varchar(255) DEFAULT NULL COMMENT '상품 id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT '상품 id',
  `status` enum('purchase','refund','upgrade','downgrade','extension','pending','installment_payment','full_payment') NOT NULL COMMENT '상품 상태',
  `amount` mediumint(8) unsigned NOT NULL,
  `cash_amount` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `wiretransfer_amount` mediumint(9) NOT NULL DEFAULT '0' COMMENT '계좌이체로 결제',
  `transfer_amount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '양도금',
  `card_amount` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `unpaid_amount` mediumint(8) NOT NULL DEFAULT '0' COMMENT '미납금',
  `method` enum('cash','card','mixed') NOT NULL,
  `installment_period` tinyint(3) unsigned NOT NULL COMMENT '할부',
  `model_preview` text COMMENT '마지막 상태 저장',
  `settlement_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payments_id_unique` (`id`),
  KEY `payments_studio_id_foreign` (`studio_id`),
  KEY `payments_user_id_foreign` (`user_id`),
  KEY `goods` (`goods_id`,`goods_type`),
  KEY `parent` (`parent_id`,`parent_type`),
  KEY `payments_method_index` (`method`),
  KEY `payments_order_id_index` (`order_id`),
  CONSTRAINT `payments_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `studio_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission_role_templates`
--

DROP TABLE IF EXISTS `permission_role_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role_templates` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission_types`
--

DROP TABLE IF EXISTS `permission_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_types_id_unique` (`id`),
  UNIQUE KEY `permission_types_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission_user`
--

DROP TABLE IF EXISTS `permission_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_user` (
  `permission_id` int(10) unsigned NOT NULL,
  `studio_user_id` int(10) unsigned NOT NULL,
  `user_type` varchar(255) NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  UNIQUE KEY `pu_unique` (`studio_user_id`,`permission_id`,`user_type`,`facility_id`),
  KEY `permission_user_facility_id_foreign` (`facility_id`),
  CONSTRAINT `permission_user_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permission_user_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` tinyint(3) unsigned NOT NULL,
  `parent_id` int(10) NOT NULL DEFAULT '0' COMMENT '상위 권한',
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_id_unique` (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `display_title` varchar(255) NOT NULL,
  `description` text,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_tags`
--

DROP TABLE IF EXISTS `product_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `original_price` int(11) DEFAULT NULL,
  `actual_price` int(11) NOT NULL,
  `is_promotion` tinyint(1) NOT NULL,
  `is_stock_infinite` tinyint(1) NOT NULL,
  `stock` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_tags_studio_id_foreign` (`studio_id`),
  KEY `product_tags_product_id_index` (`product_id`),
  CONSTRAINT `product_tags_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned DEFAULT NULL,
  `goods_type` enum('ticket','goods','sms','subscription') DEFAULT NULL,
  `goods_id` int(10) unsigned DEFAULT NULL,
  `actual_price` int(11) NOT NULL DEFAULT '0',
  `original_price` int(11) NOT NULL DEFAULT '0',
  `is_selling` tinyint(1) NOT NULL DEFAULT '1',
  `is_selling_term_infinite` tinyint(1) NOT NULL,
  `selling_start_at` datetime DEFAULT NULL,
  `selling_end_at` datetime DEFAULT NULL,
  `is_promotion` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_studio_id_foreign` (`studio_id`),
  KEY `products_goods_id_index` (`goods_id`),
  KEY `products_goods_type_index` (`goods_type`),
  CONSTRAINT `products_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_codes`
--

DROP TABLE IF EXISTS `qr_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qr_codes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '스튜디오 ID',
  `user_id` int(10) unsigned NOT NULL COMMENT '유저 아이디',
  `user_ticket_id` int(10) unsigned NOT NULL COMMENT '유저 티켓 아이디',
  `expire_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '만료시간',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `qr_codes_studio_id_foreign` (`studio_id`),
  KEY `qr_codes_user_id_foreign` (`user_id`),
  KEY `qr_codes_user_ticket_id_foreign` (`user_ticket_id`),
  CONSTRAINT `qr_codes_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `qr_codes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `qr_codes_user_ticket_id_foreign` FOREIGN KEY (`user_ticket_id`) REFERENCES `user_tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_templates`
--

DROP TABLE IF EXISTS `role_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `is_immutable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_templates_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_user` (
  `role_id` int(10) unsigned NOT NULL,
  `studio_user_id` int(10) unsigned NOT NULL,
  `user_type` varchar(100) NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  UNIQUE KEY `role_user_studio_user_id_role_id_user_type_facility_id_unique` (`studio_user_id`,`role_id`,`user_type`,`facility_id`),
  KEY `role_user_facility_id_foreign` (`facility_id`),
  CONSTRAINT `role_user_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `is_immutable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_id_unique` (`id`),
  KEY `roles_studio_id_foreign` (`studio_id`),
  CONSTRAINT `roles_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '시설 ID',
  `name` varchar(150) NOT NULL DEFAULT '' COMMENT '룸 이름',
  `updated_for` int(10) unsigned NOT NULL COMMENT '행위자 ID',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rooms_studio_id_foreign` (`studio_id`),
  CONSTRAINT `rooms_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '상품명',
  `quantity` int(11) NOT NULL COMMENT '충전 횟수',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms_log`
--

DROP TABLE IF EXISTS `sms_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_sms_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `msg_type` varchar(255) DEFAULT NULL COMMENT 'LMS 인지 SMS인지',
  `message` text COMMENT '내용',
  `toto` varchar(255) DEFAULT NULL COMMENT '받는이',
  `fromfrom` varchar(255) DEFAULT NULL COMMENT '발송인',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_account_create_tokens`
--

DROP TABLE IF EXISTS `staff_account_create_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_account_create_tokens` (
  `studio_user_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(30) NOT NULL,
  `created_at` datetime NOT NULL,
  UNIQUE KEY `staff_account_create_tokens_studio_user_id_unique` (`studio_user_id`),
  UNIQUE KEY `staff_account_create_tokens_token_unique` (`token`),
  CONSTRAINT `staff_account_create_tokens_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_account_password_resets`
--

DROP TABLE IF EXISTS `staff_account_password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_account_password_resets` (
  `staff_account_id` varchar(255) NOT NULL,
  `identity` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `staff_account_password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_accounts`
--

DROP TABLE IF EXISTS `staff_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `identity` varchar(64) NOT NULL,
  `password` varchar(200) NOT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `web_token` varchar(255) DEFAULT NULL COMMENT '웹 FCM TOKEN',
  `app_type` char(1) DEFAULT NULL,
  `app_version` varchar(30) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `recent_password_changed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_accounts_studio_id_foreign` (`studio_id`),
  CONSTRAINT `staff_accounts_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_careers`
--

DROP TABLE IF EXISTS `staff_careers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_careers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `studio_user_id` int(10) unsigned NOT NULL,
  `index` tinyint(3) unsigned NOT NULL,
  `career` varchar(200) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_careers_studio_id_foreign` (`studio_id`),
  KEY `staff_careers_studio_user_id_foreign` (`studio_user_id`),
  CONSTRAINT `staff_careers_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `staff_careers_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_notice`
--

DROP TABLE IF EXISTS `staff_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_notice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL,
  `msg_type` varchar(150) DEFAULT NULL COMMENT '발송 종류',
  `ref_type` varchar(255) NOT NULL,
  `ref_id` bigint(20) unsigned NOT NULL,
  `message` text NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `checked_at` timestamp NULL DEFAULT NULL,
  `is_checked` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `staff_notice_staff_id_foreign` (`staff_id`),
  KEY `staff_notice_created_at_index` (`created_at`),
  KEY `staff_notice_ref_type_ref_id_index` (`ref_type`,`ref_id`),
  CONSTRAINT `staff_notice_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_profiles`
--

DROP TABLE IF EXISTS `staff_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `studio_user_id` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `self_introduction` text,
  `representative_color` varchar(6) DEFAULT 'f95454',
  `hired_at` varchar(255) DEFAULT NULL,
  `get_noti_all` tinyint(1) NOT NULL DEFAULT '0' COMMENT '시설에 다른 강사의 알림을 모두 받음',
  `registered_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_profiles_studio_id_foreign` (`studio_id`),
  KEY `staff_profiles_studio_user_id_foreign` (`studio_user_id`),
  CONSTRAINT `staff_profiles_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `staff_profiles_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_rest_hours`
--

DROP TABLE IF EXISTS `staff_rest_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_rest_hours` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  `studio_user_id` int(10) unsigned NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_rest_hours_studio_id_foreign` (`studio_id`),
  KEY `staff_rest_hours_studio_user_id_foreign` (`studio_user_id`),
  KEY `staff_rest_hours_facility_id_foreign` (`facility_id`),
  CONSTRAINT `staff_rest_hours_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `staff_rest_hours_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_schedules`
--

DROP TABLE IF EXISTS `staff_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_schedules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '시설 아이디',
  `staff_id` int(10) unsigned NOT NULL COMMENT '강사 아이디',
  `date` date DEFAULT NULL COMMENT '요일',
  `type` enum('workTime','restTime','eventWorkTime','eventRestTime') NOT NULL COMMENT '강사 스케쥴 구분',
  `day_of_week` int(11) NOT NULL COMMENT '요일',
  `start_time` time NOT NULL COMMENT '시작 시간',
  `end_time` time NOT NULL COMMENT '종료 시간',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_schedules_staff_id_foreign` (`staff_id`),
  KEY `staff_schedules_studio_id_foreign` (`studio_id`),
  CONSTRAINT `staff_schedules_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_schedules_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_user_ticket`
--

DROP TABLE IF EXISTS `staff_user_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_user_ticket` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL COMMENT '강사 아이디',
  `user_ticket_id` int(10) unsigned NOT NULL COMMENT '수강권 아이디',
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `user_ticket_id` (`user_ticket_id`),
  CONSTRAINT `staff_user_ticket_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `studio_users` (`id`),
  CONSTRAINT `staff_user_ticket_ibfk_2` FOREIGN KEY (`user_ticket_id`) REFERENCES `user_tickets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `staff_view`
--

DROP TABLE IF EXISTS `staff_view`;
/*!50001 DROP VIEW IF EXISTS `staff_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `staff_view` AS SELECT 
 1 AS `studio_name`,
 1 AS `name`,
 1 AS `contact`,
 1 AS `identity`,
 1 AS `id`,
 1 AS `studio_id`,
 1 AS `account_type`,
 1 AS `account_id`,
 1 AS `mobile`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `deleted_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `staff_working_hours`
--

DROP TABLE IF EXISTS `staff_working_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_working_hours` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `facility_id` int(10) unsigned DEFAULT '0',
  `studio_user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_working_hours_studio_id_foreign` (`studio_id`),
  KEY `staff_working_hours_studio_user_id_foreign` (`studio_user_id`),
  KEY `staff_working_hours_facility_id_foreign` (`facility_id`),
  CONSTRAINT `staff_working_hours_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `staff_working_hours_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_holiday`
--

DROP TABLE IF EXISTS `studio_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_holiday` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `not_action_auto_balance` tinyint(1) NOT NULL DEFAULT '0' COMMENT '자동차감 사용안함',
  `color` varchar(10) NOT NULL DEFAULT 'f95454' COMMENT '사유 컬러',
  `reason` varchar(255) NOT NULL DEFAULT '휴일 입니다.' COMMENT '사유',
  `studio_user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `studio_holiday_studio_id_date_deleted_at_unique` (`studio_id`,`date`,`deleted_at`),
  KEY `studio_holiday_studio_user_id_foreign` (`studio_user_id`),
  KEY `studio_holiday_deleted_at_index` (`deleted_at`),
  CONSTRAINT `studio_holiday_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `studio_holiday_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_message`
--

DROP TABLE IF EXISTS `studio_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `studio_user_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `send_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(255) DEFAULT NULL,
  `member_filter` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `studio_message_studio_id_foreign` (`studio_id`),
  KEY `studio_message_studio_user_id_foreign` (`studio_user_id`),
  KEY `studio_message_deleted_at_index` (`deleted_at`),
  KEY `studio_message_send_on_index` (`send_on`),
  KEY `studio_message_status_index` (`status`),
  CONSTRAINT `studio_message_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `studio_message_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_message_target`
--

DROP TABLE IF EXISTS `studio_message_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_message_target` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `studio_message_id` bigint(20) unsigned NOT NULL,
  `studio_user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `studio_message_target_studio_message_id_foreign` (`studio_message_id`),
  KEY `studio_message_target_studio_user_id_foreign` (`studio_user_id`),
  CONSTRAINT `studio_message_target_studio_message_id_foreign` FOREIGN KEY (`studio_message_id`) REFERENCES `studio_message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `studio_message_target_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_plans`
--

DROP TABLE IF EXISTS `studio_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `plan_id` int(10) unsigned NOT NULL,
  `paid_number_of_facility` smallint(5) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `studio_plans_studio_id_foreign` (`studio_id`),
  CONSTRAINT `studio_plans_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_policies`
--

DROP TABLE IF EXISTS `studio_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_policies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `booking_limit_day_term` smallint(5) unsigned NOT NULL,
  `booking_limit_date` timestamp NULL DEFAULT NULL,
  `private_booking_limit_day_term` smallint(5) unsigned NOT NULL COMMENT '프라이빗 수업 예약 연장 일수',
  `private_booking_limit_date` timestamp NULL DEFAULT NULL COMMENT '프라이빗 수업 예약 가능 기한',
  `private_using_booking_limit_detail_option` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'private 고급설정 사용 유무',
  `private_booking_limit_day_term_time` time NOT NULL DEFAULT '15:00:00' COMMENT '예약가능기한 일반설정 시간',
  `group_booking_limit_day_term` smallint(5) unsigned NOT NULL COMMENT '그룹 수업 예약 연장 일수',
  `group_booking_limit_date` timestamp NULL DEFAULT NULL COMMENT '그룹 수업 예약 가능 기한',
  `group_using_booking_limit_detail_option` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'group 고급설정 사용 유무',
  `group_booking_limit_day_term_time` time NOT NULL DEFAULT '15:00:00' COMMENT '예약가능기한 일반설정 시간',
  `booking_limit_time` varchar(8) NOT NULL DEFAULT '00:00:00' COMMENT '오픈시간 자동 갱신 시간',
  `private_booking_deadline` smallint(5) unsigned NOT NULL,
  `group_booking_deadline` smallint(5) unsigned NOT NULL,
  `private_booking_cancel_deadline` smallint(5) unsigned NOT NULL,
  `group_booking_cancel_deadline` smallint(5) unsigned NOT NULL,
  `is_ticket_expire_sms_noti` tinyint(1) NOT NULL,
  `is_ticket_expire_push_noti` tinyint(1) NOT NULL,
  `is_show_current_count` tinyint(1) NOT NULL DEFAULT '1' COMMENT '사용자에게 현재 인원을 표시할것인지 여부',
  `ticket_expire_noti_term` smallint(5) unsigned NOT NULL,
  `is_remainder_coupon_sms_noti` tinyint(1) NOT NULL,
  `is_remainder_coupon_push_noti` tinyint(1) NOT NULL,
  `remainder_coupon_noti_count` smallint(5) unsigned NOT NULL,
  `is_reminder_course_sms_noti` tinyint(1) NOT NULL,
  `is_reminder_course_push_noti` tinyint(1) NOT NULL,
  `reminder_course_noti_term` smallint(5) unsigned NOT NULL,
  `is_reminder_counseling_sms_noti` tinyint(1) NOT NULL,
  `is_reminder_counseling_push_noti` tinyint(1) NOT NULL,
  `reminder_counseling_noti_term` smallint(5) unsigned NOT NULL,
  `is_ticket_holding_end_sms_noti` tinyint(1) NOT NULL,
  `is_ticket_holding_end_push_noti` tinyint(1) NOT NULL,
  `reminder_ticket_holding_noti_term` smallint(5) unsigned NOT NULL,
  `is_before_lecture_alarm_sms` tinyint(1) NOT NULL DEFAULT '0',
  `is_before_lecture_alarm_push` tinyint(1) NOT NULL DEFAULT '1',
  `before_lecture_alarm_hour` tinyint(3) unsigned DEFAULT '3' COMMENT '수업시작 알림 Group',
  `before_private_lecture_alarm_hour` tinyint(3) unsigned DEFAULT '3' COMMENT '수업시작 알림 Private',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `weekly_waiting_limit` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `private_start_interval` int(11) DEFAULT '30',
  `daily_booking_limit` int(2) NOT NULL DEFAULT '1',
  `daily_booking_limit_by` enum('daily','ticket') NOT NULL DEFAULT 'ticket' COMMENT '일일 예약 제한 [daily 일일 제한, ticket 티켓으로 제한]',
  `is_daily_booking_limited` tinyint(1) NOT NULL DEFAULT '1',
  `is_use_rooms` tinyint(4) NOT NULL DEFAULT '0' COMMENT '룸 사용',
  `is_enter` tinyint(1) NOT NULL DEFAULT '0' COMMENT '출석기능 사용',
  `is_locker` tinyint(1) NOT NULL DEFAULT '0' COMMENT '락커 사용여부',
  `check_in_msg` varchar(255) DEFAULT NULL COMMENT '체크인 문구',
  `check_in_img` varchar(255) DEFAULT NULL COMMENT '체크인 이미지',
  `enter_start_deadline` int(11) DEFAULT NULL COMMENT '입장 시 마감 시간',
  `enter_end_deadline` int(11) DEFAULT NULL COMMENT '입장 종료 마감 시간',
  `is_use_user_grade` tinyint(1) NOT NULL DEFAULT '0' COMMENT '유저 등급 사용여부',
  `is_visible_qna` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'QnA 게시판 공개여부',
  `is_absence_by_user` tinyint(1) NOT NULL DEFAULT '0' COMMENT '사용자 결석',
  `is_visible_all_lectures` tinyint(1) NOT NULL DEFAULT '0' COMMENT '모든 수업 노출',
  `is_auto_write_unpaid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '미수금 자동 입력',
  `autoclose_deadline` int(11) NOT NULL DEFAULT '0',
  `booking_open_at` varchar(6) NOT NULL DEFAULT '00:00' COMMENT '일일 예약가능 시작 시각. open=00:00 & close=24:00 이면 사용하지 않는 것으로 간주.',
  `booking_close_at` varchar(6) NOT NULL DEFAULT '24:00' COMMENT '일일 예약가능 마감 시각',
  `rule_type` enum('R','A','RR','AR') NOT NULL DEFAULT 'R' COMMENT '예약 규약 구분자 상대성:R / 절대성:A',
  `group_booking_cancel_rule_type` enum('A','AR','R','RR') NOT NULL DEFAULT 'R' COMMENT '그륍 취소 예약 룰',
  `private_booking_cancel_rule_type` enum('A','AR','R','RR') NOT NULL DEFAULT 'R' COMMENT '프라이빗 취소 예약 룰',
  `group_booking_rule_type` enum('A','AR','R','RR') NOT NULL DEFAULT 'R' COMMENT '그룹 예약 룰',
  `private_booking_rule_type` enum('A','AR','R','RR') NOT NULL DEFAULT 'R' COMMENT '프라이빗 예약 룰',
  `private_booking_startline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 프라이빗 예약 가능 시작 시간',
  `private_booking_cancel_startline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 프라이빗 취소 가능 시작 시간',
  `group_booking_startline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 그룹 예약 가능 시작 시간',
  `group_booking_cancel_startline` smallint(5) unsigned DEFAULT NULL COMMENT '[상대] 그룹 취소 가능 시작 시간',
  `private_booking_start_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 예약 시작 가능 일',
  `private_booking_start_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 예약 시작 가능 시간',
  `private_booking_end_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 예약 가능 종료 일',
  `private_booking_end_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 예약 가능 종료 시간',
  `private_booking_cancel_start_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 취소 시작 가능 일',
  `private_booking_cancel_start_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 취소 시작 가능 시간',
  `private_booking_cancel_end_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 취소 가능 종료 일',
  `private_booking_cancel_end_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 프라이빗 취소 가능 종료 시간',
  `group_booking_start_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 예약 시작 가능 일',
  `group_booking_start_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 예약 시작 가능 시간',
  `group_booking_end_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 예약 가능 종료 일',
  `group_booking_end_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 예약 가능 종료 시간',
  `group_booking_cancel_start_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 취소 시작 가능 일',
  `group_booking_cancel_start_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 취소 시작 가능 시간',
  `group_booking_cancel_end_days` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 취소 가능 종료 일',
  `group_booking_cancel_end_time` smallint(5) unsigned DEFAULT NULL COMMENT '[절대] 그룹 취소 가능 종료 시간',
  `daily_booking_change_deadline` smallint(6) NOT NULL DEFAULT '0' COMMENT '[그룹] 당일 예약변경 제한 시간',
  `same_time_max_private_lecture_limit` int(11) DEFAULT NULL COMMENT '동시간대에 최대 생성 가능한 프라빗 수업수',
  PRIMARY KEY (`id`),
  KEY `studio_policies_studio_id_foreign` (`studio_id`),
  KEY `studio_policies_autoclose_deadline_index` (`autoclose_deadline`),
  CONSTRAINT `studio_policies_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_sms`
--

DROP TABLE IF EXISTS `studio_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '스튜디오 ID',
  `staff_id` int(10) unsigned NOT NULL COMMENT '행위자 ID',
  `sms_id` int(10) unsigned DEFAULT NULL COMMENT 'SMS 상품 ID',
  `type` enum('charge','send') NOT NULL COMMENT 'send발송, charge충전',
  `status` varchar(255) DEFAULT NULL COMMENT '결제 상태',
  `sms_type` enum('SMS','LMS','MESSAGE') DEFAULT NULL COMMENT '문자 구분',
  `title` varchar(255) DEFAULT NULL COMMENT 'LMS, MESSAGE 의 사용될 제목',
  `message` longtext COMMENT '발송된 문자의 내용',
  `count` int(11) NOT NULL COMMENT '충전 및 차감된 개수',
  `send_on` datetime DEFAULT NULL COMMENT '발송 예정 시간',
  `is_sent` tinyint(4) NOT NULL COMMENT '발송 여부',
  `filter` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '검색 필터',
  `deleted_by` int(10) unsigned DEFAULT NULL COMMENT '삭제 유저',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '삭제 시간',
  `payment_updated_at` datetime DEFAULT NULL COMMENT '결제 변경시간',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `studio_sms_studio_id_foreign` (`studio_id`),
  CONSTRAINT `studio_sms_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_sms_studio_users`
--

DROP TABLE IF EXISTS `studio_sms_studio_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_sms_studio_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_user_id` int(10) unsigned DEFAULT NULL,
  `counseling_log_id` int(10) unsigned DEFAULT NULL COMMENT '카운셀링 아이디',
  `name` varchar(20) NOT NULL COMMENT '이름',
  `mobile` varchar(15) NOT NULL COMMENT '모바일 번호',
  `studio_sms_id` int(10) unsigned NOT NULL,
  `result_message` varchar(255) NOT NULL,
  `msg_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `studio_sms_studio_users_counseling_log_id_foreign` (`counseling_log_id`),
  KEY `studio_sms_studio_users_studio_sms_id_foreign` (`studio_sms_id`),
  KEY `studio_sms_studio_users_studio_user_id_foreign` (`studio_user_id`),
  CONSTRAINT `studio_sms_studio_users_counseling_log_id_foreign` FOREIGN KEY (`counseling_log_id`) REFERENCES `counseling_logs` (`id`),
  CONSTRAINT `studio_sms_studio_users_studio_sms_id_foreign` FOREIGN KEY (`studio_sms_id`) REFERENCES `studio_sms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_statistics`
--

DROP TABLE IF EXISTS `studio_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_statistics` (
  `studio_id` int(10) NOT NULL,
  `category` enum('purchase','order','usage','balance') NOT NULL COMMENT '데이터 분류. purchase:판매내역, order: 주문내역, usage: 이용내역, balance: 미수업금 잔액',
  `date_for` date NOT NULL COMMENT '대상기간 날짜',
  `results` mediumtext NOT NULL,
  `created_at` datetime NOT NULL,
  UNIQUE KEY `studio_statistics_studio_id_category_date_for_uindex` (`studio_id`,`category`,`date_for`),
  KEY `studio_statistics_date_for_index` (`date_for`),
  KEY `studio_statistics_studio_id_index` (`studio_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='시설별 일간 매출 관련 통계 자료';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_statistics_changes`
--

DROP TABLE IF EXISTS `studio_statistics_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_statistics_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studio_id` int(11) NOT NULL,
  `period` varchar(1000) NOT NULL COMMENT '갱신 대상기간 날짜 목록 JSON',
  `created_at` datetime NOT NULL COMMENT '데이터 변경 발생한 일시.',
  PRIMARY KEY (`id`),
  KEY `studio_statistics_source_changed_studio_id_index` (`studio_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='과거 기간의 통계 관련 데이터 변동 여부 기록. 변동 있다면 갱신 진행.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studio_users`
--

DROP TABLE IF EXISTS `studio_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studio_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `user_grade_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(20) NOT NULL COMMENT '이름',
  `account_type` varchar(255) DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `registered_at` timestamp NULL DEFAULT NULL COMMENT '등록일',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `studio_users_studio_id_foreign` (`studio_id`),
  KEY `studio_users_user_grade_id_foreign` (`user_grade_id`),
  KEY `account` (`account_id`,`account_type`),
  CONSTRAINT `studio_users_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `studio_users_user_grade_id_foreign` FOREIGN KEY (`user_grade_id`) REFERENCES `user_grade` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studios`
--

DROP TABLE IF EXISTS `studios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `subdomain` varchar(20) NOT NULL,
  `logo_img` varchar(255) DEFAULT NULL,
  `representative_color` varchar(6) DEFAULT NULL,
  `description` text,
  `report_password` varchar(255) NOT NULL DEFAULT '$2y$10$oxAM7XWAIYMNTd4egLNFBechAyJpJkYRCleYOUL4YXzKi3hk/3JFu' COMMENT '통계 비밀번호',
  `disable` tinyint(1) NOT NULL,
  `expire_on` date DEFAULT NULL,
  `grade` int(10) unsigned NOT NULL DEFAULT '1',
  `usable_enter` tinyint(1) NOT NULL DEFAULT '1' COMMENT '출석기능 사용',
  `point` int(10) unsigned NOT NULL DEFAULT '0',
  `key` varchar(255) DEFAULT NULL COMMENT '결제키',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `crn` varchar(10) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `tlx_pass_id` varchar(15) DEFAULT NULL,
  `is_terms` tinyint(4) NOT NULL DEFAULT '0' COMMENT '약관 동의 여부',
  `is_old_studio` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1:올드, 0:신규',
  `is_terms_update_time` timestamp NULL DEFAULT NULL COMMENT '약관 동의 시간',
  PRIMARY KEY (`id`),
  UNIQUE KEY `studios_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '상품',
  `grade` varchar(255) NOT NULL COMMENT '등급(basic, plus)',
  `quantity` int(10) unsigned NOT NULL COMMENT '구독 개월수',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_payment`
--

DROP TABLE IF EXISTS `subscription_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '스튜디오 아이디',
  `staff_id` int(10) unsigned NOT NULL COMMENT '요청한 스테프 아이디',
  `subscription_id` int(10) unsigned NOT NULL COMMENT '상품 아이디',
  `credit_card_id` int(10) unsigned DEFAULT NULL COMMENT '결제할 카드 아이디',
  `status` enum('reservation','pending','purchase','fail') NOT NULL,
  `send_on` datetime DEFAULT NULL COMMENT '결제 요청 시간 (미래일경우 예약)',
  `order_no` varchar(255) NOT NULL COMMENT '주문번호',
  `reservation_expire` date DEFAULT NULL COMMENT '해당 일에 요금제가 변경된다.',
  `reservation_grade` varchar(255) DEFAULT NULL COMMENT '해당 일에 해당등급으로 등급이 변경된다.',
  `expire_status` enum('reservation','purchase') DEFAULT NULL COMMENT 'null:예약 없음, reservation:예약, purchase:변경 완료',
  `payment_updated_at` datetime DEFAULT NULL COMMENT '결제 변경시간',
  `change_count` int(11) NOT NULL DEFAULT '0' COMMENT '0보다 큰경우 변경 불가능',
  `message` longtext COMMENT '성공, 실패 메세지',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscription_payment_staff_id_foreign` (`staff_id`),
  KEY `subscription_payment_studio_id_foreign` (`studio_id`),
  KEY `subscription_payment_subscription_id_foreign` (`subscription_id`),
  CONSTRAINT `subscription_payment_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `studio_users` (`id`),
  CONSTRAINT `subscription_payment_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`),
  CONSTRAINT `subscription_payment_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscription` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `super_logins`
--

DROP TABLE IF EXISTS `super_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `super_logins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '시설 ID',
  `token` varchar(255) NOT NULL COMMENT 'token ID',
  `studio_user_id` int(10) unsigned NOT NULL COMMENT '로그인 대상자 아이디',
  `expire_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '만료시간',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT '스튜디오 ID',
  `max_trainee` int(11) NOT NULL COMMENT '인원수',
  `current_trainee_count` int(11) NOT NULL DEFAULT '0' COMMENT '현재 인원수',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `teams_studio_id_foreign` (`studio_id`),
  CONSTRAINT `teams_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticket_division`
--

DROP TABLE IF EXISTS `ticket_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_division` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `division` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_division_ticket_id_division_unique` (`ticket_id`,`division`),
  CONSTRAINT `ticket_division_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticket_division2`
--

DROP TABLE IF EXISTS `ticket_division2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_division2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `division` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `type` enum('T','P') NOT NULL COMMENT 'T : time, P : period',
  `favorite` tinyint(1) NOT NULL DEFAULT '0' COMMENT '즐겨 찾기',
  `favorite_stamp` timestamp NULL DEFAULT NULL COMMENT '즐겨찾기 한 시간',
  `available_class_type` enum('P','G','C') NOT NULL COMMENT 'P : private, G : group, C : course',
  `min_trainee` tinyint(3) unsigned NOT NULL,
  `max_trainee` tinyint(3) unsigned NOT NULL,
  `max_coupon` smallint(5) unsigned DEFAULT NULL,
  `max_cancel` mediumint(8) unsigned DEFAULT NULL,
  `max_modify` mediumint(8) unsigned NOT NULL,
  `booking_limit_per_week` tinyint(3) unsigned NOT NULL,
  `booking_limit_per_month` int(11) NOT NULL DEFAULT '0' COMMENT '월간 예약횟수 제한',
  `daily_booking_change_limit` tinyint(4) NOT NULL DEFAULT '0' COMMENT '일일 예약 변경 제한 횟수',
  `class_period` mediumint(8) unsigned DEFAULT NULL COMMENT '수업 시간 분 단위',
  `is_active_holding_function` tinyint(1) NOT NULL,
  `is_show_cancel_count` tinyint(1) NOT NULL DEFAULT '0' COMMENT '취소 버튼 노출 여부',
  `is_ignore_new_payment` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1',
  `colors` varchar(255) DEFAULT NULL COMMENT '수강권 컬러',
  `availability_start_at` date DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `available_period` int(10) unsigned DEFAULT NULL,
  `booking_start_time` time DEFAULT NULL,
  `booking_end_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `use_weekly_auto_coupon_balance` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tickets_studio_id_foreign` (`studio_id`),
  KEY `tickets_use_weekly_auto_coupon_balance_index` (`use_weekly_auto_coupon_balance`),
  CONSTRAINT `tickets_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickets_20190910`
--

DROP TABLE IF EXISTS `tickets_20190910`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets_20190910` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `type` enum('T','P') NOT NULL COMMENT 'T : time, P : period',
  `available_class_type` enum('P','G','C') NOT NULL COMMENT 'P : private, G : group, C : course',
  `min_trainee` tinyint(3) unsigned NOT NULL,
  `max_trainee` tinyint(3) unsigned NOT NULL,
  `max_coupon` smallint(5) unsigned DEFAULT NULL,
  `max_cancel` mediumint(8) unsigned DEFAULT NULL,
  `max_modify` mediumint(8) unsigned NOT NULL,
  `booking_limit_per_week` tinyint(3) unsigned NOT NULL,
  `class_period` mediumint(8) unsigned DEFAULT NULL COMMENT '수업 시간 분 단위',
  `is_active_holding_function` tinyint(1) NOT NULL,
  `availability_start_at` date DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `available_period` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tlx_admin_users`
--

DROP TABLE IF EXISTS `tlx_admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tlx_admin_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identity` varchar(64) NOT NULL,
  `password` varchar(200) NOT NULL,
  `name` varchar(10) NOT NULL,
  `email` varchar(150) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tmp_bookings`
--

DROP TABLE IF EXISTS `tmp_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_bookings` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `studio_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `lecture_id` int(10) unsigned NOT NULL,
  `user_ticket_id` int(10) unsigned NOT NULL,
  `status` enum('booking_waiting','booking_pending','booked','booking_confirmed','attendance','absence','noshow','cancel') CHARACTER SET utf8mb4 DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `updated_for` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '예약상태 변경 사유',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tmp_payment_users`
--

DROP TABLE IF EXISTS `tmp_payment_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_payment_users` (
  `payments_id` int(10) unsigned NOT NULL DEFAULT '0',
  `studio_id` int(10) unsigned NOT NULL,
  `amount` mediumint(8) unsigned NOT NULL,
  `pay_date` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `studio_user_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_accounts`
--

DROP TABLE IF EXISTS `user_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(150) NOT NULL,
  `password` varchar(200) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `lang` enum('ko','en') NOT NULL DEFAULT 'ko',
  `mobile_invalid_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `recent_password_changed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `app_type` char(1) DEFAULT NULL,
  `app_version` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_accounts_email_unique` (`email`),
  UNIQUE KEY `mobile` (`mobile`,`mobile_invalid_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_grade`
--

DROP TABLE IF EXISTS `user_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_grade` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `representative_color` varchar(255) NOT NULL DEFAULT '#757575' COMMENT '대표 컬러',
  `updated_for` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_for` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_grade_studio_id_foreign` (`studio_id`),
  CONSTRAINT `user_grade_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_notice`
--

DROP TABLE IF EXISTS `user_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_notice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ref_type` varchar(255) DEFAULT NULL,
  `ref_id` bigint(20) unsigned DEFAULT NULL,
  `studio_user_id` int(10) unsigned NOT NULL,
  `booking_id` int(10) unsigned DEFAULT NULL,
  `lecture_id` int(10) unsigned DEFAULT NULL,
  `user_ticket_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_notice_booking_id_foreign` (`booking_id`),
  KEY `user_notice_lecture_id_foreign` (`lecture_id`),
  KEY `user_notice_studio_user_id_foreign` (`studio_user_id`),
  KEY `user_notice_user_ticket_id_foreign` (`user_ticket_id`),
  KEY `ref` (`ref_id`,`ref_type`),
  KEY `user_notice_created_at_index` (`created_at`),
  KEY `user_notice_ref_type_ref_id_index` (`ref_type`,`ref_id`),
  CONSTRAINT `user_notice_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_notice_lecture_id_foreign` FOREIGN KEY (`lecture_id`) REFERENCES `lectures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_notice_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_notice_user_ticket_id_foreign` FOREIGN KEY (`user_ticket_id`) REFERENCES `user_tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_ticket_count_history`
--

DROP TABLE IF EXISTS `user_ticket_count_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ticket_count_history` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_ticket_id` int(10) DEFAULT NULL COMMENT 'user_tickets.id 회원에게 발급된 수강권 ID',
  `staff_id` int(10) DEFAULT NULL,
  `kind` varchar(30) NOT NULL DEFAULT 'count' COMMENT '구분. count: 수정에 의한 횟수 변경 결과, created: 발급시점의 초기 횟수, deducted: 자동 등 차감에 의해 사용한 횟수로 간주하고 변경된 경우, date : 수강권 기간변경, holding:수강권 정지',
  `context` varchar(150) DEFAULT NULL COMMENT 'kind text 일때 표시되는 내용',
  `title` varchar(15) DEFAULT NULL COMMENT 'kind text 일때 노출되는 제목',
  `new` longtext COMMENT '변경 후',
  `old` longtext COMMENT '변경 전',
  `max_coupon_from` int(3) DEFAULT NULL COMMENT '전체 횟수 (변경 전)',
  `max_coupon_to` int(3) DEFAULT NULL COMMENT '전체 횟수 (변경 후)',
  `remaining_coupon_from` int(3) DEFAULT NULL COMMENT '잔여 횟수 (변경 전)',
  `remaining_coupon_to` int(3) DEFAULT NULL COMMENT '잔여 횟수 (변경 후)',
  `usable_coupon_from` int(10) DEFAULT NULL COMMENT '예약가능 횟수 (변경 전)',
  `usable_coupon_to` int(10) DEFAULT NULL COMMENT '예약가능 횟수 (변경 후)',
  `max_cancel_from` int(3) DEFAULT NULL COMMENT '취소 가능 횟수 (변경 전)',
  `max_cancel_to` int(3) DEFAULT NULL COMMENT '취소 가능 횟수 (변경 후)',
  `remaining_cancel_from` int(3) DEFAULT NULL COMMENT '잔여 취소 가능 횟수 (변경 전)',
  `remaining_cancel_to` int(3) DEFAULT NULL COMMENT '잔여 취소 가능 횟수 (변경 후)',
  `start_at_from` date DEFAULT NULL COMMENT '이용 시작일 변경 전',
  `start_at_to` date DEFAULT NULL COMMENT '이용 시작일 변경 후',
  `expire_at_from` date DEFAULT NULL COMMENT '이용 종료일 변경 후',
  `expire_at_to` date DEFAULT NULL COMMENT '이용 종료일 변경 후',
  `unpaid_amount_to` mediumint(9) DEFAULT NULL COMMENT '미납금 변경 후',
  `unpaid_amount_from` mediumint(9) DEFAULT NULL COMMENT '미납금 변경 전',
  `card_amount_to` mediumint(9) DEFAULT NULL COMMENT '카드 결제 변경 후',
  `card_amount_from` mediumint(9) DEFAULT NULL COMMENT '카드 결제 변경 전',
  `cash_amount_to` mediumint(9) DEFAULT NULL COMMENT '현금 결제 변경 후',
  `cash_amount_from` mediumint(9) DEFAULT NULL COMMENT '현금 결제 변경 전',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_ticket_count_history_kind_index` (`kind`),
  KEY `user_ticket_count_history_user_ticket_id_index` (`user_ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='회원 수강권 변경 이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_ticket_holding`
--

DROP TABLE IF EXISTS `user_ticket_holding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ticket_holding` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_ticket_id` int(10) unsigned NOT NULL,
  `start_on` date NOT NULL,
  `end_on` date NOT NULL,
  `studio_user_id` int(10) unsigned DEFAULT NULL,
  `auto_calculation` tinyint(1) NOT NULL DEFAULT '1' COMMENT '자동계산 사용 유무',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_ticket_holding_studio_user_id_foreign` (`studio_user_id`),
  KEY `user_ticket_holding_user_ticket_id_foreign` (`user_ticket_id`),
  CONSTRAINT `user_ticket_holding_studio_user_id_foreign` FOREIGN KEY (`studio_user_id`) REFERENCES `studio_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `user_ticket_holding_user_ticket_id_foreign` FOREIGN KEY (`user_ticket_id`) REFERENCES `user_tickets` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_tickets`
--

DROP TABLE IF EXISTS `user_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `ticket_id` int(10) unsigned NOT NULL,
  `team_id` int(10) unsigned DEFAULT NULL COMMENT 'TEAM ID',
  `order_item_id` int(10) unsigned NOT NULL,
  `max_coupon` smallint(5) unsigned DEFAULT NULL,
  `remaining_coupon` smallint(5) unsigned NOT NULL,
  `usable_coupon` smallint(5) unsigned NOT NULL,
  `max_cancel` mediumint(8) unsigned NOT NULL,
  `remaining_cancel` mediumint(8) unsigned NOT NULL,
  `max_modify` mediumint(8) unsigned NOT NULL,
  `remaining_modify` mediumint(8) unsigned NOT NULL,
  `booking_limit_per_week` tinyint(3) unsigned NOT NULL,
  `booking_limit_per_month` int(11) NOT NULL DEFAULT '0' COMMENT '월간 예약횟수 제한',
  `is_active_holding_function` tinyint(1) NOT NULL,
  `availability_start_at` date DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `inactive_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `is_shared` tinyint(1) NOT NULL DEFAULT '0',
  `un_check` tinyint(1) NOT NULL DEFAULT '0' COMMENT '수강권 보정에서 제외',
  `is_show_cancel_count` tinyint(1) NOT NULL DEFAULT '0' COMMENT '취소 버튼 노출 여부',
  `staff_updated_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payment_updated_at` timestamp NULL DEFAULT NULL COMMENT '결제관련 변경 시간',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `booking_count_per_week` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned DEFAULT NULL,
  `status` enum('purchase','refund','upgrade','downgrade','full_payment','installment_payment') NOT NULL COMMENT '상품 상태',
  PRIMARY KEY (`id`),
  KEY `user_tickets_staff_id_foreign` (`staff_id`),
  KEY `user_tickets_studio_id_foreign` (`studio_id`),
  KEY `user_tickets_team_id_foreign` (`team_id`),
  KEY `user_tickets_user_id_foreign` (`user_id`),
  KEY `user_tickets_order_item_id_index` (`order_item_id`),
  KEY `user_tickets_ticket_id_index` (`ticket_id`),
  CONSTRAINT `user_tickets_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`),
  CONSTRAINT `user_tickets_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_tickets_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_tickets_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE SET NULL,
  CONSTRAINT `user_tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_tickets_20181116`
--

DROP TABLE IF EXISTS `user_tickets_20181116`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tickets_20181116` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `ticket_id` int(10) unsigned NOT NULL,
  `order_item_id` int(10) unsigned NOT NULL,
  `max_coupon` smallint(5) unsigned DEFAULT NULL,
  `remaining_coupon` smallint(5) unsigned NOT NULL,
  `usable_coupon` smallint(5) unsigned NOT NULL,
  `max_cancel` mediumint(8) unsigned NOT NULL,
  `remaining_cancel` mediumint(8) unsigned NOT NULL,
  `max_modify` mediumint(8) unsigned NOT NULL,
  `remaining_modify` mediumint(8) unsigned NOT NULL,
  `booking_limit_per_week` tinyint(3) unsigned NOT NULL,
  `is_active_holding_function` tinyint(1) NOT NULL,
  `availability_start_at` date DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `inactive_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `is_shared` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `booking_count_per_week` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_tickets_studio_id_foreign` (`studio_id`),
  KEY `user_tickets_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_tickets_20190502`
--

DROP TABLE IF EXISTS `user_tickets_20190502`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tickets_20190502` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `ticket_id` int(10) unsigned NOT NULL,
  `order_item_id` int(10) unsigned NOT NULL,
  `max_coupon` smallint(5) unsigned DEFAULT NULL,
  `remaining_coupon` smallint(5) unsigned NOT NULL,
  `usable_coupon` smallint(5) unsigned NOT NULL,
  `max_cancel` mediumint(8) unsigned NOT NULL,
  `remaining_cancel` mediumint(8) unsigned NOT NULL,
  `max_modify` mediumint(8) unsigned NOT NULL,
  `remaining_modify` mediumint(8) unsigned NOT NULL,
  `booking_limit_per_week` tinyint(3) unsigned NOT NULL,
  `is_active_holding_function` tinyint(1) NOT NULL,
  `availability_start_at` date DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `inactive_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `is_shared` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `booking_count_per_week` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_tickets_staff_id_foreign` (`staff_id`),
  KEY `user_tickets_studio_id_foreign` (`studio_id`),
  KEY `user_tickets_user_id_foreign` (`user_id`),
  CONSTRAINT `user_tickets_20190502_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_tickets_20190502_ibfk_2` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_tickets_20190502_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `studio_users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_tickets_sd942`
--

DROP TABLE IF EXISTS `user_tickets_sd942`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tickets_sd942` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `ticket_id` int(10) unsigned NOT NULL,
  `order_item_id` int(10) unsigned NOT NULL,
  `max_coupon` smallint(5) unsigned DEFAULT NULL,
  `remaining_coupon` smallint(5) unsigned NOT NULL,
  `usable_coupon` smallint(5) unsigned NOT NULL,
  `max_cancel` mediumint(8) unsigned NOT NULL,
  `remaining_cancel` mediumint(8) unsigned NOT NULL,
  `max_modify` mediumint(8) unsigned NOT NULL,
  `remaining_modify` mediumint(8) unsigned NOT NULL,
  `booking_limit_per_week` tinyint(3) unsigned NOT NULL,
  `is_active_holding_function` tinyint(1) NOT NULL,
  `availability_start_at` date DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `inactive_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `is_shared` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `booking_count_per_week` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_tickets_studio_id_foreign` (`studio_id`),
  KEY `user_tickets_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `validation_code`
--

DROP TABLE IF EXISTS `validation_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validation_code` (
  `id` char(13) NOT NULL,
  `code` char(6) NOT NULL,
  `expired_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ref_id` int(10) unsigned DEFAULT NULL,
  `ref_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `validation_code_expired_at_index` (`expired_at`),
  KEY `validation_code_ref_id_ref_type_index` (`ref_id`,`ref_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `write_templates`
--

DROP TABLE IF EXISTS `write_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `write_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studio_id` int(10) unsigned NOT NULL COMMENT 'studio_id',
  `template` longtext NOT NULL COMMENT '템플릿',
  `type` varchar(10) NOT NULL COMMENT '종류',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `write_templates_studio_id_foreign` (`studio_id`),
  CONSTRAINT `write_templates_studio_id_foreign` FOREIGN KEY (`studio_id`) REFERENCES `studios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `lecture_view`
--

/*!50001 DROP VIEW IF EXISTS `lecture_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`web`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `lecture_view` AS (select `l`.`id` AS `id`,`l`.`studio_id` AS `studio_id`,`l`.`course_id` AS `course_id`,`l`.`instructor_id` AS `instructor_id`,`l`.`min_trainee` AS `min_trainee`,`l`.`max_trainee` AS `max_trainee`,`l`.`current_trainee_count` AS `current_trainee_count`,`l`.`coupon_deduction` AS `coupon_deduction`,`l`.`created_at` AS `created_at`,`l`.`updated_at` AS `updated_at`,`l`.`deleted_at` AS `deleted_at`,`e`.`start_on` AS `start_on`,`e`.`end_on` AS `end_on`,`e`.`id` AS `event_id` from (`lectures` `l` join `events` `e` on(((`e`.`schedule_type` = 'lecture') and (`e`.`schedule_id` = `l`.`id`))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `member_view`
--

/*!50001 DROP VIEW IF EXISTS `member_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`web`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `member_view` AS (select `su`.`id` AS `id`,`su`.`studio_id` AS `studio_id`,`mp`.`name` AS `name`,`s`.`name` AS `studio_name`,`su`.`mobile` AS `mobile`,`ua`.`email` AS `email`,`su`.`account_id` AS `account_id` from (((`studio_users` `su` join `member_profiles` `mp` on((`mp`.`studio_user_id` = `su`.`id`))) join `studios` `s` on((`s`.`id` = `su`.`studio_id`))) left join `user_accounts` `ua` on(((`ua`.`id` = `su`.`account_id`) and (`su`.`account_type` = 'userAccount'))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `member_view_temp`
--

/*!50001 DROP VIEW IF EXISTS `member_view_temp`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`web`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `member_view_temp` AS (select `su`.`id` AS `id`,`su`.`studio_id` AS `studio_id`,`mp`.`name` AS `name`,`s`.`name` AS `studio_name`,`su`.`mobile` AS `mobile`,`ua`.`email` AS `email`,`su`.`account_id` AS `account_id` from (((`studio_users` `su` join `member_profiles` `mp` on((`mp`.`studio_user_id` = `su`.`id`))) join `studios` `s` on((`s`.`id` = `su`.`studio_id`))) left join `user_accounts` `ua` on(((`ua`.`id` = `su`.`account_id`) and (`su`.`account_type` = 'userAccount')))) where isnull(`su`.`deleted_at`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `staff_view`
--

/*!50001 DROP VIEW IF EXISTS `staff_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`web`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `staff_view` AS (select `s`.`name` AS `studio_name`,`sp`.`name` AS `name`,`oci`.`contact` AS `contact`,`sa`.`identity` AS `identity`,`su`.`id` AS `id`,`su`.`studio_id` AS `studio_id`,`su`.`account_type` AS `account_type`,`su`.`account_id` AS `account_id`,`su`.`mobile` AS `mobile`,`su`.`created_at` AS `created_at`,`su`.`updated_at` AS `updated_at`,`su`.`deleted_at` AS `deleted_at` from ((((`studio_users` `su` join `staff_profiles` `sp` on((`sp`.`studio_user_id` = `su`.`id`))) join `studios` `s` on((`s`.`id` = `su`.`studio_id`))) left join `staff_accounts` `sa` on((`sa`.`id` = `su`.`account_id`))) left join `owner_contact_infos` `oci` on((`oci`.`owner_id` = `su`.`id`))) where (`su`.`account_type` = 'staffAccount')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-15 12:33:44
