
CREATE DATABASE IF NOT EXISTS `signum` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_czech_ci;

USE `signum`;

CREATE TABLE IF NOT EXISTS `clients` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `firstname` VARCHAR(40) NOT NULL,
    `lastname` VARCHAR(60) NOT NULL,
    `birthdate` DATE NOT NULL,
    `street` VARCHAR(40) NOT NULL,
    `housenum` VARCHAR(10) NOT NULL,
    `postal` VARCHAR(5) NOT NULL,
    `city` VARCHAR(40) NOT NULL,
    `username` VARCHAR(30) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,          
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `phone` VARCHAR(20) NOT NULL,
    INDEX `idx_name` (`lastname`, `firstname`)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `certificates` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `client_id` INT UNSIGNED NOT NULL,
    `certifkey` VARCHAR(16) NOT NULL UNIQUE,    
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `valid_from` DATE NOT NULL,
    `valid_to` DATE NOT NULL,
    `status` ENUM('active', 'revoked', 'expired') NOT NULL DEFAULT 'active',
    
    FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    UNIQUE KEY `uq_certifkey` (`certifkey`),
    INDEX `idx_client` (`client_id`),
    INDEX `idx_valid_to` (`valid_to`)
) ENGINE=InnoDB;