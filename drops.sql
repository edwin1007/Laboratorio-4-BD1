
/*elimar tablas, secuencias y triggers*/

DROP PROCEDURE create_teaches;

DROP TRIGGER invalid_grade_insert ON enrols;

DROP TRIGGER same_grade_update ON enrols;

DROP TRIGGER invalid_grade_update ON enrols;

DROP TRIGGER invalid_grade_insert ON enrols;

DROP TABLE requires;

DROP TABLE teaches;

DROP TABLE enrols;

DROP TABLE course_offering;

DROP TABLE course;

DROP TABLE instructor;

DROP TABLE student;

DROP SEQUENCE course_seq;

DROP SEQUENCE student_seq;
