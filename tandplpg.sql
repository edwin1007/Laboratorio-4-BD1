--4.a.i     Al agregar una tupla en enrols, en caso de que la nota sea negativa, cero (0.0) o
--      mayor de 5.00 se debe generar una excepción indicando que el valor a guardar en
--      grade es incorrecto o invalido.

--BEFORE o AFTER ?

/*

alter TABLE high_schooler drop COLUMN his_id;
alter TABLE high_schooler add COLUMN his_id int not null
default nextval('his_id_seq');

*/

ALTER DATABASE registro_universidad RENAME TO sra_uv;

ALTER TABLE enrols DROP COLUMN grade;
ALTER TABLE enrols ADD COLUMN grade numeric(3, 2) not null;

/*modificacion de enrols, sin check en grade
    no es necesario crear tabla, solo se modificó 
    la columna.
*/

CREATE TABLE enrols(
    student_id int not null,
    course_id int not null,
    sec_id int not null,
    semester int not null,
    year int not null,
    grade numeric(3, 2),
    foreign key (student_id) references student(student_id),
    foreign key (course_id) references course(course_id),
    primary key (student_id, course_id, sec_id, semester, year) 
);

/*primer posible solucion*/

CREATE TRIGGER invalid_grade_insert
BEFORE INSERT ON enrols
FOR EACH ROW
    WHEN EXISTS (SELECT * FROM enrols
        WHERE NEW.grade = 0.00 OR NEW.grade < 0 OR NEW.grade > 5)
DECLARE 
    invalid_grade_excep EXCEPTION;
BEGIN
    RAISE invalid_grade_excep;
EXCEPTION 
    WHEN invalid_grade_excep THEN
        dbms_output.put_line('Grade must be bigger than 1 and smaller than 5!'); 
END;

/*segunda posible solucion*/

CREATE TRIGGER invalid_grade_insert
AFTER INSERT ON enrols
FOR EACH ROW
    WHEN EXISTS (SELECT * FROM enrols
                WHERE NEW.grade = 0.00 OR NEW.grade < 0 OR NEW.grade > 5)

DECLARE 
    invalid_grade_excep EXCEPTION;

BEGIN
    RAISE invalid_grade_excep;

EXCEPTION 
    WHEN invalid_grade_excep THEN
        ROLLBACK TRANSACTION;
        dbms_output.put_line('Grade must be bigger than 1 and smaller than 5!'); 
END;





--4.a.ii  Durante la actualización de un registro si el valor grade es modificado, usando
--      RAISE NOTICE se debe presentar un mensaje indicando el cambio, si es igual al
--      valor grade en la tabla se debe indicar que el valor no ha sido modificado. Si el
--      grade a actualizar es negativo, cero o mayor de cinco use RAISE EXCEPTION

CREATE TRIGGER same_grade_update
AFTER UPDATE ON enrols
FOR EACH ROW
    WHEN EXISTS (SELECT * FROM enrols
                WHERE NEW.grade = OLD.grade)
--DECLARE 
    --valid_grade_update NOTICE; --NSIN

BEGIN
    RAISE NOTICE 'The grade has not been modified';
END;



CREATE TRIGGER valid_different_grade_update
AFTER UPDATE ON enrols
FOR EACH ROW
    WHEN EXISTS (SELECT * FROM enrols
                WHERE NEW.grade > 0 OR NEW.grade < 5)   
--DECLARE 
    --valid_grade_update NOTICE; --NSIN

BEGIN
    RAISE NOTICE 'The grade has been changed to: ', NEW.grade;
    
END;




CREATE TRIGGER invalid_grade_update
AFTER UPDATE ON enrols
FOR EACH ROW
    WHEN EXISTS (SELECT * FROM enrols
                WHERE NEW.grade = 0.00 OR NEW.grade < 0 OR NEW.grade > 5)

DECLARE 
    invalid_grade_update_excep EXCEPTION; --NS

BEGIN
    --DELETE FROM friend
      --  WHERE his_id_A = OLD.his_id_B AND his_id_B = OLD.his_id_A;

    RAISE invalid_grade_update_excep; --NS

EXCEPTION 
    WHEN invalid_grade_excep THEN
        ROLLBACK TRANSACTION;
        --DELETE FROM enrols
            --WHERE NEW.grade = 0.00 OR NEW.grade < 0 OR NEW.grade > 5;
        --dbms_output.put_line('Grade must be bigger than 1 and smaller than 5!'); 
        RAISE NOTICE 'Grade must be bigger than 1 and smaller than 5!';
END;





--4.b.  Cree un procedimiento create_teaches que automáticamente agregue un registro a teaches.
--  Este recibe dos argumentos un identificador de instructor instructor_id y un identificador
--  de course_id. Se asume que ambos existen en la base de datos.
--  i. Este procedimiento debe verificar que el curso exista en la oferta de cursos.
--  ii.Use curse_id, sec_id, year y semester de la oferta de curso y instructor_id el para
--  insertar en teaches.


CREATE PROCEDURE create_teaches(instructor_id_arg INT, course_id_arg INT)
LANGUAGE SQL
AS $$
    BEGIN
        if (
            EXISTS( SELECT 1 FROM course_offering 
            WHERE course_id_arg = course_id) 
            )
        Begin

        INSERT INTO teaches VALUES(course_id_arg, 
        SELECT sec_id FROM course_offering LIMIT 1 WHERE course_offering.course_id = course_id_arg,
        SELECT semester FROM course_offering LIMIT 1 WHERE course_offering.course_id = course_id_arg,
        SELECT year FROM course_offering LIMIT 1 WHERE course_offering.course_id = course_id_arg,
        instructor_id_arg
        ));
        
    END;
$$;













