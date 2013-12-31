/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
use suspension;
delimiter &
/*------------------------------------------------*/

DROP PROCEDURE IF EXISTS suspension.clear_open_work_orders;
CREATE PROCEDURE suspension.clear_open_work_orders(
              )
/*This procedure is for clearing the open work orders */
/*It is invoked if the application crashes and leaves work orders locked for editing*/
BEGIN
  DELETE FROM open_work_orders;
END;

DROP PROCEDURE IF EXISTS suspension.prepare_comments;
CREATE PROCEDURE suspension.prepare_comments(
               IN `in_comments` varchar(5000),
               OUT `out_comments_id` int(10) 
              )
BEGIN
   DECLARE comments_id int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE id_cursor CURSOR FOR
                     SELECT COMMENTS.row_id FROM suspension.comments 
                                            WHERE COMMENTS.comments =`in_comments`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

   IF (LENGTH(`in_comments`)=0) THEN
        SET `out_comments_id`=0;
        ELSE
          OPEN id_cursor;
            FETCH id_cursor into comments_id;
          CLOSE id_cursor; 

         IF comments_id<=>NULL THEN
              INSERT INTO suspension.comments (comments) VALUES (`in_comments`);
              SET `out_comments_id`=LAST_INSERT_ID();
             ELSE
              SET `out_comments_id`=comments_id;
         END IF;
   END IF;
END;


DROP PROCEDURE IF EXISTS suspension.collect_bike;
CREATE PROCEDURE suspension.collect_bike(
               IN `in_work_order` int(10),
	       OUT `out_year` varchar(10),
               OUT `out_brand` varchar(100), 
               OUT `out_model` varchar(100) 
              )
BEGIN
   DECLARE existing_year varchar(10) DEFAULT 0; 
   DECLARE existing_brand varchar(100) DEFAULT 0;  
   DECLARE existing_model varchar(100) DEFAULT 0; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE bike_cursor CURSOR FOR
   	SELECT 
        	YEAR.year as `Year`,
        	MODEL.brand as `Brand`,
        	MODEL.model as `Model`
   	FROM suspension.work_order as WORK_ORDER 
        	LEFT JOIN suspension.bike as BIKE 
			ON WORK_ORDER.bike=BIKE.row_id
        	LEFT JOIN suspension.bike_year as YEAR
			ON BIKE.bike_year=YEAR.row_id
        	LEFT JOIN suspension.bike_brand_model as MODEL 
			ON BIKE.bike_brand_model=MODEL.row_id
   	WHERE WORK_ORDER.row_id=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN bike_cursor;
      FETCH bike_cursor into existing_year, existing_brand, existing_model;
    CLOSE bike_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    /*IF existing_year != 0 THEN*/
         SET `out_year`=existing_year;
         SET `out_brand`=existing_brand;
         SET `out_model`=existing_model;
    /*END IF;*/
END;


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*The Get General Informtion*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_general_info;
CREATE PROCEDURE suspension.get_general_info (
               IN `in_work_order_id` int(10)
       )
BEGIN
   /*get the revision specs for this work order*/
   SET @shock_revision=0;
   SET @fork_revision=0;
   SET @year=null;
   SET @brand=null;
   SET @model=null;

   call find_revision(`in_work_order_id`,@shock_revision,@fork_revision);
   call collect_bike(`in_work_order_id`,@year,@brand,@model); 
   SELECT 
        RIDER.first_name as `First Name`,
        RIDER.last_name as `Last Name`,
        ABILITY.description as `Riding Ability`,
	@year  as `Year`,
	@brand as `Brand`,
	@model as `Model`,
        @shock_revision as `shock_rev`,
        @fork_revision as `fork_rev`
   FROM suspension.work_order as WORK_ORDER 
        LEFT JOIN suspension.rider_instance as RIDER_INST
		ON WORK_ORDER.rider_instance=RIDER_INST.row_id
        LEFT JOIN suspension.rider as RIDER
		ON RIDER_INST.rider=RIDER.row_id
        LEFT JOIN suspension.rider_ability as ABILITY
		ON RIDER_INST.rider_ability=ABILITY.row_id
 WHERE WORK_ORDER.row_id=`in_work_order_id`;
END;


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedure prepares the setting_id*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.prepare_setting;
CREATE PROCEDURE suspension.prepare_setting(
               IN `in_setting` int(10),
               OUT `out_setting` int(10) 
              )
BEGIN
   DECLARE existing_setting int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE setting_cursor CURSOR FOR
		SELECT row_id FROM suspension.setting
			      WHERE row_id=`in_setting`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN setting_cursor;
      FETCH setting_cursor into existing_setting;
    CLOSE setting_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF existing_setting<=>NULL THEN
       /*create an empty work_order entry*/
       INSERT INTO suspension.setting () VALUES(); 
       SET @new_setting=LAST_INSERT_ID();
       SET `out_setting`=@new_setting;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_setting`=existing_setting;
     END IF;
END;
/*-------------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS suspension.get_work_order_for_setting;
CREATE PROCEDURE suspension.get_work_order_for_setting(
               IN `in_setting` int(10),
               OUT `out_work_order` int(10) 
              )
BEGIN
   DECLARE existing_work_order int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE work_order_cursor CURSOR FOR
		SELECT row_id FROM suspension.work_order
			      WHERE setting=`in_setting`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN work_order_cursor;
      FETCH work_order_cursor into existing_work_order;
    CLOSE work_order_cursor; 

    IF existing_work_order<=>NULL THEN
       SET `out_work_order`=0;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_work_order`=existing_work_order;
     END IF;
END;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedure deal with the fork and shock arrivale specs*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.prepare_arrival_spec;
CREATE PROCEDURE suspension.prepare_arrival_spec(
               IN `in_setting` int(10),
               OUT `out_arrival_spec` int(10) 
              )
BEGIN
     DECLARE existing_arrival_spec int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE arrival_spec_cursor CURSOR FOR
		SELECT settings_on_arrival FROM suspension.setting
				           WHERE row_id=`in_setting`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     OPEN arrival_spec_cursor;
       FETCH arrival_spec_cursor into existing_arrival_spec;
     CLOSE arrival_spec_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF existing_arrival_spec<=>NULL THEN
       /*create an empty work_order entry*/
       INSERT INTO suspension.settings_on_arrival () VALUES(); 
       SET @new_arrival_spec=LAST_INSERT_ID();
       /*update the setting record with the new arrival_arrival_spec reference*/
       SELECT "the in_setting is ",`in_setting`;
       UPDATE suspension.setting SET settings_on_arrival=@new_arrival_spec WHERE row_id=`in_setting`;
       SET `out_arrival_spec`=@new_arrival_spec;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_arrival_spec`=existing_arrival_spec;
     END IF;
END;


DROP PROCEDURE IF EXISTS suspension.prepare_arrival_shock_spec;
CREATE PROCEDURE suspension.prepare_arrival_shock_spec(
               IN `in_settings_on_arrival` int(10),
               OUT `out_shock_spec` int(20) 
              )
BEGIN
   DECLARE spec_id int(20); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE spec_cursor CURSOR FOR
		SELECT shock_spec FROM suspension.settings_on_arrival
		                  WHERE row_id=`in_settings_on_arrival`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN spec_cursor;
      FETCH spec_cursor into spec_id;
    CLOSE spec_cursor; 

    /*if the spec_id was null, return 0; otherwise return the spec_id*/
    IF spec_id<=>NULL THEN
       /*create an empty shock_spec entry*/
       INSERT INTO suspension.shock_spec () VALUES(); 
       SET @new_arrival_spec=LAST_INSERT_ID();
       /*update the settings_on_arrival record with the new shock_spec reference*/
       UPDATE suspension.settings_on_arrival SET shock_spec=@new_arrival_spec WHERE row_id=`in_settings_on_arrival`;
       SET `out_shock_spec`=@new_arrival_spec;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_shock_spec`=spec_id;
   END IF;
END;


DROP PROCEDURE IF EXISTS suspension.save_shock_arrival_settings;
CREATE PROCEDURE suspension.save_shock_arrival_settings(
	       IN `in_setting_id` int(10),
	       IN `in_leaking` int(1),
               IN `in_spring` decimal(4,3),
               IN `in_LS_comp` int(2),
               IN `in_HS_comp` varchar(5),
               IN `in_reb` int(2),
	       IN `in_compressed_length` int(4),
	       IN `in_free_length` int(4)
       )

BEGIN 
     SET @valid_work_order=0;
     SET @valid_setting_id=0;
     SET @valid_arrival_spec=0;
     SET @valid_shock_spec=0;

     call prepare_setting(`in_setting_id`,@valid_setting_id);
     /*SELECT "valid setting id  is ",@valid_setting_id;*/
     call prepare_arrival_spec(@valid_setting_id,@valid_arrival_spec);
     /*SELECT "valid arrival spec  is ",@valid_arrival_spec;*/
     call prepare_arrival_shock_spec(@valid_arrival_spec,@valid_shock_spec);
     /*SELECT "valid shock spec  is ",@valid_shock_spec;*/

     UPDATE suspension.settings_on_arrival SET shock_leaking=`in_leaking` WHERE row_id=@valid_arrival_spec;

     UPDATE suspension.shock_spec SET springs=`in_spring` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET LS_comp_clicks=`in_LS_comp` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET HS_comp_turns=`in_HS_comp` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET reb_clicks=`in_reb` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET compressed_length=`in_compressed_length` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET free_length=`in_free_length` WHERE row_id=@valid_shock_spec;

     call get_work_order_for_setting(@valid_setting_id, @valid_work_order);
     call update_lookup_table(@valid_work_order);
END;

DROP PROCEDURE IF EXISTS suspension.prepare_arrival_fork_spec;
CREATE PROCEDURE suspension.prepare_arrival_fork_spec(
               IN `in_settings_on_arrival` int(10),
               OUT `out_fork_spec` int(20) 
              )
