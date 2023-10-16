
DROP TABLE IF EXISTS `answer_advise`;
DROP TABLE IF EXISTS `answer`;
DROP TABLE IF EXISTS `problem_option`;
DROP TABLE IF EXISTS `problem_detail`;
DROP TABLE IF EXISTS `problem`;
DROP TABLE IF EXISTS `student_score`;
DROP TABLE IF EXISTS `exam_problem`;
DROP TABLE IF EXISTS `exam_detail`;
DROP TABLE IF EXISTS `exam`;
DROP TABLE IF EXISTS `class_students`;
DROP TABLE IF EXISTS `class`;
DROP TABLE IF EXISTS `student_detail`;
DROP TABLE IF EXISTS `student`;
DROP TABLE IF EXISTS `curriculum_detail`;
DROP TABLE IF EXISTS `curriculum`;
DROP TABLE IF EXISTS `teacher_detail`;
DROP TABLE IF EXISTS `teacher`;
DROP TABLE IF EXISTS `school_detail`;
DROP TABLE IF EXISTS `school`;

CREATE TABLE `school` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `subscription` varchar(255) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `school_detail` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) NOT NULL,
    `address` varchar(255) NOT NULL,
    `phone` varchar(255) NOT NULL,
    `website` varchar(255) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `teacher` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) NOT NULL,
    `email` varchar(255) NOT NULL,
    `password` varchar(255) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `teacher_detail` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `teacher_id` BIGINT(20) NOT NULL,
    `name` varchar(255) NOT NULL,
    `phone` varchar(255) NOT NULL,
    `admin` tinyint(1) NOT NULL DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `curriculum` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `curriculum_detail` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `curriculum_id` BIGINT(20) NOT NULL,
    `name` varchar(255) NOT NULL,
    `subject` varchar(255) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) NOT NULL,
    `email` varchar(255) NOT NULL,
    `password` varchar(255) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student_detail` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `student_id` BIGINT(20) NOT NULL,
    `name` varchar(255) NOT NULL,
    `phone` varchar(255) NOT NULL,
    `grade` SMALLINT NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `class` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `school_id` BIGINT(20) NOT NULL,
    `name` varchar(255) NOT NULL,
    `grade` SMALLINT NOT NULL,
    `teacher_id` BIGINT(20) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`),
    FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `class_students` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `class_id` BIGINT(20) NOT NULL,
    `student_id` BIGINT(20) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`class_id`) REFERENCES `class`(`id`),
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `exam` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `curriculum_id` BIGINT(20) NOT NULL,
    `school_id` BIGINT(20) NOT NULL,
    `teacher_id` BIGINT(20) NOT NULL,
    `class_id` BIGINT(20) NOT NULL,
    `exam_type` SMALLINT NOT NULL,
    `is_private` SMALLINT NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum`(`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school`(`id`),
    FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`id`),
    FOREIGN KEY (`class_id`) REFERENCES `class`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `exam_detail` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `exam_id` BIGINT(20) NOT NULL,
    `start_time` datetime NOT NULL,
    `end_time` datetime NOT NULL,
    `duration` BIGINT(20) NOT NULL,
    `passing_score` BIGINT(20) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`exam_id`) REFERENCES `exam`(`id`)
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
    `is_private` SMALLINT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `exam_problem` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `exam_id` BIGINT(20) NOT NULL,
    `problem_id` BIGINT(20) NOT NULL,
    `score` SMALLINT NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`exam_id`) REFERENCES `exam`(`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `problem_detail` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `problem_id` BIGINT(20) NOT NULL,
    `question_text` text NOT NULL,
    `wrong_answer_cnt` BIGINT(20) NOT NULL,
    `correct_answer_cnt` BIGINT(20) NOT NULL,
    `solved_cnt` BIGINT(20) NOT NULL,
    `solved_avg_second` BIGINT(20) NOT NULL,
    `correct_answer_id` BIGINT(20),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `problem_option` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `problem_id` BIGINT(20) NOT NULL,
    `option_text` varchar(255) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `answer` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `problem_id` BIGINT(20) NOT NULL,
    `student_id` BIGINT(20) NOT NULL,
    `answer_text` text NOT NULL,
    `solve_second` int NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`),
    FOREIGN KEY (`student_id`) REFERENCES `student`(`id`)
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
