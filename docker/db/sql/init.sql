CREATE TABLE `school` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `registration_code` VARCHAR(255) NOT NULL,
    `subscription` TINYINT UNSIGNED NOT NULL,
    `is_active` TINYINT UNSIGNED NOT NULL DEFAULT '0',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `class` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) UNSIGNED NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `grade` TINYINT UNSIGNED NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `waiting_account` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) UNSIGNED NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `account_type` TINYINT UNSIGNED NOT NULL,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `account` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) UNSIGNED NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `account_type` TINYINT UNSIGNED NOT NULL,
    `is_active` TINYINT UNSIGNED NOT NULL DEFAULT '0',
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `teacher` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) UNSIGNED NOT NULL,
    `class_id` BIGINT(20) UNSIGNED NOT NULL,
    `account_id` BIGINT(20) UNSIGNED NOT NULL,
    `admin` TINYINT UNSIGNED NOT NULL DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`),
    FOREIGN KEY (`class_id`) REFERENCES `class`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `curriculum` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `subject` SMALLINT UNSIGNED NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) UNSIGNED NOT NULL,
    `class_id` BIGINT(20) UNSIGNED NOT NULL,
    `account_id` BIGINT(20) UNSIGNED NOT NULL,
    `grade` TINYINT UNSIGNED NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`),
    FOREIGN KEY (`class_id`) REFERENCES `class`(`id`),
    FOREIGN KEY (`account_id`) REFERENCES `account`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `exam` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `school_id` BIGINT(20) UNSIGNED,
    `teacher_id` BIGINT(20) UNSIGNED,
    `exam_type` TINYINT UNSIGNED NOT NULL,
    `start_time` datetime NOT NULL,
    `end_time` datetime NOT NULL,
    `passing_score` SMALLINT UNSIGNED NOT NULL,
    `target_accuracy_rate` TINYINT UNSIGNED NOT NULL,
    `is_perpetual` TINYINT UNSIGNED NOT NULL DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`),
    FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `exam_curriculum` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `exam_id` BIGINT(20) UNSIGNED NOT NULL,
    `curriculum_id` BIGINT(20) UNSIGNED NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`exam_id`) REFERENCES `exam`(`id`),
    FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student_score` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `student_id` BIGINT(20) UNSIGNED NOT NULL,
    `curriculum_id` BIGINT(20) UNSIGNED NOT NULL,
    `exam_id` BIGINT(20) UNSIGNED NOT NULL,
    `score` TINYINT UNSIGNED NOT NULL,
    `accuracy_rate` TINYINT UNSIGNED NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`),
    FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum`(`id`),
    FOREIGN KEY (`exam_id`) REFERENCES `exam`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `problem` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `curriculum_id` BIGINT(20) UNSIGNED NOT NULL,
    `problem_type` TINYINT UNSIGNED NOT NULL,
    `is_public` TINYINT UNSIGNED NOT NULL,
    `status` TINYINT UNSIGNED NOT NULL,
    `problem_text` TEXT NOT NULL,
    `wrong_answer_cnt` BIGINT(20) UNSIGNED NOT NULL,
    `correct_answer_cnt` BIGINT(20) UNSIGNED NOT NULL,
    `solved_cnt` BIGINT(20) UNSIGNED NOT NULL,
    `solved_avg_second` BIGINT(20) UNSIGNED NOT NULL,
    `correct_answer_id` BIGINT(20) UNSIGNED,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `exam_problem` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `exam_id` BIGINT(20) UNSIGNED NOT NULL,
    `problem_id` BIGINT(20) UNSIGNED NOT NULL,
    `score` TINYINT UNSIGNED NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`exam_id`) REFERENCES `exam`(`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `problem_option` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `problem_id` BIGINT(20) UNSIGNED NOT NULL,
    `option_text` TEXT NOT NULL,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `answer` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `problem_id` BIGINT(20) UNSIGNED NOT NULL,
    `student_id` BIGINT(20) UNSIGNED NOT NULL,
    `answer_text` text,
    `answer_id` BIGINT(20) UNSIGNED,
    `solve_second` int NOT NULL,
    `is_correct` TINYINT UNSIGNED NOT NULL,
    `is_descriptive` TINYINT UNSIGNED NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`),
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`),
    FOREIGN KEY (`answer_id`) REFERENCES `problem_option`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `answer_advise` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `answer_id` BIGINT(20) UNSIGNED NOT NULL,
    `advise` text NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`answer_id`) REFERENCES `answer`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