BEGIN
   DECLARE spec_id int(20); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE spec_cursor CURSOR FOR
		SELECT fork_spec FROM suspension.settings_on_arrival
		                  WHERE row_id=`in_settings_on_arrival`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN spec_cursor;
      FETCH spec_cursor into spec_id;
    CLOSE spec_cursor; 

    /*if the spec_id was null, return 0; otherwise return the spec_id*/
    IF spec_id<=>NULL THEN
       /*create an empty fork_spec entry*/
       INSERT INTO suspension.fork_spec () VALUES(); 
       SET @new_arrival_spec=LAST_INSERT_ID();
       /*update the settings_on_arrival record with the new shock_spec reference*/
       UPDATE suspension.settings_on_arrival SET fork_spec=@new_arrival_spec WHERE row_id=`in_settings_on_arrival`;
       SET `out_fork_spec`=@new_arrival_spec;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_fork_spec`=spec_id;
   END IF;
END;

DROP PROCEDURE IF EXISTS suspension.save_fork_arrival_settings;
CREATE PROCEDURE suspension.save_fork_arrival_settings(
	       IN `in_setting_id` int(10),
	       IN `in_leaking` int(1),
               IN `in_spring` decimal(4,3),
               IN `in_comp` int(2),
               IN `in_reb` int(2),
               IN `in_oil_vol` int(3),
               IN `in_oil_height` int(3),
	       IN `in_spring_length` int(4),
	       IN `in_chamber_length` int(4)
       )

BEGIN 
     SET @valid_work_order=0;
     SET @valid_setting_id=0;
     SET @valid_arrival_spec=0;
     SET @valid_fork_spec=0;

     call prepare_setting(`in_setting_id`,@valid_setting_id);
     call prepare_arrival_spec(@valid_setting_id,@valid_arrival_spec);
     call prepare_arrival_fork_spec(@valid_arrival_spec,@valid_fork_spec);

     UPDATE suspension.settings_on_arrival SET forks_leaking=`in_leaking` WHERE row_id=@valid_arrival_spec;

     UPDATE suspension.fork_spec SET springs=`in_spring` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET comp_clicks=`in_comp` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET reb_clicks=`in_reb` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET oil_vol=`in_oil_vol` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET oil_height=`in_oil_height` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET spring_length=`in_spring_length` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET chamber_length=`in_chamber_length` WHERE row_id=@valid_fork_spec;

     call get_work_order_for_setting(@valid_setting_id, @valid_work_order);
     call update_lookup_table(@valid_work_order);
END;
/*-------------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS suspension.remove_additional_products_from_work_order;
CREATE PROCEDURE suspension.remove_additional_products_from_work_order(
               IN `in_work_order_id`  int(10),
               IN `in_type` varchar(20)
       )

BEGIN
   IF (`in_type`="Fork") THEN 
      SET @syntax=CONCAT("  DELETE from suspension.fork_additional_products_combo",
                         "  WHERE work_order=",`in_work_order_id`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;

   IF (`in_type`="Shock") THEN 
      SET @syntax=CONCAT("  DELETE from suspension.shock_additional_products_combo",
                         "  WHERE work_order=",`in_work_order_id`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;
   FLUSH QUERY CACHE;
END;


DROP PROCEDURE IF EXISTS suspension.save_additional_products;
CREATE PROCEDURE suspension.save_additional_products(
	       IN `in_work_order` int(10),
               IN `in_type` varchar(20),
               IN `in_product_id` int(10),
               IN `in_comments` varchar(5000)
       )

BEGIN
     SET @valid_work_order=0;
     SET @valid_setting_id=0;	
     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
     
     IF (`in_type`="Shock") THEN
        SET @table_name="suspension.shock_additional_products_combo"; 
        SET @col_name="shock_additional_products";
     END IF;

     IF (`in_type`="Fork") THEN
        SET @table_name="suspension.fork_additional_products_combo"; 
        SET @col_name="fork_additional_products";
     END IF;

     call prepare_comments(`in_comments`,@new_comments_id); 

     SET @syntax=CONCAT("  INSERT INTO ", @table_name, " (work_order, ", @col_name,", comments) ",
                        "  VALUES (",@valid_work_order,",",`in_product_id`,",",@new_comments_id,");"
                       );
     /*Now execute the statement prepared from above*/
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;
     FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.get_settings_fork_additional_products;
CREATE PROCEDURE get_settings_fork_additional_products(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ADD_PROD.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM suspension.fork_additional_products_combo as ADD_PROD_COMBO
           LEFT JOIN suspension.fork_additional_products as ADD_PROD 
		   ON ADD_PROD_COMBO.fork_additional_products=ADD_PROD.row_id 
           LEFT JOIN suspension.comments as COMMENTS 
		   ON ADD_PROD_COMBO.comments=COMMENTS.row_id
       WHERE 
	    ADD_PROD_COMBO.work_order=`in_work_order`; 
END;


DROP PROCEDURE IF EXISTS suspension.get_settings_shock_additional_products;
CREATE PROCEDURE get_settings_shock_additional_products(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ADD_PROD.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM suspension.shock_additional_products_combo as ADD_PROD_COMBO
           LEFT JOIN suspension.shock_additional_products as ADD_PROD 
		   ON ADD_PROD_COMBO.shock_additional_products=ADD_PROD.row_id 
           LEFT JOIN suspension.comments as COMMENTS 
		   ON ADD_PROD_COMBO.comments=COMMENTS.row_id
       WHERE 
	    ADD_PROD_COMBO.work_order=`in_work_order`; 
END;
/*-------------------------------------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with fork and shock standard work requested*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.remove_standard_work_from_work_order;
CREATE PROCEDURE suspension.remove_standard_work_from_work_order(
               IN `in_work_order`  int(10),
               IN `in_type` varchar(20)
       )

BEGIN
   IF (`in_type`="Fork") THEN 
      SET @syntax=CONCAT("  DELETE from suspension.fork_work_combo",
                         "  WHERE work_order=",`in_work_order`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;

   IF (`in_type`="Shock") THEN 
      SET @syntax=CONCAT("  DELETE from suspension.shock_work_combo",
                         "  WHERE work_order=",`in_work_order`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;
   FLUSH QUERY CACHE;
END;


DROP PROCEDURE IF EXISTS suspension.save_standard_work;
CREATE PROCEDURE suspension.save_standard_work(
	       IN `in_work_order` int(10),
               IN `in_type` varchar(20),
               IN `in_product_id` int(10),
               IN `in_comments` varchar(5000)
       )

BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;
     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
     
     IF (`in_type`="Fork") THEN
        SET @table_name="suspension.fork_work_combo"; 
        SET @col_name="fork_work";
     END IF;

     IF (`in_type`="Shock") THEN
        SET @table_name="suspension.shock_work_combo"; 
        SET @col_name="shock_work";
     END IF;

     call prepare_comments(`in_comments`,@new_comments_id); 
     SET @syntax=CONCAT("  INSERT INTO ", @table_name, " (work_order, ", @col_name,", comments) ",
                        "  VALUES (",@valid_work_order,",",`in_product_id`,",",@new_comments_id,");"
                       );
     /*Now execute the statement prepared from above*/
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;
     FLUSH QUERY CACHE;
END;



DROP PROCEDURE IF EXISTS suspension.get_fork_standard_work_from_work_order;
CREATE PROCEDURE get_fork_standard_work_from_work_order(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        WORK.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM suspension.fork_work_combo as WORK_COMBO
           LEFT JOIN suspension.fork_work as WORK 
		   ON WORK_COMBO.fork_work=WORK.row_id 
           LEFT JOIN suspension.comments as COMMENTS 
		   ON WORK_COMBO.comments=COMMENTS.row_id
       WHERE 
	    WORK_COMBO.work_order=`in_work_order`; 
END;


DROP PROCEDURE IF EXISTS suspension.get_shock_standard_work_from_work_order;
CREATE PROCEDURE get_shock_standard_work_from_work_order(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        WORK.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM suspension.shock_work_combo as WORK_COMBO
           LEFT JOIN suspension.shock_work as WORK 
		   ON WORK_COMBO.shock_work=WORK.row_id 
           LEFT JOIN suspension.comments as COMMENTS 
		   ON WORK_COMBO.comments=COMMENTS.row_id
       WHERE 
	    WORK_COMBO.work_order=`in_work_order`; 
END;


/*-------------------------------------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with fork and shock services requested*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.remove_additional_services_from_work_order;
CREATE PROCEDURE suspension.remove_additional_services_from_work_order(
               IN `in_work_order`  int(10),
               IN `in_type` varchar(20)
       )

BEGIN
   IF (`in_type`="Fork") THEN 
      SET @syntax=CONCAT("  DELETE from suspension.fork_additional_services_combo",
                         "  WHERE work_order=",`in_work_order`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;

   IF (`in_type`="Shock") THEN 
      SET @syntax=CONCAT("  DELETE from suspension.shock_additional_services_combo",
                         "  WHERE work_order=",`in_work_order`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;
   FLUSH QUERY CACHE;
END;


DROP PROCEDURE IF EXISTS suspension.save_additional_services;
CREATE PROCEDURE suspension.save_additional_services(
	       IN `in_work_order` int(10),
               IN `in_type` varchar(20),
               IN `in_product_id` int(10),
               IN `in_comments` varchar(5000)
       )

BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;
     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);

     IF (`in_type`="Fork") THEN
        SET @table_name="suspension.fork_additional_services_combo"; 
        SET @col_name="fork_additional_services";
     END IF;

     IF (`in_type`="Shock") THEN
        SET @table_name="suspension.shock_additional_services_combo"; 
        SET @col_name="shock_additional_services";
     END IF;

     call prepare_comments(`in_comments`,@new_comments_id); 
     SET @syntax=CONCAT("  INSERT INTO ", @table_name, " (work_order, ", @col_name,", comments) ",
                        "  VALUES (",@valid_work_order,",",`in_product_id`,",",@new_comments_id,");"
                       );
     /*Now execute the statement prepared from above*/
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;
     FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.get_fork_additional_services_from_work_order;
CREATE PROCEDURE get_fork_additional_services_from_work_order(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ADD_SRV.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM suspension.fork_additional_services_combo as ADD_SRV_COMBO
           LEFT JOIN suspension.fork_additional_services as ADD_SRV 
		   ON ADD_SRV_COMBO.fork_additional_services=ADD_SRV.row_id 
           LEFT JOIN suspension.comments as COMMENTS 
		   ON ADD_SRV_COMBO.comments=COMMENTS.row_id
       WHERE 
	    ADD_SRV_COMBO.work_order=`in_work_order`; 
END;


DROP PROCEDURE IF EXISTS suspension.get_shock_additional_services_from_work_order;
CREATE PROCEDURE get_shock_additional_services_from_work_order(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ADD_SRV.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM suspension.shock_additional_services_combo as ADD_SRV_COMBO
           LEFT JOIN suspension.shock_additional_services as ADD_SRV 
		   ON ADD_SRV_COMBO.shock_additional_services=ADD_SRV.row_id 
           LEFT JOIN suspension.comments as COMMENTS 
		   ON ADD_SRV_COMBO.comments=COMMENTS.row_id
       WHERE 
	    ADD_SRV_COMBO.work_order=`in_work_order`; 
END;

/*-------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with terrain*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_terrain;
CREATE PROCEDURE get_terrain(
		IN `in_work_order` int (10)
                 )
BEGIN
  SELECT 
         TERRAIN.description as `Terrain`
  FROM 
       suspension.terrain_combo as TC,
       suspension.terrain as TERRAIN
  WHERE 
        TC.work_order=`in_work_order` AND
        TC.terrain=TERRAIN.row_id;
END;


DROP PROCEDURE IF EXISTS suspension.remove_terrain_from_work_order;
CREATE PROCEDURE suspension.remove_terrain_from_work_order(
               IN `in_work_order`  int(10)
       )
/*Remove all the terrain combos for the work_order*/
BEGIN
   DELETE FROM suspension.terrain_combo
          WHERE work_order=`in_work_order`;
   FLUSH QUERY CACHE;
END;


DROP PROCEDURE IF EXISTS suspension.save_terrain;
CREATE PROCEDURE suspension.save_terrain(
	       IN `in_work_order` int(10),
               IN `in_terrain_id` int(10)
       )

BEGIN
   SET @valid_work_order=0;
   SET @valid_setting=0;

   call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
   INSERT INTO suspension.terrain_combo (work_order,terrain) 
          VALUES (@valid_work_order,`in_terrain_id`);

   call update_lookup_table(@valid_work_order);
END;

/*-------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with Riding Type*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_riding_type;
CREATE PROCEDURE get_riding_type(
		IN `in_work_order` int (10)
                 )
BEGIN
  SELECT 
       RIDING_TYPE.description as `Riding Type`
  FROM 
       suspension.riding_type_combo as RIDING_COMBO,
       suspension.riding_type as RIDING_TYPE 
  WHERE 
        RIDING_COMBO.work_order=`in_work_order` AND
        RIDING_COMBO.riding_type=RIDING_TYPE.row_id;
END;



DROP PROCEDURE IF EXISTS suspension.remove_riding_types_from_work_order;
CREATE PROCEDURE suspension.remove_riding_types_from_work_order(
               IN `in_work_order`  int(10)
       )
/*Remove all the riding_type combos for the work_order*/
BEGIN
   DELETE FROM suspension.riding_type_combo
          WHERE work_order=`in_work_order`;
   FLUSH QUERY CACHE;
END;


DROP PROCEDURE IF EXISTS suspension.save_riding_types;
CREATE PROCEDURE suspension.save_riding_types(
	       IN `in_work_order` int(10),
               IN `in_riding_type_id` int(10)
       )

BEGIN
   call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
   INSERT INTO suspension.riding_type_combo (work_order,riding_type) 
          VALUES (@valid_work_order,`in_riding_type_id`);

   call update_lookup_table(@valid_work_order);
END;

/*-------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with the credit_card_info*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_credit_card_info;
CREATE PROCEDURE get_credit_card_info(
		IN `in_work_order_id` int (10)
                 )
BEGIN
  call get_key(@the_key); 
  
  SELECT 
            AES_DECRYPT(CC.name,@the_key) as "name_on_card",
	    AES_DECRYPT(CC.number,@the_key) as "number_on_card",
	    AES_DECRYPT(CC.security_code,@the_key) as "security_code",
	    AES_DECRYPT(CC.expiration,@the_key) as "expiration"
    FROM suspension.finance as FINANCE 
            LEFT JOIN suspension.credit_card as CC 
		    ON FINANCE.credit_card=CC.row_id
        WHERE 
              FINANCE.work_order=`in_work_order_id`;
END;


/*This is not used in the current logic, but is retained in case the business process changes*/
DROP PROCEDURE IF EXISTS suspension.remove_credit_card_from_finance_entry;
CREATE PROCEDURE suspension.remove_credit_card_from_finance_entry(
               IN `in_finance_entry`  int(10)
       )
/*Remove the credit_card for the given finance entry*/
BEGIN
   DECLARE credit_entry int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE credit_entry_cursor CURSOR FOR
                         SELECT credit_card FROM suspension.finance
                                            WHERE row_id =`in_finance_entry`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

   OPEN credit_entry_cursor;
      FETCH credit_entry_cursor into credit_entry;
   CLOSE credit_entry_cursor; 

   IF credit_entry>0 THEN
      DELETE FROM suspension.credit_card
             WHERE row_id=credit_entry;
      UPDATE suspension.finance SET credit_card=null WHERE row_id=`in_finance_entry`;
      FLUSH QUERY CACHE;
   END IF;
   
END;

DROP PROCEDURE IF EXISTS suspension.get_key;
CREATE PROCEDURE suspension.get_key(
               OUT `return_key`  varchar(100)
       )
/*Remove the credit_card for the given finance entry*/
BEGIN
   DECLARE the_key varchar(100); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE key_cursor CURSOR FOR
                         SELECT some_stuff FROM suspension.basic_info
                                            WHERE row_id = 1;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

   OPEN key_cursor;
      FETCH key_cursor into the_key;
   CLOSE key_cursor; 

   /*if there was an entry found SET return_key to the value */
   IF (the_key<=>NULL) THEN
      SET return_key=0;
      ELSE SET return_key=the_key;       
   END IF;
   FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.prepare_credit_card_account;
CREATE PROCEDURE suspension.prepare_credit_card_account(
               IN `in_encrypted_card` blob,
	       OUT `out_cc_id` int(10)
       )
BEGIN
   DECLARE cc_id int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE cc_cursor CURSOR FOR
                         SELECT row_id FROM suspension.credit_card
                                       WHERE number =`in_encrypted_card`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

   OPEN cc_cursor;
      FETCH cc_cursor into cc_id;
   CLOSE cc_cursor; 

   /*if there was an existing account that matched, just return that row_id*/
   IF no_rows_found=0 THEN
      SET `out_cc_id`=cc_id;	 
      SELECT "cc found with row_id of ",cc_id;
      /*if there wasn't an existing accout that matched, create one and return the new row_id*/
      ELSEIF no_rows_found=1 THEN
             INSERT INTO suspension.credit_card(number) VALUES (`in_encrypted_card`);
             SET @new_cc_id=LAST_INSERT_ID();
             SET `out_cc_id`=@new_cc_id;	 
             SELECT "created cc with row_id of ",@new_cc_id;
   END IF;
END;


DROP PROCEDURE IF EXISTS suspension.save_credit_card_info;
CREATE PROCEDURE suspension.save_credit_card_info(
		IN `in_work_order_id` int (10),
		IN `in_name_on_card` varchar (100),
		IN `in_number_on_card` varchar (25),
		IN `in_security_code` varchar(10),
		IN `in_expiration` varchar(10)
       )

BEGIN 
    SET @valid_work_order=0;
    SET @valid_setting=0;
    SET @valid_finance=0;


    call prepare_work_order(`in_work_order_id`,@valid_work_order,@valid_setting); 
    call prepare_finance_info(@valid_work_order,@valid_finance_id);

    /*if the name_on_card is not an empty string then do the card routines*/
    IF !(`in_name_on_card`="") THEN 
       /*This is not used in the current logic, but is retained in case the business process changes*/
       /*clean up any existing credit card instances for this finance id already existing*/
       /*call remove_credit_card_from_finance_entry(@valid_finance_id);*/
   
       call get_key(@the_key);
       SET @encrypted_name=AES_ENCRYPT(`in_name_on_card`,@the_key);
       SET @encrypted_card=AES_ENCRYPT(`in_number_on_card`,@the_key);
       SET @encrypted_security_code=AES_ENCRYPT(`in_security_code`,@the_key);
       SET @encrypted_expiration=AES_ENCRYPT(`in_expiration`,@the_key);

       /*see if this encrypted card is already in the credit card table*/
       call prepare_credit_card_account(@encrypted_card,@out_cc_id);

       UPDATE suspension.credit_card SET name=@encrypted_name WHERE row_id=@out_cc_id;
       UPDATE suspension.credit_card SET security_code=@encrypted_security_code WHERE row_id=@out_cc_id;
       UPDATE suspension.credit_card SET expiration=@encrypted_expiration WHERE row_id=@out_cc_id;

       UPDATE suspension.finance SET credit_card=@out_cc_id WHERE row_id=@valid_finance_id;
       ELSE
         UPDATE suspension.finance SET credit_card=NULL WHERE row_id=@valid_finance_id;
	  
   END IF;

  FLUSH QUERY CACHE;
END;
/*-------------------------------------------------------------------------------------*/




/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedure updates the comments at the given comments_id with the new_comments and the timestamp*/ 
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DROP PROCEDURE IF EXISTS suspension.update_support_comments;
CREATE PROCEDURE suspension.update_support_comments(
	       IN `in_work_order_id` int(10),
               IN `in_cust_comments` varchar(5000),
               IN `in_tech_comments` varchar(5000)
       )

BEGIN
     DECLARE cust_comments varchar(5000) DEFAULT NULL; 
     DECLARE tech_comments varchar(5000) DEFAULT NULL; 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE id_cursor CURSOR FOR
                         SELECT 
				customer_comments,
				tech_support_comments 
			 FROM
  				suspension.work_order
			        where row_id=`in_work_order_id`;

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     /*See if this setting has any customer or tech support comments*/
     OPEN id_cursor;
       FETCH id_cursor into cust_comments, tech_comments;
     CLOSE id_cursor; 

     SET @date=curdate();
     SET @time=curtime();

     /* if there were no customer comments for this setting create some*/ 
     IF (cust_comments <=> NULL ) AND (LENGTH(`in_cust_comments`)>0) THEN
         SET @new_cust_comments=concat(`in_cust_comments`," -- ",@date,"  ",@time);
         UPDATE suspension.work_order SET customer_comments=@new_cust_comments WHERE row_id=`in_work_order_id`; 
         ELSEIF  LENGTH(cust_comments)!=LENGTH(`in_cust_comments`)  THEN
                   SET @new_cust_comments=concat(`in_cust_comments`," -- ",@date,"  ",@time);
                   UPDATE suspension.work_order SET customer_comments=@new_cust_comments WHERE row_id=`in_work_order_id`; 
     END IF;


     /* if there were no tech support comments for this setting create some*/ 
     IF (tech_comments <=> NULL  ) AND (LENGTH(`in_tech_comments`)>0) THEN
            SET @new_tech_comments=concat(`in_tech_comments`," -- ",@date,"  ",@time);
            UPDATE suspension.work_order SET tech_support_comments=@new_tech_comments WHERE row_id=`in_work_order_id`; 
            ELSEIF  LENGTH(tech_comments)!=LENGTH(`in_tech_comments`)  THEN
                   SET @new_tech_comments=concat(`in_tech_comments`," -- ",@date,"  ",@time);
                   UPDATE suspension.work_order SET tech_support_comments=@new_tech_comments WHERE row_id=`in_work_order_id`; 
     END IF;
   FLUSH QUERY CACHE;
END;

/*-------------------------------------------------------------*/



/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedures deal with the save of the fork and shock comments*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.save_shock_comments;
CREATE PROCEDURE suspension.save_shock_comments(
	       IN `in_setting` int(10),
               IN `in_comments` varchar(5000)
       )
BEGIN
     SET @valid_setting=0;
     SET @valid_shock_spec=0;

     call prepare_setting(`in_setting`,@valid_setting);
     call prepare_shock_spec(@valid_setting,@valid_shock_spec);
     call save_shock_comments_in_shock_spec(@valid_shock_spec,`in_comments`);
     FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.save_shock_comments_in_shock_spec;
CREATE PROCEDURE suspension.save_shock_comments_in_shock_spec(
	       IN `in_shock_spec` int(20),
               IN `in_comments` varchar(5000)
       )

BEGIN
  UPDATE suspension.shock_spec SET comments=`in_comments` WHERE row_id=`in_shock_spec`; 
END;

DROP PROCEDURE IF EXISTS suspension.save_fork_comments;
CREATE PROCEDURE suspension.save_fork_comments(
	       IN `in_setting` int(10),
               IN `in_comments` varchar(5000)
       )

BEGIN
     SET @valid_setting=0;
     SET @valid_fork_spec=0;

     call prepare_setting(`in_setting`,@valid_setting);
     call prepare_fork_spec(@valid_setting,@valid_fork_spec);
     call save_fork_comments_in_fork_spec(@valid_fork_spec,`in_comments`);
     FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.save_fork_comments_in_fork_spec;
CREATE PROCEDURE suspension.save_fork_comments_in_fork_spec(
	       IN `in_fork_spec` int(20),
               IN `in_comments` varchar(5000)
       )

BEGIN
  UPDATE suspension.fork_spec SET comments=`in_comments` WHERE row_id=`in_fork_spec`; 
END;
/*-------------------------------------------------------------*/



/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with the shims*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DROP PROCEDURE IF EXISTS suspension.prepare_fork_shock_spec;
CREATE PROCEDURE suspension.prepare_fork_shock_spec(
               IN `in_setting_id` int(10),
	       IN `ref_table` varchar(100),
	       OUT `spec_id` int(20)
       )
BEGIN
        DECLARE existing_fork_spec int(20);
        DECLARE existing_shock_spec int(20);
        DECLARE no_rows_found INT DEFAULT 0;
        DECLARE spec_cursor CURSOR FOR
		   SELECT SETTING.fork_spec,shock_spec FROM suspension.setting as SETTING
						    WHERE SETTING.row_id=`in_setting_id`; 

        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

        OPEN spec_cursor;
          FETCH spec_cursor into existing_fork_spec, existing_shock_spec;
        CLOSE spec_cursor; 

	/*if there is no existing fork_spec*/ 
        IF existing_fork_spec <=>NULL THEN
                /*create the fork spec*/
        	INSERT INTO suspension.fork_spec () VALUES ();
                SET @new_fork_spec=LAST_INSERT_ID();
                /*associate the new_fork_spec with the the setting*/
        	UPDATE suspension.setting SET fork_spec=@new_fork_spec WHERE row_id=`in_setting_id`;
		SET @out_fork_spec=@new_fork_spec;
        END IF;

	/*if there is no existing shock_spec*/ 
        IF existing_shock_spec <=>NULL THEN
                /*create the shock spec*/
        	INSERT INTO suspension.shock_spec () VALUES ();
                SET @new_shock_spec=LAST_INSERT_ID();
                /*associate the new_shock_spec with the the setting*/
        	UPDATE suspension.setting SET shock_spec=@new_shock_spec WHERE row_id=`in_setting_id`;
		SET @out_shock_spec=@new_shock_spec;
        END IF;

	/*Update the last revised date with the current date*/
        UPDATE suspension.setting SET date=curdate() WHERE row_id=`in_setting_id`;

	/*if there is an existing fork_spec*/ 
        IF existing_fork_spec >0 THEN
		SET @out_fork_spec=existing_fork_spec;
        END IF;

	/*if there is an existing shock_spec*/ 
        IF existing_shock_spec >0 THEN
		SET @out_shock_spec=existing_shock_spec;
        END IF;

	IF `ref_table` like "fork%" THEN
	       SET `spec_id`=@out_fork_spec;	
        END IF;

	IF `ref_table` like "shock%" THEN
	       SET `spec_id`=@out_shock_spec;	
        END IF;
   FLUSH QUERY CACHE;
END;



DROP PROCEDURE IF EXISTS suspension.remove_shims_from_spec;
CREATE PROCEDURE suspension.remove_shims_from_spec(
               IN `in_setting`int(10),
               IN `in_ref_table`varchar(100),
               IN `in_ref_spec` varchar(100)
       )
BEGIN
   SET @spec_id=0;
   call prepare_fork_shock_spec(`in_setting`,`in_ref_table`,@spec_id);

   SET @syntax=CONCAT("  DELETE from suspension.", `in_ref_table`,
                      "  WHERE ", `in_ref_spec`,"=",@spec_id,";"); 
   PREPARE stmt1 FROM @syntax;
   EXECUTE stmt1;

   SELECT @spec_id AS spec_id;
END;


DROP PROCEDURE IF EXISTS suspension.insert_shims_into_spec;
CREATE PROCEDURE suspension.insert_shims_into_spec(
	       IN `in_setting_id`int(10), 
               IN `in_ref_table` varchar(100),
               IN `in_ref_spec` varchar(100),
               IN `in_spec_id` int(20),
               IN `in_pos` int(10),
               IN `in_ID` decimal(5,3),
               IN `in_Col_Width` decimal(5,3),
               IN `in_Reb_Piston_Tower` decimal(5,3),
               IN `in_Spring_Cup` decimal(5,3),
               IN `in_OD_is_DELTA` int(1),
               IN `in_OD` decimal(5,3),
               IN `in_Thickness` decimal(5,3),
               IN `in_Qty` int(10)
       )

BEGIN
    /*SELECT `in_spec_id`,`in_pos`,`in_ID_id`,@OD_id,@Thickness_id,@Qty;*/
    IF `in_ref_table`="fork_bcv_stack" THEN
        SET @syntax=CONCAT("  INSERT INTO suspension.", `in_ref_table`,
                           " (",`in_ref_spec`,",position,collar_width,rebound_piston_tower,spring_cup,shim_inner_diameter,shim_outer_diameter_is_delta,shim_outer_diameter,shim_thickness,quantity) ",
                           " VALUES ", "(",
                                               `in_spec_id`,",",
                                               `in_pos`,",",
                                               `in_Col_Width`,",",
                                               `in_Reb_Piston_Tower`,",",
                                               `in_Spring_Cup`,",",
                                               `in_ID`,",",
					       `in_OD_is_DELTA`,",",
					       `in_OD`,",",
					       `in_Thickness`,",",
                                               `in_Qty`,");"
                                ); 
       ELSE
        SET @syntax=CONCAT("  INSERT INTO suspension.", `in_ref_table`,
                           " (",`in_ref_spec`,",position, shim_inner_diameter,shim_outer_diameter_is_delta,shim_outer_diameter,shim_thickness,quantity) ",
                           " VALUES ", "(",
                                               `in_spec_id`,",",
                                               `in_pos`,",",
                                               `in_ID`,",",
					       `in_OD_is_DELTA`,",",
					       `in_OD`,",",
					       `in_Thickness`,",",
                                               `in_Qty`,");"
                                ); 
    END IF;

    SELECT @syntax;
    PREPARE stmt1 FROM @syntax;
    EXECUTE stmt1;
END;
/*-------------------------------------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with the support comments*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_support_comments;
CREATE PROCEDURE get_support_comments(
		IN `in_work_order_id` int (10)
                 )
BEGIN
  SELECT
	WORK_ORDER.customer_comments as "Customer Comments",
        WORK_ORDER.tech_support_comments as "Tech Support Comments"
  FROM 
        suspension.work_order as WORK_ORDER 
   WHERE 
	 WORK_ORDER.row_id =`in_work_order_id`;
   FLUSH QUERY CACHE;
END;


DROP PROCEDURE IF EXISTS suspension.get_comments;
CREATE PROCEDURE get_comments(
		IN `in_spec_id` int (10)
                 )
BEGIN
  SELECT
  	  COMMENTS.row_id as spec_id,
          COMMENTS.comments as comments
	
    FROM 
          suspension.comments as COMMENTS 
    WHERE 
	  COMMENTS.row_id =`in_spec_id`;
END;

/*-------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with the fork and shock general information*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_fork_general_info;
CREATE PROCEDURE get_fork_general_info(
		IN `in_spec_id` int (20)
                 )
BEGIN
  SELECT
        INFO.general_info as "General Info"
  FROM 
        suspension.fork_spec as SPEC 
	LEFT JOIN suspension.fork_spec_general_info AS INFO
		ON SPEC.general_info=INFO.row_id		
   WHERE 
	 SPEC.row_id =`in_spec_id`;
END;

DROP PROCEDURE IF EXISTS suspension.get_shock_general_info;
CREATE PROCEDURE get_shock_general_info(
		IN `in_spec_id` int (20)
                 )
BEGIN
  SELECT
        INFO.general_info as "General Info"
  FROM 
        suspension.shock_spec as SPEC 
	LEFT JOIN suspension.shock_spec_general_info AS INFO
		ON SPEC.general_info=INFO.row_id		
  WHERE 
	 SPEC.row_id =`in_spec_id`;
END;


DROP PROCEDURE IF EXISTS suspension.update_fork_general_comments;
CREATE PROCEDURE suspension.update_fork_general_comments(
	       IN `in_fork_spec_id` int(20),
               IN `in_info` varchar(5000)
       )

BEGIN
     DECLARE info_id int(10) DEFAULT NULL; 
     DECLARE info varchar(5000) DEFAULT NULL; 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE id_cursor CURSOR FOR
  		SELECT INFO.row_id, 
		       INFO.general_info as "General Info"
  		FROM   suspension.fork_spec as SPEC 
		       LEFT JOIN suspension.fork_spec_general_info AS INFO
		 	    ON SPEC.general_info=INFO.row_id		
   		WHERE 
	 		SPEC.row_id =`in_fork_spec_id`;

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     /*See if this fork spec has an existing info*/ 
     OPEN id_cursor;
       FETCH id_cursor into info_id, info;
     CLOSE id_cursor; 

     SET @date=curdate();
     SET @time=curtime();

     /* if there were no customer comments for this setting create some*/ 
     IF (info <=> NULL ) AND (LENGTH(`in_info`)>0) THEN
	 /*The next two lines add a timestamp if we decide we need it*/
         /*SET @new_info=concat(`in_info`," -- ",@date,"  ",@time);
	 INSERT INTO suspension.fork_spec_general_info (general_info) VALUES (@new_info);*/
	 INSERT INTO suspension.fork_spec_general_info (general_info) VALUES (`in_info`);
         UPDATE suspension.fork_spec SET general_info=LAST_INSERT_ID() WHERE row_id=`in_fork_spec_id`; 
         ELSEIF LENGTH(info)!=LENGTH(`in_info`) AND (LENGTH(`in_info`)>0) THEN
	           /*The next two lines add a timestamp if we decide we need it*/
                   /*SET @new_info=concat(`in_info`," -- ",@date,"  ",@time);
                   UPDATE suspension.fork_spec_general_info SET general_info=@new_info WHERE row_id=`info_id`;*/ 
                   UPDATE suspension.fork_spec_general_info SET general_info=`in_info` WHERE row_id=`info_id`; 
                   ELSEIF (LENGTH(`in_info`)=0) THEN
                   UPDATE suspension.fork_spec_general_info SET general_info=NULL WHERE row_id=`info_id`; 
     END IF;
   FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.update_shock_general_comments;
CREATE PROCEDURE suspension.update_shock_general_comments(
	       IN `in_shock_spec_id` int(20),
               IN `in_info` varchar(5000)
       )

BEGIN
     DECLARE info_id int(10) DEFAULT NULL; 
     DECLARE info varchar(5000) DEFAULT NULL; 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE id_cursor CURSOR FOR
            SELECT INFO.row_id,
	           INFO.general_info as "General Info"
            FROM 
               suspension.shock_spec as SPEC 
	       LEFT JOIN suspension.shock_spec_general_info AS INFO
		       ON SPEC.general_info=INFO.row_id	
             WHERE 
	        SPEC.row_id =`in_shock_spec_id`;

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     /*See if this shock spec has an existing info*/ 
     OPEN id_cursor;
       FETCH id_cursor into info_id, info;
     CLOSE id_cursor; 

     SET @date=curdate();
     SET @time=curtime();

     /* if there were no customer comments for this setting create some*/ 
     IF (info <=> NULL ) AND (LENGTH(`in_info`)>0) THEN
	 /*The next two lines add a timestamp if we decide we need it*/
         /*SET @new_info=concat(`in_info`," -- ",@date,"  ",@time);
	 INSERT INTO suspension.shock_spec_general_info (general_info) VALUES (@new_info);*/
	 INSERT INTO suspension.shock_spec_general_info (general_info) VALUES (`in_info`);
         UPDATE suspension.shock_spec SET general_info=LAST_INSERT_ID() WHERE row_id=`in_shock_spec_id`; 
         ELSEIF LENGTH(info)!=LENGTH(`in_info`) AND (LENGTH(`in_info`)>0) THEN
	           /*The next two lines add a timestamp if we decide we need it*/
                   /*SET @new_info=concat(`in_info`," -- ",@date,"  ",@time);
                   UPDATE suspension.shock_spec_general_info SET general_info=@new_info WHERE row_id=`info_id`;*/
                   UPDATE suspension.shock_spec_general_info SET general_info=`in_info` WHERE row_id=`info_id`;
                   ELSEIF (LENGTH(`in_info`)=0) THEN
                   UPDATE suspension.shock_spec_general_info SET general_info=NULL WHERE row_id=`info_id`; 
     END IF;
   FLUSH QUERY CACHE;
END;


/*-------------------------------------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with adding addresses and riders*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.add_address;
CREATE PROCEDURE add_address(
		IN `in_address1` varchar (100),
		IN `in_address2` varchar (100),
		IN `in_address3` varchar (100),
		IN `in_city` varchar (100),
		IN `in_state_province` varchar (50),
		IN `in_country` varchar (50),
		IN `in_zip` varchar (50),
		IN `in_phone1` varchar (50),
		IN `in_phone2` varchar (50)
                 )
BEGIN
  INSERT INTO suspension.address
         (address1,address2,address3,city,state_province,country,zip, phone1,phone2) 
  	 VALUES (`in_address1`,`in_address2`,`in_address3`,`in_city`,`in_state_province`,`in_country`,`in_zip`,`in_phone1`,`in_phone2`);
  SELECT LAST_INSERT_ID() AS new_address;
END;

DROP PROCEDURE IF EXISTS suspension.add_rider;
CREATE PROCEDURE add_rider(
		IN `in_first_name` varchar (100),
		IN `in_last_name` varchar (100),
		IN `in_address_id` int (10)
                 )
BEGIN
  INSERT INTO suspension.rider
         (first_name, last_name,address)
         VALUES (`in_first_name`,`in_last_name`,`in_address_id`);
   FLUSH QUERY CACHE;
END;
/*-------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with adding products*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.add_fork_additional_product;
CREATE PROCEDURE add_fork_additional_product(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.fork_additional_products
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.add_shock_additional_product;
CREATE PROCEDURE add_shock_additional_product(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.shock_additional_products
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;
/*-------------------------------------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with adding services*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DROP PROCEDURE IF EXISTS suspension.add_fork_additional_service;
CREATE PROCEDURE add_fork_additional_service(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.fork_additional_services
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.add_shock_additional_service;
CREATE PROCEDURE add_shock_additional_service(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.shock_additional_services
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;
/*-------------------------------------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with adding standard work services*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DROP PROCEDURE IF EXISTS suspension.add_fork_standard_work;
CREATE PROCEDURE add_fork_standard_work(
                IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.fork_work
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.add_shock_standard_work;
CREATE PROCEDURE add_shock_standard_work(
                IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.shock_work
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;
/*-------------------------------------------------------------*/     


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedure returns all the in_field_names from the in_table_name table*/
/*fields are ordered by the in_field_names*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_all_values;
CREATE PROCEDURE suspension.get_all_values (
               IN `in_table_name` varchar(50),
               IN `in_field_names` varchar(100),
               IN `in_order_by_field` varchar(100)
       )

BEGIN
	IF `in_table_name` like "bike_year" THEN
		/*for bike years, order by descending
		  so the newest bikes are always presented first*/
		SET @syntax=CONCAT(" SELECT row_id, ", 
                          `in_field_names`, " FROM ",
                          `in_table_name`, " ORDER BY ",
                          `in_order_by_field`," DESC",";");

	ELSE       
		SET @syntax=CONCAT(" SELECT row_id, ", 
                          `in_field_names`, " FROM ",
                          `in_table_name`, " ORDER BY ",
                          `in_order_by_field`,";");
	END IF;

     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;

END;

/*-------------------------------------------------------------*/     

/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedure is used by multiple stored procedures to prep the work order*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.prepare_work_order;
CREATE PROCEDURE suspension.prepare_work_order(
               IN `in_work_order` int(10),
               OUT `out_work_order` int(10), 
               OUT `out_setting` int(10) 
              )
BEGIN
   DECLARE existing_work_order int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE work_order_cursor CURSOR FOR
		SELECT row_id FROM suspension.work_order
			      WHERE row_id=`in_work_order`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN work_order_cursor;
      FETCH work_order_cursor into existing_work_order;
    CLOSE work_order_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF existing_work_order<=>NULL THEN
       /*create an empty setting entry*/
       INSERT INTO suspension.setting (date) VALUES(curdate()); 
       SET @new_setting=LAST_INSERT_ID();
       SET `out_setting`=@new_setting;

       /*create an work_order entry with the new setting*/
       INSERT INTO suspension.work_order (setting) VALUES(@new_setting); 
       SET @new_work_order=LAST_INSERT_ID();
       SET `out_work_order`=@new_work_order;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_work_order`=existing_work_order;
     END IF;
