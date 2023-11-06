CREATE TABLE `school` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` TEXT NOT NULL,
    `address` TEXT NOT NULL,
    `phone` TEXT NOT NULL,
    `registration_code` TEXT NOT NULL,
    `subscription` TEXT NOT NULL,
    `is_active` TINYINT NOT NULL DEFAULT '0',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `class` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) NOT NULL,
    `name` TEXT NOT NULL,
    `grade` SMALLINT NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `waiting_account` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) NOT NULL,
    `email` TEXT NOT NULL,
    `password` TEXT NOT NULL,
    `name` TEXT NOT NULL,
    `account_type` SMALLINT NOT NULL,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `account` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `email` TEXT NOT NULL,
    `password` TEXT NOT NULL,
    `name` TEXT NOT NULL,
    `account_type` SMALLINT NOT NULL,
    `is_active` TINYINT NOT NULL DEFAULT '0',
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `teacher` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) NOT NULL,
    `class_id` BIGINT(20) NOT NULL,
    `account_id` BIGINT(20) NOT NULL,
    `admin` TINYINT NOT NULL DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`),
    FOREIGN KEY (`class_id`) REFERENCES `class`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `curriculum` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` TEXT NOT NULL,
    `subject` TEXT NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) NOT NULL,
    `class_id` BIGINT(20) NOT NULL,
    `account_id` BIGINT(20) NOT NULL,
    `grade` SMALLINT NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`),
    FOREIGN KEY (`class_id`) REFERENCES `class`(`id`),
    FOREIGN KEY (`account_id`) REFERENCES `account`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `exam` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` TEXT NOT NULL,
    `school_id` BIGINT(20),
    `teacher_id` BIGINT(20),
    `exam_type` TINYINT NOT NULL,
    `start_time` datetime NOT NULL,
    `end_time` datetime NOT NULL,
    `passing_score` BIGINT(20) NOT NULL,
    `target_accuracy_rate` SMALLINT NOT NULL,
    `is_perpetual` TINYINT NOT NULL DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`),
    FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `exam_curriculum` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `exam_id` BIGINT(20) NOT NULL,
    `curriculum_id` BIGINT(20) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`exam_id`) REFERENCES `exam`(`id`),
    FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student_score` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `student_id` BIGINT(20) NOT NULL,
    `curriculum_id` BIGINT(20) NOT NULL,
    `exam_id` BIGINT(20) NOT NULL,
    `score` SMALLINT NOT NULL,
    `accuracy_rate` SMALLINT NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`),
    FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum`(`id`),
    FOREIGN KEY (`exam_id`) REFERENCES `exam`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `problem` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `curriculum_id` BIGINT(20) NOT NULL,
    `problem_type` SMALLINT NOT NULL,
    `is_public` TINYINT NOT NULL,
    `status` TINYINT NOT NULL,
    `question_text` TEXT NOT NULL,
    `wrong_answer_cnt` BIGINT(20) NOT NULL,
    `correct_answer_cnt` BIGINT(20) NOT NULL,
    `solved_cnt` BIGINT(20) NOT NULL,
    `solved_avg_second` BIGINT(20) NOT NULL,
    `correct_answer_id` BIGINT(20),
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `exam_problem` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `exam_id` BIGINT(20) NOT NULL,
    `problem_id` BIGINT(20) NOT NULL,
    `score` SMALLINT NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`exam_id`) REFERENCES `exam`(`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `problem_option` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `problem_id` BIGINT(20) NOT NULL,
    `option_text` TEXT NOT NULL,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `answer` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `problem_id` BIGINT(20) NOT NULL,
    `student_id` BIGINT(20) NOT NULL,
    `answer_text` text,
    `answer_id` BIGINT(20),
    `solve_second` int NOT NULL,
    `is_correct` SMALLINT NOT NULL,
    `is_descriptive` SMALLINT NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`),
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`),
    FOREIGN KEY (`answer_id`) REFERENCES `problem_option`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `answer_advise` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `answer_id` BIGINT(20) NOT NULL,
    `advise` text NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`answer_id`) REFERENCES `answer`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
