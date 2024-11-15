--COPY filename FROM 'C:\SQL\DATABASE\filename.csv' DELIMITER ';' CSV HEADER ENCODING 'windows-1251';

--1.  использующие реляционные и булевы операторы в предикатах

/*SELECT *
FROM house
WHERE cost_per_day < 6500
AND (capacity = 4 OR capacity = 5);*/

/*SELECT *
FROM contract
WHERE NOT overall_cost > 30000
AND NOT house_id = 5;*/



--2.  с использованием специальных операторов в условиях

/*SELECT house_id,
	   cost_per_day,
	   capacity
FROM house
WHERE capacity IN (4,
				   6);*/

/*SELECT booking_id,
       start_date,
	   end_date
FROM booking
WHERE end_date BETWEEN '2024-11-21' AND '2025-01-01';*/				   

/*SELECT house_id,
       description,
	   photo
FROM house
WHERE description LIKE '%уют%';*/

--3.  с использованием групповых функций (где структура данных допускает их использование)

/*SELECT house_id,
       AVG(rating)
FROM feedback GROUP BY house_id ORDER BY AVG(rating) DESC
LIMIT 8;*/

/*SELECT payment_id, 
	     AVG(amount) AS average
FROM payment
GROUP BY payment_id 
HAVING AVG(amount) < 40000
ORDER BY payment_id;*/


--4.  на вычислимое поле с форматированием результата

/*SELECT booking_id, 
       overall_cost,
       CONCAT(overall_cost, ' рублей 00 копеек') AS formatted_cost
FROM booking;*/


--5.  с использованием нескольких таблиц

/*SELECT house.house_id, COUNT(booking.booking_id) AS times_booked
FROM house
LEFT JOIN booking 
ON house.house_id = booking.house_id
GROUP BY house.house_id
ORDER BY house.house_id;*/


--6.  на соединение таблицы самой с собой


/*SELECT h1.house_id, h1.capacity, h2.house_id, h2.capacity
FROM house h1
JOIN house h2 ON h1.capacity = h2.capacity
WHERE h1.house_id != h2.house_id;*/



--7. с использованием вложенных запросов

/*SELECT h.house_id, h.capacity, h.cost_per_day
FROM house h
WHERE h.capacity = (SELECT MIN(capacity) FROM house);*/

--8.  на связанные подзапросы


/*SELECT b.booking_id, b.start_date, b.overall_cost
FROM booking b
WHERE b.overall_cost = (
  SELECT MAX(overall_cost)
  FROM booking
  WHERE b.start_date = start_date
); */

--9.  с использованием операторов EXIST, ANY, ALL, SOME

/*SELECT booking_id, start_date, end_date, house_id
FROM booking b
WHERE b.extra_service_id = SOME (
  SELECT extra_service_id
  FROM extra_service
  WHERE extra_service_id = 5
); */


--10.  с использованием оператора UNION

/*SELECT b.booking_id, b.overall_cost, 'Confirmed' AS booking_status
FROM booking b
WHERE b.status = 'Подтверждено' AND NOT EXISTS (
    SELECT 1
    FROM payment p
    WHERE p.booking_id = b.booking_id AND p.paid = true
)
UNION 
SELECT b.booking_id, p.amount, 'Confirmed and paid' AS booking_status
FROM booking b
JOIN payment p ON b.booking_id = p.booking_id
WHERE b.status = 'Подтверждено' AND p.paid = true
ORDER BY booking_id;*/

--11.  с командами обновления

/*UPDATE house
--SET cost_per_day = 3500          -- НЕ ТРОГАТЬ - почему то меняет сортировку house_id
--WHERE cost_per_day = 4000;*/

/*SELECT*
FROM house
ORDER BY house_id;*/


--COPY house FROM 'C:\SQL\DATABASE\house.csv' DELIMITER ';' CSV HEADER ENCODING 'windows-1251';