END;
/*-------------------------------------------------------------*/     

/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedure is used by multiple stored procedures to prep the work order*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.prepare_finance_info;
CREATE PROCEDURE suspension.prepare_finance_info(
               IN `in_work_order` int(10),
               OUT `out_finance` int(10) 
              )
BEGIN
   DECLARE existing_finance int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE finance_cursor CURSOR FOR
		SELECT row_id FROM suspension.finance
			      WHERE work_order=`in_work_order`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN finance_cursor;
      FETCH finance_cursor into existing_finance;
    CLOSE finance_cursor; 

    /*if the existing_finance_info was null,we need to create a finance entry*/
    /*and return the new row_id */
    IF existing_finance<=>NULL THEN
       /*create an empty finance entry*/
       INSERT INTO suspension.finance (work_order) VALUES(`in_work_order`); 
       SET @new_finance=LAST_INSERT_ID();
       SET `out_finance`=@new_finance;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_finance`=existing_finance;
     END IF;
END;
/*-------------------------------------------------------------*/     


DROP PROCEDURE IF EXISTS suspension.collect_rider;
CREATE PROCEDURE suspension.collect_rider(
               IN `in_work_order` int(10),
	       OUT `out_rider_instance` int(10)
              )
BEGIN
   DECLARE existing_rider_instance int(10) DEFAULT 0; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
	   rider_instance FROM suspension.work_order as WORK_ORDER 
        WHERE WORK_ORDER.row_id=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN the_cursor;
      FETCH the_cursor into existing_rider_instance;
    CLOSE the_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF existing_rider_instance != 0 THEN
         SET `out_rider_instance`=existing_rider_instance;
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.collect_rider_info1;
CREATE PROCEDURE suspension.collect_rider_info1(
               IN `in_rider_instance` int(10),
	       OUT `out_ability` varchar(50),
               OUT `out_weight_lbs` varchar(10), 
               OUT `out_weight_kgs` varchar(10), 
               OUT `out_height_in` varchar(10), 
               OUT `out_height_cm` varchar(10) 
              )
BEGIN
   DECLARE existing_ability varchar(50) DEFAULT null; 
   DECLARE existing_weight_lbs varchar(10) DEFAULT null;  
   DECLARE existing_weight_kgs varchar(10) DEFAULT null; 
   DECLARE existing_height_in varchar(10) DEFAULT null; 
   DECLARE existing_height_cm varchar(10) DEFAULT null; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
           ABILITY.description,
           WEIGHT.weight_lbs,
           WEIGHT.weight_kg,
           HEIGHT.height_in,
           HEIGHT.height_cm
        FROM suspension.rider_instance as RIDER_INST 
           LEFT JOIN suspension.rider as RIDER
	  	 ON RIDER_INST.rider=RIDER.row_id
           LEFT JOIN suspension.rider_ability as ABILITY
	   	ON RIDER_INST.rider_ability=ABILITY.row_id
	   LEFT JOIN suspension.rider_weight as WEIGHT
	   	ON RIDER_INST.rider_weight=WEIGHT.row_id
	   LEFT JOIN suspension.rider_height as HEIGHT
	   	ON RIDER_INST.rider_height=HEIGHT.row_id
       WHERE RIDER_INST.row_id=`in_rider_instance`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN the_cursor;
      FETCH the_cursor into existing_ability,existing_weight_lbs,existing_weight_kgs,
                            existing_height_in,existing_height_cm;
    CLOSE the_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF !(existing_ability <=>null) THEN
         SET `out_ability`=existing_ability;
         SET `out_weight_lbs`=existing_weight_lbs;
         SET `out_weight_kgs`=existing_weight_kgs;
         SET `out_height_in`=existing_height_in;
         SET `out_height_cm`=existing_height_cm;
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.collect_rider_info2;
CREATE PROCEDURE suspension.collect_rider_info2(
               IN `in_rider_instance` int(10),
	       OUT `out_first_name` varchar(100),
               OUT `out_last_name` varchar(100), 
               OUT `out_support_id` varchar(50), 
               OUT `out_phone1` varchar(100), 
               OUT `out_phone2` varchar(100) 
              )
BEGIN
   DECLARE existing_first_name varchar(100) DEFAULT null; 
   DECLARE existing_last_name varchar(100) DEFAULT null;  
   DECLARE existing_support_id varchar(50) DEFAULT null; 
   DECLARE existing_phone1 varchar(100) DEFAULT null; 
   DECLARE existing_phone2 varchar(100) DEFAULT null; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
	   RIDER.first_name as "First Name",
	   RIDER.last_name as "Last Name",
	   RIDER.support_id as "Support ID",
	   RIDER.rider_phone1 as "Rider Phone 1",
	   RIDER.rider_phone2 as "Rider Phone 2"
        FROM suspension.rider_instance as RIDER_INST 
           LEFT JOIN suspension.rider as RIDER
	  	 ON RIDER_INST.rider=RIDER.row_id
       WHERE RIDER_INST.row_id=`in_rider_instance`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN the_cursor;
      FETCH the_cursor into existing_first_name,existing_last_name,existing_support_id,
                            existing_phone1,existing_phone2;
    CLOSE the_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF !(existing_first_name <=>null) THEN
         SET `out_first_name`=existing_first_name;
         SET `out_last_name`=existing_last_name;
         SET `out_support_id`=existing_support_id;
         SET `out_phone1`=existing_phone1;
         SET `out_phone2`=existing_phone2;
    END IF;
END;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with the rider_settings_info*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_rider_settings_info;
CREATE PROCEDURE get_rider_settings_info(
		IN `in_work_order_id` int (10)
                 )
BEGIN
   DECLARE rider_instance int(10) DEFAULT 0;
   DECLARE ability varchar(10) DEFAULT null;
   DECLARE weight_lbs int(3) DEFAULT 0;
   DECLARE weight_kgs int(3) DEFAULT 0;
   DECLARE height_in int(3) DEFAULT 0;
   DECLARE height_cm int(3) DEFAULT 0;
   DECLARE first_name varchar(100) DEFAULT null;
   DECLARE last_name varchar(100) DEFAULT null;
   DECLARE support_id varchar(10) DEFAULT null;
   DECLARE phone1 varchar(50) DEFAULT null;
   DECLARE phone2 varchar(50) DEFAULT null;

   call collect_rider(`in_work_order_id`,rider_instance);
   call collect_rider_info1(rider_instance,ability,weight_lbs,weight_kgs,height_in,height_cm);
   call collect_rider_info2(rider_instance,first_name,last_name,support_id,phone1,phone2);
 SELECT 
	   first_name as "First Name",
	   last_name as "Last Name",
	   support_id as "Support ID",
	   phone1 as "Rider Phone 1",
	   phone2 as "Rider Phone 2",
           ability as "Riding Ability",
           weight_lbs as "LB Weight",
           weight_kgs as "KG Weight",
           height_in as "IN Height",
           height_cm as "CM Height"
   FROM suspension.work_order as WORK_ORDER 
   WHERE WORK_ORDER.row_id=`in_work_order_id`;
END;


/*This procedure sees if there is an existing rider instance that meets*/
/*the criteria passed in;if there is, it just returns the reference to */
/*that instance; otherwise it creates a new instance and returns its reference*/
DROP PROCEDURE IF EXISTS suspension.prepare_rider_instance;
CREATE PROCEDURE suspension.prepare_rider_instance(
               IN `in_rider_id` int(10),
               IN `in_ability_id` int(10),
               IN `in_weight_id` int(10),
               IN `in_height_id` int(10),
               OUT `out_rider_instance` int(10) 
              )
BEGIN
    DECLARE existing_rider_instance int(10); 
    DECLARE no_rows_found INT DEFAULT 0;

    DECLARE rider_instance_cursor CURSOR FOR
		 SELECT row_id FROM suspension.rider_instance
			       WHERE rider=`in_rider_id` AND
			       		    rider_weight=`in_weight_id` AND
					    rider_ability=`in_ability_id` AND
					    rider_height=`in_height_id`;	

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN rider_instance_cursor;
      FETCH rider_instance_cursor into existing_rider_instance;
    CLOSE rider_instance_cursor; 

    /*if the existing_rider_instance was null,we need to create a rider_instance*/
    /*and return the new row_id */
    IF existing_rider_instance<=>NULL THEN
       /*create a new rider_instance entry*/
       INSERT INTO suspension.rider_instance (rider,rider_weight,rider_ability, rider_height) 
                             VALUES(`in_rider_id`,`in_weight_id`,`in_ability_id`,`in_height_id`); 
       SET @new_rider_instance=LAST_INSERT_ID();
       SET `out_rider_instance`=@new_rider_instance;
       ELSE
       /*otherwise return the existing_rider_instance*/
        SET `out_rider_instance`=existing_rider_instance;
     END IF;
END;


DROP PROCEDURE IF EXISTS suspension.save_rider_settings_info;
CREATE PROCEDURE suspension.save_rider_settings_info(
		IN `in_work_order_id` int (10),
		IN `in_rider_id` int (10),
		IN `in_ability_id` int(10),
		IN `in_weight_id` int(10),
		IN `in_height_id` int(10),
		IN `in_shop_id` int(10),
		IN `in_service_location_id` int(10)
       )

BEGIN 
    SET @valid_work_order=0;
    SET @valid_setting=0;
    SET @valid_rider_instance=0;

    call prepare_work_order(`in_work_order_id`,@valid_work_order,@valid_setting); 
    call prepare_rider_instance(`in_rider_id`,`in_ability_id`,`in_weight_id`,`in_height_id`,@valid_rider_instance); 

    UPDATE suspension.work_order SET rider_instance=@valid_rider_instance WHERE row_id=@valid_work_order;

    UPDATE suspension.work_order SET shop=`in_shop_id` WHERE row_id=@valid_work_order;
    UPDATE suspension.work_order SET service_location=`in_service_location_id` WHERE row_id=@valid_work_order;

    call update_lookup_table(@valid_work_order);
END;
/*-------------------------------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with work_order payment_methods*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.remove_payment_method_from_work_order;
CREATE PROCEDURE suspension.remove_payment_method_from_work_order(
               IN `in_work_order`  int(10)
       )

BEGIN
   DELETE FROM suspension.payment_method_combo
          WHERE work_order=`in_work_order`; 
   FLUSH QUERY CACHE;
END;



DROP PROCEDURE IF EXISTS suspension.save_payment_method;
CREATE PROCEDURE suspension.save_payment_method(
	       IN `in_work_order` int(10),
               IN `in_payment_method_id` int(10)
       )

BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;

     SET @table_name="suspension.payment_method_combo"; 
     SET @col_name="payment_method";
 
     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);

     INSERT INTO suspension.payment_method_combo (work_order, payment_method) 
            VALUES (@valid_work_order,`in_payment_method_id`);
   FLUSH QUERY CACHE;
END;




DROP PROCEDURE IF EXISTS suspension.get_payment_method_from_work_order;
CREATE PROCEDURE get_payment_method_from_work_order(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        PAY_METHOD.description as "Description"
   FROM suspension.payment_method_combo as PAY_METHOD_COMBO
           LEFT JOIN suspension.payment_method as PAY_METHOD 
		   ON PAY_METHOD_COMBO.payment_method=PAY_METHOD.row_id 
       WHERE 
	    PAY_METHOD_COMBO.work_order=`in_work_order`; 
END;


/*-------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with the general bike_info*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/

DROP PROCEDURE IF EXISTS suspension.get_bike_info;
CREATE PROCEDURE get_bike_info(
		IN `in_work_order_id` int (10)
                 )
BEGIN
   SET @year=null;
   SET @brand=null;
   SET @model=null;
   call collect_bike(`in_work_order_id`,@year,@brand,@model);
 SELECT 
           @year as 'Year',
           @brand as 'Brand',
	   @model as 'Model',
           SHOCK_BRAND.name as "Shock Brand",
           FORK_BRAND.name as "Fork Brand"
   FROM suspension.work_order as WORK_ORDER 

           LEFT JOIN suspension.bike as BIKE 
		   ON WORK_ORDER.bike=BIKE.row_id
           LEFT JOIN suspension.suspension_brand as SHOCK_BRAND 
		   ON BIKE.shock_brand=SHOCK_BRAND.row_id 
           LEFT JOIN suspension.suspension_brand as FORK_BRAND 
		   ON BIKE.fork_brand=FORK_BRAND.row_id 
       WHERE 
             WORK_ORDER.row_id=`in_work_order_id`;
END;

/*This procedure sees if there is an existing bike instance that meets*/
/*the criteria passed in;if there is, it just returns the reference to */
/*that instance; otherwise it creates a new instance and returns its reference*/
DROP PROCEDURE IF EXISTS suspension.prepare_bike_instance;
CREATE PROCEDURE suspension.prepare_bike_instance(
               IN `in_year_id` int(10),
               IN `in_model_id` int(10),
               IN `in_shock_brand_id` int(10),
               IN `in_fork_brand_id` int(10),
               OUT `out_bike_instance` int(10) 
              )
BEGIN
    DECLARE existing_bike int(10); 
    DECLARE no_rows_found INT DEFAULT 0;

    DECLARE bike_cursor CURSOR FOR
		 SELECT row_id FROM suspension.bike
			     WHERE bike_year=`in_year_id` AND
		                   bike_brand_model=`in_model_id` AND
			           shock_brand=`in_shock_brand_id` AND	
			           fork_brand=`in_fork_brand_id`;	

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN bike_cursor;
      FETCH bike_cursor into existing_bike;
    CLOSE bike_cursor; 

    /*if the existing_bike was null,we need to create a bike entry*/
    /*and return the new row_id */
    IF existing_bike<=>NULL THEN
       /*create a new bike entry*/
       INSERT INTO suspension.bike (bike_year,bike_brand_model,shock_brand,fork_brand) 
                             VALUES(`in_year_id`,`in_model_id`,`in_shock_brand_id`,`in_fork_brand_id`); 
       SET @new_bike_instance=LAST_INSERT_ID();
       SET `out_bike_instance`=@new_bike_instance;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_bike_instance`=existing_bike;
     END IF;
