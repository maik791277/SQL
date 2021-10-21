CREATE TABLE language
(
	ID varchar(2) not null unique,
	NAME varchar(200) not null,
	PRIMARY KEY (ID)
);

CREATE TABLE movie_title
(
	LANGUAGE_ID varchar(2) not null,
    MOVIE_ID int not null,
    TITLE varchar(500),
    PRIMARY KEY (MOVIE_ID),
    FOREIGN KEY FK_MA_MOVIE (MOVIE_ID)
	    REFERENCES movie(ID)
	    ON UPDATE RESTRICT
	    ON DELETE RESTRICT,
    FOREIGN KEY FK_MA_LANGUAGE (LANGUAGE_ID)
	    REFERENCES language(ID)
	    ON UPDATE RESTRICT
	    ON DELETE RESTRICT
);

INSERT INTO language (ID, NAME)
	VALUE ('ru','Русский'),
	('en','Английский'),
	('de','Немецкий');

INSERT INTO movie_title (LANGUAGE_ID, MOVIE_ID, TITLE)
SELECT 'ru' AS LANGUAGE_ID, ID, TITLE FROM movie;

ALTER TABLE movie DROP COLUMN TITLE;