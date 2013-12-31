/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
use suspension;
delimiter &
/*------------------------------------------------*/

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedure creates and empty work_order*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.create_new_work_order;
CREATE PROCEDURE suspension.create_new_work_order(
              )
BEGIN
  SET @new_work_order=0;
  SET @new_setting=0;
  SET @valid_shock_spec=0;
  SET @valid_fork_spec=0;

  call prepare_work_order(0,@new_work_order,@new_setting);
  call prepare_shock_spec(@new_setting,@valid_shock_spec); 
  call prepare_fork_spec(@new_setting,@valid_fork_spec); 
  call update_lookup_table(@new_work_order);
  SELECT @new_work_order AS "New ID";
END;
/*-------------------------------------------------------------------------------------*/




/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*This procedure clones the given work_order*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DROP PROCEDURE IF EXISTS suspension.get_setting_to_clone;
CREATE PROCEDURE suspension.get_setting_to_clone(
               IN `old_work_order` int(10), 
	       OUT `out_setting` int(10)
              )
BEGIN
     DECLARE old_setting int(10); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE setting_cursor CURSOR FOR
	 SELECT setting FROM suspension.work_order
			WHERE row_id=`old_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     OPEN setting_cursor;
       FETCH setting_cursor into old_setting;
     CLOSE setting_cursor; 

     IF old_setting<=>NULL THEN
         SET `out_setting`=0;
        ELSE 
         SET `out_setting`=old_setting;
     END IF;
END;

/*This procedure returns the fork spec and shock spec for a given setting*/
DROP PROCEDURE IF EXISTS suspension.get_setting_to_clone_info;
CREATE PROCEDURE suspension.get_setting_to_clone_info(
               IN `old_setting` int(10), 
	       OUT `out_fork_spec` int(20),
	       OUT `out_shock_spec` int(20)
              )
BEGIN
     DECLARE old_fork_spec int(20); 
     DECLARE old_shock_spec int(20); 

     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE setting_info_cursor CURSOR FOR
	 SELECT fork_spec, shock_spec FROM suspension.setting
			WHERE row_id=`old_setting`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     OPEN setting_info_cursor;
       FETCH setting_info_cursor into old_fork_spec,old_shock_spec;
     CLOSE setting_info_cursor; 

     IF old_fork_spec<=>NULL THEN
         SET  `out_fork_spec`=0;
        ELSE
         SET  `out_fork_spec`=old_fork_spec; 
     END IF;

     IF old_shock_spec<=>NULL THEN
         SET  `out_shock_spec`=0;
        ELSE
         SET  `out_shock_spec`=old_shock_spec; 
     END IF;
END;

DROP PROCEDURE IF EXISTS suspension.clone_fork_spec;
CREATE PROCEDURE suspension.clone_fork_spec(
               IN  `old_fork_spec` int(20), 
	       IN  `new_fork_revision_number` decimal(5,2),
	       OUT `new_fork_spec` int(20)
              )
BEGIN
  /*insert a clone of the fork_spec*/
  INSERT INTO suspension.fork_spec 
                        (revision_number,springs,comp_clicks,reb_clicks,spring_length,
			 chamber_length,oil_vol,oil_height,oil_type,general_info,comments)
                  SELECT `new_fork_revision_number`,springs,comp_clicks,reb_clicks,spring_length,
		          chamber_length,oil_vol,oil_height,oil_type,general_info,comments
                  FROM suspension.fork_spec 
	          WHERE row_id=`old_fork_spec`;

  SET `new_fork_spec`=LAST_INSERT_ID();

  INSERT INTO suspension.fork_bcv_stack 
                        (fork_spec,position,collar_width,rebound_piston_tower,spring_cup,
			 shim_inner_diameter,shim_outer_diameter_is_delta,shim_outer_diameter,shim_thickness,quantity) 
            SELECT `new_fork_spec`,position,collar_width,rebound_piston_tower,spring_cup,
	            shim_inner_diameter,shim_outer_diameter_is_delta,shim_outer_diameter,shim_thickness,quantity 
            FROM suspension.fork_bcv_stack 
	    WHERE fork_spec=`old_fork_spec`;

  INSERT INTO suspension.fork_compression_stack 
                        (fork_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_fork_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.fork_compression_stack 
	    WHERE fork_spec=`old_fork_spec`;

  INSERT INTO suspension.fork_lsv_stack 
                        (fork_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_fork_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.fork_lsv_stack 
	    WHERE fork_spec=`old_fork_spec`;

  INSERT INTO suspension.fork_rebound_stack 
                         (fork_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
             SELECT `new_fork_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
             FROM suspension.fork_rebound_stack 
	     WHERE fork_spec=`old_fork_spec`;