END;


DROP PROCEDURE IF EXISTS suspension.save_bike_info;
CREATE PROCEDURE suspension.save_bike_info(
		IN `in_work_order_id` int (10),
		IN `in_year_id` int (10),
		IN `in_model_id` int(10),
		IN `in_shock_brand_id` int(10),
		IN `in_fork_brand_id` int(10)
       )

BEGIN 
    SET @valid_work_order=0;
    SET @valid_setting=0;
    SET @valid_bike_instance=0;

    call prepare_work_order(`in_work_order_id`,@valid_work_order,@valid_setting); 
    call prepare_bike_instance(`in_year_id`,`in_model_id`,`in_shock_brand_id`,
	                       `in_fork_brand_id`,@valid_bike_instance); 

    UPDATE suspension.work_order SET bike=@valid_bike_instance WHERE row_id=@valid_work_order;

    FLUSH QUERY CACHE;
END;

/*-------------------------------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with the shipping_address_info*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_shipping_address_info;
CREATE PROCEDURE get_shipping_address_info(
		IN `in_work_order_id` int (10)
                 )
BEGIN
   SELECT 
           SHIPPING.use_rider_shipping_address,
	   ADDRESS.phone1,
	   ADDRESS.phone2,
           ADDRESS.address1,
           ADDRESS.address2,
           ADDRESS.address3,
           ADDRESS.city as "City",
           ADDRESS.state_province as "State",
           ADDRESS.country as "Country",
           ADDRESS.zip as "Zip"
   FROM suspension.work_order AS WORK_ORDER
           LEFT JOIN suspension.shipping as SHIPPING
	           ON SHIPPING.work_order=WORK_ORDER.row_id
	   LEFT JOIN suspension.address as ADDRESS
		   ON SHIPPING.ship_address=ADDRESS.row_id
       WHERE 
	     WORK_ORDER.row_id =`in_work_order_id`;	
END;

DROP PROCEDURE IF EXISTS suspension.get_rider_address_info;
CREATE PROCEDURE get_rider_address_info(
		IN `in_work_order_id` int (10)
                 )
BEGIN
   SELECT 
	   ADDRESS.phone1,
	   ADDRESS.phone2,
           ADDRESS.address1,
           ADDRESS.address2,
           ADDRESS.address3,
           ADDRESS.city as "City",
           ADDRESS.state_province as "State",
           ADDRESS.country as "Country",
           ADDRESS.zip as "Zip"
   FROM suspension.work_order AS WORK_ORDER
           LEFT JOIN suspension.shipping as SHIPPING
	           ON SHIPPING.work_order=WORK_ORDER.row_id
           LEFT JOIN suspension.rider_instance as RIDER_INSTANCE
	           ON WORK_ORDER.rider_instance=RIDER_INSTANCE.row_id
	   LEFT JOIN suspension.rider as RIDER
		  ON RIDER_INSTANCE.rider=RIDER.row_id
	   LEFT JOIN suspension.address as ADDRESS
		   ON RIDER.address=ADDRESS.row_id
       WHERE 
	     WORK_ORDER.row_id =`in_work_order_id`;	
END;

DROP PROCEDURE IF EXISTS suspension.prepare_address;
CREATE PROCEDURE suspension.prepare_address(
	       IN `in_phone1` varchar(50),
	       IN `in_phone2` varchar(50),
	       IN `in_address1` varchar(100),
	       IN `in_address2` varchar(100),
	       IN `in_address3` varchar(100),
	       IN `in_city` varchar(100),
	       IN `in_state` varchar(100),
	       IN `in_country` varchar(100),
	       IN `in_zip` varchar(10),
               OUT `out_address` int(10) 
              )
BEGIN
   DECLARE existing_address int(10);
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE address_cursor CURSOR FOR
		SELECT row_id FROM suspension.address
			      WHERE 
			            phone1 <=> `in_phone1` AND
			            phone2 <=> `in_phone2` AND
			            address1 <=> `in_address1` AND
			            address2 <=> `in_address2` AND
			            address3 <=> `in_address3` AND
			            city <=> `in_city`  AND
			            state_province <=> `in_state`  AND
			            country <=> `in_country`  AND
			            zip <=>`in_zip`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN address_cursor;
      FETCH address_cursor into existing_address;
    CLOSE address_cursor; 

    /*if the existing_shipping was null,we need to create a shipping entry*/
    /*and return the new row_id */
    IF existing_address<=>NULL THEN
       /*create an empty address entry*/
       INSERT INTO suspension.address (phone1,phone2,address1,address2,address3,city,state_province,country,zip) 
                               VALUES (`in_phone1`,`in_phone2`,`in_address1`,`in_address2`,`in_address3`,`in_city`,`in_state`,`in_country`,`in_zip`); 
       SET @new_shipping=LAST_INSERT_ID();
       SET `out_address`=@new_shipping;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_address`=existing_address;
    END IF;
   FLUSH QUERY CACHE;
END;

DROP PROCEDURE IF EXISTS suspension.save_shipping_address_info;
CREATE PROCEDURE suspension.save_shipping_address_info(
	       IN `in_work_order` int(10),
	       IN `in_use_rider_address` int(1),
	       IN `in_phone1` varchar(100),
	       IN `in_phone2` varchar(100),
	       IN `in_address1` varchar(100),
	       IN `in_address2` varchar(100),
	       IN `in_address3` varchar(100),
	       IN `in_city` varchar(100),
	       IN `in_state` varchar(100),
	       IN `in_country` varchar(100),
	       IN `in_zip` varchar(10)
               )
BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;
     SET @valid_shipping_id=0;

     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting); 
     call prepare_shipping(@valid_work_order,@valid_shipping_id); 

     UPDATE suspension.shipping SET use_rider_shipping_address=`in_use_rider_address`
                                WHERE row_id=@valid_shipping_id;

     call prepare_address(`in_phone1`,`in_phone2`,`in_address1`,`in_address2`,`in_address3`,`in_city`,`in_state`,`in_country`,`in_zip`,@valid_address); 
     UPDATE suspension.shipping SET ship_address=@valid_address
                                WHERE row_id=@valid_shipping_id;

     call update_lookup_table(@valid_work_order);
END;
/*-------------------------------------------------------------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with the shipping_acct_info*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.prepare_shipping;
CREATE PROCEDURE suspension.prepare_shipping(
               IN `in_work_order` int(10),
               OUT `out_shipping` int(10) 
              )
BEGIN
   DECLARE existing_shipping int(10);
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE shipping_cursor CURSOR FOR
		SELECT row_id FROM suspension.shipping
			      WHERE work_order=`in_work_order`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN shipping_cursor;
      FETCH shipping_cursor into existing_shipping;
    CLOSE shipping_cursor; 

    /*if the existing_shipping was null,we need to create a shipping entry*/
    /*and return the new row_id */
    IF existing_shipping<=>NULL THEN
       /*create an empty shipping entry*/
       INSERT INTO suspension.shipping (work_order) VALUES(`in_work_order`); 
       SET @new_shipping=LAST_INSERT_ID();
       SET `out_shipping`=@new_shipping;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_shipping`=existing_shipping;
     END IF;
