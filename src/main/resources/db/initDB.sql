DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS project_chunk;
DROP TABLE IF EXISTS project;
DROP TABLE IF EXISTS user;

CREATE TABLE roles (
  id int(6) NOT NULL AUTO_INCREMENT,
  role varchar(20) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE user (
  id INT AUTO_INCREMENT NOT NULL,
  email VARCHAR(30) UNIQUE NOT NULL,
  password VARCHAR(30) NOT NULL,
  PRIMARY KEY (id),
  INDEX (email)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE `user_roles` (
  `user_id` int(6) NOT NULL,
  `role_id` int(6) NOT NULL,
  KEY `user` (`user_id`),
  KEY `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE message (
id INT AUTO_INCREMENT NOT NULL,
user_email VARCHAR(30) NOT NULL,
text VARCHAR(500) NOT NULL,
date_time TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE project (
  project_id INT AUTO_INCREMENT NOT NULL,
  project_name VARCHAR(255) UNIQUE NOT NULL,
  text VARCHAR(500) NOT NULL,
  user_email VARCHAR(30),
  date_time TIMESTAMP NOT NULL,
  dev_time TIME NOT NULL,
  PRIMARY KEY (project_id),
  FOREIGN KEY (user_email) REFERENCES user(email) ON DELETE CASCADE,
  INDEX (project_name)
);

CREATE TABLE project_chunk (
  chunk_id INT AUTO_INCREMENT NOT NULL,
  project_id INT NOT NULL,
  text VARCHAR(500) NOT NULL,
  date_time TIMESTAMP NOT NULL,
  value INT NOT NULL,
  PRIMARY KEY (chunk_id),
  FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
);

INSERT INTO roles (role) VALUES ('admin'), ('user');
INSERT INTO user (email, password) VALUES ('moder', '111'), ('adm', '222');
INSERT INTO user_roles (user_id, role_id) VALUES (1, 2), (2, 1);
INSERT INTO message (id,user_email,text,date_time) VALUES (1,'moder','first message', now());
INSERT INTO message (id,user_email,text,date_time) VALUES (2,'adm','first message', now());
INSERT INTO project (project_id,user_email,project_name,text, date_time, dev_time) VALUES (1,'adm','My site','first project', now(), '0:0:0');
INSERT INTO project_chunk  (chunk_id,project_id, text, date_time, value) VALUES (1,1,'first upd',now(), 1);