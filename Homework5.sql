# 1. Вывести список фильмов, в которых снимались одновременно Арнольд Шварценеггер* и Линда Хэмилтон.
SELECT
       mo.ID,
       mt.TITLE,
       d.NAME
FROM movie mo
        LEFT JOIN movie_title mt on mo.ID = mt.MOVIE_ID
                                        AND mt.LANGUAGE_ID = 'ru'
	    INNER JOIN
    director d on mo.DIRECTOR_ID = d.ID
        INNER  JOIN
    movie_actor man1 on mo.ID = man1.MOVIE_ID
        INNER  JOIN
    movie_actor man2 on mo.ID = man2.MOVIE_ID
WHERE man1.ACTOR_ID = 1 AND man2.ACTOR_ID = 3;



# 2. Вывести список названий фильмов на англйском языке с "откатом" на русский, в случае если название на английском не задано.
SELECT
	m.ID,
	IFNULL(mot_en.TITLE,mot_ru.TITLE) AS Name
FROM movie AS m
	     LEFT JOIN
    movie_title mot_en on m.ID = mot_en.MOVIE_ID
                              AND mot_en.LANGUAGE_ID = 'en'
	     LEFT JOIN
    movie_title mot_ru on m.ID = mot_ru.MOVIE_ID
                              AND mot_ru.LANGUAGE_ID = 'ru'
ORDER BY ID;



# 3. Вывести самый длительный фильм Джеймса Кэмерона.
SELECT
    MOVIE_ID  ,
	movie_title.TITLE as TITLE,
	MAX(LENGTH) as TIME
FROM movie_title, movie, director
WHERE DIRECTOR_ID = 1 AND  movie_title.LANGUAGE_ID='ru';



# 4. Вывести список фильмов с названием, сокращённым до 10 символов. Если название короче 10 символов – оставляем как есть. Если длиннее – сокращаем до 10 символов и добавляем многоточие.
SELECT MOVIE_ID,
       CASE WHEN LENGTH(TITLE) <= 10
	            THEN TITLE
            ELSE CONCAT(LEFT(TITLE,10),'...')
	       END As Name
FROM  movie_title;



#5 Вывести количество фильмов, в которых снимался каждый актёр.
SELECT
       a.NAME,
       COUNT(ma.MOVIE_ID) AS movie
FROM actor AS a
	     LEFT JOIN
    movie_actor ma on a.ID = ma.ACTOR_ID
GROUP BY a.NAME;



#6 Вывести жанры, в которых никогда не снимался Арнольд Шварценеггер
SELECT
       g.ID,
       g.NAME
FROM genre as g
	     INNER JOIN
    movie_genre mg on g.ID = mg.GENRE_ID
	     LEFT JOIN
    movie_actor ma on mg.MOVIE_ID = ma.MOVIE_ID AND ma.ACTOR_ID = 1
GROUP BY 1 HAVING COUNT(ma.MOVIE_ID) = 0;



# 7. Вывести список фильмов, у которых больше 3-х жанров.
SELECT MOVIE_ID
FROM (SELECT movie_genre.MOVIE_ID, COUNT(GENRE_ID) AS CJ
FROM movie_genre
GROUP BY  MOVIE_ID) AS T
WHERE T.CJ > 3;



#8 Вывести самый популярный жанр для каждого актёра.
SELECT
       a.NAME as Name_actor,
       (SELECT g.NAME FROM movie_actor ma
           INNER join
        movie_genre mg on ma.MOVIE_ID = mg.MOVIE_ID
           INNER join
        genre g on mg.GENRE_ID = g.ID
           WHERE ma.ACTOR_ID = a.ID
           GROUP BY 1
           ORDER BY COUNT(DISTINCT mg.MOVIE_ID)DESC
           LIMIT 1) AS Popular_genre
FROM actor a;