END;

DROP PROCEDURE IF EXISTS suspension.get_shipping_acct_info;
CREATE PROCEDURE get_shipping_acct_info(
		IN `in_work_order_id` int (10)
                 )
BEGIN
  SELECT 
            SHIP.use_shipping_account,      
	    VENDOR.name as "shipping_vendor",
            ACCT_NUM.account_number
    FROM suspension.shipping as SHIP 
            LEFT JOIN suspension.ship_method_account as ACCT_NUM 
		    ON SHIP.ship_method_account=ACCT_NUM.row_id
            LEFT JOIN suspension.ship_vendor as VENDOR
		   ON ACCT_NUM.ship_vendor=VENDOR.row_id
        WHERE 
              SHIP.work_order=`in_work_order_id`;
END;

/*This is not used in the current logic, but is retained in case the business process changes*/
DROP PROCEDURE IF EXISTS suspension.remove_acct_from_shipping_entry;
CREATE PROCEDURE suspension.remove_acct_from_shipping_entry(
               IN `in_shipping_entry`  int(10)
       )
/*Remove the acct for the given finance entry*/
BEGIN
   DECLARE shipping_acct int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE ship_acct_cursor CURSOR FOR
                         SELECT ship_method_account FROM suspension.shipping
                                                    WHERE row_id =`in_shipping_entry`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

   OPEN ship_acct_cursor;
      FETCH ship_acct_cursor into shipping_acct;
   CLOSE ship_acct_cursor; 

   IF shipping_acct>0 THEN
      DELETE FROM suspension.ship_method_account
             WHERE row_id=shipping_acct;
      UPDATE suspension.shipping SET ship_method_account=null WHERE row_id=`in_shipping_entry`;
      FLUSH QUERY CACHE;
   END IF;
   
END;

DROP PROCEDURE IF EXISTS suspension.prepare_shipping_vendor;
CREATE PROCEDURE suspension.prepare_shipping_vendor(
	       IN `in_shipping_vendor_string` varchar(4),
	       OUT `out_ship_vendor_id` int(10)
       )
BEGIN
   DECLARE vendor_id int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE vendor_cursor CURSOR FOR
                         SELECT row_id FROM suspension.ship_vendor
                                       WHERE name like `in_shipping_vendor_string`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

   OPEN vendor_cursor;
     FETCH vendor_cursor into vendor_id;
   CLOSE vendor_cursor; 

   /*if there was a vendor_id found, return the value*/
   IF no_rows_found=0 THEN
       SET `out_ship_vendor_id`=vendor_id;
      /*if there was not a vendor_id found, return the null*/
      ELSE
          SET `out_ship_vendor_id`=NULL;
   END IF;
END;

DROP PROCEDURE IF EXISTS suspension.prepare_shipping_account;
CREATE PROCEDURE suspension.prepare_shipping_account(
	       IN `in_shipping_vendor_id` int(10),
               IN `in_shipping_method_account` varchar(100),
	       OUT `out_ship_method_account` int(10)
       )
BEGIN
   DECLARE shipping_acct int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE ship_acct_cursor CURSOR FOR
                         SELECT row_id FROM suspension.ship_method_account
                                       WHERE ship_vendor=`in_shipping_vendor_id` AND
				             account_number =`in_shipping_method_account`;
				             

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

   /*if the shipping account info was null, just return null for the out_ship_method_account */
   IF (`in_shipping_method_account` <=> NULL) THEN 
       SET `out_ship_method_account`=NULL;
       /*otherwise check to see if there is an existing _ship_method_account */
       ELSE 
         OPEN ship_acct_cursor;
           FETCH ship_acct_cursor into shipping_acct;
         CLOSE ship_acct_cursor; 


         /*if there was an existing accout that matched, just return that row_id*/
         IF no_rows_found=0 THEN
            SET `out_ship_method_account`=shipping_acct;	 
            /*if there wasn't an existing accout that matched, create one and return the new row_id*/
            ELSEIF no_rows_found=1 THEN
                   INSERT INTO suspension.ship_method_account(ship_vendor,account_number)
                                                      VALUES (`in_shipping_vendor_id`,`in_shipping_method_account`);
                   SET @new_ship_method_account_entry=LAST_INSERT_ID();
                   SET `out_ship_method_account`=@new_ship_method_account_entry;	 
         END IF;
   END IF;

END;


DROP PROCEDURE IF EXISTS suspension.save_shipping_acct_info;
CREATE PROCEDURE suspension.save_shipping_acct_info(
	       IN `in_work_order` int(10),
	       IN `in_use_shipping_account` int(1),
	       IN `in_shipping_vendor_string` varchar(50),
	       IN `in_shipping_method_account` varchar(100)
               )
BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;
     SET @valid_shipping_id=0;

     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting); 
     call prepare_shipping(@valid_work_order,@valid_shipping_id); 

     /*clean up any existing shipping accounts for this shipping entry already existing*/
     /*call remove_acct_from_shipping_entry(@valid_shipping_id);*/

     UPDATE suspension.shipping SET use_shipping_account=`in_use_shipping_account`
                                WHERE row_id=@valid_shipping_id;

     IF `in_use_shipping_account`=1 THEN
        /*see if this shipping account is present already*/
        call prepare_shipping_vendor(CONCAT(substring(`in_shipping_vendor_string`,1,3),"%"),@valid_vendor_id);
	SELECT "valid_vendor_id was ",@valid_vendor_id;
        call prepare_shipping_account(@valid_vendor_id,`in_shipping_method_account`,@valid_shipping_method_account_id);

        UPDATE suspension.shipping SET ship_method_account=@valid_shipping_method_account_id
                                   WHERE row_id=@valid_shipping_id;
	ELSE
           UPDATE suspension.shipping SET ship_method_account=null
                                      WHERE row_id=@valid_shipping_id;
     END IF;