END;

DROP PROCEDURE IF EXISTS suspension.clone_shock_spec;
CREATE PROCEDURE suspension.clone_shock_spec(
               IN  `old_shock_spec` int(20), 
	       IN  `new_shock_revision_number` decimal(5,2),	
	       OUT `new_shock_spec` int(20)
              )
BEGIN
  /*insert a clone of the shock_spec*/
  INSERT INTO suspension.shock_spec 
                        (revision_number,springs,LS_comp_clicks,HS_comp_turns,reb_clicks,compressed_length,
			 free_length,oil_type,nitrogen,z_cut,sag,general_info,comments)
                  SELECT `new_shock_revision_number`,springs,LS_comp_clicks,HS_comp_turns,reb_clicks,compressed_length,
		          free_length,oil_type,nitrogen,z_cut,sag,general_info,comments
                  FROM suspension.shock_spec 
	          WHERE row_id=`old_shock_spec`;

  SET `new_shock_spec`=LAST_INSERT_ID();

  INSERT INTO suspension.shock_compression_stack 
                        (shock_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)   
            SELECT `new_shock_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.shock_compression_stack 
	    WHERE shock_spec=`old_shock_spec`;

  INSERT INTO suspension.shock_compression_adjuster_stack 
                        (shock_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_shock_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.shock_compression_adjuster_stack 
	    WHERE shock_spec=`old_shock_spec`;

  INSERT INTO suspension.shock_rebound_stack 
                        (shock_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_shock_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.shock_rebound_stack
	    WHERE shock_spec=`old_shock_spec`;
END;




DROP PROCEDURE IF EXISTS suspension.get_settings_on_arrival_to_clone;
CREATE PROCEDURE suspension.get_settings_on_arrival_to_clone(
               IN `old_setting` int(10), 
	       OUT `out_settings_on_arrival` int(10)
              )
BEGIN
     DECLARE old_settings_on_arrival int(10); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE settings_on_arrival_cursor CURSOR FOR
	 SELECT settings_on_arrival FROM suspension.setting
			            WHERE row_id=`old_setting`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     OPEN settings_on_arrival_cursor;
       FETCH settings_on_arrival_cursor into old_settings_on_arrival;
     CLOSE settings_on_arrival_cursor; 

     IF old_settings_on_arrival<=>NULL THEN
         SET `out_settings_on_arrival`=0;
        ELSE 
         SET `out_settings_on_arrival`=old_settings_on_arrival;
     END IF;
END;

DROP PROCEDURE IF EXISTS suspension.get_settings_on_arrival_to_clone_info;
CREATE PROCEDURE suspension.get_settings_on_arrival_to_clone_info(
               IN `old_settings_on_arrival` int(10), 
	       OUT `out_arrival_fork_spec` int(20),
	       OUT `out_arrival_shock_spec` int(20)
              )
BEGIN
     DECLARE old_arrival_fork_spec int(20); 
     DECLARE old_arrival_shock_spec int(20); 

     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE settings_on_arrival_info_cursor CURSOR FOR
	 SELECT fork_spec, shock_spec FROM suspension.settings_on_arrival
			              WHERE row_id=`old_settings_on_arrival`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     OPEN settings_on_arrival_info_cursor;
       FETCH settings_on_arrival_info_cursor into old_arrival_fork_spec,old_arrival_shock_spec;
     CLOSE settings_on_arrival_info_cursor; 

     IF old_arrival_fork_spec<=>NULL THEN
         SET  `out_arrival_fork_spec`=0;
        ELSE
         SET  `out_arrival_fork_spec`=old_arrival_fork_spec; 
     END IF;

     IF old_arrival_shock_spec<=>NULL THEN
         SET  `out_arrival_shock_spec`=0;
        ELSE
         SET  `out_arrival_shock_spec`=old_arrival_shock_spec; 
     END IF;
END;

DROP PROCEDURE IF EXISTS suspension.clone_arrival_fork_spec;
CREATE PROCEDURE suspension.clone_arrival_fork_spec(
               IN  `old_arrival_fork_spec` int(20), 
	       OUT `new_arrival_fork_spec` int(20)
              )
BEGIN
  /*insert a clone of the fork_spec*/
  INSERT INTO suspension.fork_spec 
                        (springs,comp_clicks,reb_clicks,spring_length,chamber_length,oil_vol,oil_height,oil_type)
                  SELECT springs,comp_clicks,reb_clicks,spring_length,chamber_length,oil_vol,oil_height,oil_type
                  FROM suspension.fork_spec 
	          WHERE row_id=`old_arrival_fork_spec`;

  SET `new_arrival_fork_spec`=LAST_INSERT_ID();
END;

DROP PROCEDURE IF EXISTS suspension.clone_arrival_shock_spec;
CREATE PROCEDURE suspension.clone_arrival_shock_spec(
               IN  `old_arrival_shock_spec` int(20), 
	       OUT `new_arrival_shock_spec` int(20)
              )
BEGIN
  /*insert a clone of the shock_spec*/
  INSERT INTO suspension.shock_spec 
                        (springs,LS_comp_clicks,HS_comp_turns,reb_clicks,compressed_length,free_length,oil_type,nitrogen,z_cut,sag)
                  SELECT springs,LS_comp_clicks,HS_comp_turns,reb_clicks,compressed_length,free_length,oil_type,nitrogen,z_cut,sag
                  FROM suspension.shock_spec 
	          WHERE row_id=`old_arrival_shock_spec`;

  SET `new_arrival_shock_spec`=LAST_INSERT_ID();
END;


DROP PROCEDURE IF EXISTS suspension.determine_revision_number;
CREATE PROCEDURE suspension.determine_revision_number(
               IN `old_setting` int(10), 
       	       IN `clone_type` varchar(15),	
       	       IN `revision_type` varchar(15),	
	       OUT `out_shock_revision_number` decimal(5,2),
	       OUT `out_fork_revision_number` decimal(5,2)
              )
BEGIN
     DECLARE old_shock_revision_number decimal(5,2); 
     DECLARE old_fork_revision_number decimal(5,2); 

     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE shock_revision_cursor CURSOR FOR
	 SELECT SHOCK_SPEC.revision_number 
	   FROM suspension.setting AS SETTING,
	        suspension.shock_spec AS SHOCK_SPEC
          WHERE SETTING.row_id=`old_setting` AND
	        SETTING.shock_spec=SHOCK_SPEC.row_id;
	       
     DECLARE fork_revision_cursor CURSOR FOR
	 SELECT FORK_SPEC.revision_number 
	   FROM suspension.setting AS SETTING,
	        suspension.fork_spec AS FORK_SPEC
          WHERE SETTING.row_id=`old_setting` AND
	        SETTING.fork_spec=FORK_SPEC.row_id;


     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     OPEN shock_revision_cursor;
       FETCH shock_revision_cursor into old_shock_revision_number;
     CLOSE shock_revision_cursor; 

     OPEN fork_revision_cursor;
       FETCH fork_revision_cursor into old_fork_revision_number;
     CLOSE fork_revision_cursor; 


     /*reset revision number to one if it is a new spec*/
     IF ((old_shock_revision_number<=>NULL)OR(`clone_type`="New Spec")) THEN
         SET  `out_shock_revision_number`=0;
     END IF;

     /*reset revision number to one if it is a new spec*/
     IF ((old_fork_revision_number<=>NULL)OR(`clone_type`="New Spec")) THEN
         SET  `out_fork_revision_number`=0;
     END IF;

     IF (`clone_type`="Major Revision")AND(`revision_type`="Revise Both") THEN
         SET  `out_shock_revision_number`=TRUNCATE(old_shock_revision_number,0)+1;
         SET  `out_fork_revision_number`=TRUNCATE(old_fork_revision_number,0)+1;
     END IF;

     IF (`clone_type`="Major Revision")AND(`revision_type`="Revise Shock") THEN
         SET  `out_shock_revision_number`=TRUNCATE(old_shock_revision_number,0)+1;
         SET  `out_fork_revision_number`=old_fork_revision_number;
     END IF;

     IF (`clone_type`="Major Revision")AND(`revision_type`="Revise Fork") THEN
         SET  `out_shock_revision_number`=old_shock_revision_number;
         SET  `out_fork_revision_number`=TRUNCATE(old_fork_revision_number,0)+1;
     END IF;
END;

DROP PROCEDURE IF EXISTS suspension.clone_setting;
CREATE PROCEDURE suspension.clone_setting(
               IN `old_work_order` int(10),
               IN `new_work_order` int(10),
       	       IN `clone_type` varchar(15),	
       	       IN `revision_type` varchar(15)	
              )
BEGIN
   SET @old_setting=0;
   SET @new_setting=0;
   SET @shock_revision_number=0;
   SET @fork_revision_number=0;
   SET @old_shock_spec=0;
   SET @new_shock_spec=0;
   SET @old_fork_spec=0;
   SET @new_fork_spec=0;

   call get_setting_to_clone(`old_work_order`,@old_setting);
   call determine_revision_number(@old_setting,`clone_type`,`revision_type`,@shock_revision_number,@fork_revision_number);

   call get_setting_to_clone_info(@old_setting,@old_fork_spec, @old_shock_spec);
   call clone_shock_spec(@old_shock_spec,@shock_revision_number, @new_shock_spec);
   call clone_fork_spec(@old_fork_spec,@fork_revision_number, @new_fork_spec);

   /*insert a clone of the inputed setting record*/
   INSERT INTO suspension.setting (date,fork_spec,shock_spec) 
			  VALUES  (curdate(), @new_fork_spec,@new_shock_spec);
   SET @new_setting=LAST_INSERT_ID();
    
  IF (`clone_type`="Major Revision") THEN 
     call clone_settings_on_arrival(@old_setting,@new_setting); 
  END IF;

  /*update the new work order with the new setting*/
  UPDATE suspension.work_order SET setting=@new_setting WHERE row_id=`new_work_order`;
END;

DROP PROCEDURE IF EXISTS suspension.clone_settings_on_arrival;
CREATE PROCEDURE suspension.clone_settings_on_arrival(
               IN `old_setting` int(10),
               IN `new_setting` int(10)
              )
BEGIN
   SET @old_settings_on_arrival=0;
   SET @new_settings_on_arrival=0;
   SET @old_arrival_shock_spec=0;
   SET @new_arrival_shock_spec=0;
   SET @old_arrival_fork_spec=0;
   SET @new_arrival_fork_spec=0;

   call get_settings_on_arrival_to_clone(`old_setting`,@old_settings_on_arrival);
   call get_settings_on_arrival_to_clone_info(@old_settings_on_arrival,@old_arrival_fork_spec, @old_arrival_shock_spec);
   call clone_arrival_fork_spec(@old_arrival_fork_spec, @new_arrival_fork_spec);
   call clone_arrival_shock_spec(@old_arrival_shock_spec, @new_arrival_shock_spec);

   /*insert a clone of the inputed settings_on_arrival record*/
   INSERT INTO suspension.settings_on_arrival 
                          (shock_leaking,forks_leaking,shock_spec,fork_spec) 
	   SELECT shock_leaking, forks_leaking,@new_arrival_shock_spec, @new_arrival_fork_spec
           FROM suspension.settings_on_arrival
	   WHERE row_id=@old_settings_on_arrival;
   SET @new_settings_on_arrival=LAST_INSERT_ID();

  /*update the new work order with the new setting*/
  UPDATE suspension.setting SET settings_on_arrival=@new_settings_on_arrival WHERE row_id=`new_setting`;
END;

DROP PROCEDURE IF EXISTS suspension.clone_top_level_of_work_order;
CREATE PROCEDURE suspension.clone_top_level_of_work_order(
               IN `old_work_order` int(10),
               IN `clone_type` varchar(25),
               OUT `new_work_order` int(10)
              )
BEGIN
  SET `new_work_order`=NULL;
  IF (`clone_type`="Major Revision")THEN 
    /*if we are saving an update, all fields need to be cloned first*/
    INSERT INTO suspension.work_order 
                          (service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
			   ok_to_replace_bearing,turn_around, referrer) 
                    SELECT service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
	                   ok_to_replace_bearing,turn_around, referrer 
                    FROM suspension.work_order 
	            WHERE row_id=`old_work_order`;
    SET `new_work_order`=LAST_INSERT_ID();
  END IF;

  IF (`clone_type`="New Spec") THEN
    /*if we are saving a New Spec, all fields except the comments and finance info need to be cloned first*/
     SET @new_customer_comments=NULL;
     SET @new_tech_support_comments=NULL;
     INSERT INTO suspension.work_order 
                          (service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
			   ok_to_replace_bearing,turn_around, referrer) 
                    SELECT service_location,shop,rider_instance, bike, 
		           @new_customer_comments,@new_tech_support_comments, call_prior,
	                   ok_to_replace_bearing,turn_around, referrer 
                    FROM suspension.work_order 
	            WHERE row_id=`old_work_order`;
    SET `new_work_order`=LAST_INSERT_ID();
  END IF;
END;

DROP PROCEDURE IF EXISTS suspension.clone_work_order;
CREATE PROCEDURE suspension.clone_work_order(
               IN `old_work_order` int(10),
       	       IN `clone_type` varchar(15),	
       	       IN `revision_type` varchar(15)	
              )
BEGIN
  DECLARE script varchar(500); 
  SET @new_work_order=0;

  IF (`clone_type`="Major Revision")THEN 
    call clone_top_level_of_work_order(`old_work_order`,`clone_type`,@new_work_order);
    call clone_setting(`old_work_order`,@new_work_order,`clone_type`,`revision_type`);
    call clone_other_work_order_records(`old_work_order`,@new_work_order,`clone_type`);
    call clone_finance(`old_work_order`,@new_work_order);/*for a revision, make sure we copy the financial information*/
    call update_lookup_table(@new_work_order);/*causes the lookup_table to be updated with this work_order's new information*/
    SELECT @new_work_order AS "new_work_order"; /*send the new id back to the front end*/
  END IF;

  IF (`clone_type`="New Spec") THEN
    call clone_top_level_of_work_order(`old_work_order`,`clone_type`,@new_work_order);
    call clone_setting(`old_work_order`,@new_work_order,`clone_type`,`revision_type`);
    call clone_other_work_order_records(`old_work_order`,@new_work_order,`clone_type`);
    /*For a new spec, do not copy financial information*/
    call update_lookup_table(@new_work_order);/*causes the lookup_table to be updated with this work_order's new information*/
    SELECT @new_work_order AS "new_work_order"; /*send the new id back to the front end*/
  END IF;

END;


DROP PROCEDURE IF EXISTS suspension.clone_other_work_order_records;
CREATE PROCEDURE suspension.clone_other_work_order_records(
	       IN `old_work_order` int(10),
               IN `new_work_order` int(10),
               IN `clone_type` varchar(15)	
              )
BEGIN
  /*if we are saving an update, all fields need to be clone first*/
  IF (`clone_type`="Major Revision") THEN 
     /*insert a clone of the payment_method_combo*/ 
     INSERT INTO suspension.payment_method_combo 
                           (work_order,payment_method)
               SELECT `new_work_order`,payment_method
               FROM suspension.payment_method_combo
	       WHERE work_order=`old_work_order`;

     /*insert a clone of the shipping*/ 
     INSERT INTO suspension.shipping 
                           (work_order,delivery_instructions, use_rider_shipping_address,
	                    ship_address,ship_method,use_shipping_account,ship_method_account,
			    ship_total,shipping_weight,gun_case)
               SELECT `new_work_order`,delivery_instructions, use_rider_shipping_address,
	                    ship_address,ship_method,use_shipping_account,ship_method_account,
		            ship_total,shipping_weight,gun_case
               FROM suspension.shipping
	       WHERE work_order=`old_work_order`;
  END IF;

  /*insert a clone of the riding_type_combo*/ 
  INSERT INTO suspension.riding_type_combo 
                        (work_order,riding_type)
            SELECT `new_work_order`,riding_type
            FROM suspension.riding_type_combo
	    WHERE work_order=`old_work_order`;

  /*insert a clone of the terrain_combo*/ 
  INSERT INTO suspension.terrain_combo 
                        (work_order,terrain)
            SELECT `new_work_order`,terrain
            FROM suspension.terrain_combo
	    WHERE work_order=`old_work_order`;

   /*insert a clone of the fork_work_combo*/ 
  INSERT INTO suspension.fork_work_combo 
                        (work_order,fork_work,comments)
            SELECT `new_work_order`,fork_work,comments
            FROM suspension.fork_work_combo
	    WHERE work_order=`old_work_order`;

   /*insert a clone of the fork_additional_services_combo*/ 
  INSERT INTO suspension.fork_additional_services_combo 
                        (work_order,fork_additional_services,comments)
            SELECT `new_work_order`,fork_additional_services,comments
            FROM suspension.fork_additional_services_combo
	    WHERE work_order=`old_work_order`;

   /*insert a clone of the fork_additional_products_combo*/ 
  INSERT INTO suspension.fork_additional_products_combo 
                        (work_order,fork_additional_products,comments)
            SELECT `new_work_order`,fork_additional_products,comments
            FROM suspension.fork_additional_products_combo
	    WHERE work_order=`old_work_order`;


   /*insert a clone of the shock_work_combo*/ 
  INSERT INTO suspension.shock_work_combo 
                        (work_order,shock_work,comments)
            SELECT `new_work_order`,shock_work,comments
            FROM suspension.shock_work_combo
	    WHERE work_order=`old_work_order`;

   /*insert a clone of the shock_additional_services_combo*/ 
  INSERT INTO suspension.shock_additional_services_combo 
                        (work_order,shock_additional_services,comments)
            SELECT `new_work_order`,shock_additional_services,comments
            FROM suspension.shock_additional_services_combo
	    WHERE work_order=`old_work_order`;

   /*insert a clone of the shock_additional_products_combo*/ 
  INSERT INTO suspension.shock_additional_products_combo 
                        (work_order,shock_additional_products,comments)
            SELECT `new_work_order`,shock_additional_products,comments
            FROM suspension.shock_additional_products_combo
	    WHERE work_order=`old_work_order`;


   /*insert a clone of the need_springs*/ 
  INSERT INTO suspension.need_springs 
                        (work_order,need_shock_spring,recommended_shock_spring,
	                 need_fork_spring,recommended_fork_spring,ok_to_replace)
            SELECT `new_work_order`,need_shock_spring,recommended_shock_spring,
	                 need_fork_spring,recommended_fork_spring,ok_to_replace
            FROM suspension.need_springs
	    WHERE work_order=`old_work_order`;
END;

DROP PROCEDURE IF EXISTS suspension.get_finance_to_clone_info;
CREATE PROCEDURE suspension.get_finance_to_clone_info(
               IN `old_work_order` int(10), 
	       OUT `out_estimate_fork` int(10),
	       OUT `out_estimate_shock` int(10),
	       OUT `out_credit_card` int(10)
              )
BEGIN
     DECLARE old_estimate_fork int(10); 
     DECLARE old_estimate_shock int(10); 
     DECLARE old_credit_card int(10); 

     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE finance_info_cursor CURSOR FOR
	 SELECT estimate_fork, estimate_shock, credit_card FROM suspension.finance
			WHERE work_order=`old_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     OPEN finance_info_cursor;
       FETCH finance_info_cursor into old_estimate_fork,old_estimate_shock,old_credit_card;
     CLOSE finance_info_cursor; 

     IF old_estimate_fork<=>NULL THEN
         SET  `out_estimate_fork`=0;
        ELSE
         SET  `out_estimate_fork`=old_estimate_fork; 
     END IF;

     IF old_estimate_shock<=>NULL THEN
         SET  `out_estimate_shock`=0;
        ELSE
         SET  `out_estimate_shock`=old_estimate_shock; 
     END IF;

     IF old_credit_card<=>NULL THEN
         SET  `out_credit_card`=0;
        ELSE
         SET  `out_credit_card`=old_credit_card; 
     END IF;
