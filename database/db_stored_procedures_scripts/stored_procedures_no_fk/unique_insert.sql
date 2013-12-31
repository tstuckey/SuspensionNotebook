/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
use suspension;
delimiter &
/*------------------------------------------------*/


DROP PROCEDURE IF EXISTS suspension.unique_spring_length_insert;
CREATE PROCEDURE suspension.unique_spring_length_insert(
               IN `in_measure` int(10)
              )
BEGIN
   DECLARE existing_measure int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE measure_cursor CURSOR FOR
		SELECT row_id FROM suspension.spring_length
			      WHERE measure=`in_measure`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN measure_cursor;
      FETCH measure_cursor into existing_measure;
    CLOSE measure_cursor; 

    /*if the existing_measure was not found only then do we insert it*/
    IF existing_measure<=>NULL THEN
       /*create an empty work_order entry*/
       INSERT INTO suspension.spring_length (measure) VALUES(`in_measure`); 
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.unique_shim_OD_insert;
CREATE PROCEDURE suspension.unique_shim_OD_insert(
               IN `in_measure` decimal(3,2)
              )
BEGIN
   DECLARE existing_measure int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE measure_cursor CURSOR FOR
		SELECT row_id FROM suspension.shim_outer_diameter
			      WHERE measure=`in_measure`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN measure_cursor;
      FETCH measure_cursor into existing_measure;
    CLOSE measure_cursor; 

    /*if the existing_measure was not found only then do we insert it*/
    IF existing_measure<=>NULL THEN
       /*create an empty work_order entry*/
       INSERT INTO suspension.shim_outer_diameter (measure) VALUES(`in_measure`); 
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.unique_collar_width_insert;
CREATE PROCEDURE suspension.unique_collar_width_insert(
               IN `in_measure` decimal(3,2)
              )
BEGIN
   DECLARE existing_measure int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE measure_cursor CURSOR FOR
		SELECT row_id FROM suspension.collar_width
			      WHERE measure=`in_measure`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN measure_cursor;
      FETCH measure_cursor into existing_measure;
    CLOSE measure_cursor; 

    /*if the existing_measure was not found only then do we insert it*/
    IF existing_measure<=>NULL THEN
       /*create an empty work_order entry*/
       INSERT INTO suspension.collar_width (measure) VALUES(`in_measure`); 
    END IF;
END;


/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
&
delimiter ;
/*------------------------------------------------*/