END;


DROP PROCEDURE IF EXISTS suspension.get_shipping_info;
CREATE PROCEDURE get_shipping_info(
		IN `in_work_order_id` int (10)
                 )
BEGIN
  SELECT 
            METHOD.description 
    FROM suspension.shipping as SHIP 
            LEFT JOIN suspension.ship_method as METHOD 
		    ON SHIP.ship_method=METHOD.row_id
        WHERE 
              SHIP.work_order=`in_work_order_id`;
END;


DROP PROCEDURE IF EXISTS suspension.save_shipping_info;
CREATE PROCEDURE suspension.save_shipping_info(
	       IN `in_work_order` int(10),
	       IN `in_ship_method` int(10)
               )
BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;
     SET @valid_shipping_id=0;

     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting); 
     call prepare_shipping(@valid_work_order,@valid_shipping_id); 
     UPDATE suspension.shipping SET ship_method=`in_ship_method` 
                                WHERE row_id=@valid_shipping_id;
END;

/*-------------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS suspension.prepare_work_order_setting;
CREATE PROCEDURE suspension.prepare_work_order_setting(
               IN `in_work_order` int(10),
               OUT `out_setting` int(10) 
              )
BEGIN
   DECLARE existing_setting int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE setting_cursor CURSOR FOR
		SELECT setting FROM suspension.work_order
			      WHERE row_id=`in_work_order`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN setting_cursor;
      FETCH setting_cursor into existing_setting;
    CLOSE setting_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF existing_setting<=>NULL THEN
       /*create an empty setting entry*/
       INSERT INTO suspension.setting (date) VALUES(curdate()); 
       SET @new_setting=LAST_INSERT_ID();

       /*update the work_order with the new setting*/
       UPDATE suspension.work_order SET setting =@new_setting WHERE row_id=`in_work_order`; 
       SET @new_work_order=LAST_INSERT_ID();
       SET `out_setting`=@new_work_order;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_setting`=existing_setting;
     END IF;
END;


DROP PROCEDURE IF EXISTS suspension.get_setting_from_workorder;
CREATE PROCEDURE get_setting_from_workorder(
		IN `in_work_order` int (10)
                 )
BEGIN
  SET @valid_setting=0;
  call prepare_work_order_setting(`in_work_order`,@valid_setting);
  SELECT @valid_setting AS setting;
END;

DROP PROCEDURE IF EXISTS suspension.get_change_date;
CREATE PROCEDURE get_change_date(
		IN `in_setting` int (10)
                 )
BEGIN
  SELECT 
	 SETTING.date as "Date"
  FROM 
       suspension.setting as SETTING
  WHERE 
        SETTING.row_id=`in_setting`; 
END;

DROP PROCEDURE IF EXISTS suspension.get_revision;
CREATE PROCEDURE get_revision(
		IN `in_work_order_id` int (10)
                 )
BEGIN
   SET @shock_revision=0;
   SET @fork_revision=0;
   call find_revision(`in_work_order_id`,@shock_revision,@fork_revision);
   SELECT 
        @shock_revision as `shock_rev`,
        @fork_revision as `fork_rev`;
END;


DROP PROCEDURE IF EXISTS suspension.get_work_order_info;
CREATE PROCEDURE get_work_order_info(
		 IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
           SHOP.name as "Shop",
	   SRV_LOC.location as "Service Location"
   FROM suspension.work_order as WORK_ORDER 
           LEFT JOIN  suspension.shop as SHOP
		   ON WORK_ORDER.shop=SHOP.row_id 
           LEFT JOIN  suspension.service_location as SRV_LOC 
		   ON WORK_ORDER.service_location=SRV_LOC.row_id 
       WHERE 
	     WORK_ORDER.row_id =`in_work_order`;
END;

DROP PROCEDURE IF EXISTS suspension.get_rider_info;
CREATE PROCEDURE get_rider_info(
		IN `in_rider_id` int (10)
                 )
BEGIN
   SELECT 
	   RIDER.first_name as "First Name",
	   RIDER.last_name as "Last Name",
	   RIDER.support_id as "Support ID",
	   RIDER.rider_phone1 as "Rider Phone 1",
	   RIDER.rider_phone2 as "Rider Phone 2",
           ADDRESS.address1 as "Address 1",
           ADDRESS.address2 as "Address 2",
           ADDRESS.address3 as "Address 3",
           ADDRESS.city as "City",
           ADDRESS.state_province as "State",
           ADDRESS.country as "Country",
           ADDRESS.zip as "Zip",
           ADDRESS.phone1 as "Phone at Address",
           ADDRESS.phone2 as "Alt Phone"
   FROM suspension.rider as RIDER
	   LEFT JOIN suspension.address as ADDRESS
		   ON RIDER.address=ADDRESS.row_id
       WHERE 
	     RIDER.row_id =`in_rider_id`;
END;


DROP PROCEDURE IF EXISTS suspension.get_arrival_specs_for_setting;
CREATE PROCEDURE get_arrival_specs_for_setting(
		IN `in_setting_id` int (10)
                 )
BEGIN
  SELECT
         ARRIVAL_SPEC.row_id as "arrival_spec",
         ARRIVAL_SPEC.shock_leaking as "shock_leaking",
         ARRIVAL_SPEC.forks_leaking as "fork_leaking",
         SHOCK_SPEC.row_id as "arrival_shock_spec", 
         FORK_SPEC.row_id as "arrival_fork_spec" 
	  
    FROM 
          suspension.setting as SETTING 
		LEFT JOIN suspension.settings_on_arrival as ARRIVAL_SPEC 
			ON SETTING.settings_on_arrival=ARRIVAL_SPEC.row_id  
                LEFT JOIN suspension.shock_spec as SHOCK_SPEC
			ON ARRIVAL_SPEC.shock_spec=SHOCK_SPEC.row_id
                LEFT JOIN suspension.fork_spec as FORK_SPEC
			ON ARRIVAL_SPEC.fork_spec=FORK_SPEC.row_id
    WHERE 
	  SETTING.row_id =`in_setting_id`;
END;

DROP PROCEDURE IF EXISTS suspension.get_shock_fork_specs_for_setting;
CREATE PROCEDURE get_shock_fork_specs_for_setting(
		IN `in_setting_id` int (10)
                 )
BEGIN
  SELECT
          SETTING.fork_spec as fork_spec,
	  SETTING.shock_spec as shock_spec
    FROM 
          suspension.setting as SETTING 
    WHERE 
	  SETTING.row_id =`in_setting_id`;
END;



DROP PROCEDURE IF EXISTS suspension.get_arrival_fork_spec;
CREATE PROCEDURE get_arrival_fork_spec(
		IN `in_fork_spec` int (20)
                 )
BEGIN
  SELECT
        FORK.springs as Rate,
	FORK.comp_clicks as Compression,
	FORK.reb_clicks as Rebound,
	FORK.spring_length as "Spring Length",
	FORK.chamber_length as "Chamber Length",
	FORK.oil_vol as Oil_Vol,
	FORK.oil_height as Oil_Height
    FROM 
          suspension.fork_spec as FORK
    WHERE 
	  FORK.row_id =`in_fork_spec`;
END;

DROP PROCEDURE IF EXISTS suspension.get_fork_spec;
CREATE PROCEDURE get_fork_spec(
		IN `in_fork_spec` int (20)
                 )
BEGIN
  SELECT
	FORK.springs as Rate,
	FORK.comp_clicks as Compression,
	FORK.reb_clicks as Rebound,
	FORK.spring_length as "Spring Length",
	FORK.chamber_length as "Chamber Length",
	FORK.oil_vol as Oil_Vol,
	FORK.oil_height as Oil_Height,
	FORK.oil_type as Oil_Type,
        FORK.comments as Comments	
    FROM 
          suspension.fork_spec as FORK
    WHERE 
	  FORK.row_id =`in_fork_spec`;
END;

DROP PROCEDURE IF EXISTS suspension.get_arrival_shock_spec;
CREATE PROCEDURE get_arrival_shock_spec(
		IN `in_shock_spec` int (20)
                 )
BEGIN
  SELECT 
	SHOCK.springs as Rate,
	SHOCK.LS_comp_clicks as LS_Comp,
	SHOCK.HS_comp_turns as HS_Comp,
	SHOCK.reb_clicks as Rebound,
	SHOCK.compressed_length as "Compressed Length",
	SHOCK.free_length as "Free Length"
  FROM 
        suspension.shock_spec as SHOCK
  WHERE 
	SHOCK.row_id =`in_shock_spec`;
END;

DROP PROCEDURE IF EXISTS suspension.get_shock_spec;
CREATE PROCEDURE get_shock_spec(
		IN `in_shock_spec` int (20)
                 )
BEGIN
  SELECT 
	SHOCK.springs as Rate,
	SHOCK.LS_comp_clicks as LS_Comp,
	SHOCK.HS_comp_turns as HS_Comp,
	SHOCK.reb_clicks as Rebound,
        SHOCK.compressed_length as "Compressed Length",
        SHOCK.free_length as "Free Length",
	SHOCK.oil_type as Oil_Type,
	SHOCK.nitrogen as Nitrogen,
	SHOCK.z_cut as Z_Cut,
	SHOCK.sag as Sag,
        SHOCK.comments as Comments
  FROM 
        suspension.shock_spec as SHOCK
  WHERE 
	SHOCK.row_id =`in_shock_spec`;
END;

DROP PROCEDURE IF EXISTS suspension.get_shock_comp_shims;
CREATE PROCEDURE get_shock_comp_shims(
		IN `in_shock_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id AS spec_id,
         STACK.position AS pos, 
         STACK.shim_inner_diameter AS ID,
	 STACK.shim_outer_diameter_is_delta AS OD_is_DELTA,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.shock_compression_stack as STACK
  WHERE 
        STACK.shock_spec=`in_shock_spec` 
  ORDER BY STACK.position; 
END;

