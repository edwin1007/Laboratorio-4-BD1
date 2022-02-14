--4.a.i     Al agregar una tupla en enrols, en caso de que la nota sea negativa, cero (0.0) o
--      mayor de 5.00 se debe generar una excepción indicando que el valor a guardar en
--      grade es incorrecto o invalido.

--BEFORE o AFTER ?



CREATE TRIGGER invalid_grade_insert
BEFORE INSERT ON enrols
FOR EACH ROW
    WHEN EXISTS (SELECT * FROM enrols
                WHERE NEW.grade = 0.00 OR NEW.grade < 0 OR NEW.grade > 5)

DECLARE 
    invalid_grade_excep EXCEPTION;

BEGIN
    --DELETE FROM friend
      --  WHERE his_id_A = OLD.his_id_B AND his_id_B = OLD.his_id_A;

    RAISE invalid_grade_excep;

EXCEPTION 
    WHEN invalid_grade_excep THEN
        dbms_output.put_line('Grade must be bigger than 1 and smaller than 5!'); 

END;





CREATE TRIGGER invalid_grade_insert
AFTER INSERT ON enrols
FOR EACH ROW
    WHEN EXISTS (SELECT * FROM enrols
                WHERE NEW.grade = 0.00 OR NEW.grade < 0 OR NEW.grade > 5)

DECLARE 
    invalid_grade_excep EXCEPTION;

BEGIN
    --DELETE FROM friend
      --  WHERE his_id_A = OLD.his_id_B AND his_id_B = OLD.his_id_A;

    RAISE invalid_grade_excep;

EXCEPTION 
    WHEN invalid_grade_excep THEN
        ROLLBACK TRANSACTION;
        --DELETE FROM enrols
            --WHERE NEW.grade = 0.00 OR NEW.grade < 0 OR NEW.grade > 5;
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


CREATE PROCEDURE create_teaches(instructor_id INT, course_id INT)
LANGUAGE SQL
AS $$
    BEGIN

        -- A is a friend of B
        INSERT INTO friend VALUES(id_A, id_B);
        -- B is a friend of A
        INSERT INTO friend VALUES(id_B, id_A);
        -- Hacer las inserciones 
        COMMIT;
    END;
$$;













