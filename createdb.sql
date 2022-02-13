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
    main_course int not null,
    prerequisite int not null,
    foreign key (main_course) references course(course_id),
    foreign key (prerequisite) references course(course_id),
    primary key (main_course, prerequisite)
);


