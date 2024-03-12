/* queries for my db - pgAdmin. i create new db named "School"*/

CREATE TABLE student (
  id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT
);

/* one to one connection to student */
-- One to One --
CREATE TABLE contact_detail (
  id INTEGER REFERENCES student(id) UNIQUE,
  tel TEXT,
  address TEXT
);

-- Data --
INSERT INTO student (first_name, last_name)
VALUES ('Angela', 'Yu');
INSERT INTO contact_detail (id, tel, address)
VALUES (1, '+123456789', '123 App Brewery Road');


/* join 2 tables together based on cratiria "ON" (where student.id = contact_detail.id) */
-- Join --
SELECT * 
FROM student
JOIN contact_detail
ON student.id = contact_detail.id




/* each student make many homework submmission 
  student_id INTEGER REFERENCES student(id) - This is who to establish many to one connection. Using refrences key word to set up forgein key, then using "table name (field)".
  This means look for the student table, find field called id, and set this as a relation to student_id field.
  */
-- Many to One --
CREATE TABLE homework_submission (
  id SERIAL PRIMARY KEY,
  mark INTEGER,
  student_id INTEGER REFERENCES student(id)
);

-- Data --
INSERT INTO homework_submission (mark, student_id)
VALUES (98, 1), (87, 1), (88, 1)

/* select everything based on the cretiria*/
-- Join --
SELECT *
FROM student
JOIN homework_submission
ON student.id = homework_submission.student_id


/* narrow down the repeated columns */
SELECT student.id, first_name, last_name, mark
FROM student
JOIN homework_submission
ON student.id = student_id



/* many student to many classes*/
-- Many to Many --
CREATE TABLE class (
  id SERIAL PRIMARY KEY,
  title VARCHAR(45)
);

CREATE TABLE enrollment (
  student_id INTEGER REFERENCES student(id),
  class_id INTEGER REFERENCES class(id),
  PRIMARY KEY (student_id, class_id)
);


-- Data --
INSERT INTO student (first_name, last_name)
VALUES ('Jack', 'Bauer');

INSERT INTO class (title)
VALUES ('English Literature'), ('Maths'), ('Physics');

INSERT INTO enrollment (student_id, class_id ) VALUES (1, 1), (1, 2);
INSERT INTO enrollment (student_id ,class_id) VALUES (2, 2), (2, 3);


-- Join --
SELECT *
FROM enrollment 
JOIN student ON student.id = enrollment.student_id
JOIN class ON class.id = enrollment.class_id;

SELECT student.id AS id, first_name, last_name, title
FROM enrollment 
JOIN student ON student.id = enrollment.student_id
JOIN class ON class.id = enrollment.class_id;


/* rename s.id field as id*/
-- ALIAS --
SELECT s.id AS id, first_name, last_name, title
FROM enrollment AS e
JOIN student AS s ON s.id = e.student_id
JOIN class AS c ON c.id = e.class_id;


/* shortcut for names. FROM enrollment e is equal to FROM enrollment AS e (as is optional) */
SELECT s.id AS id, first_name, last_name, title
FROM enrollment e
JOIN student s ON s.id = e.student_id
JOIN class c ON c.id = e.class_id;








-- EXERCISE SOLUTION AND SETUP (Family travel tracker) --

DROP TABLE IF EXISTS visited_countries, users;

CREATE TABLE users(
id SERIAL PRIMARY KEY,
name VARCHAR(15) UNIQUE NOT NULL,
color VARCHAR(15)
);

/* one to many relation -
by creating a foreign key that points to the primary key of the other table.
(REFERENCES - set user_id to foreign key
*/
CREATE TABLE visited_countries(
id SERIAL PRIMARY KEY,
country_code CHAR(2) NOT NULL,
user_id INTEGER REFERENCES users(id)
);

/*
vs previous version:
CREATE TABLE visited_countries(
  id SERIAL PRIMARY KEY,
  country_code CHAR (2)
);
*/

INSERT INTO users (name, color)
VALUES ('Shani', 'teal'), ('Jack', 'powderblue');

INSERT INTO visited_countries (country_code, user_id)
VALUES ('FR', 1), ('GB', 1), ('CA', 2), ('FR', 2 );

SELECT *
FROM visited_countries
JOIN users
ON users.id = user_id;

/*
"id"	"country_code"	"user_id"	"id"	"name"	"color"
1	"FR"	1	1	"Shani"	"teal"
2	"IL"	1	1	"Shani"	"teal"
3	"CA"	2	2	"Jack"	"powderblue"
4	"FR"	2	2	"Jack"	"powderblue"
*/



/*
"FR"
"DE"
"GR"
"IL"
"IT"
"NL"
"US"
"SZ"
"AT"
"BG"
*/