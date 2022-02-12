/*
Laboratorio 4: base de datos 1.
*/

create database registro_universidad;

/*relacion de student*/
CREATE SEQUENCE student_seq start with 7488 increment by 168;

--DROP SEQUENCE student_seq;

CREATE TABLE student(
    student_id int default nextval('student_seq'),
    name_s varchar(45) not null,
    program varchar(45) not null,
    primary key (student_id)
);

/*relacion de instructor*/
CREATE TABLE instructor(
    instructor_id int not null,
    name_i varchar(45) not null,
    dept varchar(45),
    title varchar(45),
    primary key (instructor_id)
);

/*relacion de course*/
CREATE SEQUENCE course_seq start with 837827 increment by 23;

CREATE TABLE course (
    course_id int default nextval('course_seq'),
    title varchar(45) not null,
    syllabus varchar(45) not null,
    credits int not null,
    primary key (course_id)
);

select * from course;

/*relacion de course offering*/
CREATE TABLE course_offering (
    course_id int not null,
    sec_id int not null,
    year int not null,
    semester int not null,
    time timestamp not null,
    classroom varchar(45) not null,
    foreign key (course_id) references course(course_id),
    primary key (course_id, sec_id, year, semester)
);

/*relacion enrols*/
CREATE TABLE enrols(
    student_id int not null,
    course_id int not null,
    sec_id int not null,
    semester int not null,
    year int not null,
    grade numeric(3, 2) check(grade > 1 and grade < 5) default 1,
    foreign key (student_id) references student(student_id),
    foreign key (course_id) references course(course_id),
    primary key (student_id, course_id, sec_id, semester, year) 
);

/*relacion de teaches*/
CREATE TABLE teaches(
    course_id int not null,
    sec_id int not null,
    semester int not null,
    year int not null,
    instructor_id int not null,
    foreign key (course_id) references course(course_id),
    foreign key (instructor_id) references instructor(instructor_id),
    primary key (course_id, sec_id, semester, year, instructor_id)
);

/*relacion de requires*/
CREATE TABLE requires(
    main_course varchar(45) not null,
    prerequisite varchar(45) not null
    foreign key (main_course) references course(course_id),
    foreign key (prerequisite) references enrols(sec_id),
    primary key (main_course, prerequisite)
);

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
