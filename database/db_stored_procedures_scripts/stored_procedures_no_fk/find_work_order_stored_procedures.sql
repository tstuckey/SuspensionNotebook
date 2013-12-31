/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
use suspension;
delimiter &
/*------------------------------------------------*/



DROP PROCEDURE IF EXISTS suspension.find_rider;
CREATE PROCEDURE find_rider(
		IN `in_work_order` int (10),
		OUT `out_rider_id` int (10),
		OUT `out_ability_id` int (10),
		OUT `out_first_name` varchar(100),
		OUT `out_last_name` varchar(100),
		OUT `out_ability` varchar(100)
                 )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE rider_id int(10) DEFAULT 0; 
   DECLARE ability_id int(10) DEFAULT 0; 
   DECLARE rider_first_name varchar(100) DEFAULT NULL; 
   DECLARE rider_last_name varchar(100)  DEFAULT NULL; 
   DECLARE rider_ability varchar(100)  DEFAULT NULL; 

   DECLARE rider_cursor CURSOR FOR 
           SELECT RIDER.row_id,ABILITY.row_id,
		  RIDER.first_name, RIDER.last_name, 
	          ABILITY.description 
           FROM 
                  suspension.work_order as WORK_ORDER
                  LEFT JOIN suspension.rider_instance as RIDER_INST
			ON WORK_ORDER.rider_instance=RIDER_INST.row_id
		  LEFT JOIN suspension.rider as RIDER
		        ON RIDER_INST.rider=RIDER.row_id
                  LEFT JOIN  suspension.rider_ability as ABILITY
		        ON RIDER_INST.rider_ability=ABILITY.row_id
                  WHERE 
                        WORK_ORDER.row_id=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 

   OPEN rider_cursor;
   FETCH rider_cursor INTO rider_id,ability_id,rider_first_name,rider_last_name,rider_ability;
   IF NOT done THEN
      SET `out_rider_id`=rider_id;
      SET `out_ability_id`=ability_id;
      SET `out_first_name`=rider_first_name;
      SET `out_last_name`=rider_last_name;
      SET `out_ability`=rider_ability;
   END IF;
  CLOSE rider_cursor; 
END;


DROP PROCEDURE IF EXISTS suspension.find_bike;
CREATE PROCEDURE find_bike(
		IN `in_work_order` int (10),
		OUT `out_year_id` int (10),
		OUT `out_model_id` int (10),
		OUT `out_bike_year` varchar(100),
		OUT `out_bike_brand` varchar(100),
		OUT `out_bike_model` varchar(100)
                 )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE year_id int(10) DEFAULT 0; 
   DECLARE model_id int(10) DEFAULT 0; 
   DECLARE bike_year varchar(100) DEFAULT NULL; 
   DECLARE bike_brand varchar(100)  DEFAULT NULL; 
   DECLARE bike_model varchar(100)  DEFAULT NULL; 

   DECLARE bike_cursor CURSOR FOR 
                        SELECT YEAR.row_id,MODEL.row_id,
			       YEAR.year,MODEL.brand, MODEL.model 
                        FROM 
                             suspension.work_order as WORK_ORDER,
                             suspension.bike as BIKE, 
                             suspension.bike_year as YEAR,
			     suspension.bike_brand_model as MODEL 
                        WHERE 
                             WORK_ORDER.row_id=`in_work_order` AND
                             WORK_ORDER.bike=BIKE.row_id AND
                             BIKE.bike_year=YEAR.row_id AND
			     BIKE.bike_brand_model=MODEL.row_id;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 

   OPEN bike_cursor;
   FETCH bike_cursor INTO year_id,model_id,bike_year,bike_brand,bike_model;  
   IF NOT done THEN
      SET `out_year_id`=year_id;
      SET `out_model_id`=model_id;
      SET `out_bike_year`=bike_year;
      SET `out_bike_brand`=bike_brand;
      SET `out_bike_model`=bike_model;
   END IF;
  CLOSE bike_cursor; 
END;


DROP PROCEDURE IF EXISTS suspension.find_setting_info;
CREATE PROCEDURE find_setting_info(
		IN `in_work_order` int (10),
		OUT `out_setting_id` int(10),
		OUT `out_date` varchar(100)
                 )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE setting_id int(10) DEFAULT 0; 
   DECLARE date varchar(100)  DEFAULT NULL; 

   DECLARE setting_info CURSOR FOR 
                        SELECT SETTING.row_id, 
			       SETTING.date 
                        FROM 
                             suspension.work_order as WORK_ORDER,
                             suspension.setting as SETTING 
                        WHERE 
                             WORK_ORDER.row_id=`in_work_order` AND
                             WORK_ORDER.setting=SETTING.row_id;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 

   OPEN setting_info;
   FETCH setting_info INTO setting_id,date; 
   IF NOT done THEN
      SET `out_setting_id`=setting_id;
      SET `out_date`=date;
   END IF;
  CLOSE setting_info; 