END;


DROP PROCEDURE IF EXISTS suspension.clone_estimate_fork;
CREATE PROCEDURE suspension.clone_estimate_fork(
               IN  `old_estimate_fork` int(10), 
	       OUT `new_estimate_fork` int(10)
              )
BEGIN
  INSERT INTO suspension.estimate_fork
                        (labor,labor_discount,fluid,fluid_discount,springs,springs_discount,parts,parts_discount,
			 coatings, coatings_discount, other, other_discount)
                  SELECT labor,labor_discount,fluid,fluid_discount,springs,springs_discount,parts,parts_discount,
			 coatings, coatings_discount, other, other_discount
                  FROM suspension.estimate_fork
	          WHERE row_id=`old_estimate_fork`;

  SET `new_estimate_fork`=LAST_INSERT_ID();
END;

DROP PROCEDURE IF EXISTS suspension.clone_estimate_shock;
CREATE PROCEDURE suspension.clone_estimate_shock(
               IN  `old_estimate_shock` int(10), 
	       OUT `new_estimate_shock` int(10)
              )
BEGIN
  INSERT INTO suspension.estimate_shock
                        (labor,labor_discount,fluid,fluid_discount,springs,springs_discount,parts,parts_discount,
			 coatings, coatings_discount, other, other_discount)
                  SELECT labor,labor_discount,fluid,fluid_discount,springs,springs_discount,parts,parts_discount,
			 coatings, coatings_discount, other, other_discount
                  FROM suspension.estimate_shock
	          WHERE row_id=`old_estimate_shock`;

  SET `new_estimate_shock`=LAST_INSERT_ID();