DROP PROCEDURE IF EXISTS suspension.get_shock_comp_adj_shims;
CREATE PROCEDURE get_shock_comp_adj_shims(
		IN `in_shock_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter AS ID,
	 STACK.shim_outer_diameter_is_delta AS OD_is_DELTA,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.shock_compression_adjuster_stack as STACK
  WHERE 
        STACK.shock_spec=`in_shock_spec` 
  ORDER BY pos; 
END;


DROP PROCEDURE IF EXISTS suspension.get_shock_reb_shims;
CREATE PROCEDURE get_shock_reb_shims(
		IN `in_shock_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter AS ID,
	 STACK.shim_outer_diameter_is_delta AS OD_is_DELTA,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.shock_rebound_stack as STACK
  WHERE 
        STACK.shock_spec=`in_shock_spec` 
  ORDER BY pos; 

END;


DROP PROCEDURE IF EXISTS suspension.get_fork_comp_shims;
CREATE PROCEDURE get_fork_comp_shims(
		IN `in_fork_spec` int (10)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter As ID,
	 STACK.shim_outer_diameter_is_delta AS OD_is_DELTA,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.fork_compression_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec` 
  ORDER BY pos; 
END;


DROP PROCEDURE IF EXISTS suspension.get_fork_lsv_shims;
CREATE PROCEDURE get_fork_lsv_shims(
		IN `in_fork_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter As ID,
	 STACK.shim_outer_diameter_is_delta AS OD_is_DELTA,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.fork_lsv_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec` 
  ORDER BY pos; 
END;

DROP PROCEDURE IF EXISTS suspension.get_fork_reb_shims;
CREATE PROCEDURE get_fork_reb_shims(
		IN `in_fork_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter As ID,
	 STACK.shim_outer_diameter_is_delta AS OD_is_DELTA,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.fork_rebound_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec`
  ORDER BY pos; 
END;


DROP PROCEDURE IF EXISTS suspension.get_fork_bcv_shims;
CREATE PROCEDURE get_fork_bcv_shims(
		IN `in_fork_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.collar_width as col_width,
	 STACK.rebound_piston_tower AS rebound_piston_tower,
	 STACK.spring_cup AS spring_cup,
         STACK.shim_inner_diameter  AS ID,
	 STACK.shim_outer_diameter_is_delta AS OD_is_DELTA,
         STACK.shim_outer_diameter  AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.fork_bcv_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec`
  ORDER BY pos; 
END;

DROP PROCEDURE IF EXISTS suspension.get_shock_springs;
CREATE PROCEDURE get_shock_springs()
BEGIN
  SELECT 
        SPRINGS.row_id,
        SPRINGS.rate

  FROM 
       suspension.springs as SPRINGS,
       suspension.spring_type as SPRING_TYPE
  WHERE 
        SPRINGS.spring_type=SPRING_TYPE.row_id AND
        SPRING_TYPE.description like "Shock";
END;

DROP PROCEDURE IF EXISTS suspension.get_fork_springs;
CREATE PROCEDURE get_fork_springs()
BEGIN
  SELECT 
        SPRINGS.row_id,
        SPRINGS.rate

  FROM 
       suspension.springs as SPRINGS,
       suspension.spring_type as SPRING_TYPE
  WHERE 
        SPRINGS.spring_type=SPRING_TYPE.row_id AND
        SPRING_TYPE.description like "Fork";
END;




/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedure deals with shock adjustments*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.prepare_shock_spec;
CREATE PROCEDURE suspension.prepare_shock_spec(
               IN `in_setting` int(10),
               OUT `out_spec` int(20) 
              )
BEGIN
   DECLARE existing_spec int(20); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE spec_cursor CURSOR FOR
		SELECT shock_spec FROM suspension.setting WHERE row_id=`in_setting`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN spec_cursor;
      FETCH spec_cursor into existing_spec;
    CLOSE spec_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF existing_spec<=>NULL THEN
       /*create an empty work_order entry*/
       INSERT INTO suspension.shock_spec (revision_number) VALUES(0); 
       SET @new_spec=LAST_INSERT_ID();
       UPDATE suspension.setting SET shock_spec=@new_spec WHERE row_id=`in_setting`;
       SET `out_spec`=@new_spec;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_spec`=existing_spec;
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.save_shock_adjustments;
CREATE PROCEDURE suspension.save_shock_adjustments(
	       IN `in_setting_id` int(10),
               IN `in_springs` decimal(4,3),
               IN `in_LS_comp` int(2),
               IN `in_HS_comp` varchar(5),
               IN `in_reb` int(2),
               IN `in_oil_type` varchar(10),
               IN `in_nitrogen` int(4),
	       IN `in_z_cut` varchar(3),
               IN `in_sag` int(4)	
       )

BEGIN 
     SET @valid_setting=0;
     SET @valid_shock_spec=0;
     call prepare_setting(`in_setting_id`,@valid_setting);
     call prepare_shock_spec(@valid_setting, @valid_shock_spec);

     UPDATE suspension.shock_spec SET springs=`in_springs` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET LS_comp_clicks=`in_LS_comp` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET HS_comp_turns=`in_HS_comp` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET reb_clicks=`in_reb` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET oil_type=`in_oil_type` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET nitrogen=`in_nitrogen` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET z_cut=`in_z_cut` WHERE row_id=@valid_shock_spec;
     UPDATE suspension.shock_spec SET sag=`in_sag` WHERE row_id=@valid_shock_spec;
END;
/*-------------------------------------------------------------------------------------*


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedure deals with fork adjustments*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.prepare_fork_spec;
CREATE PROCEDURE suspension.prepare_fork_spec(
               IN `in_setting` int(10),
               OUT `out_spec` int(20) 
              )
BEGIN
    DECLARE existing_spec int(20); 
    DECLARE no_rows_found INT DEFAULT 0;

    DECLARE spec_cursor CURSOR FOR
 		SELECT fork_spec FROM suspension.setting WHERE row_id=`in_setting`; 

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN spec_cursor;
      FETCH spec_cursor into existing_spec;
    CLOSE spec_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF existing_spec<=>NULL THEN
       /*create an empty work_order entry*/
       INSERT INTO suspension.fork_spec (revision_number) VALUES(0); 
       SET @new_spec=LAST_INSERT_ID();
       UPDATE suspension.setting SET fork_spec=@new_spec WHERE row_id=`in_setting`;
       SET `out_spec`=@new_spec;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_spec`=existing_spec;
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.save_fork_adjustments;
CREATE PROCEDURE suspension.save_fork_adjustments(
	       IN `in_setting_id` int(10),
               IN `in_springs` decimal(4,3),
               IN `in_comp` int(2),
               IN `in_reb` int(2),
               IN `in_oil_vol` int(3),
               IN `in_oil_height` int(3),
               IN `in_oil_type` varchar(10),	
	       IN `in_spring_length` int(4),
	       IN `in_chamber_length` int(4)
       )

BEGIN 
     SET @valid_setting=0;
     SET @valid_fork_spec=0;
     call prepare_setting(`in_setting_id`,@valid_setting);
     call prepare_fork_spec(@valid_setting, @valid_fork_spec);

     UPDATE suspension.fork_spec SET springs=`in_springs` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET comp_clicks=`in_comp` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET reb_clicks=`in_reb` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET oil_vol=`in_oil_vol` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET oil_height=`in_oil_height` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET oil_type=`in_oil_type` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET spring_length=`in_spring_length` WHERE row_id=@valid_fork_spec;
     UPDATE suspension.fork_spec SET chamber_length=`in_chamber_length` WHERE row_id=@valid_fork_spec;
END;
/*-------------------------------------------------------------------------------------*/
      
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with getting and setting the work permissions*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_overall_info;
CREATE PROCEDURE get_overall_info(
		IN `in_work_order` int (10)
                )
BEGIN
     SELECT 
	    NEED_SPRINGS.ok_to_replace,
	    WORK_ORDER.call_prior,
	    WORK_ORDER.ok_to_replace_bearing,
	    TURN_AROUND.num_days as `Turn Around`
       FROM suspension.work_order as WORK_ORDER 
            LEFT JOIN suspension.need_springs as NEED_SPRINGS
	    	 ON WORK_ORDER.row_id=NEED_SPRINGS.work_order
            LEFT JOIN suspension.days as TURN_AROUND
	    	 ON WORK_ORDER.turn_around=TURN_AROUND.row_id
       WHERE 
	    WORK_ORDER.row_id=`in_work_order`; 
END;

DROP PROCEDURE IF EXISTS suspension.prepare_need_springs;
CREATE PROCEDURE suspension.prepare_need_springs(
               IN `in_work_order` int(10),
               OUT `out_need_springs` int(10) 
              )
BEGIN
     DECLARE existing_need_springs int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE need_springs_cursor CURSOR FOR
		SELECT row_id FROM suspension.need_springs
	                      WHERE work_order=`in_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     OPEN need_springs_cursor;
       FETCH need_springs_cursor into existing_need_springs; 
     CLOSE need_springs_cursor; 

    /*if the existing_work_order was null,we need to create a need_springs entry*/
    /*and return the new row_id */
    IF existing_need_springs<=>NULL THEN
       /*create a need_springs entry for the given work_order*/
       INSERT INTO suspension.need_springs (work_order) VALUES(`in_work_order`); 
       SET @new_need_springs=LAST_INSERT_ID();
       SET `out_need_springs`=@new_need_springs;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_need_springs`=existing_need_springs;
     END IF;
END;


DROP PROCEDURE IF EXISTS suspension.save_overall_info;
CREATE PROCEDURE save_overall_info(
		 IN `in_work_order` int (10),
		 IN `in_OK_to_Replace` int (1),
		 IN `in_OK_to_Replace_Bearing` int (1),
		 IN `in_Call_Prior_to_Work` int (1),
		 IN `in_turn_around` int (10)
	         ) 
BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;
     SET @valid_need_springs=0;

     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
     call prepare_need_springs(@valid_work_order,@valid_need_springs); 

     /*First, update the work_order table with the new call_prior values*/
     UPDATE suspension.work_order SET call_prior=`in_Call_Prior_to_Work` WHERE row_id=@valid_work_order;
     UPDATE suspension.work_order SET ok_to_replace_bearing=`in_OK_to_Replace_Bearing` WHERE row_id=@valid_work_order;
     UPDATE suspension.work_order SET turn_around=`in_turn_around` WHERE row_id=@valid_work_order;

     /*Second, update the need_springs entry with the new OK_to_Replace value*/
     UPDATE suspension.need_springs SET ok_to_replace=`in_OK_to_Replace` WHERE work_order=@valid_work_order;
END;

/*-------------------------------------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with Finance Header Information*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.get_finance_header_info;
CREATE PROCEDURE get_finance_header_info(
		 IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        quote as "quote number",
	sales_order as "sales order",
	invoice as "invoice number"
   FROM suspension.finance
   WHERE 
	work_order=`in_work_order`; 
END;


DROP PROCEDURE IF EXISTS suspension.save_finance_header_info;
CREATE PROCEDURE suspension.save_finance_header_info(
	       IN `in_work_order` int(10),
	       IN `in_quote_num` varchar(10),
	       IN `in_sales_order` varchar(10),
	       IN `in_invoice_num` varchar(10)
               )
BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;
     SET @valid_finance_id=0;

     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting); 
     call prepare_finance_info(@valid_work_order,@valid_finance_id); 
     /*save only the first 10 characters*/
     UPDATE suspension.finance SET quote=substring(`in_quote_num`,1,10) WHERE work_order=@valid_work_order;
     UPDATE suspension.finance SET sales_order=substring(`in_sales_order`,1,10) WHERE work_order=@valid_work_order;
     UPDATE suspension.finance SET invoice=substring(`in_invoice_num`,1,10) WHERE work_order=@valid_work_order;
END;
/*-------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures are used in saving fork and shock services information*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.prepare_finance;
CREATE PROCEDURE suspension.prepare_finance(
               IN `in_work_order` int(10),
               OUT `out_finance` int(10) 
              )
BEGIN
     DECLARE existing_finance int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE finance_cursor CURSOR FOR
		SELECT row_id FROM suspension.finance 
			      WHERE work_order=`in_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     OPEN finance_cursor;
       FETCH finance_cursor into existing_finance;
     CLOSE finance_cursor; 

    /*if the existing_work_order was null,we need to create a need_springs entry*/
    /*and return the new row_id */
    IF existing_finance<=>NULL THEN
       /*create a need_springs entry for the given work_order*/
       INSERT INTO suspension.finance (work_order) VALUES(`in_work_order`); 
       SET @new_finance=LAST_INSERT_ID();
       SET `out_finance`=@out_finance;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_finance`=existing_finance;
     END IF;
END;
/*-------------------------------------------------------------*/



/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with fork services estimates*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.save_fork_need_springs_info_for_work_order;
CREATE PROCEDURE suspension.save_fork_need_springs_info_for_work_order(
	       IN `in_work_order` int(10),
	       IN `in_Need_Springs` int(1),
	       IN `in_rate` decimal(4,3)
               )
BEGIN
     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
     call prepare_need_springs(@valid_work_order,@valid_need_springs); 

     UPDATE suspension.need_springs SET need_fork_spring=`in_Need_Springs` WHERE work_order=`in_work_order`;
     UPDATE suspension.need_springs SET recommended_fork_spring=`in_rate` WHERE work_order=`in_work_order`;
END;


DROP PROCEDURE IF EXISTS suspension.collect_fork_labor_discount;
CREATE PROCEDURE suspension.collect_fork_labor_discount(
               IN `in_work_order` int(10),
	       OUT `out_amount` decimal(8,2),
	       OUT `out_discount` int(3)
              )
BEGIN
   DECLARE amount decimal(8,2) DEFAULT null; 
   DECLARE discount int(3) DEFAULT null; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
	   BASE.labor, 
	   DISCOUNT.amount 
        FROM suspension.finance as FINANCE 
           LEFT JOIN suspension.estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=ESTIMATE_FORK.row_id
	   LEFT JOIN suspension.discount_rate as DISCOUNT
		ON BASE.labor_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END;


DROP PROCEDURE IF EXISTS suspension.collect_fork_fluid_discount;
CREATE PROCEDURE suspension.collect_fork_fluid_discount(
               IN `in_work_order` int(10),
	       OUT `out_amount` decimal(8,2),
	       OUT `out_discount` int(3)
              )
BEGIN
   DECLARE amount decimal(8,2) DEFAULT null; 
   DECLARE discount int(3) DEFAULT null; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
	   BASE.fluid, 
	   DISCOUNT.amount 
        FROM suspension.finance as FINANCE 
           LEFT JOIN suspension.estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN suspension.discount_rate as DISCOUNT
		ON BASE.fluid_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.collect_fork_spring_discount;
CREATE PROCEDURE suspension.collect_fork_spring_discount(
               IN `in_work_order` int(10),
	       OUT `out_amount` decimal(8,2),
	       OUT `out_discount` int(3)
              )
BEGIN
   DECLARE amount decimal(8,2) DEFAULT null; 
   DECLARE discount int(3) DEFAULT null; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
	   BASE.springs, 
	   DISCOUNT.amount 
        FROM suspension.finance as FINANCE 
           LEFT JOIN suspension.estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN suspension.discount_rate as DISCOUNT
		ON BASE.spring_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.collect_fork_parts_discount;
CREATE PROCEDURE suspension.collect_fork_parts_discount(
               IN `in_work_order` int(10),
	       OUT `out_amount` decimal(8,2),
	       OUT `out_discount` int(3)
              )
BEGIN
   DECLARE amount decimal(8,2) DEFAULT null; 
   DECLARE discount int(3) DEFAULT null; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
	   BASE.parts, 
	   DISCOUNT.amount 
        FROM suspension.finance as FINANCE 
           LEFT JOIN suspension.estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN suspension.discount_rate as DISCOUNT
		ON BASE.parts_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.collect_fork_coatings_discount;
CREATE PROCEDURE suspension.collect_fork_coatings_discount(
               IN `in_work_order` int(10),
	       OUT `out_amount` decimal(8,2),
	       OUT `out_discount` int(3)
              )
BEGIN
   DECLARE amount decimal(8,2) DEFAULT null; 
   DECLARE discount int(3) DEFAULT null; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
	   BASE.coatings, 
	   DISCOUNT.amount 
        FROM suspension.finance as FINANCE 
           LEFT JOIN suspension.estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN suspension.discount_rate as DISCOUNT
		ON BASE.coatings_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END;

DROP PROCEDURE IF EXISTS suspension.collect_fork_other_discount;
CREATE PROCEDURE suspension.collect_fork_other_discount(
               IN `in_work_order` int(10),
	       OUT `out_amount` decimal(8,2),
	       OUT `out_discount` int(3)
              )
BEGIN
   DECLARE amount decimal(8,2) DEFAULT null; 
   DECLARE discount int(3) DEFAULT null; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
	   BASE.other, 
	   DISCOUNT.amount 
        FROM suspension.finance as FINANCE 
           LEFT JOIN suspension.estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN suspension.discount_rate as DISCOUNT
		ON BASE.other_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    /*if the existing_work_order was null,we need to create a work_order entry*/
    /*and return the new row_id */
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END;



DROP PROCEDURE IF EXISTS suspension.get_fork_estimate_info;
CREATE PROCEDURE get_fork_estimate_info(
		 IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ESTIMATE_FORK.labor,
        ESTIMATE_FORK.labor_discount,
        ESTIMATE_FORK.fluid,
        ESTIMATE_FORK.fluid_discount,
        ESTIMATE_FORK.springs,
        ESTIMATE_FORK.springs_discount,
	ESTIMATE_FORK.parts,
	ESTIMATE_FORK.parts_discount,
	ESTIMATE_FORK.coatings,
	ESTIMATE_FORK.coatings_discount,
	ESTIMATE_FORK.other,
	ESTIMATE_FORK.other_discount
   FROM suspension.finance as FINANCE 
	LEFT JOIN suspension.estimate_fork as ESTIMATE_FORK
		ON FINANCE.estimate_fork=ESTIMATE_FORK.row_id
   WHERE 
	FINANCE.work_order=`in_work_order`; 
END;

DROP PROCEDURE IF EXISTS suspension.get_fork_need_springs_info;
CREATE PROCEDURE get_fork_need_springs_info(
		IN `in_work_order` int (10)
                )
BEGIN
     SELECT 
	    NEED_SPRINGS.need_fork_spring,
	    NEED_SPRINGS.recommended_fork_spring AS 'rate'
       FROM suspension.need_springs as NEED_SPRINGS 
       WHERE 
	    NEED_SPRINGS.work_order=`in_work_order`; 
END;


DROP PROCEDURE IF EXISTS suspension.get_fork_estimate_id;
CREATE PROCEDURE suspension.get_fork_estimate_id(
               IN `in_finance` varchar(5000),
               OUT `out_fork_estimate_id` int(10) 
              )
BEGIN
     DECLARE fork_estimate_id int(10); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE fork_estimate_cursor CURSOR FOR
	 SELECT estimate_fork FROM suspension.finance
			      WHERE row_id=`in_finance`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     /*Get the id of the customer comments and the tech support comments*/
     OPEN fork_estimate_cursor;
       FETCH fork_estimate_cursor into fork_estimate_id;
     CLOSE fork_estimate_cursor; 

     IF no_rows_found=0 THEN
         SET `out_fork_estimate_id`=fork_estimate_id;
        ELSEIF no_rows_found=1 THEN
         SET `out_fork_estimate_id`=0;
      END IF;
END;


DROP PROCEDURE IF EXISTS suspension.prepare_estimate_fork;
CREATE PROCEDURE suspension.prepare_estimate_fork(
               IN `in_finance` int(10),
               OUT `out_estimate` int(10) 
              )
BEGIN
     DECLARE existing_estimate int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE estimate_cursor CURSOR FOR
		SELECT estimate_fork FROM suspension.finance 
			      WHERE row_id=`in_finance`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     OPEN estimate_cursor;
       FETCH estimate_cursor into existing_estimate;
     CLOSE estimate_cursor; 

    /*if the existing_work_order was null,we need to create a need_springs entry*/
    /*and return the new row_id */
    IF existing_estimate<=>NULL THEN
       /*create a fork_estimate entry for the given finance entry*/
       INSERT INTO suspension.estimate_fork () VALUES(); 
       SET @new_estimate=LAST_INSERT_ID();
       UPDATE suspension.finance SET estimate_fork=@new_estimate WHERE row_id=`in_finance`;
       SET `out_estimate`=@new_estimate;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_estimate`=existing_estimate;
     END IF;
END;


DROP PROCEDURE IF EXISTS suspension.save_fork_estimate;
CREATE PROCEDURE save_fork_estimate(
		 IN `in_work_order` int (10),
		 IN `in_labor` decimal(8,2),
		 IN `in_labor_discount` varchar (4),
		 IN `in_fluid` decimal(8,2),
		 IN `in_fluid_discount` varchar (4),
		 IN `in_springs` decimal(8,2),
		 IN `in_springs_discount` varchar (4),
		 IN `in_parts` decimal(8,2),
		 IN `in_parts_discount` varchar (4),
		 IN `in_coatings` decimal(8,2),
		 IN `in_coatings_discount` varchar (4),
		 IN `in_other` decimal(8,2),
		 IN `in_other_discount` varchar (4),
		 IN `in_Need_Springs` int (1),
		 IN `in_rate` decimal (4,3)
	         ) 
BEGIN
     SET @valid_finance=0;
     SET @valid_fork_estimate=0;
     call prepare_finance(`in_work_order`,@valid_finance);
     call prepare_estimate_fork(@valid_finance,@valid_fork_estimate);

     UPDATE suspension.estimate_fork SET labor=`in_labor` WHERE row_id=@valid_fork_estimate;
     UPDATE suspension.estimate_fork SET labor_discount=`in_labor_discount` WHERE row_id=@valid_fork_estimate;

     UPDATE suspension.estimate_fork SET fluid=`in_fluid` WHERE row_id=@valid_fork_estimate;
     UPDATE suspension.estimate_fork SET fluid_discount=`in_fluid_discount` WHERE row_id=@valid_fork_estimate;

     UPDATE suspension.estimate_fork SET springs=`in_springs` WHERE row_id=@valid_fork_estimate;
     UPDATE suspension.estimate_fork SET springs_discount=`in_springs_discount` WHERE row_id=@valid_fork_estimate;
					
     UPDATE suspension.estimate_fork SET parts=`in_parts` WHERE row_id=@valid_fork_estimate;
     UPDATE suspension.estimate_fork SET parts_discount=`in_parts_discount` WHERE row_id=@valid_fork_estimate;

     UPDATE suspension.estimate_fork SET coatings=`in_coatings` WHERE row_id=@valid_fork_estimate;
     UPDATE suspension.estimate_fork SET coatings_discount=`in_coatings_discount` WHERE row_id=@valid_fork_estimate;

     UPDATE suspension.estimate_fork SET other=`in_other` WHERE row_id=@valid_fork_estimate;
     UPDATE suspension.estimate_fork SET other_discount=`in_other_discount` WHERE row_id=@valid_fork_estimate;

     call save_fork_need_springs_info_for_work_order(`in_work_order`,`in_Need_Springs`,`in_rate`);
END;
/*-------------------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedures deal with shock services estimates*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.save_shock_need_springs_info_for_work_order;
CREATE PROCEDURE suspension.save_shock_need_springs_info_for_work_order(
	       IN `in_work_order` int(10),
	       IN `in_Need_Springs` int(1),
	       IN `in_rate` decimal(4,3)
               )
BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;
     SET @valid_need_springs=0;
     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
     call prepare_need_springs(@valid_work_order,@valid_need_springs); 

     UPDATE suspension.need_springs SET need_shock_spring=`in_Need_Springs` WHERE work_order=@valid_work_order;
     UPDATE suspension.need_springs SET recommended_shock_spring=`in_rate` WHERE work_order=@valid_work_order;
END;

DROP PROCEDURE IF EXISTS suspension.get_shock_estimate_info;
CREATE PROCEDURE get_shock_estimate_info(
		 IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ESTIMATE_SHOCK.labor,
        ESTIMATE_SHOCK.labor_discount,
        ESTIMATE_SHOCK.fluid,
        ESTIMATE_SHOCK.fluid_discount,
        ESTIMATE_SHOCK.springs,
        ESTIMATE_SHOCK.springs_discount,
	ESTIMATE_SHOCK.parts,
	ESTIMATE_SHOCK.parts_discount,
	ESTIMATE_SHOCK.coatings,
	ESTIMATE_SHOCK.coatings_discount,
	ESTIMATE_SHOCK.other,
	ESTIMATE_SHOCK.other_discount
   FROM suspension.finance as FINANCE 
	LEFT JOIN suspension.estimate_shock as ESTIMATE_SHOCK
		ON FINANCE.estimate_shock=ESTIMATE_SHOCK.row_id
   WHERE 
	FINANCE.work_order=`in_work_order`; 
END;

DROP PROCEDURE IF EXISTS suspension.get_shock_need_springs_info;
CREATE PROCEDURE get_shock_need_springs_info(
		IN `in_work_order` int (10)
                )
BEGIN
     SELECT 
	    NEED_SPRINGS.need_shock_spring,
	    NEED_SPRINGS.recommended_shock_spring AS 'rate'
       FROM suspension.need_springs as NEED_SPRINGS 
       WHERE 
	    NEED_SPRINGS.work_order=`in_work_order`; 
END;


DROP PROCEDURE IF EXISTS suspension.get_shock_estimate_id;
CREATE PROCEDURE suspension.get_shock_estimate_id(
               IN `in_finance` varchar(5000),
               OUT `out_shock_estimate_id` int(10) 
              )
BEGIN
     DECLARE shock_estimate_id int(10); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE shock_estimate_cursor CURSOR FOR
	 SELECT estimate_shock FROM suspension.finance
			       WHERE row_id=`in_finance`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     /*Get the id of the customer comments and the tech support comments*/
     OPEN shock_estimate_cursor;
       FETCH shock_estimate_cursor into shock_estimate_id;
     CLOSE shock_estimate_cursor; 

     IF no_rows_found=0 THEN
         SET `out_shock_estimate_id`=shock_estimate_id;
        ELSEIF no_rows_found=1 THEN
         SET `out_shock_estimate_id`=0;
      END IF;
END;

DROP PROCEDURE IF EXISTS suspension.prepare_estimate_shock;
CREATE PROCEDURE suspension.prepare_estimate_shock(
               IN `in_finance` int(10),
               OUT `out_estimate` int(10) 
              )
BEGIN
     DECLARE existing_estimate int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE estimate_cursor CURSOR FOR
		SELECT estimate_shock FROM suspension.finance 
			      WHERE row_id=`in_finance`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     OPEN estimate_cursor;
       FETCH estimate_cursor into existing_estimate;
     CLOSE estimate_cursor; 

    /*if the existing_work_order was null,we need to create a need_springs entry*/
    /*and return the new row_id */
    IF existing_estimate<=>NULL THEN
       /*create a shock_estimate entry for the given finance entry*/
       INSERT INTO suspension.estimate_shock () VALUES(); 
       SET @new_estimate=LAST_INSERT_ID();
       UPDATE suspension.finance SET estimate_shock=@new_estimate WHERE row_id=`in_finance`;
       SET `out_estimate`=@new_estimate;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_estimate`=existing_estimate;
     END IF;
END;


DROP PROCEDURE IF EXISTS suspension.save_shock_estimate;
CREATE PROCEDURE save_shock_estimate(
		 IN `in_work_order` int (10),
		 IN `in_labor` decimal(8,2),
		 IN `in_labor_discount` varchar (4),
		 IN `in_fluid` decimal(8,2),
		 IN `in_fluid_discount` varchar (4),
		 IN `in_springs` decimal(8,2),
		 IN `in_springs_discount` varchar (4),
		 IN `in_parts` decimal(8,2),
		 IN `in_parts_discount` varchar (4),
		 IN `in_coatings` decimal(8,2),
		 IN `in_coatings_discount` varchar (4),
		 IN `in_other` decimal(8,2),
		 IN `in_other_discount` varchar (4),
		 IN `in_Need_Springs` int (1),
		 IN `in_rate` decimal(4,3)
	         ) 
BEGIN
     SET @valid_finance=0;
     SET @valid_shock_estimate=0;
     call prepare_finance(`in_work_order`,@valid_finance);
     call prepare_estimate_shock(@valid_finance,@valid_shock_estimate);

     UPDATE suspension.estimate_shock SET labor=`in_labor` WHERE row_id=@valid_shock_estimate;
     UPDATE suspension.estimate_shock SET labor_discount=`in_labor_discount` WHERE row_id=@valid_shock_estimate;

     UPDATE suspension.estimate_shock SET fluid=`in_fluid` WHERE row_id=@valid_shock_estimate;
     UPDATE suspension.estimate_shock SET fluid_discount=`in_fluid_discount` WHERE row_id=@valid_shock_estimate;

     UPDATE suspension.estimate_shock SET springs=`in_springs` WHERE row_id=@valid_shock_estimate;
     UPDATE suspension.estimate_shock SET springs_discount=`in_springs_discount` WHERE row_id=@valid_shock_estimate;
					
     UPDATE suspension.estimate_shock SET parts=`in_parts` WHERE row_id=@valid_shock_estimate;
     UPDATE suspension.estimate_shock SET parts_discount=`in_parts_discount` WHERE row_id=@valid_shock_estimate;

     UPDATE suspension.estimate_shock SET coatings=`in_coatings` WHERE row_id=@valid_shock_estimate;
     UPDATE suspension.estimate_shock SET coatings_discount=`in_coatings_discount` WHERE row_id=@valid_shock_estimate;

     UPDATE suspension.estimate_shock SET other=`in_other` WHERE row_id=@valid_shock_estimate;
     UPDATE suspension.estimate_shock SET other_discount=`in_other_discount` WHERE row_id=@valid_shock_estimate;

     call save_shock_need_springs_info_for_work_order(`in_work_order`,`in_Need_Springs`,`in_rate`);
END;

/*-------------------------------------------------------------*/


DROP PROCEDURE IF EXISTS suspension.insert_open_work_order;
CREATE PROCEDURE suspension.insert_open_work_order(
               IN `in_work_order` int(10)
              )
BEGIN
     INSERT INTO suspension.open_work_orders(work_order) VALUES (`in_work_order`);
END;

DROP PROCEDURE IF EXISTS suspension.delete_open_work_order;
CREATE PROCEDURE suspension.delete_open_work_order(
               IN `in_work_order` int(10)
              )
BEGIN
     DELETE FROM suspension.open_work_orders WHERE work_order=`in_work_order`;
END;

DROP PROCEDURE IF EXISTS suspension.work_order_is_editable;
CREATE PROCEDURE suspension.work_order_is_editable(
               IN `in_work_order` int(10)
              )
BEGIN
   DECLARE existing_work_order int(10); 
   DECLARE response int(1) DEFAULT 0; 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE work_order_cursor CURSOR FOR
                     SELECT work_order FROM suspension.open_work_orders 
                                       WHERE work_order =`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

   OPEN work_order_cursor;
        FETCH work_order_cursor into existing_work_order;
   CLOSE work_order_cursor; 


   /*if it wasn't found it isn't open so it is editable, return 1*/
   /*if it was found, return 0 to indicate it is not editable*/
   IF existing_work_order<=>NULL THEN
      SET response=1;
      ELSE
      SET response=0;
   END IF;
   SELECT response;
END;

DROP PROCEDURE IF EXISTS suspension.update_address;
CREATE PROCEDURE update_address(
               IN `in_rider` int(10),
               IN `in_phone1` varchar(50),
               IN `in_phone2` varchar(50),
               IN `in_address1` varchar(100),
               IN `in_address2` varchar(100),
               IN `in_address3` varchar(100),
               IN `in_city` varchar(100),
               IN `in_state` varchar(50),
               IN `in_country` varchar(50),
               IN `in_zip` varchar(50)
	       )
BEGIN
   DECLARE existing_address int(10); 
   DECLARE done INT DEFAULT 0;

   DECLARE address_cursor CURSOR FOR
	   SELECT address FROM suspension.rider WHERE row_id=`in_rider`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1; /*To handle when no rows found*/
   SET @out_address=0;


   OPEN address_cursor;
 	 FETCH address_cursor into existing_address; 
   CLOSE address_cursor; 

   IF existing_address<=>NULL THEN
	/*there wasn't any address found, so create a new address and associate it with the rider*/
        call prepare_address(`in_phone1`,`in_phone2`,
		             `in_address1`,`in_address2`, `in_address3`,
			     `in_city`,`in_state`,`in_country`, 
			      `in_zip`,@out_address);
        UPDATE suspension.rider SET address=@out_address WHERE row_id=`in_rider`;
	/*otherwise just update the existing address*/
	ELSE
	UPDATE suspension.address SET phone1=`in_phone1` WHERE row_id=existing_address;
	UPDATE suspension.address SET phone2=`in_phone2` WHERE row_id=existing_address;
        UPDATE suspension.address SET address1=`in_address1` WHERE row_id=existing_address;
	UPDATE suspension.address SET address2=`in_address2` WHERE row_id=existing_address;
	UPDATE suspension.address SET address3=`in_address3` WHERE row_id=existing_address;
	UPDATE suspension.address SET city=`in_city` WHERE row_id=existing_address;
	UPDATE suspension.address SET state_province=`in_state` WHERE row_id=existing_address;
	UPDATE suspension.address SET country=`in_country` WHERE row_id=existing_address;
	UPDATE suspension.address SET zip=`in_zip` WHERE row_id=existing_address;
   END IF;

END;



DROP PROCEDURE IF EXISTS suspension.get_rider_names;
CREATE PROCEDURE get_rider_names()
BEGIN
   DECLARE the_row_id int(10); 
   DECLARE the_first_name varchar(100); 
   DECLARE the_last_name varchar(100); 

   DECLARE done INT DEFAULT 0;

   DECLARE names_cursor CURSOR FOR
	   SELECT row_id,first_name, last_name FROM suspension.rider;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1; /*To handle when no rows found*/

   DROP TEMPORARY TABLE IF EXISTS tmp_rider_names;
   CREATE TEMPORARY TABLE tmp_rider_names (
          row_id int(10),
          name varchar(100)
   );

   OPEN names_cursor;
 	FETCH names_cursor into the_row_id,the_first_name, the_last_name;
	WHILE (done=0) DO
	       IF (the_first_name!=the_last_name) THEN
	         INSERT INTO tmp_rider_names (row_id,name) VALUES (the_row_id, CONCAT(the_last_name,", ",the_first_name));
	       END IF;
	       IF (the_first_name=the_last_name) THEN
	         INSERT INTO tmp_rider_names (row_id,name) VALUES (the_row_id,the_first_name);
	       END IF;
 	       FETCH names_cursor into the_row_id,the_first_name, the_last_name;
	END WHILE;
   CLOSE names_cursor; 

   SELECT * FROM tmp_rider_names;
   DROP TEMPORARY TABLE IF EXISTS tmp_rider_names;
END;

/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
&
delimiter ;
/*------------------------------------------------*/