END;

DROP PROCEDURE IF EXISTS suspension.find_service_location;
CREATE PROCEDURE find_service_location(
		IN `in_work_order` int (10),
		OUT `out_service_location` varchar(100)
                 )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE service_location varchar(100) DEFAULT NULL; 

   DECLARE service_cursor CURSOR FOR 
                        SELECT SRV_LOC.location
                        FROM 
                             suspension.work_order as WORK_ORDER,
                             suspension.service_location as SRV_LOC 
                        WHERE 
                             WORK_ORDER.row_id=`in_work_order` AND
                             WORK_ORDER.service_location=SRV_LOC.row_id;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 

   OPEN service_cursor;
   FETCH service_cursor INTO service_location; 
   IF NOT done THEN
      SET `out_service_location`=service_location;
   END IF;
  CLOSE service_cursor; 
END;

DROP PROCEDURE IF EXISTS suspension.find_terrain;
CREATE PROCEDURE find_terrain(
		IN `in_work_order` int (10),
		OUT `out_terrain_description` varchar(500)
                 )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE this_terrain_description varchar(100); 
   DECLARE count INT DEFAULT 0;

   DECLARE terrain_cursor CURSOR FOR 
                          SELECT TERRAIN.description as `Terrain`
                          FROM 
                                 suspension.terrain_combo as TC,
                                 suspension.terrain as TERRAIN
                          WHERE 
                                 TC.work_order=`in_work_order` AND
                                 TC.terrain=TERRAIN.row_id;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; /*To handle when no rows found*/

   OPEN terrain_cursor;
   SET `out_terrain_description`="";/*Initialize the description*/
      REPEAT
          FETCH terrain_cursor INTO this_terrain_description;
          IF NOT done THEN
	     IF count=0 THEN
                SET `out_terrain_description`=this_terrain_description;     
	        ELSE
                SET `out_terrain_description`=CONCAT(`out_terrain_description`, ",", this_terrain_description);     
	     END IF;
          END IF;
	  SET count=count+1; 
     UNTIL done END REPEAT;

   CLOSE terrain_cursor; 
END;

DROP PROCEDURE IF EXISTS suspension.find_riding_type;
CREATE PROCEDURE find_riding_type(
		IN `in_work_order` int (10),
		OUT `out_riding_description` varchar(500)
                 )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE this_riding_description varchar(100); 
   DECLARE count INT DEFAULT 0;

   DECLARE riding_type_cursor CURSOR FOR 
                          SELECT RIDING_TYPE.description
                          FROM 
                                 suspension.riding_type_combo as RIDING_COMBO,
                                 suspension.riding_type as RIDING_TYPE 
                          WHERE 
                                 RIDING_COMBO.work_order=`in_work_order` AND
                                 RIDING_COMBO.riding_type=RIDING_TYPE.row_id;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; /*To handle when no rows found*/

   OPEN riding_type_cursor;
   SET `out_riding_description`="";/*Initialize the description*/
      REPEAT
          FETCH riding_type_cursor INTO this_riding_description;
          IF NOT done THEN
	     IF count=0 THEN
                SET `out_riding_description`=this_riding_description;     
	        ELSE
                SET `out_riding_description`=CONCAT(`out_riding_description`, ",", this_riding_description);
	     END IF;
          END IF;
	  SET count=count+1; 
     UNTIL done END REPEAT;

   CLOSE riding_type_cursor; 
END;


/*This procedure returns the revision info for a given work_order*/
DROP PROCEDURE IF EXISTS suspension.find_revision;
CREATE PROCEDURE suspension.find_revision(
                 IN `in_work_order_id` int(10),
	         OUT `out_shock_revision` decimal(5,2),
	         OUT `out_fork_revision` decimal(5,2)
                )
BEGIN
   DECLARE this_shock_revision decimal(52) DEFAULT 0; 
   DECLARE this_fork_revision decimal(52) DEFAULT 0; 
   DECLARE done INT DEFAULT 0;

   DECLARE revision_cursor CURSOR FOR
                          SELECT SHOCK_SPEC.revision_number,
			         FORK_SPEC.revision_number
                          FROM suspension.work_order as WORK_ORDER, 
			       suspension.setting as SETTING,
			       suspension.fork_spec as FORK_SPEC,
			       suspension.shock_spec as SHOCK_SPEC
                          WHERE WORK_ORDER.row_id=`in_work_order_id` AND
			        WORK_ORDER.setting=SETTING.row_id AND
				SETTING.fork_spec=FORK_SPEC.row_id AND
				SETTING.shock_spec=SHOCK_SPEC.row_id; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; /*To handle when no rows found*/

    OPEN revision_cursor;
    FETCH revision_cursor into this_shock_revision,this_fork_revision;
    SET `out_shock_revision`=this_shock_revision;
    SET `out_fork_revision`=this_fork_revision;
    CLOSE revision_cursor; 
