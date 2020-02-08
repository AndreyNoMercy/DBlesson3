CREATE DATABASE vk;

USE vk;

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(15) NOT NULL UNIQUE,
  `password` VARCHAR(15),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE profiles (
  id_user INT UNSIGNED NOT NULL PRIMARY KEY,
  birthdate DATE,
  sex CHAR(1) NOT NULL,
  city VARCHAR(100),
  country VARCHAR(100),
  photo_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  is_important BOOLEAN,
  is_delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);

CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status_id INT UNSIGNED NOT NULL,
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);


CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (community_id, user_id)
);

CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE media_types (
  media_type_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

#Доработка моих данных

USE vk;

UPDATE friendship SET requested_at = confirmed_at WHERE requested_at > confirmed_at;

UPDATE media SET created_at = updated_at WHERE created_at > updated_at;
UPDATE media SET `size` = 1 WHERE `size` = 0; 
UPDATE media SET metadata = CONCAT('{"owner":"', (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),'"}');

UPDATE profiles SET created_at = updated_at WHERE created_at > updated_at;
UPDATE profiles SET created_at = birthdate WHERE birthdate > created_at;
CREATE TEMPORARY TABLE sex (sex CHAR(1));
INSERT INTO sex VALUES ('m'), ('f');
SELECT * FROM sex;
UPDATE profiles SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);
UPDATE profiles SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);
UPDATE profiles SET photo_id  = 1 + RAND() * 100; 

DELETE FROM communities WHERE id > 20;
UPDATE communities_users SET community_id = 1 + RAND() * 20, user_id = 1 + RAND() * 100; 
SELECT * FROM communities_users;

UPDATE users SET created_at = updated_at WHERE created_at > updated_at;

# Создание таблиц

CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  media_id INT UNSIGNED, 
  user_id INT UNSIGNED not null,
  head VARCHAR(255), 
  body MEDIUMTEXT, 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
); 

UPDATE posts SET created_at = updated_at WHERE created_at > updated_at;

#CREATE TABLE likes (
#id INT UNSIGNED NOT NULL AUTO_INCREMENT  PRIMARY KEY, 
#user_make_like_id INT UNSIGNED NOT NULL, 
#user_get_like_id INT UNSIGNED,
#post_id INT UNSIGNED,
#message_id INT UNSIGNED,
#media_id INT UNSIGNED
#created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
#);


# Добавление id_user в таблицу profile, но так как у меня уже был решил сделать это для столбца id_photo

#UPDATE profiles SET photo_id = NULL;
#SELECT * FROM profiles;
#CREATE TEMPORARY TABLE id_photo(id;
#INSERT INTO profiles(photo_id ) SELECT media_tipe_id FROM media;
