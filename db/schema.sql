CREATE DATABASE IF NOT EXISTS rustforge CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE rustforge;

CREATE TABLE users (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 username VARCHAR(40) NOT NULL UNIQUE,
 email VARCHAR(190) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 role ENUM('user','moderator','admin') NOT NULL DEFAULT 'user',
 is_banned TINYINT(1) NOT NULL DEFAULT 0,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE categories (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 parent_id INT UNSIGNED NULL,
 name VARCHAR(80) NOT NULL,
 slug VARCHAR(100) NOT NULL UNIQUE,
 description VARCHAR(255) DEFAULT NULL,
 FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE CASCADE
);
CREATE TABLE posts (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 category_id INT UNSIGNED NOT NULL,
 user_id INT UNSIGNED NOT NULL,
 title VARCHAR(180) NOT NULL,
 body TEXT NOT NULL,
 image_path VARCHAR(255) DEFAULT NULL,
 is_security TINYINT(1) NOT NULL DEFAULT 0,
 is_closed TINYINT(1) NOT NULL DEFAULT 0,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
 INDEX (category_id, created_at), INDEX (is_security, created_at)
);
CREATE TABLE comments (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 post_id INT UNSIGNED NOT NULL,
 user_id INT UNSIGNED NOT NULL,
 body TEXT NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE TABLE badges (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(60) NOT NULL UNIQUE,
 icon VARCHAR(10) NOT NULL DEFAULT '◆',
 color VARCHAR(20) NOT NULL DEFAULT '#f26a3d'
);
CREATE TABLE user_badges (
 user_id INT UNSIGNED NOT NULL,
 badge_id INT UNSIGNED NOT NULL,
 PRIMARY KEY (user_id, badge_id),
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
 FOREIGN KEY (badge_id) REFERENCES badges(id) ON DELETE CASCADE
);
CREATE TABLE settings (
 setting_key VARCHAR(80) PRIMARY KEY,
 setting_value VARCHAR(255) NOT NULL
);
INSERT INTO settings VALUES ('chat_enabled','1');
INSERT INTO badges (name, icon, color) VALUES ('Pionero','✦','#f26a3d'),('Cazabugs','⌁','#6dd6c6'),('Moderador','◆','#f5c15b');
INSERT INTO categories (parent_id,name,slug,description) VALUES (NULL,'Anuncios','anuncios','Cambios, lanzamientos y notas del cliente'),(NULL,'Comunidad','comunidad','Debates, ayuda y feedback');
INSERT INTO categories (parent_id,name,slug,description) VALUES (1,'Changelog','changelog','Historial de cambios por versión'),(2,'Soporte','soporte','Ayuda con instalación y uso');