END;

DROP PROCEDURE IF EXISTS suspension.clone_credit_card;
CREATE PROCEDURE suspension.clone_credit_card(
               IN  `old_credit_card` int(10), 
	       OUT `new_credit_card` int(10)
              )
BEGIN
  INSERT INTO suspension.credit_card
                        (name, number, security_code, expiration, address)
                  SELECT name, number, security_code, expiration, address
                  FROM suspension.credit_card
	          WHERE row_id=`old_credit_card`;

  SET `new_credit_card`=LAST_INSERT_ID();
END;

DROP PROCEDURE IF EXISTS suspension.clone_finance;
CREATE PROCEDURE suspension.clone_finance(
               IN `old_work_order` int(10), 
               IN `new_work_order` int(10) 
              )
BEGIN
  SET @old_estimate_shock=0;
  SET @new_estimate_shock=0;
  SET @old_estimate_fork=0;
  SET @new_estimate_fork=0;
  SET @old_credit_card=0;
  SET @new_credit_card=0;

  call get_finance_to_clone_info(`old_work_order`,@old_estimate_fork, @old_estimate_shock, @old_credit_card);

  call clone_estimate_fork(@old_estimate_fork,@new_estimate_fork);
  call clone_estimate_shock(@old_estimate_shock,@new_estimate_shock);
  call clone_credit_card(@old_credit_card,@new_credit_card);

   /*insert a clone of the inputed work_order record*/
  INSERT INTO suspension.finance 
                        (work_order, estimate_fork, estimate_shock,time_estimate, quote,
                         sales_order, invoice, include_shipping, total_charges, credit_card)
                  SELECT `new_work_order`, @new_estimate_fork, @new_estimate_shock, time_estimate, quote,
	       		  sales_order, invoice, include_shipping, total_charges, @new_credit_card	
                  FROM suspension.finance
	          WHERE work_order=`old_work_order`;
END;

/*----------------------------------------------------------------------*/


/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
&
delimiter ;
/*------------------------------------------------*/