END;

DROP PROCEDURE IF EXISTS suspension.prepare_limit_statement;
CREATE PROCEDURE suspension.prepare_limit_statement(
               IN `in_page` int(3),
               OUT `out_limit_statement` varchar(50) 
              )
BEGIN
  /*we are going to return 50 records per page*/
  SET @records_per_page=50;
  /*take whatever page of results we want to retrieve*/
  /*multiply it by the number of results we are displaying per page*/
  /*and subtract the number of results we are displaying per page*/
  SET @start_value=`in_page` * @records_per_page - @records_per_page;
  SET `out_limit_statement`=CONCAT(" LIMIT ",@start_value,",",@records_per_page); 
END;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*The Find Setting Stored Procedure*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.find_work_orders;
CREATE PROCEDURE suspension.find_work_orders (
               IN `in_page` int(3),
               IN `in_rider_id` int(10),
               IN `in_year_id` int(10),
               IN `in_model_id` int(10),
               IN `in_ability_id` int(10)
       )

BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE this_work_order int(10); 

   DECLARE work_order_cursor CURSOR FOR SELECT row_id FROM suspension.work_order; 
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; /*To handle when no rows found*/

   SET @start_syntax="
       SELECT 
       	      work_order AS 'Work Order', 
              CONCAT(last_name,', ',first_name) AS 'Customer',
              ability AS 'Ability',
	      CONCAT(year,' ',brand,' ',model) AS 'Bike',
	      shock_rev AS 'Shock rev', 
	      fork_rev AS 'Fork rev', 
	      date AS 'Date',
	      service_location AS 'Center',
	      terrain AS 'Terrain',
	      riding_type AS 'Riding Type'
       FROM suspension.lookup_table "; 
      SET @where_syntax=" WHERE work_order>0 ";/*initialize the where syntax with something always true*/

      IF `in_rider_id` > 0 THEN 
          SET @where_syntax=CONCAT(@where_syntax,
              " AND rider_id =", `in_rider_id`);
      END IF;

      IF `in_year_id` > 0 THEN 
          SET @where_syntax=CONCAT(@where_syntax,
              " AND year_id =", `in_year_id`);
      END IF;

      IF `in_model_id` > 0 THEN 
          SET @where_syntax=CONCAT(@where_syntax,
              " AND model_id =", `in_model_id`);
      END IF;

      IF `in_ability_id` > 0 THEN 
          SET @where_syntax=CONCAT(@where_syntax,
              " AND ability_id =", `in_ability_id`);
      END IF;

     /*SET @order_by_syntax=CONCAT(" ORDER BY 'Work Order' DESC , Date DESC,Customer,'Shock rev','Fork rev' "); */
     SET @order_by_syntax=CONCAT(" ORDER BY work_order  "); 
     call prepare_limit_statement(`in_page`,@limit_syntax);

     SET @syntax=CONCAT(@start_syntax, @where_syntax,@order_by_syntax,@limit_syntax,";");
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;
END;

DROP PROCEDURE IF EXISTS suspension.get_number_of_work_orders;
CREATE PROCEDURE suspension.get_number_of_work_orders (
               IN `in_rider_id` int(10),
               IN `in_year_id` int(10),
               IN `in_model_id` int(10),
               IN `in_ability_id` int(10)
       )

BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE this_work_order int(10); 

   DECLARE work_order_cursor CURSOR FOR SELECT row_id FROM suspension.work_order; 
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; /*To handle when no rows found*/
   SET @records_per_page=50;

   SET @start_syntax="
       SELECT 
       	      count(row_id) AS 'total', @records_per_page AS 'records per page' 
       FROM suspension.lookup_table "; 
      SET @where_syntax=" WHERE work_order>0 ";/*initialize the where syntax with something always true*/

      IF `in_rider_id` > 0 THEN 
          SET @where_syntax=CONCAT(@where_syntax,
              " AND rider_id =", `in_rider_id`);
      END IF;

      IF `in_year_id` > 0 THEN 
          SET @where_syntax=CONCAT(@where_syntax,
              " AND year_id =", `in_year_id`);
      END IF;

      IF `in_model_id` > 0 THEN 
          SET @where_syntax=CONCAT(@where_syntax,
              " AND model_id =", `in_model_id`);
      END IF;

      IF `in_ability_id` > 0 THEN 
          SET @where_syntax=CONCAT(@where_syntax,
              " AND ability_id =", `in_ability_id`);
      END IF;

     SET @syntax=CONCAT(@start_syntax, @where_syntax);
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;
END;


/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
&
delimiter ;
/*------------------------------------------------*/

