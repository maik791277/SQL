#1







#2






# 3. ������� ����� ���������� ����� ������� ��������.
SELECT
    MOVIE_ID  ,
	movie_title.TITLE as TITLE,
	MAX(LENGTH) as TIME
FROM movie_title, movie, director WHERE DIRECTOR_ID = 1 AND  movie_title.LANGUAGE_ID='ru';

# 4. ������� ������ ������� � ���������, ����������� �� 10 ��������. ���� �������� ������ 10 �������� � ��������� ��� ����. ���� ������� � ��������� �� 10 �������� � ��������� ����������.

SELECT MOVIE_ID,
       CASE WHEN LENGTH(TITLE) = 10
	            THEN TITLE
            ELSE CONCAT(LEFT(TITLE,10),'...')
	       END As TITLE
FROM  movie_title;

#5



#6



# 7. ������� ������ �������, � ������� ������ 3-� ������.
SELECT MOVIE_ID
FROM (SELECT movie_genre.MOVIE_ID, COUNT(GENRE_ID) AS CJ FROM movie_title, movie_genre
GROUP BY MOVIE_ID ,TITLE) AS T
WHERE T.CJ  3


#8