
/*inserccion de datos de las 7 relaciones */

insert into student (name_s, program) values 
    ('hooler', '3456'),
    ('keleer', '5678'),
    ('levinth', '3876'),
    ('junart', '4561'),
    ('sederich', '8765');

insert into instructor (instructor_id, name_i, dept, title) values
    (1, 'instructor 1', 'matematicas a', 'profesional 1'),
    (2, 'instructor 2', 'matematicas b', 'profesional 2'),
    (3, 'instructor 3', 'matematicas c', 'profesional 3'),
    (4, 'instructor 4', 'matematicas d', 'profesional 4'),
    (5, 'instructor 5', 'matematicas e', 'profesional 5');

insert into course (title, syllabus, credits) values 
    ('calculo 1', 'syllabus 2020', 4),
    ('calculo 3', 'syllabus', 3),
    ('calculo 2', 'syllabus 19', 2),
    ('calculo 4', 'syllabus 20', 4),
    ('calculo 5', 'syllabus 21', 3);

insert into course_offering (course_id, sec_id, year, semester, time, classroom) 
    values
        (837827, 1, 2000, 4, '17-02-2022 12:00:00',  '1027A'),
        (837850, 2, 2001, 2, '17-02-2022 12:01:00',  '1012B'),
        (837873, 3, 2002, 5, '17-02-2022 12:02:00',  '1115A'),
        (837896, 4, 2003, 3, '17-02-2022 12:03:00',  '1209C'),
        (837919, 5, 2004, 6, '17-02-2022 12:04:00',  '1210C');


