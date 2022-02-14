

--3.3.a   Encuentre el dept, title de los instructores registrados en la base de datos.
SELECT dept, title 
FROM instructor;


--3.3.b   Indique el nombre y programa del estudiante con student_id = 76567
SELECT name_s, program 
FROM student
WHERE student_id = 76567;


--3.3.c   Encuentre los nombres de todos los estudiantes que se han matriculado en el curso con
--        course_id = 837873
SELECT name_s 
FROM student NATURAL JOIN enrols
WHERE course_id = 837873;


--3.3.d   Cree una vista llamada better_students que presente los estudiantes que obtuvieron las
--        notas más altas por cada semestre entre los años 1900 y 2018


select student_id, grade, year, name_s as better_students
from  student
natural join  enrols WHERE year > 1900 and year < 2018
order by grade desc limit 3;




