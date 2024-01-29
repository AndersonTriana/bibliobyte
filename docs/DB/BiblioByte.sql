-- MySQL Script generated by MySQL Workbench
-- Wed Dec 13 10:27:26 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
SET
  @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS,
  UNIQUE_CHECKS = 0;

SET
  @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS,
  FOREIGN_KEY_CHECKS = 0;

SET
  @OLD_SQL_MODE = @@SQL_MODE,
  SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bibliobyte
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bibliobyte`;

-- -----------------------------------------------------
-- Schema bibliobyte
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bibliobyte` DEFAULT CHARACTER SET utf8;

USE `bibliobyte`;

-- -----------------------------------------------------
-- Table `bibliobyte`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliobyte`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE
);

-- -----------------------------------------------------
-- Table `bibliobyte`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliobyte`.`books` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `title` VARCHAR(60) NOT NULL,
  `author` VARCHAR(60) NULL DEFAULT '',
  `file_name` VARCHAR(255) NOT NULL,
  `file_path` VARCHAR(255) NOT NULL,
  `cover_name` VARCHAR(255) NULL DEFAULT NULL,
  `cover_path` VARCHAR(255) NULL DEFAULT NULL,
  `pages` INT UNSIGNED NOT NULL,
  `publication_year` YEAR NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `file_path_UNIQUE` (`file_path` ASC) VISIBLE,
  UNIQUE INDEX `cover_path_UNIQUE` (`cover_path` ASC) VISIBLE,
  INDEX `_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_books_user_id` FOREIGN KEY (`user_id`) REFERENCES `bibliobyte`.`users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `bibliobyte`.`books_progress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliobyte`.`books_progress` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `book_id` INT UNSIGNED NOT NULL,
  `current_page` INT UNSIGNED NULL DEFAULT NULL,
  `last_read_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_book_id_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_progress_user_id` FOREIGN KEY (`user_id`) REFERENCES `bibliobyte`.`users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_progress_book_id` FOREIGN KEY (`book_id`) REFERENCES `bibliobyte`.`books` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

SET
  SQL_MODE = @OLD_SQL_MODE;

SET
  FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

SET
  UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;