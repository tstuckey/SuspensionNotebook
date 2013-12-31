use suspension_new;
-- ----------------------------
-- Procedure structure for `add_address`
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_address`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_address`(
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
  INSERT INTO address
         (address1,address2,address3,city,state_province,country,zip, phone1,phone2) 
  	 VALUES (`in_address1`,`in_address2`,`in_address3`,`in_city`,`in_state_province`,`in_country`,`in_zip`,`in_phone1`,`in_phone2`);
  SELECT LAST_INSERT_ID() AS new_address;
END
;;
DELIMITER ;


-- ----------------------------
-- Procedure structure for `add_fork_additional_product`
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_fork_additional_product`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_fork_additional_product`(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO fork_additional_products
         (`description`) VALUES (`in_description`);
END
;;
DELIMITER ;


-- ----------------------------
-- Procedure structure for `add_fork_additional_service`
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_fork_additional_service`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_fork_additional_service`(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO fork_additional_services
         (`description`) VALUES (`in_description`);
END
;;
DELIMITER ;


-- ----------------------------
-- Procedure structure for `add_fork_standard_work`
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_fork_standard_work`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_fork_standard_work`(
                IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO fork_work
         (`description`) VALUES (`in_description`);
END
;;
DELIMITER ;


-- ----------------------------
-- Procedure structure for `add_rider`
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_rider`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_rider`(
		IN `in_first_name` varchar (100),
		IN `in_last_name` varchar (100),
		IN `in_address_id` int (10)
                 )
BEGIN
  INSERT INTO rider
         (first_name, last_name,address)
         VALUES (`in_first_name`,`in_last_name`,`in_address_id`);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `add_shock_additional_product`
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_shock_additional_product`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_shock_additional_product`(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO shock_additional_products
         (`description`) VALUES (`in_description`);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `add_shock_additional_service`
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_shock_additional_service`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_shock_additional_service`(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO shock_additional_services
         (`description`) VALUES (`in_description`);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `add_shock_standard_work`
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_shock_standard_work`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_shock_standard_work`(
                IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO shock_work
         (`description`) VALUES (`in_description`);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clear_open_work_orders`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clear_open_work_orders`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clear_open_work_orders`(
              )
BEGIN
  DELETE FROM open_work_orders;
END
;;
DELIMITER ;

------------------------------------------------------------------------------------------
--===================================RE-EVAL DONE TO HERE=================================
------------------------------------------------------------------------------------------

-- ----------------------------
-- Procedure structure for `clone_arrival_fork_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_arrival_fork_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_arrival_fork_spec`(
               IN  `old_arrival_fork_spec` int(20), 
	       OUT `new_arrival_fork_spec` int(20)
              )
BEGIN
  SET FOREIGN_KEY_CHECKS=0; 
  INSERT INTO fork_spec 
                        (springs,comp_clicks,reb_clicks,spring_length,chamber_length,oil_vol,oil_height,oil_type)
                  SELECT springs,comp_clicks,reb_clicks,spring_length,chamber_length,oil_vol,oil_height,oil_type
                  FROM fork_spec 
	          WHERE row_id=`old_arrival_fork_spec`;

  SET `new_arrival_fork_spec`=LAST_INSERT_ID();
  SET FOREIGN_KEY_CHECKS=1; 
END
;;
DELIMITER ;


-- ----------------------------
-- Procedure structure for `clone_arrival_shock_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_arrival_shock_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_arrival_shock_spec`(
               IN  `old_arrival_shock_spec` int(20), 
	       OUT `new_arrival_shock_spec` int(20)
              )
BEGIN
  
  INSERT INTO shock_spec 
                        (springs,LS_comp_clicks,HS_comp_turns,reb_clicks,compressed_length,free_length,oil_type,nitrogen,z_cut,sag)
                  SELECT springs,LS_comp_clicks,HS_comp_turns,reb_clicks,compressed_length,free_length,oil_type,nitrogen,z_cut,sag
                  FROM shock_spec 
	          WHERE row_id=`old_arrival_shock_spec`;

  SET `new_arrival_shock_spec`=LAST_INSERT_ID();
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_credit_card`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_credit_card`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_credit_card`(
               IN  `old_credit_card` int(10), 
	       OUT `new_credit_card` int(10)
              )
BEGIN
  INSERT INTO credit_card
                        (name, number, security_code, expiration, address)
                  SELECT name, number, security_code, expiration, address
                  FROM credit_card
	          WHERE row_id=`old_credit_card`;

  SET `new_credit_card`=LAST_INSERT_ID();
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_estimate_fork`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_estimate_fork`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_estimate_fork`(
               IN  `old_estimate_fork` int(10), 
	       OUT `new_estimate_fork` int(10)
              )
BEGIN
  INSERT INTO estimate_fork
                        (labor,labor_discount,fluid,fluid_discount,springs,springs_discount,parts,parts_discount,
			 coatings, coatings_discount, other, other_discount)
                  SELECT labor,labor_discount,fluid,fluid_discount,springs,springs_discount,parts,parts_discount,
			 coatings, coatings_discount, other, other_discount
                  FROM estimate_fork
	          WHERE row_id=`old_estimate_fork`;

  SET `new_estimate_fork`=LAST_INSERT_ID();
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_estimate_shock`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_estimate_shock`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_estimate_shock`(
               IN  `old_estimate_shock` int(10), 
	       OUT `new_estimate_shock` int(10)
              )
BEGIN
  INSERT INTO estimate_shock
                        (labor,labor_discount,fluid,fluid_discount,springs,springs_discount,parts,parts_discount,
			 coatings, coatings_discount, other, other_discount)
                  SELECT labor,labor_discount,fluid,fluid_discount,springs,springs_discount,parts,parts_discount,
			 coatings, coatings_discount, other, other_discount
                  FROM estimate_shock
	          WHERE row_id=`old_estimate_shock`;

  SET `new_estimate_shock`=LAST_INSERT_ID();
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_finance`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_finance`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_finance`(
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

   
  INSERT INTO finance 
                        (work_order, estimate_fork, estimate_shock,time_estimate, quote,
                         sales_order, invoice, include_shipping, total_charges, credit_card)
                  SELECT `new_work_order`, @new_estimate_fork, @new_estimate_shock, time_estimate, quote,
	       		  sales_order, invoice, include_shipping, total_charges, @new_credit_card	
                  FROM finance
	          WHERE work_order=`old_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_fork_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_fork_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_fork_spec`(
               IN  `old_fork_spec` int(20), 
	       IN  `new_fork_revision_number` decimal(5,2),
	       OUT `new_fork_spec` int(20)
              )
BEGIN
  
  INSERT INTO fork_spec 
                        (revision_number,springs,comp_clicks,reb_clicks,spring_length,
			 chamber_length,oil_vol,oil_height,oil_type,general_info,comments)
                  SELECT `new_fork_revision_number`,springs,comp_clicks,reb_clicks,spring_length,
		          chamber_length,oil_vol,oil_height,oil_type,general_info,comments
                  FROM fork_spec 
	          WHERE row_id=`old_fork_spec`;

  SET `new_fork_spec`=LAST_INSERT_ID();

  INSERT INTO fork_bcv_stack 
                        (fork_spec,position,collar_width,rebound_piston_tower,spring_cup,
			 shim_inner_diameter,shim_outer_diameter_is_delta,shim_outer_diameter,shim_thickness,quantity) 
            SELECT `new_fork_spec`,position,collar_width,rebound_piston_tower,spring_cup,
	            shim_inner_diameter,shim_outer_diameter_is_delta,shim_outer_diameter,shim_thickness,quantity 
            FROM fork_bcv_stack 
	    WHERE fork_spec=`old_fork_spec`;

  INSERT INTO fork_compression_stack 
                        (fork_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_fork_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM fork_compression_stack 
	    WHERE fork_spec=`old_fork_spec`;

  INSERT INTO fork_lsv_stack 
                        (fork_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_fork_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM fork_lsv_stack 
	    WHERE fork_spec=`old_fork_spec`;

  INSERT INTO fork_rebound_stack 
                         (fork_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
             SELECT `new_fork_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
             FROM fork_rebound_stack 
	     WHERE fork_spec=`old_fork_spec`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_other_work_order_records`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_other_work_order_records`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_other_work_order_records`(
	       IN `old_work_order` int(10),
               IN `new_work_order` int(10),
               IN `clone_type` varchar(15)	
              )
BEGIN
  
  IF (`clone_type`="Major Revision") THEN 
      
     INSERT INTO payment_method_combo 
                           (work_order,payment_method)
               SELECT `new_work_order`,payment_method
               FROM payment_method_combo
	       WHERE work_order=`old_work_order`;

      
     INSERT INTO shipping 
                           (work_order,delivery_instructions, use_rider_shipping_address,
	                    ship_address,ship_method,use_shipping_account,ship_method_account,
			    ship_total,shipping_weight,gun_case)
               SELECT `new_work_order`,delivery_instructions, use_rider_shipping_address,
	                    ship_address,ship_method,use_shipping_account,ship_method_account,
		            ship_total,shipping_weight,gun_case
               FROM shipping
	       WHERE work_order=`old_work_order`;
  END IF;

   
  INSERT INTO riding_type_combo 
                        (work_order,riding_type)
            SELECT `new_work_order`,riding_type
            FROM riding_type_combo
	    WHERE work_order=`old_work_order`;

   
  INSERT INTO terrain_combo 
                        (work_order,terrain)
            SELECT `new_work_order`,terrain
            FROM terrain_combo
	    WHERE work_order=`old_work_order`;

    
  INSERT INTO fork_work_combo 
                        (work_order,fork_work,comments)
            SELECT `new_work_order`,fork_work,comments
            FROM fork_work_combo
	    WHERE work_order=`old_work_order`;

    
  INSERT INTO fork_additional_services_combo 
                        (work_order,fork_additional_services,comments)
            SELECT `new_work_order`,fork_additional_services,comments
            FROM fork_additional_services_combo
	    WHERE work_order=`old_work_order`;

    
  INSERT INTO fork_additional_products_combo 
                        (work_order,fork_additional_products,comments)
            SELECT `new_work_order`,fork_additional_products,comments
            FROM fork_additional_products_combo
	    WHERE work_order=`old_work_order`;


    
  INSERT INTO shock_work_combo 
                        (work_order,shock_work,comments)
            SELECT `new_work_order`,shock_work,comments
            FROM shock_work_combo
	    WHERE work_order=`old_work_order`;

    
  INSERT INTO shock_additional_services_combo 
                        (work_order,shock_additional_services,comments)
            SELECT `new_work_order`,shock_additional_services,comments
            FROM shock_additional_services_combo
	    WHERE work_order=`old_work_order`;

    
  INSERT INTO shock_additional_products_combo 
                        (work_order,shock_additional_products,comments)
            SELECT `new_work_order`,shock_additional_products,comments
            FROM shock_additional_products_combo
	    WHERE work_order=`old_work_order`;


    
  INSERT INTO need_springs 
                        (work_order,need_shock_spring,recommended_shock_spring,
	                 need_fork_spring,recommended_fork_spring,ok_to_replace)
            SELECT `new_work_order`,need_shock_spring,recommended_shock_spring,
	                 need_fork_spring,recommended_fork_spring,ok_to_replace
            FROM need_springs
	    WHERE work_order=`old_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_setting`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_setting`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_setting`(
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

   
   INSERT INTO setting (date,fork_spec,shock_spec) 
			  VALUES  (curdate(), @new_fork_spec,@new_shock_spec);
   SET @new_setting=LAST_INSERT_ID();
    
  IF (`clone_type`="Major Revision") THEN 
     call clone_settings_on_arrival(@old_setting,@new_setting); 
  END IF;

  
  UPDATE work_order SET setting=@new_setting WHERE row_id=`new_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_settings_on_arrival`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_settings_on_arrival`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_settings_on_arrival`(
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

   
   INSERT INTO settings_on_arrival 
                          (shock_leaking,forks_leaking,shock_spec,fork_spec) 
	   SELECT shock_leaking, forks_leaking,@new_arrival_shock_spec, @new_arrival_fork_spec
           FROM settings_on_arrival
	   WHERE row_id=@old_settings_on_arrival;
   SET @new_settings_on_arrival=LAST_INSERT_ID();

  
  UPDATE setting SET settings_on_arrival=@new_settings_on_arrival WHERE row_id=`new_setting`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_shock_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_shock_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_shock_spec`(
               IN  `old_shock_spec` int(20), 
	       IN  `new_shock_revision_number` decimal(5,2),	
	       OUT `new_shock_spec` int(20)
              )
BEGIN
  
  INSERT INTO shock_spec 
                        (revision_number,springs,LS_comp_clicks,HS_comp_turns,reb_clicks,compressed_length,
			 free_length,oil_type,nitrogen,z_cut,sag,general_info,comments)
                  SELECT `new_shock_revision_number`,springs,LS_comp_clicks,HS_comp_turns,reb_clicks,compressed_length,
		          free_length,oil_type,nitrogen,z_cut,sag,general_info,comments
                  FROM shock_spec 
	          WHERE row_id=`old_shock_spec`;

  SET `new_shock_spec`=LAST_INSERT_ID();

  INSERT INTO shock_compression_stack 
                        (shock_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)   
            SELECT `new_shock_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM shock_compression_stack 
	    WHERE shock_spec=`old_shock_spec`;

  INSERT INTO shock_compression_adjuster_stack 
                        (shock_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_shock_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM shock_compression_adjuster_stack 
	    WHERE shock_spec=`old_shock_spec`;

  INSERT INTO shock_rebound_stack 
                        (shock_spec, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_shock_spec`, position, shim_inner_diameter, shim_outer_diameter_is_delta,shim_outer_diameter, shim_thickness, quantity  
            FROM shock_rebound_stack
	    WHERE shock_spec=`old_shock_spec`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_top_level_of_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_top_level_of_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_top_level_of_work_order`(
               IN `old_work_order` int(10),
               IN `clone_type` varchar(25),
               OUT `new_work_order` int(10)
              )
BEGIN
  SET `new_work_order`=NULL;
  IF (`clone_type`="Major Revision")THEN 
    
    INSERT INTO work_order 
                          (service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
			   ok_to_replace_bearing,turn_around, referrer) 
                    SELECT service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
	                   ok_to_replace_bearing,turn_around, referrer 
                    FROM work_order 
	            WHERE row_id=`old_work_order`;
    SET `new_work_order`=LAST_INSERT_ID();
  END IF;

  IF (`clone_type`="New Spec") THEN
    
     SET @new_customer_comments=NULL;
     SET @new_tech_support_comments=NULL;
     INSERT INTO work_order 
                          (service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
			   ok_to_replace_bearing,turn_around, referrer) 
                    SELECT service_location,shop,rider_instance, bike, 
		           @new_customer_comments,@new_tech_support_comments, call_prior,
	                   ok_to_replace_bearing,turn_around, referrer 
                    FROM work_order 
	            WHERE row_id=`old_work_order`;
    SET `new_work_order`=LAST_INSERT_ID();
  END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `clone_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `clone_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_work_order`(
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
    call clone_finance(`old_work_order`,@new_work_order);
    call update_lookup_table(@new_work_order);
    SELECT @new_work_order AS "new_work_order"; 
  END IF;

  IF (`clone_type`="New Spec") THEN
    call clone_top_level_of_work_order(`old_work_order`,`clone_type`,@new_work_order);
    call clone_setting(`old_work_order`,@new_work_order,`clone_type`,`revision_type`);
    call clone_other_work_order_records(`old_work_order`,@new_work_order,`clone_type`);
    
    call update_lookup_table(@new_work_order);
    SELECT @new_work_order AS "new_work_order"; 
  END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_bike`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_bike`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_bike`(
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
   	FROM work_order as WORK_ORDER 
        	LEFT JOIN bike as BIKE 
			ON WORK_ORDER.bike=BIKE.row_id
        	LEFT JOIN bike_year as YEAR
			ON BIKE.bike_year=YEAR.row_id
        	LEFT JOIN bike_brand_model as MODEL 
			ON BIKE.bike_brand_model=MODEL.row_id
   	WHERE WORK_ORDER.row_id=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN bike_cursor;
      FETCH bike_cursor into existing_year, existing_brand, existing_model;
    CLOSE bike_cursor; 

    
    
    
         SET `out_year`=existing_year;
         SET `out_brand`=existing_brand;
         SET `out_model`=existing_model;
    
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_fork_coatings_discount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_fork_coatings_discount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_fork_coatings_discount`(
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
        FROM finance as FINANCE 
           LEFT JOIN estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN discount_rate as DISCOUNT
		ON BASE.coatings_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    
    
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_fork_fluid_discount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_fork_fluid_discount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_fork_fluid_discount`(
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
        FROM finance as FINANCE 
           LEFT JOIN estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN discount_rate as DISCOUNT
		ON BASE.fluid_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    
    
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_fork_labor_discount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_fork_labor_discount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_fork_labor_discount`(
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
        FROM finance as FINANCE 
           LEFT JOIN estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=ESTIMATE_FORK.row_id
	   LEFT JOIN discount_rate as DISCOUNT
		ON BASE.labor_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    
    
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_fork_other_discount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_fork_other_discount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_fork_other_discount`(
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
        FROM finance as FINANCE 
           LEFT JOIN estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN discount_rate as DISCOUNT
		ON BASE.other_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    
    
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_fork_parts_discount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_fork_parts_discount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_fork_parts_discount`(
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
        FROM finance as FINANCE 
           LEFT JOIN estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN discount_rate as DISCOUNT
		ON BASE.parts_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    
    
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_fork_spring_discount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_fork_spring_discount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_fork_spring_discount`(
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
        FROM finance as FINANCE 
           LEFT JOIN estimate_fork as BASE 
	  	 ON FINANCE.estimate_fork=BASE.row_id
	   LEFT JOIN discount_rate as DISCOUNT
		ON BASE.spring_discount=DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 

    
    
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_labor_discount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_labor_discount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_labor_discount`(
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
	   ESTIMATE_FORK.labor, 
	   LABOR_DISCOUNT.amount 
        FROM finance as FINANCE 
           LEFT JOIN estimate_fork as ESTIMATE_FORK 
	  	 ON FINANCE.estimate_fork=ESTIMATE_FORK.row_id
	   LEFT JOIN discount_rate as LABOR_DISCOUNT
		ON ESTIMATE_FORK.labor_discount=LABOR_DISCOUNT.row_id	       	
       WHERE FINANCE.work_order=`in_work_order`;
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
    OPEN the_cursor;
      FETCH the_cursor into amount, discount;
    CLOSE the_cursor; 
    
    
    IF !(amount <=>null) THEN
         SET `out_amount`=amount;
         SET `out_discount`=discount;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_rider`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_rider`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_rider`(
               IN `in_work_order` int(10),
	       OUT `out_rider_instance` int(10)
              )
BEGIN
   DECLARE existing_rider_instance int(10) DEFAULT 0; 

   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE the_cursor CURSOR FOR
   	SELECT 
	   rider_instance FROM work_order as WORK_ORDER 
        WHERE WORK_ORDER.row_id=`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN the_cursor;
      FETCH the_cursor into existing_rider_instance;
    CLOSE the_cursor; 

    
    
    IF existing_rider_instance != 0 THEN
         SET `out_rider_instance`=existing_rider_instance;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_rider_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_rider_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_rider_info`(
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
        FROM RIDER_INSTANCE as RIDER_INST 
           LEFT JOIN rider as RIDER
	  	 ON RIDER_INST.rider=RIDER.row_id
           LEFT JOIN rider_ability as ABILITY
	   	ON RIDER_INST.rider_ability=ABILITY.row_id
	   LEFT JOIN rider_weight as WEIGHT
	   	ON RIDER_INST.rider_weight=WEIGHT.row_id
	   LEFT JOIN rider_height as HEIGHT
	   	ON RIDER_INST.rider_height=HEIGHT.row_id
       WHERE RIDER_INST.row_id=`in_rider_instance`;
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
    OPEN the_cursor;
      FETCH the_cursor into existing_ability,existing_weight_lbs,existing_weight_kgs,existing_height_in,existing_height_cm;
    CLOSE the_cursor; 
    
    
    IF !(existing_ability <=>null) THEN
         SET `out_ability`=existing_ability;
         SET `out_weight_lbs`=existing_weight_lbs;
         SET `out_weight_kgs`=existing_weight_kgs;
         SET `out_height_in`=existing_height_in;
         SET `out_height_cm`=existing_height_cm;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_rider_info1`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_rider_info1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_rider_info1`(
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
        FROM rider_instance as RIDER_INST 
           LEFT JOIN rider as RIDER
	  	 ON RIDER_INST.rider=RIDER.row_id
           LEFT JOIN rider_ability as ABILITY
	   	ON RIDER_INST.rider_ability=ABILITY.row_id
	   LEFT JOIN rider_weight as WEIGHT
	   	ON RIDER_INST.rider_weight=WEIGHT.row_id
	   LEFT JOIN rider_height as HEIGHT
	   	ON RIDER_INST.rider_height=HEIGHT.row_id
       WHERE RIDER_INST.row_id=`in_rider_instance`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN the_cursor;
      FETCH the_cursor into existing_ability,existing_weight_lbs,existing_weight_kgs,
                            existing_height_in,existing_height_cm;
    CLOSE the_cursor; 

    
    
    IF !(existing_ability <=>null) THEN
         SET `out_ability`=existing_ability;
         SET `out_weight_lbs`=existing_weight_lbs;
         SET `out_weight_kgs`=existing_weight_kgs;
         SET `out_height_in`=existing_height_in;
         SET `out_height_cm`=existing_height_cm;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `collect_rider_info2`
-- ----------------------------
DROP PROCEDURE IF EXISTS `collect_rider_info2`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `collect_rider_info2`(
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
        FROM rider_instance as RIDER_INST 
           LEFT JOIN rider as RIDER
	  	 ON RIDER_INST.rider=RIDER.row_id
       WHERE RIDER_INST.row_id=`in_rider_instance`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN the_cursor;
      FETCH the_cursor into existing_first_name,existing_last_name,existing_support_id,
                            existing_phone1,existing_phone2;
    CLOSE the_cursor; 

    
    
    IF !(existing_first_name <=>null) THEN
         SET `out_first_name`=existing_first_name;
         SET `out_last_name`=existing_last_name;
         SET `out_support_id`=existing_support_id;
         SET `out_phone1`=existing_phone1;
         SET `out_phone2`=existing_phone2;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `create_new_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `create_new_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_work_order`(
              )
BEGIN
  INSERT INTO work_order () VALUES(); 
  SELECT LAST_INSERT_ID() AS "New ID";
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `delete_finance`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_finance`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_finance`(
               IN `in_work_order` int(10)
              )
BEGIN
   SET @estimate_fork=0;
   SET @estimate_shock=0;
   SET @credit_card=0;
   call get_finance_to_delete_info(`in_work_order`,@estimate_fork,@estimate_shock, @credit_card);
   DELETE FROM estimate_fork
 	  WHERE row_id=@estimate_fork;
   DELETE FROM estimate_shock
 	  WHERE row_id=@estimate_shock;
   DELETE FROM credit_card
 	  WHERE row_id=@credit_card;
   DELETE FROM finance
 	  WHERE work_order=`in_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `delete_fork_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_fork_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_fork_spec`(
               IN  `in_fork_spec` int(20) 
              )
BEGIN
     DELETE FROM fork_spec 
	    WHERE row_id=`in_fork_spec`;
     DELETE FROM fork_bcv_stack 
	    WHERE fork_spec=`in_fork_spec`;
     DELETE FROM fork_compression_stack 
	    WHERE fork_spec=`in_fork_spec`;
     DELETE FROM fork_lsv_stack 
	    WHERE fork_spec=`in_fork_spec`;
     DELETE FROM fork_lsv_stack 
	    WHERE fork_spec=`in_fork_spec`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `delete_open_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_open_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_open_work_order`(
               IN `in_work_order` int(10)
              )
BEGIN
     DELETE FROM open_work_orders WHERE work_order=`in_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `delete_other_work_order_records`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_other_work_order_records`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_other_work_order_records`(
               IN `in_work_order` int(10) 
              )
BEGIN
     DELETE FROM riding_type_combo 
	    WHERE work_order=`in_work_order`;
     DELETE FROM terrain_combo 
 	    WHERE work_order=`in_work_order`;
     DELETE FROM fork_work_combo
 	    WHERE work_order=`in_work_order`;
     DELETE  FROM fork_additional_services_combo
	    WHERE work_order=`in_work_order`;
     DELETE FROM shock_work_combo
	    WHERE work_order=`in_work_order`;
     DELETE FROM shock_additional_services_combo
	    WHERE work_order=`in_work_order`;
     DELETE FROM payment_method_combo
	    WHERE work_order=`in_work_order`;
     DELETE FROM shipping
            WHERE work_order=`in_work_order`;
     DELETE FROM need_springs
	    WHERE work_order=`in_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `delete_setting`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_setting`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_setting`(
               IN `in_work_order` int(10)
              )
BEGIN
   SET @setting=0;
   SET @settings_on_arrival=0;
   SET @shock_spec=0;
   SET @fork_spec=0;
   call get_setting_to_delete(`in_work_order`,@setting);
   call get_setting_to_delete_info(@setting,@settings_on_arrival,@fork_spec, @shock_spec);
   call delete_settings_on_arrival(@settings_on_arrival);
   call delete_fork_spec(@fork_spec);
   call delete_shock_spec(@shock_spec);
   DELETE FROM setting
 	  WHERE row_id=@setting;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `delete_settings_on_arrival`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_settings_on_arrival`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_settings_on_arrival`(
               IN  `in_settings_on_arrival` int(20) 
              )
BEGIN
     SET @arrival_shock_spec=0;
     SET @arrival_fork_spec=0;
     call get_settings_on_arrival_to_delete_info(`in_settings_on_arrival`,@arrival_fork_spec,@arrival_shock_spec);
     
     
     DELETE FROM fork_spec 
	    WHERE row_id=@arrival_fork_spec;
     DELETE FROM shock_spec 
	    WHERE row_id=@arrival_shock_spec;
     DELETE FROM settings_on_arrival
	    WHERE row_id=`in_settings_on_arrival`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `delete_shock_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_shock_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_shock_spec`(
               IN  `in_shock_spec` int(20) 
              )
BEGIN
     DELETE FROM shock_spec 
	    WHERE row_id=`in_shock_spec`;
     DELETE FROM shock_compression_stack 
	    WHERE shock_spec=`in_shock_spec`;
     DELETE FROM shock_rebound_stack 
	    WHERE shock_spec=`in_shock_spec`;
     DELETE FROM shock_compression_adjuster_stack 
	    WHERE shock_spec=`in_shock_spec`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `delete_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_work_order`(
               IN `in_work_order` int(10) 
              )
BEGIN
  call delete_setting(`in_work_order`);
  call delete_other_work_order_records(`in_work_order`);
  call delete_finance(`in_work_order`);
  	
  DELETE FROM work_order
	 WHERE row_id=`in_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `determine_revision_number`
-- ----------------------------
DROP PROCEDURE IF EXISTS `determine_revision_number`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `determine_revision_number`(
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
	   FROM setting AS SETTING,
	        shock_spec AS SHOCK_SPEC
          WHERE SETTING.row_id=`old_setting` AND
	        SETTING.shock_spec=SHOCK_SPEC.row_id;
	       
     DECLARE fork_revision_cursor CURSOR FOR
	 SELECT FORK_SPEC.revision_number 
	   FROM setting AS SETTING,
	        fork_spec AS FORK_SPEC
          WHERE SETTING.row_id=`old_setting` AND
	        SETTING.fork_spec=FORK_SPEC.row_id;


     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     OPEN shock_revision_cursor;
       FETCH shock_revision_cursor into old_shock_revision_number;
     CLOSE shock_revision_cursor; 

     OPEN fork_revision_cursor;
       FETCH fork_revision_cursor into old_fork_revision_number;
     CLOSE fork_revision_cursor; 


     
     IF ((old_shock_revision_number<=>NULL)OR(`clone_type`="New Spec")) THEN
         SET  `out_shock_revision_number`=0;
     END IF;

     
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `export_get_top_level_of_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `export_get_top_level_of_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `export_get_top_level_of_work_order`(
               IN  `exp_work_order` int(10),
               OUT `exp_service_location` int(10),
               OUT `exp_shop` int(10),
               OUT `exp_rider_instance` int(10),
               OUT `exp_bike` int(10),
               OUT `exp_customer_comments` varchar(5000),
               OUT `exp_tech_support_comments` varchar(5000),
               OUT `exp_call_prior` int(1),
               OUT `exp_ok_to_replace_bearing` int(1),
               OUT `exp_turnaround` int(10),
               OUT `exp_referrer` int(10)
              )
BEGIN
     DECLARE no_rows_found INT DEFAULT 0;
     DECLARE info_cursor CURSOR FOR
             SELECT service_location,shop,rider_instance, bike, 
		    customer_comments,tech_support_comments, call_prior,
	            ok_to_replace_bearing,turn_around, referrer 
                    FROM work_order 
	            WHERE row_id=`exp_work_order`;
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     OPEN info_cursor;
       FETCH info_cursor INTO 
               `exp_service_location`,
               `exp_shop`,
               `exp_rider_instance`,
               `exp_bike`,
               `exp_customer_comments`,
               `exp_tech_support_comments`,
               `exp_call_prior`,
               `exp_ok_to_replace_bearing`,
               `exp_turnaround`,
               `exp_referrer`;
     CLOSE info_cursor;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `export_top_level_of_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `export_top_level_of_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `export_top_level_of_work_order`(
               IN  `exp_work_order` int(10),
               OUT `exp_service_location` int(10),
               OUT `exp_shop` int(10),
               OUT `exp_rider_instance` int(10),
               OUT `exp_bike` int(10),
               OUT `exp_customer_comments` varchar(5000),
               OUT `exp_tech_support_comments` varchar(5000),
               OUT `exp_call_prior` int(1),
               OUT `exp_ok_to_replace_bearing` int(1),
               OUT `exp_turnaround` int(10),
               OUT `exp_referrer` int(10)
              )
BEGIN
     DECLARE no_rows_found INT DEFAULT 0;
     DECLARE info_cursor CURSOR FOR
             SELECT service_location,shop,rider_instance, bike, 
		    customer_comments,tech_support_comments, call_prior,
	            ok_to_replace_bearing,turn_around, referrer 
                    FROM work_order 
	            WHERE row_id=`exp_work_order`;
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     OPEN info_cursor;
       FETCH info_cursor INTO 
               `exp_service_location`,
               `exp_shop`,
               `exp_rider_instance`,
               `exp_bike`,
               `exp_customer_comments`,
               `exp_tech_support_comments`,
               `exp_call_prior`,
               `exp_ok_to_replace_bearing`,
               `exp_turnaround`,
               `exp_referrer`;
     CLOSE info_cursor;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `export_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `export_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `export_work_order`(
		IN `exp_work_order` int(10)
              )
BEGIN
  DECLARE export_script varchar(2000) DEFAULT NULL;

  SET @exp_service_location=0;
  SET @exp_shop=0;
  SET @exp_rider_instance=0;
  SET @exp_bike=0;
  SET @exp_customer_comments=0;
  SET @exp_tech_support_comments=0;
  SET @exp_call_prior=0;
  SET @exp_ok_to_replace_bearing=0;
  SET @exp_turnaround=0;
  SET @exp_referrer=0;


  

  call export_get_top_level_of_work_order(
	exp_work_order,
	@exp_service_location,
  	@exp_shop,
  	@exp_rider_instance,
  	@exp_bike,
  	@exp_customer_comments,
  	@exp_tech_support_comments,
  	@exp_call_prior,
  	@exp_ok_to_replace_bearing,
  	@exp_turnaround,
  	@exp_referrer);

 
 SET export_script='
  	SET @imp_work_order=0;
  	SET @imp_setting=0;
  	SET @imp_shock_spec=0;
  	SET @imp_fork_spec=0;\n\n';


  SET export_script= CONCAT(export_script,
	'call import_create_new_work_order(
		@imp_work_order,
		@imp_setting,
		@imp_shock_spec, 
		@imp_fork_spec);\n\n');


  SET export_script= CONCAT(export_script,
   	'call import_top_level_of_work_order(\n',
        	'\t\t  @imp_work_order,  \n',
        	'\t\t  ',COALESCE(@exp_service_location,'NULL'),',  \n',
        	'\t\t  ',COALESCE(@exp_shop,'NULL'),',  \n',
        	'\t\t  ',COALESCE(@exp_rider_instance,'NULL'),',  \n',
        	'\t\t  ',COALESCE(@exp_bike,'NULL'),',   \n',
        	'\t\t  ',COALESCE(@exp_customer_comments,'NULL'),',  \n',
        	'\t\t  ',COALESCE(@exp_tech_support_comments,'NULL'),',  \n',
        	'\t\t  ',COALESCE(@exp_call_prior,'NULL'),',  \n',
        	'\t\t  ',COALESCE(@exp_ok_to_replace_bearing,'NULL'),',  \n',
        	'\t\t  ',COALESCE(@exp_turnaround,'NULL'),',  \n',
        	'\t\t  ',COALESCE(@exp_referrer,'NULL'),');\n\n');

  SELECT export_script;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `find_bike`
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_bike`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_bike`(
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
                             work_order as WORK_ORDER,
                             bike as BIKE, 
                             bike_year as YEAR,
			     bike_brand_model as MODEL 
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `find_revision`
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_revision`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_revision`(
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
                          FROM work_order as WORK_ORDER, 
			       setting as SETTING,
			       fork_spec as FORK_SPEC,
			       shock_spec as SHOCK_SPEC
                          WHERE WORK_ORDER.row_id=`in_work_order_id` AND
			        WORK_ORDER.setting=SETTING.row_id AND
				SETTING.fork_spec=FORK_SPEC.row_id AND
				SETTING.shock_spec=SHOCK_SPEC.row_id; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 

    OPEN revision_cursor;
    FETCH revision_cursor into this_shock_revision,this_fork_revision;
    SET `out_shock_revision`=this_shock_revision;
    SET `out_fork_revision`=this_fork_revision;
    CLOSE revision_cursor; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `find_rider`
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_rider`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_rider`(
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
                  work_order as WORK_ORDER
                  LEFT JOIN rider_instance as RIDER_INST
			ON WORK_ORDER.rider_instance=RIDER_INST.row_id
		  LEFT JOIN rider as RIDER
		        ON RIDER_INST.rider=RIDER.row_id
                  LEFT JOIN  rider_ability as ABILITY
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `find_riding_type`
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_riding_type`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_riding_type`(
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
                                 riding_type_combo as RIDING_COMBO,
                                 riding_type as RIDING_TYPE 
                          WHERE 
                                 RIDING_COMBO.work_order=`in_work_order` AND
                                 RIDING_COMBO.riding_type=RIDING_TYPE.row_id;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 

   OPEN riding_type_cursor;
   SET `out_riding_description`="";
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `find_service_location`
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_service_location`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_service_location`(
		IN `in_work_order` int (10),
		OUT `out_service_location` varchar(100)
                 )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE service_location varchar(100) DEFAULT NULL; 

   DECLARE service_cursor CURSOR FOR 
                        SELECT SRV_LOC.location
                        FROM 
                             work_order as WORK_ORDER,
                             service_location as SRV_LOC 
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `find_setting_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_setting_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_setting_info`(
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
                             work_order as WORK_ORDER,
                             setting as SETTING 
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `find_terrain`
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_terrain`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_terrain`(
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
                                 terrain_combo as TC,
                                 terrain as TERRAIN
                          WHERE 
                                 TC.work_order=`in_work_order` AND
                                 TC.terrain=TERRAIN.row_id;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 

   OPEN terrain_cursor;
   SET `out_terrain_description`="";
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `find_work_orders`
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_work_orders`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_work_orders`(
               IN `in_page` int(3),
               IN `in_rider_id` int(10),
               IN `in_year_id` int(10),
               IN `in_model_id` int(10),
               IN `in_ability_id` int(10)
       )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE this_work_order int(10); 

   DECLARE work_order_cursor CURSOR FOR SELECT row_id FROM work_order; 
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 

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
       FROM lookup_table "; 
      SET @where_syntax=" WHERE work_order>0 ";

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

     
     SET @order_by_syntax=CONCAT(" ORDER BY work_order  "); 
     call prepare_limit_statement(`in_page`,@limit_syntax);

     SET @syntax=CONCAT(@start_syntax, @where_syntax,@order_by_syntax,@limit_syntax,";");
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `find_work_orders_count`
-- ----------------------------
DROP PROCEDURE IF EXISTS `find_work_orders_count`;
DELIMITER ;;
CREATE DEFINER=`tom`@`` PROCEDURE `find_work_orders_count`(
               IN `in_rider_id` int(10),
               IN `in_year_id` int(10),
               IN `in_model_id` int(10),
               IN `in_ability_id` int(10)
       )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE this_work_order int(10); 
   DECLARE work_order_cursor CURSOR FOR SELECT row_id FROM work_order; 
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 
   SET @start_syntax="
       SELECT 
       	      count(row_id) AS 'total' 
       FROM lookup_table "; 
      SET @where_syntax=" WHERE work_order>0 ";
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_all_values`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_all_values`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_values`(
               IN `in_table_name` varchar(50),
               IN `in_field_names` varchar(100),
               IN `in_order_by_field` varchar(100)
       )
BEGIN
	IF `in_table_name` like "bike_year" THEN
		
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_all_values2`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_all_values2`;
DELIMITER ;;
CREATE DEFINER=`tom`@`` PROCEDURE `get_all_values2`(
               IN `in_table_name` varchar(50),
               IN `in_field_names` varchar(100),
               IN `in_order_by_field` varchar(100)
       )
BEGIN
	IF `in_order_by_field` IS NULL THEN
	        SET @syntax=CONCAT(" SELECT row_id, ", 
                          `in_field_names`, " FROM ",
                          `in_table_name`, ";");
	ELSE
	        SET @syntax=CONCAT(" SELECT row_id, ", 
                          `in_field_names`, " FROM ",
                          `in_table_name`, " ORDER BY ",
                          `in_order_by_field`,";");
	END IF;

     SELECT @syntax;
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_arrival_fork_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_arrival_fork_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_arrival_fork_spec`(
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
          fork_spec as FORK
    WHERE 
	  FORK.row_id =`in_fork_spec`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_arrival_shock_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_arrival_shock_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_arrival_shock_spec`(
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
        shock_spec as SHOCK
  WHERE 
	SHOCK.row_id =`in_shock_spec`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_arrival_specs_for_setting`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_arrival_specs_for_setting`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_arrival_specs_for_setting`(
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
          setting as SETTING 
		LEFT JOIN settings_on_arrival as ARRIVAL_SPEC 
			ON SETTING.settings_on_arrival=ARRIVAL_SPEC.row_id  
                LEFT JOIN shock_spec as SHOCK_SPEC
			ON ARRIVAL_SPEC.shock_spec=SHOCK_SPEC.row_id
                LEFT JOIN fork_spec as FORK_SPEC
			ON ARRIVAL_SPEC.fork_spec=FORK_SPEC.row_id
    WHERE 
	  SETTING.row_id =`in_setting_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_bike_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_bike_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_bike_info`(
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
   FROM work_order as WORK_ORDER 

           LEFT JOIN bike as BIKE 
		   ON WORK_ORDER.bike=BIKE.row_id
           LEFT JOIN suspension_brand as SHOCK_BRAND 
		   ON BIKE.shock_brand=SHOCK_BRAND.row_id 
           LEFT JOIN suspension_brand as FORK_BRAND 
		   ON BIKE.fork_brand=FORK_BRAND.row_id 
       WHERE 
             WORK_ORDER.row_id=`in_work_order_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_change_date`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_change_date`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_change_date`(
		IN `in_setting` int (10)
                 )
BEGIN
  SELECT 
	 SETTING.date as "Date"
  FROM 
       setting as SETTING
  WHERE 
        SETTING.row_id=`in_setting`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_comments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_comments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_comments`(
		IN `in_spec_id` int (10)
                 )
BEGIN
  SELECT
  	  COMMENTS.row_id as spec_id,
          COMMENTS.comments as comments
	
    FROM 
          comments as COMMENTS 
    WHERE 
	  COMMENTS.row_id =`in_spec_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_credit_card_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_credit_card_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_credit_card_info`(
		IN `in_work_order_id` int (10)
                 )
BEGIN
  call get_key(@the_key); 
  
  SELECT 
            AES_DECRYPT(CC.name,@the_key) as "name_on_card",
	    AES_DECRYPT(CC.number,@the_key) as "number_on_card",
	    AES_DECRYPT(CC.security_code,@the_key) as "security_code",
	    AES_DECRYPT(CC.expiration,@the_key) as "expiration"
    FROM finance as FINANCE 
            LEFT JOIN credit_card as CC 
		    ON FINANCE.credit_card=CC.row_id
        WHERE 
              FINANCE.work_order=`in_work_order_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_finance_header_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_finance_header_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_finance_header_info`(
		 IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        quote as "quote number",
	sales_order as "sales order",
	invoice as "invoice number"
   FROM finance
   WHERE 
	work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_finance_to_clone_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_finance_to_clone_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_finance_to_clone_info`(
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
	 SELECT estimate_fork, estimate_shock, credit_card FROM finance
			WHERE work_order=`old_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_finance_to_delete_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_finance_to_delete_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_finance_to_delete_info`(
               IN `in_work_order` int(10), 
	       OUT `out_estimate_fork` int(10),
	       OUT `out_estimate_shock` int(10),
	       OUT `out_credit_card` int(10)
              )
BEGIN
     DECLARE estimate_fork_id int(10); 
     DECLARE estimate_shock_id int(10); 
     DECLARE credit_card_id int(10); 
     DECLARE no_rows_found INT DEFAULT 0;
     DECLARE finance_info_cursor CURSOR FOR
	 SELECT estimate_fork,estimate_shock,credit_card FROM finance
			WHERE work_order=`in_work_order`; 
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     OPEN finance_info_cursor;
       FETCH finance_info_cursor into estimate_fork_id,estimate_shock_id,credit_card_id;
     CLOSE finance_info_cursor; 
     IF estimate_fork_id<=>NULL THEN
         SET  `out_estimate_fork`=0;
        ELSE
         SET  `out_estimate_fork`=estimate_fork_id; 
     END IF;
     IF estimate_shock_id<=>NULL THEN
         SET  `out_estimate_shock`=0;
        ELSE
         SET  `out_estimate_shock`=estimate_shock_id; 
     END IF;
     IF credit_card_id<=>NULL THEN
         SET  `out_credit_card`=0;
        ELSE
         SET  `out_credit_card`=credit_card_id; 
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_additional_services_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_additional_services_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_additional_services_from_work_order`(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ADD_SRV.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM fork_additional_services_combo as ADD_SRV_COMBO
           LEFT JOIN fork_additional_services as ADD_SRV 
		   ON ADD_SRV_COMBO.fork_additional_services=ADD_SRV.row_id 
           LEFT JOIN comments as COMMENTS 
		   ON ADD_SRV_COMBO.comments=COMMENTS.row_id
       WHERE 
	    ADD_SRV_COMBO.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_bcv_shims`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_bcv_shims`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_bcv_shims`(
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
       fork_bcv_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec`
  ORDER BY pos; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_comp_shims`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_comp_shims`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_comp_shims`(
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
       fork_compression_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec` 
  ORDER BY pos; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_estimate_id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_estimate_id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_estimate_id`(
               IN `in_finance` varchar(5000),
               OUT `out_fork_estimate_id` int(10) 
              )
BEGIN
     DECLARE fork_estimate_id int(10); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE fork_estimate_cursor CURSOR FOR
	 SELECT estimate_fork FROM finance
			      WHERE row_id=`in_finance`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     
     OPEN fork_estimate_cursor;
       FETCH fork_estimate_cursor into fork_estimate_id;
     CLOSE fork_estimate_cursor; 

     IF no_rows_found=0 THEN
         SET `out_fork_estimate_id`=fork_estimate_id;
        ELSEIF no_rows_found=1 THEN
         SET `out_fork_estimate_id`=0;
      END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_estimate_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_estimate_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_estimate_info`(
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
   FROM finance as FINANCE 
	LEFT JOIN estimate_fork as ESTIMATE_FORK
		ON FINANCE.estimate_fork=ESTIMATE_FORK.row_id
   WHERE 
	FINANCE.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_general_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_general_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_general_info`(
		IN `in_spec_id` int (20)
                 )
BEGIN
  SELECT
        INFO.general_info as "General Info"
  FROM 
        fork_spec as SPEC 
	LEFT JOIN fork_spec_general_info AS INFO
		ON SPEC.general_info=INFO.row_id		
   WHERE 
	 SPEC.row_id =`in_spec_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_lsv_shims`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_lsv_shims`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_lsv_shims`(
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
       fork_lsv_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec` 
  ORDER BY pos; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_need_springs_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_need_springs_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_need_springs_info`(
		IN `in_work_order` int (10)
                )
BEGIN
     SELECT 
	    NEED_SPRINGS.need_fork_spring,
	    NEED_SPRINGS.recommended_fork_spring AS 'rate'
       FROM need_springs as NEED_SPRINGS 
       WHERE 
	    NEED_SPRINGS.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_reb_shims`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_reb_shims`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_reb_shims`(
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
       fork_rebound_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec`
  ORDER BY pos; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_spec`(
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
          fork_spec as FORK
    WHERE 
	  FORK.row_id =`in_fork_spec`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_springs`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_springs`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_springs`()
BEGIN
  SELECT 
        SPRINGS.row_id,
        SPRINGS.rate

  FROM 
       springs as SPRINGS,
       spring_type as SPRING_TYPE
  WHERE 
        SPRINGS.spring_type=SPRING_TYPE.row_id AND
        SPRING_TYPE.description like "Fork";
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_fork_standard_work_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_fork_standard_work_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fork_standard_work_from_work_order`(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        WORK.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM fork_work_combo as WORK_COMBO
           LEFT JOIN fork_work as WORK 
		   ON WORK_COMBO.fork_work=WORK.row_id 
           LEFT JOIN comments as COMMENTS 
		   ON WORK_COMBO.comments=COMMENTS.row_id
       WHERE 
	    WORK_COMBO.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_general_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_general_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_general_info`(
               IN `in_work_order_id` int(10)
       )
BEGIN
   
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
   FROM work_order as WORK_ORDER 
        LEFT JOIN rider_instance as RIDER_INST
		ON WORK_ORDER.rider_instance=RIDER_INST.row_id
        LEFT JOIN rider as RIDER
		ON RIDER_INST.rider=RIDER.row_id
        LEFT JOIN rider_ability as ABILITY
		ON RIDER_INST.rider_ability=ABILITY.row_id
 WHERE WORK_ORDER.row_id=`in_work_order_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_key`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_key`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_key`(
               OUT `return_key`  varchar(100)
       )
BEGIN
   DECLARE the_key varchar(100); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE key_cursor CURSOR FOR
                         SELECT some_stuff FROM basic_info
                                            WHERE row_id = 1;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

   OPEN key_cursor;
      FETCH key_cursor into the_key;
   CLOSE key_cursor; 

   
   IF (the_key<=>NULL) THEN
      SET return_key=0;
      ELSE SET return_key=the_key;       
   END IF;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_number_of_work_orders`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_number_of_work_orders`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_number_of_work_orders`(
               IN `in_rider_id` int(10),
               IN `in_year_id` int(10),
               IN `in_model_id` int(10),
               IN `in_ability_id` int(10)
       )
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE this_work_order int(10); 

   DECLARE work_order_cursor CURSOR FOR SELECT row_id FROM work_order; 
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1; 
   SET @records_per_page=50;

   SET @start_syntax="
       SELECT 
       	      count(row_id) AS 'total', @records_per_page AS 'records per page' 
       FROM lookup_table "; 
      SET @where_syntax=" WHERE work_order>0 ";

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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_overall_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_overall_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_overall_info`(
		IN `in_work_order` int (10)
                )
BEGIN
     SELECT 
	    NEED_SPRINGS.ok_to_replace,
	    WORK_ORDER.call_prior,
	    WORK_ORDER.ok_to_replace_bearing,
	    TURN_AROUND.num_days as `Turn Around`
       FROM work_order as WORK_ORDER 
            LEFT JOIN need_springs as NEED_SPRINGS
	    	 ON WORK_ORDER.row_id=NEED_SPRINGS.work_order
            LEFT JOIN days as TURN_AROUND
	    	 ON WORK_ORDER.turn_around=TURN_AROUND.row_id
       WHERE 
	    WORK_ORDER.row_id=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_payment_method_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_payment_method_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payment_method_from_work_order`(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        PAY_METHOD.description as "Description"
   FROM payment_method_combo as PAY_METHOD_COMBO
           LEFT JOIN payment_method as PAY_METHOD 
		   ON PAY_METHOD_COMBO.payment_method=PAY_METHOD.row_id 
       WHERE 
	    PAY_METHOD_COMBO.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_revision`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_revision`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_revision`(
		IN `in_work_order_id` int (10)
                 )
BEGIN
   SET @shock_revision=0;
   SET @fork_revision=0;
   call find_revision(`in_work_order_id`,@shock_revision,@fork_revision);
   SELECT 
        @shock_revision as `shock_rev`,
        @fork_revision as `fork_rev`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_rider_address_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_rider_address_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_rider_address_info`(
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
   FROM work_order AS WORK_ORDER
           LEFT JOIN shipping as SHIPPING
	           ON SHIPPING.work_order=WORK_ORDER.row_id
           LEFT JOIN rider_instance as RIDER_INSTANCE
	           ON WORK_ORDER.rider_instance=RIDER_INSTANCE.row_id
	   LEFT JOIN rider as RIDER
		  ON RIDER_INSTANCE.rider=RIDER.row_id
	   LEFT JOIN address as ADDRESS
		   ON RIDER.address=ADDRESS.row_id
       WHERE 
	     WORK_ORDER.row_id =`in_work_order_id`;	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_rider_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_rider_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_rider_info`(
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
   FROM rider as RIDER
	   LEFT JOIN address as ADDRESS
		   ON RIDER.address=ADDRESS.row_id
       WHERE 
	     RIDER.row_id =`in_rider_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_rider_names`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_rider_names`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_rider_names`()
BEGIN
   DECLARE the_row_id int(10); 
   DECLARE the_first_name varchar(100); 
   DECLARE the_last_name varchar(100); 

   DECLARE done INT DEFAULT 0;

   DECLARE names_cursor CURSOR FOR
	   SELECT row_id,first_name, last_name FROM rider;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1; 

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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_rider_settings_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_rider_settings_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_rider_settings_info`(
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
   FROM work_order as WORK_ORDER 
   WHERE WORK_ORDER.row_id=`in_work_order_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_riding_type`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_riding_type`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_riding_type`(
		IN `in_work_order` int (10)
                 )
BEGIN
  SELECT 
       RIDING_TYPE.description as `Riding Type`
  FROM 
       riding_type_combo as RIDING_COMBO,
       riding_type as RIDING_TYPE 
  WHERE 
        RIDING_COMBO.work_order=`in_work_order` AND
        RIDING_COMBO.riding_type=RIDING_TYPE.row_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_settings_fork_additional_products`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_settings_fork_additional_products`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_settings_fork_additional_products`(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ADD_PROD.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM fork_additional_products_combo as ADD_PROD_COMBO
           LEFT JOIN fork_additional_products as ADD_PROD 
		   ON ADD_PROD_COMBO.fork_additional_products=ADD_PROD.row_id 
           LEFT JOIN comments as COMMENTS 
		   ON ADD_PROD_COMBO.comments=COMMENTS.row_id
       WHERE 
	    ADD_PROD_COMBO.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_settings_on_arrival_to_clone`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_settings_on_arrival_to_clone`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_settings_on_arrival_to_clone`(
               IN `old_setting` int(10), 
	       OUT `out_settings_on_arrival` int(10)
              )
BEGIN
     DECLARE old_settings_on_arrival int(10); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE settings_on_arrival_cursor CURSOR FOR
	 SELECT settings_on_arrival FROM setting
			            WHERE row_id=`old_setting`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     OPEN settings_on_arrival_cursor;
       FETCH settings_on_arrival_cursor into old_settings_on_arrival;
     CLOSE settings_on_arrival_cursor; 

     IF old_settings_on_arrival<=>NULL THEN
         SET `out_settings_on_arrival`=0;
        ELSE 
         SET `out_settings_on_arrival`=old_settings_on_arrival;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_settings_on_arrival_to_clone_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_settings_on_arrival_to_clone_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_settings_on_arrival_to_clone_info`(
               IN `old_settings_on_arrival` int(10), 
	       OUT `out_arrival_fork_spec` int(20),
	       OUT `out_arrival_shock_spec` int(20)
              )
BEGIN
     DECLARE old_arrival_fork_spec int(20); 
     DECLARE old_arrival_shock_spec int(20); 

     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE settings_on_arrival_info_cursor CURSOR FOR
	 SELECT fork_spec, shock_spec FROM settings_on_arrival
			              WHERE row_id=`old_settings_on_arrival`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_settings_on_arrival_to_delete_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_settings_on_arrival_to_delete_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_settings_on_arrival_to_delete_info`(
               IN `in_settings_on_arrival` int(10), 
	       OUT `out_fork_spec` int(20),
	       OUT `out_shock_spec` int(20)
              )
BEGIN
     DECLARE fork_spec_id int(10); 
     DECLARE shock_spec_id int(10); 
     DECLARE no_rows_found INT DEFAULT 0;
     DECLARE setting_info_cursor CURSOR FOR
	 SELECT fork_spec, shock_spec FROM settings_on_arrival
			WHERE row_id=`in_settings_on_arrival`; 
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     OPEN setting_info_cursor;
       FETCH setting_info_cursor into fork_spec_id,shock_spec_id;
     CLOSE setting_info_cursor; 
     IF fork_spec_id<=>NULL THEN
         SET  `out_fork_spec`=0;
        ELSE
         SET  `out_fork_spec`=fork_spec_id; 
     END IF;
     IF shock_spec_id<=>NULL THEN
         SET  `out_shock_spec`=0;
        ELSE
         SET  `out_shock_spec`=shock_spec_id; 
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_settings_shock_additional_products`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_settings_shock_additional_products`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_settings_shock_additional_products`(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ADD_PROD.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM shock_additional_products_combo as ADD_PROD_COMBO
           LEFT JOIN shock_additional_products as ADD_PROD 
		   ON ADD_PROD_COMBO.shock_additional_products=ADD_PROD.row_id 
           LEFT JOIN comments as COMMENTS 
		   ON ADD_PROD_COMBO.comments=COMMENTS.row_id
       WHERE 
	    ADD_PROD_COMBO.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_setting_from_workorder`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_setting_from_workorder`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_setting_from_workorder`(
		IN `in_work_order` int (10)
                 )
BEGIN
  SELECT row_id FROM setting WHERE work_order=`in_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_setting_to_clone`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_setting_to_clone`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_setting_to_clone`(
               IN `old_work_order` int(10), 
	       OUT `out_setting` int(10)
              )
BEGIN
     DECLARE old_setting int(10); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE setting_cursor CURSOR FOR
	 SELECT setting FROM work_order
			WHERE row_id=`old_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     OPEN setting_cursor;
       FETCH setting_cursor into old_setting;
     CLOSE setting_cursor; 

     IF old_setting<=>NULL THEN
         SET `out_setting`=0;
        ELSE 
         SET `out_setting`=old_setting;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_setting_to_clone_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_setting_to_clone_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_setting_to_clone_info`(
               IN `old_setting` int(10), 
	       OUT `out_fork_spec` int(20),
	       OUT `out_shock_spec` int(20)
              )
BEGIN
     DECLARE old_fork_spec int(20); 
     DECLARE old_shock_spec int(20); 

     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE setting_info_cursor CURSOR FOR
	 SELECT fork_spec, shock_spec FROM setting
			WHERE row_id=`old_setting`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_setting_to_delete`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_setting_to_delete`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_setting_to_delete`(
               IN `in_work_order` int(10), 
	       OUT `out_setting` int(10)
              )
BEGIN
     DECLARE setting_id int(10); 
     DECLARE no_rows_found INT DEFAULT 0;
     DECLARE setting_cursor CURSOR FOR
	 SELECT setting FROM work_order
			WHERE row_id=`in_work_order`; 
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     OPEN setting_cursor;
       FETCH setting_cursor into setting_id;
     CLOSE setting_cursor; 
     IF setting_id <=> NULL THEN
         SET `out_setting`=0;
        ELSE
         SET `out_setting`=setting_id;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_setting_to_delete_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_setting_to_delete_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_setting_to_delete_info`(
               IN `in_setting` int(10), 
	       OUT `out_settings_on_arrival` int(10),
	       OUT `out_fork_spec` int(20),
	       OUT `out_shock_spec` int(20)
              )
BEGIN
     DECLARE arrival_id int(10); 
     DECLARE fork_spec_id int(20); 
     DECLARE shock_spec_id int(20); 
     DECLARE no_rows_found INT DEFAULT 0;
     DECLARE setting_info_cursor CURSOR FOR
	 SELECT settings_on_arrival,fork_spec, shock_spec FROM setting
			WHERE row_id=`in_setting`; 
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     OPEN setting_info_cursor;
       
       FETCH setting_info_cursor into arrival_id,fork_spec_id,shock_spec_id;
     CLOSE setting_info_cursor; 
     IF arrival_id<=>NULL THEN
         SET  `out_settings_on_arrival`=0;
        ELSE
         SET  `out_settings_on_arrival`=arrival_id; 
     END IF;
     IF fork_spec_id<=>NULL THEN
         SET  `out_fork_spec`=0;
        ELSE
         SET  `out_fork_spec`=fork_spec_id; 
     END IF;
     IF shock_spec_id<=>NULL THEN
         SET  `out_shock_spec`=0;
        ELSE
         SET  `out_shock_spec`=shock_spec_id; 
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shipping_acct_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shipping_acct_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shipping_acct_info`(
		IN `in_work_order_id` int (10)
                 )
BEGIN
  SELECT 
            SHIP.use_shipping_account,      
	    VENDOR.name as "shipping_vendor",
            ACCT_NUM.account_number
    FROM shipping as SHIP 
            LEFT JOIN ship_method_account as ACCT_NUM 
		    ON SHIP.ship_method_account=ACCT_NUM.row_id
            LEFT JOIN ship_vendor as VENDOR
		   ON ACCT_NUM.ship_vendor=VENDOR.row_id
        WHERE 
              SHIP.work_order=`in_work_order_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shipping_address_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shipping_address_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shipping_address_info`(
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
   FROM work_order AS WORK_ORDER
           LEFT JOIN shipping as SHIPPING
	           ON SHIPPING.work_order=WORK_ORDER.row_id
	   LEFT JOIN address as ADDRESS
		   ON SHIPPING.ship_address=ADDRESS.row_id
       WHERE 
	     WORK_ORDER.row_id =`in_work_order_id`;	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shipping_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shipping_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shipping_info`(
		IN `in_work_order_id` int (10)
                 )
BEGIN
  SELECT 
            METHOD.description 
    FROM shipping as SHIP 
            LEFT JOIN ship_method as METHOD 
		    ON SHIP.ship_method=METHOD.row_id
        WHERE 
              SHIP.work_order=`in_work_order_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_additional_services_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_additional_services_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_additional_services_from_work_order`(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        ADD_SRV.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM shock_additional_services_combo as ADD_SRV_COMBO
           LEFT JOIN shock_additional_services as ADD_SRV 
		   ON ADD_SRV_COMBO.shock_additional_services=ADD_SRV.row_id 
           LEFT JOIN comments as COMMENTS 
		   ON ADD_SRV_COMBO.comments=COMMENTS.row_id
       WHERE 
	    ADD_SRV_COMBO.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_comp_adj_shims`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_comp_adj_shims`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_comp_adj_shims`(
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
       shock_compression_adjuster_stack as STACK
  WHERE 
        STACK.shock_spec=`in_shock_spec` 
  ORDER BY pos; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_comp_shims`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_comp_shims`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_comp_shims`(
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
       shock_compression_stack as STACK
  WHERE 
        STACK.shock_spec=`in_shock_spec` 
  ORDER BY STACK.position; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_estimate_id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_estimate_id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_estimate_id`(
               IN `in_finance` varchar(5000),
               OUT `out_shock_estimate_id` int(10) 
              )
BEGIN
     DECLARE shock_estimate_id int(10); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE shock_estimate_cursor CURSOR FOR
	 SELECT estimate_shock FROM finance
			       WHERE row_id=`in_finance`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
 
     
     OPEN shock_estimate_cursor;
       FETCH shock_estimate_cursor into shock_estimate_id;
     CLOSE shock_estimate_cursor; 

     IF no_rows_found=0 THEN
         SET `out_shock_estimate_id`=shock_estimate_id;
        ELSEIF no_rows_found=1 THEN
         SET `out_shock_estimate_id`=0;
      END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_estimate_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_estimate_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_estimate_info`(
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
   FROM finance as FINANCE 
	LEFT JOIN estimate_shock as ESTIMATE_SHOCK
		ON FINANCE.estimate_shock=ESTIMATE_SHOCK.row_id
   WHERE 
	FINANCE.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_fork_specs_for_setting`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_fork_specs_for_setting`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_fork_specs_for_setting`(
		IN `in_setting_id` int (10)
                 )
BEGIN
  SELECT
          SETTING.fork_spec as fork_spec,
	  SETTING.shock_spec as shock_spec
    FROM 
          setting as SETTING 
    WHERE 
	  SETTING.row_id =`in_setting_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_general_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_general_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_general_info`(
		IN `in_spec_id` int (20)
                 )
BEGIN
  SELECT
        INFO.general_info as "General Info"
  FROM 
        shock_spec as SPEC 
	LEFT JOIN shock_spec_general_info AS INFO
		ON SPEC.general_info=INFO.row_id		
  WHERE 
	 SPEC.row_id =`in_spec_id`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_need_springs_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_need_springs_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_need_springs_info`(
		IN `in_work_order` int (10)
                )
BEGIN
     SELECT 
	    NEED_SPRINGS.need_shock_spring,
	    NEED_SPRINGS.recommended_shock_spring AS 'rate'
       FROM need_springs as NEED_SPRINGS 
       WHERE 
	    NEED_SPRINGS.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_reb_shims`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_reb_shims`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_reb_shims`(
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
       shock_rebound_stack as STACK
  WHERE 
        STACK.shock_spec=`in_shock_spec` 
  ORDER BY pos; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_spec`(
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
        shock_spec as SHOCK
  WHERE 
	SHOCK.row_id =`in_shock_spec`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_springs`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_springs`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_springs`()
BEGIN
  SELECT 
        SPRINGS.row_id,
        SPRINGS.rate

  FROM 
       springs as SPRINGS,
       spring_type as SPRING_TYPE
  WHERE 
        SPRINGS.spring_type=SPRING_TYPE.row_id AND
        SPRING_TYPE.description like "Shock";
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_shock_standard_work_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_shock_standard_work_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shock_standard_work_from_work_order`(
		IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
        WORK.description as "Description",
        COMMENTS.comments as "Comments"  
   FROM shock_work_combo as WORK_COMBO
           LEFT JOIN shock_work as WORK 
		   ON WORK_COMBO.shock_work=WORK.row_id 
           LEFT JOIN comments as COMMENTS 
		   ON WORK_COMBO.comments=COMMENTS.row_id
       WHERE 
	    WORK_COMBO.work_order=`in_work_order`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_support_comments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_support_comments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_support_comments`(
		IN `in_work_order_id` int (10)
                 )
BEGIN
  SELECT
	WORK_ORDER.customer_comments as "Customer Comments",
        WORK_ORDER.tech_support_comments as "Tech Support Comments"
  FROM 
        work_order as WORK_ORDER 
   WHERE 
	 WORK_ORDER.row_id =`in_work_order_id`;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_terrain`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_terrain`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_terrain`(
		IN `in_work_order` int (10)
                 )
BEGIN
  SELECT 
         TERRAIN.description as `Terrain`
  FROM 
       terrain_combo as TC,
       terrain as TERRAIN
  WHERE 
        TC.work_order=`in_work_order` AND
        TC.terrain=TERRAIN.row_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_work_order_for_setting`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_work_order_for_setting`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_work_order_for_setting`(
               IN `in_setting` int(10),
               OUT `out_work_order` int(10) 
              )
BEGIN
   DECLARE existing_work_order int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE work_order_cursor CURSOR FOR
		SELECT row_id FROM work_order
			      WHERE setting=`in_setting`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN work_order_cursor;
      FETCH work_order_cursor into existing_work_order;
    CLOSE work_order_cursor; 

    IF existing_work_order<=>NULL THEN
       SET `out_work_order`=0;
       ELSE
       
        SET `out_work_order`=existing_work_order;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `get_work_order_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_work_order_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_work_order_info`(
		 IN `in_work_order` int (10)
                 )
BEGIN
 SELECT 
           SHOP.name as "Shop",
	   SRV_LOC.location as "Service Location"
   FROM work_order as WORK_ORDER 
           LEFT JOIN  shop as SHOP
		   ON WORK_ORDER.shop=SHOP.row_id 
           LEFT JOIN  service_location as SRV_LOC 
		   ON WORK_ORDER.service_location=SRV_LOC.row_id 
       WHERE 
	     WORK_ORDER.row_id =`in_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `import_create_new_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `import_create_new_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `import_create_new_work_order`(
		OUT `imp_work_order` int(10),
		OUT `imp_setting` int(10),
		OUT `imp_shock_spec` int(20),
		OUT `imp_fork_spec` int(20)
              )
BEGIN
  /*These need to be updated for the FK paradigm*/
  --call prepare_work_order(0,imp_work_order,imp_setting);
  --call prepare_shock_spec(imp_setting,imp_shock_spec); 
  --call prepare_fork_spec(imp_setting,imp_fork_spec);   
  --call update_lookup_table(imp_work_order);            
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `import_top_level_of_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `import_top_level_of_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `import_top_level_of_work_order`(
               IN `imp_work_order` int(10),
               IN `exp_service_location` int(10),
               IN `exp_shop` int(10),
               IN `exp_rider_instance` int(10),
               IN `exp_bike` int(10),
               IN `exp_customer_comments` varchar(5000),
               IN `exp_tech_support_comments` varchar(5000),
               IN `exp_call_prior` int(1),
               IN `exp_ok_to_replace_bearing` int(1),
               IN `exp_turnaround` int(10),
               IN `exp_referrer` int(10) 
              )
BEGIN
  UPDATE work_order SET service_location=`exp_service_location`             WHERE row_id=`imp_work_order`;
  UPDATE work_order SET shop=`exp_shop`                                     WHERE row_id=`imp_work_order`;
  UPDATE work_order SET rider_instance=`exp_rider_instance`                 WHERE row_id=`imp_work_order`;
  UPDATE work_order SET bike=`exp_bike`                                     WHERE row_id=`imp_work_order`;
  UPDATE work_order SET customer_comments=`exp_customer_comments`           WHERE row_id=`imp_work_order`;
  UPDATE work_order SET tech_support_comments=`exp_tech_support_comments`   WHERE row_id=`imp_work_order`;
  UPDATE work_order SET call_prior=`exp_call_prior`                         WHERE row_id=`imp_work_order`;
  UPDATE work_order SET ok_to_replace_bearing=`exp_ok_to_replace_bearing`   WHERE row_id=`imp_work_order`;
  UPDATE work_order SET turn_around=`exp_turnaround`                        WHERE row_id=`imp_work_order`;
  UPDATE work_order SET referrer= `exp_referrer`                            WHERE row_id=`imp_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `insert_open_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_open_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_open_work_order`(
               IN `in_work_order` int(10)
              )
BEGIN
     INSERT INTO open_work_orders(work_order) VALUES (`in_work_order`);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `insert_shims_into_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_shims_into_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_shims_into_spec`(
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
    
    IF `in_ref_table`="fork_bcv_stack" THEN
        SET @syntax=CONCAT("  INSERT INTO ", `in_ref_table`,
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
        SET @syntax=CONCAT("  INSERT INTO ", `in_ref_table`,
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `check_address`
-- ----------------------------
DROP PROCEDURE IF EXISTS `check_address`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_address`(
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
   DECLARE existing_address int(10) DEFAULT NULL;
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE address_cursor CURSOR FOR
		SELECT row_id FROM address
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

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN address_cursor;
      FETCH address_cursor into existing_address;
    CLOSE address_cursor; 

    
    IF existing_address<=>NULL THEN
       
       INSERT INTO address (phone1,phone2,address1,address2,address3,city,state_province,country,zip) 
                               VALUES (`in_phone1`,`in_phone2`,`in_address1`,`in_address2`,`in_address3`,
                                       `in_city`,`in_state`,`in_country`,`in_zip`); 
       SET `out_address`=LAST_INSERT_ID();
       ELSE
       
        SET `out_address`=existing_address;
    END IF;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_arrival_fork_spec`
-- ----------------------------
/*
DROP PROCEDURE IF EXISTS `prepare_arrival_fork_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_arrival_fork_spec`(
               IN `in_settings_on_arrival` int(10),
               OUT `out_fork_spec` int(20) 
              )
BEGIN
   DECLARE spec_id int(20); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE spec_cursor CURSOR FOR
		SELECT fork_spec FROM settings_on_arrival
		                  WHERE row_id=`in_settings_on_arrival`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN spec_cursor;
      FETCH spec_cursor into spec_id;
    CLOSE spec_cursor; 

    
    IF spec_id<=>NULL THEN
       
       INSERT INTO fork_spec () VALUES(); 
       SET @new_arrival_spec=LAST_INSERT_ID();
       
       UPDATE settings_on_arrival SET fork_spec=@new_arrival_spec WHERE row_id=`in_settings_on_arrival`;
       SET `out_fork_spec`=@new_arrival_spec;
       ELSE
       
        SET `out_fork_spec`=spec_id;
   END IF;
END
;;
DELIMITER ;
*/

-- ----------------------------
-- Procedure structure for `prepare_arrival_shock_spec`
-- ----------------------------
/*
DROP PROCEDURE IF EXISTS `prepare_arrival_shock_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_arrival_shock_spec`(
               IN `in_settings_on_arrival` int(10),
               OUT `out_shock_spec` int(20) 
              )
BEGIN
   DECLARE spec_id int(20); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE spec_cursor CURSOR FOR
		SELECT shock_spec FROM settings_on_arrival
		                  WHERE row_id=`in_settings_on_arrival`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN spec_cursor;
      FETCH spec_cursor into spec_id;
    CLOSE spec_cursor; 

    
    IF spec_id<=>NULL THEN
       
       INSERT INTO shock_spec () VALUES(); 
       SET @new_arrival_spec=LAST_INSERT_ID();
       
       UPDATE settings_on_arrival SET shock_spec=@new_arrival_spec WHERE row_id=`in_settings_on_arrival`;
       SET `out_shock_spec`=@new_arrival_spec;
       ELSE
       
        SET `out_shock_spec`=spec_id;
   END IF;
END
;;
DELIMITER ;
*/
-- ----------------------------
-- Procedure structure for `prepare_arrival_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_arrival_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_arrival_spec`(
               IN `in_setting` int(10),
               OUT `out_arrival_spec` int(10) 
              )
BEGIN
     DECLARE existing_arrival_spec int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE arrival_spec_cursor CURSOR FOR
		SELECT settings_on_arrival FROM setting
				           WHERE row_id=`in_setting`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

     OPEN arrival_spec_cursor;
       FETCH arrival_spec_cursor into existing_arrival_spec;
     CLOSE arrival_spec_cursor; 

    
    
    IF existing_arrival_spec<=>NULL THEN
       
       INSERT INTO settings_on_arrival () VALUES(); 
       SET @new_arrival_spec=LAST_INSERT_ID();
       
       SELECT "the in_setting is ",`in_setting`;
       UPDATE setting SET settings_on_arrival=@new_arrival_spec WHERE row_id=`in_setting`;
       SET `out_arrival_spec`=@new_arrival_spec;
       ELSE
       
        SET `out_arrival_spec`=existing_arrival_spec;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `check_bike_instance`
-- ----------------------------
DROP PROCEDURE IF EXISTS `check_bike_instance`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_bike_instance`(
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
		 SELECT row_id FROM bike
			     WHERE bike_year=`in_year_id` AND
		                   bike_brand_model=`in_model_id` AND
			           shock_brand=`in_shock_brand_id` AND	
			           fork_brand=`in_fork_brand_id`;	

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN bike_cursor;
      FETCH bike_cursor into existing_bike;
    CLOSE bike_cursor; 

    
    
    IF existing_bike<=>NULL THEN
       
       INSERT INTO bike (bike_year,bike_brand_model,shock_brand,fork_brand) 
                             VALUES(`in_year_id`,`in_model_id`,`in_shock_brand_id`,`in_fork_brand_id`); 
       SET @new_bike_instance=LAST_INSERT_ID();
       SET `out_bike_instance`=@new_bike_instance;
       ELSE
       
        SET `out_bike_instance`=existing_bike;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_credit_card_account`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_credit_card_account`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_credit_card_account`(
               IN `in_encrypted_card` blob,
	       OUT `out_cc_id` int(10)
       )
BEGIN
   DECLARE cc_id int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE cc_cursor CURSOR FOR
                         SELECT row_id FROM credit_card
                                       WHERE number =`in_encrypted_card`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

   OPEN cc_cursor;
      FETCH cc_cursor into cc_id;
   CLOSE cc_cursor; 

   
   IF no_rows_found=0 THEN
      SET `out_cc_id`=cc_id;	 
      SELECT "cc found with row_id of ",cc_id;
      
      ELSEIF no_rows_found=1 THEN
             INSERT INTO credit_card(number) VALUES (`in_encrypted_card`);
             SET @new_cc_id=LAST_INSERT_ID();
             SET `out_cc_id`=@new_cc_id;	 
             SELECT "created cc with row_id of ",@new_cc_id;
   END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_estimate_fork`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_estimate_fork`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_estimate_fork`(
               IN `in_finance` int(10),
               OUT `out_estimate` int(10) 
              )
BEGIN
     DECLARE existing_estimate int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE estimate_cursor CURSOR FOR
		SELECT estimate_fork FROM finance 
			      WHERE row_id=`in_finance`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

     OPEN estimate_cursor;
       FETCH estimate_cursor into existing_estimate;
     CLOSE estimate_cursor; 

    
    
    IF existing_estimate<=>NULL THEN
       
       INSERT INTO estimate_fork () VALUES(); 
       SET @new_estimate=LAST_INSERT_ID();
       UPDATE finance SET estimate_fork=@new_estimate WHERE row_id=`in_finance`;
       SET `out_estimate`=@new_estimate;
       ELSE
       
        SET `out_estimate`=existing_estimate;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_estimate_shock`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_estimate_shock`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_estimate_shock`(
               IN `in_finance` int(10),
               OUT `out_estimate` int(10) 
              )
BEGIN
     DECLARE existing_estimate int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE estimate_cursor CURSOR FOR
		SELECT estimate_shock FROM finance 
			      WHERE row_id=`in_finance`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

     OPEN estimate_cursor;
       FETCH estimate_cursor into existing_estimate;
     CLOSE estimate_cursor; 

    
    
    IF existing_estimate<=>NULL THEN
       
       INSERT INTO estimate_shock () VALUES(); 
       SET @new_estimate=LAST_INSERT_ID();
       UPDATE finance SET estimate_shock=@new_estimate WHERE row_id=`in_finance`;
       SET `out_estimate`=@new_estimate;
       ELSE
       
        SET `out_estimate`=existing_estimate;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_finance`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_finance`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_finance`(
               IN `in_work_order` int(10),
               OUT `out_finance` int(10) 
              )
BEGIN
     DECLARE existing_finance int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE finance_cursor CURSOR FOR
		SELECT row_id FROM finance 
			      WHERE work_order=`in_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

     OPEN finance_cursor;
       FETCH finance_cursor into existing_finance;
     CLOSE finance_cursor; 

    
    
    IF existing_finance<=>NULL THEN
       
       INSERT INTO finance (work_order) VALUES(`in_work_order`); 
       SET @new_finance=LAST_INSERT_ID();
       SET `out_finance`=@out_finance;
       ELSE
       
        SET `out_finance`=existing_finance;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_finance_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_finance_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_finance_info`(
               IN `in_work_order` int(10),
               OUT `out_finance` int(10) 
              )
BEGIN
   DECLARE existing_finance int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE finance_cursor CURSOR FOR
		SELECT row_id FROM finance
			      WHERE work_order=`in_work_order`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN finance_cursor;
      FETCH finance_cursor into existing_finance;
    CLOSE finance_cursor; 

    
    
    IF existing_finance<=>NULL THEN
       
       INSERT INTO finance (work_order) VALUES(`in_work_order`); 
       SET @new_finance=LAST_INSERT_ID();
       SET `out_finance`=@new_finance;
       ELSE
       
        SET `out_finance`=existing_finance;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_fork_shock_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_fork_shock_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_fork_shock_spec`(
               IN `in_setting_id` int(10),
	       IN `ref_table` varchar(100),
	       OUT `spec_id` int(20)
       )
BEGIN
        DECLARE existing_fork_spec int(20);
        DECLARE existing_shock_spec int(20);
        DECLARE no_rows_found INT DEFAULT 0;
        DECLARE spec_cursor CURSOR FOR
		   SELECT SETTING.fork_spec,shock_spec FROM setting as SETTING
						    WHERE SETTING.row_id=`in_setting_id`; 

        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

        OPEN spec_cursor;
          FETCH spec_cursor into existing_fork_spec, existing_shock_spec;
        CLOSE spec_cursor; 

	 
        IF existing_fork_spec <=>NULL THEN
                
        	INSERT INTO fork_spec () VALUES ();
                SET @new_fork_spec=LAST_INSERT_ID();
                
        	UPDATE setting SET fork_spec=@new_fork_spec WHERE row_id=`in_setting_id`;
		SET @out_fork_spec=@new_fork_spec;
        END IF;

	 
        IF existing_shock_spec <=>NULL THEN
                
        	INSERT INTO shock_spec () VALUES ();
                SET @new_shock_spec=LAST_INSERT_ID();
                
        	UPDATE setting SET shock_spec=@new_shock_spec WHERE row_id=`in_setting_id`;
		SET @out_shock_spec=@new_shock_spec;
        END IF;

	
        UPDATE setting SET date=curdate() WHERE row_id=`in_setting_id`;

	 
        IF existing_fork_spec >0 THEN
		SET @out_fork_spec=existing_fork_spec;
        END IF;

	 
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_fork_spec`
-- ----------------------------
/*
DROP PROCEDURE IF EXISTS `prepare_fork_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_fork_spec`(
               IN `in_setting` int(10),
               OUT `out_spec` int(20) 
              )
BEGIN
    DECLARE existing_spec int(20); 
    DECLARE no_rows_found INT DEFAULT 0;

    DECLARE spec_cursor CURSOR FOR
 		SELECT fork_spec FROM setting WHERE row_id=`in_setting`; 

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN spec_cursor;
      FETCH spec_cursor into existing_spec;
    CLOSE spec_cursor; 

    
    
    IF existing_spec<=>NULL THEN
       
       INSERT INTO fork_spec (revision_number) VALUES(0); 
       SET @new_spec=LAST_INSERT_ID();
       UPDATE setting SET fork_spec=@new_spec WHERE row_id=`in_setting`;
       SET `out_spec`=@new_spec;
       ELSE
       
        SET `out_spec`=existing_spec;
    END IF;
END
;;
DELIMITER ;
*/

-- ----------------------------
-- Procedure structure for `prepare_limit_statement`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_limit_statement`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_limit_statement`(
               IN `in_page` int(3),
               OUT `out_limit_statement` varchar(50) 
              )
BEGIN
  
  SET @records_per_page=50;
  
  
  
  SET @start_value=`in_page` * @records_per_page - @records_per_page;
  SET `out_limit_statement`=CONCAT(" LIMIT ",@start_value,",",@records_per_page); 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_need_springs`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_need_springs`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_need_springs`(
               IN `in_work_order` int(10),
               OUT `out_need_springs` int(10) 
              )
BEGIN
     DECLARE existing_need_springs int(10);
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE need_springs_cursor CURSOR FOR
		SELECT row_id FROM need_springs
	                      WHERE work_order=`in_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

     OPEN need_springs_cursor;
       FETCH need_springs_cursor into existing_need_springs; 
     CLOSE need_springs_cursor; 

    
    
    IF existing_need_springs<=>NULL THEN
       
       INSERT INTO need_springs (work_order) VALUES(`in_work_order`); 
       SET @new_need_springs=LAST_INSERT_ID();
       SET `out_need_springs`=@new_need_springs;
       ELSE
       
        SET `out_need_springs`=existing_need_springs;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_rider_instance`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_rider_instance`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_rider_instance`(
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
		 SELECT row_id FROM rider_instance
			       WHERE rider=`in_rider_id` AND
			       		    rider_weight=`in_weight_id` AND
					    rider_ability=`in_ability_id` AND
					    rider_height=`in_height_id`;	

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN rider_instance_cursor;
      FETCH rider_instance_cursor into existing_rider_instance;
    CLOSE rider_instance_cursor; 

    
    
    IF existing_rider_instance<=>NULL THEN
       
       INSERT INTO rider_instance (rider,rider_weight,rider_ability, rider_height) 
                             VALUES(`in_rider_id`,`in_weight_id`,`in_ability_id`,`in_height_id`); 
       SET @new_rider_instance=LAST_INSERT_ID();
       SET `out_rider_instance`=@new_rider_instance;
       ELSE
       
        SET `out_rider_instance`=existing_rider_instance;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_setting`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_setting`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_setting`(
               IN `in_setting` int(10),
               OUT `out_setting` int(10) 
              )
BEGIN
    IF `in_setting`<=>NULL THEN
       INSERT INTO setting () VALUES(); 
       SET `out_setting`=LAST_INSERT_ID();
       ELSE
        SET `out_setting`=`in_setting`;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_shipping`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_shipping`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_shipping`(
               IN `in_work_order` int(10),
               OUT `out_shipping` int(10) 
              )
BEGIN
   DECLARE existing_shipping int(10)DEFAULT NULL;
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE shipping_cursor CURSOR FOR
		SELECT row_id FROM shipping
			      WHERE work_order=`in_work_order`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN shipping_cursor;
      FETCH shipping_cursor into existing_shipping;
    CLOSE shipping_cursor; 
    
    IF existing_shipping IS NULL THEN
       INSERT INTO shipping (work_order) VALUES(`in_work_order`); 
       SET `out_shipping`=LAST_INSERT_ID();
       ELSE
        SET `out_shipping`=existing_shipping;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_shipping_account`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_shipping_account`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_shipping_account`(
	       IN `in_shipping_vendor_id` int(10),
               IN `in_shipping_method_account` varchar(100),
	       OUT `out_ship_method_account` int(10)
       )
BEGIN
   DECLARE shipping_acct int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE ship_acct_cursor CURSOR FOR
                         SELECT row_id FROM ship_method_account
                                       WHERE ship_vendor=`in_shipping_vendor_id` AND
				             account_number =`in_shipping_method_account`;
				             

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

   
   IF (`in_shipping_method_account` IS NULL) THEN 
       SET `out_ship_method_account`=NULL;
       
       ELSE 
         OPEN ship_acct_cursor;
           FETCH ship_acct_cursor into shipping_acct;
         CLOSE ship_acct_cursor; 
         
         IF no_rows_found=0 THEN
            SET `out_ship_method_account`=shipping_acct;	 
            
            ELSEIF no_rows_found=1 THEN
                   INSERT INTO ship_method_account(ship_vendor,account_number)
                                                      VALUES (`in_shipping_vendor_id`,`in_shipping_method_account`);
                   SET `out_ship_method_account`=LAST_INSERT_ID();
         END IF;
   END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_shipping_vendor`
-- ----------------------------
DROP PROCEDURE IF EXISTS `prepare_shipping_vendor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_shipping_vendor`(
	       IN `in_shipping_vendor_string` varchar(4),
	       OUT `out_ship_vendor_id` int(10)
       )
BEGIN
   DECLARE vendor_id int(10) DEFAULT NULL; 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE vendor_cursor CURSOR FOR
                         SELECT row_id FROM ship_vendor
                                       WHERE name like `in_shipping_vendor_string`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

   OPEN vendor_cursor;
     FETCH vendor_cursor into vendor_id;
   CLOSE vendor_cursor; 

   
   IF vendor_id IS NULL THEN
	INSERT INTO ship_vendor (name) VALUES (substring(`in_vendor_string`,1,3));
	SET `out_ship_vendor_id`= LAST_INSERT_ID();
      ELSE
          SET `out_ship_vendor_id`=vendor_id;
   END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `prepare_shock_spec`
-- ----------------------------
/*
DROP PROCEDURE IF EXISTS `prepare_shock_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_shock_spec`(
               IN `in_setting` int(10),
               OUT `out_spec` int(20) 
              )
BEGIN
   DECLARE existing_spec int(20); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE spec_cursor CURSOR FOR
		SELECT shock_spec FROM setting WHERE row_id=`in_setting`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN spec_cursor;
      FETCH spec_cursor into existing_spec;
    CLOSE spec_cursor; 

    
    
    IF existing_spec<=>NULL THEN
       
       INSERT INTO shock_spec (revision_number) VALUES(0); 
       SET @new_spec=LAST_INSERT_ID();
       UPDATE setting SET shock_spec=@new_spec WHERE row_id=`in_setting`;
       SET `out_spec`=@new_spec;
       ELSE
       
        SET `out_spec`=existing_spec;
    END IF;
END
;;
DELIMITER ;
*/

-- ----------------------------
-- Procedure structure for `prepare_work_order`
-- ----------------------------
/*DROP PROCEDURE IF EXISTS `prepare_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_work_order`(
               IN `in_work_order` int(10),
               OUT `out_work_order` int(10) 
              )
BEGIN
   DECLARE existing_work_order int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE work_order_cursor CURSOR FOR
		SELECT row_id FROM work_order
			      WHERE row_id=`in_work_order`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN work_order_cursor;
      FETCH work_order_cursor into existing_work_order;
    CLOSE work_order_cursor; 
*/
    /*if the id of the in_work_order is NULL
     *then, create a new work_order
     */
/*    IF ISNULL(existing_work_order) THEN
       
       INSERT INTO setting () VALUES(); 
       SET @new_setting=LAST_INSERT_ID();
       SET `out_setting`=@new_setting;

       
       INSERT INTO work_order (setting) VALUES(@new_setting); 
       SET @new_work_order=LAST_INSERT_ID();
       SET `out_work_order`=@new_work_order;
       ELSE
        SET `out_work_order`=existing_work_order;
     END IF;
END
;;
DELIMITER ;
*/
-- ----------------------------
-- Procedure structure for `prepare_work_order_setting`
-- ----------------------------
/*DROP PROCEDURE IF EXISTS `prepare_work_order_setting`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prepare_work_order_setting`(
               IN `in_work_order` int(10),
               OUT `out_setting` int(10) 
              )
BEGIN
   DECLARE existing_setting int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE setting_cursor CURSOR FOR
		SELECT setting FROM work_order
			      WHERE row_id=`in_work_order`; 

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

    OPEN setting_cursor;
      FETCH setting_cursor into existing_setting;
    CLOSE setting_cursor; 

    
    
    IF existing_setting<=>NULL THEN
       
       INSERT INTO setting (date) VALUES(curdate()); 
       SET @new_setting=LAST_INSERT_ID();

       
       UPDATE work_order SET setting =@new_setting WHERE row_id=`in_work_order`; 
       SET @new_work_order=LAST_INSERT_ID();
       SET `out_setting`=@new_work_order;
       ELSE
       
        SET `out_setting`=existing_setting;
     END IF;
END
;;
DELIMITER ;
*/

-- ----------------------------
-- Procedure structure for `quiet_clone_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `quiet_clone_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `quiet_clone_work_order`(
               IN `old_work_order` int(10),
       	       IN `clone_type` varchar(15),	
       	       IN `revision_type` varchar(15)	
              )
BEGIN
  
  IF ((`clone_type`="Major Revision") OR (`clone_type`="Minor Revision"))  THEN 
     call clone_customer_comments(`old_work_order`,@new_customer_comments);
     call clone_tech_support_comments(`old_work_order`,@new_tech_support_comments);
     
    INSERT INTO work_order 
                          (service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
			   ok_to_replace_bearing,turn_around, referrer) 
                    SELECT service_location,shop,rider_instance, bike, 
		           @new_customer_comments,@new_tech_support_comments, call_prior,
	                   ok_to_replace_bearing,turn_around, referrer 
                    FROM work_order 
	            WHERE row_id=`old_work_order`;
    SET @new_work_order=LAST_INSERT_ID();
    call clone_setting(`old_work_order`,@new_work_order,`clone_type`,`revision_type`);
    call clone_other_work_order_records(`old_work_order`,@new_work_order,`clone_type`);
    call clone_finance(`old_work_order`,@new_work_order);
  END IF;
  
  IF (`clone_type`="New Spec") THEN
     SET @new_customer_comments=NULL;
     SET @new_tech_support_comments=NULL;
     
    INSERT INTO work_order 
                          (service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
			   ok_to_replace_bearing,turn_around, referrer) 
                    SELECT service_location,shop,rider_instance, bike, 
		           @new_customer_comments,@new_tech_support_comments, call_prior,
	                   ok_to_replace_bearing,turn_around, referrer 
                    FROM work_order 
	            WHERE row_id=`old_work_order`;
    SET @new_work_order=LAST_INSERT_ID();
    call clone_setting(`old_work_order`,@new_work_order,`clone_type`,`revision_type`);
    call clone_other_work_order_records(`old_work_order`,@new_work_order,`clone_type`);
  END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `remove_acct_from_shipping_entry`
-- ----------------------------
DROP PROCEDURE IF EXISTS `remove_acct_from_shipping_entry`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_acct_from_shipping_entry`(
               IN `in_shipping_entry`  int(10)
       )
BEGIN
   DECLARE shipping_acct int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE ship_acct_cursor CURSOR FOR
                         SELECT ship_method_account FROM shipping
                                                    WHERE row_id =`in_shipping_entry`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

   OPEN ship_acct_cursor;
      FETCH ship_acct_cursor into shipping_acct;
   CLOSE ship_acct_cursor; 

   IF shipping_acct>0 THEN
      DELETE FROM ship_method_account
             WHERE row_id=shipping_acct;
      UPDATE shipping SET ship_method_account=null WHERE row_id=`in_shipping_entry`;
      FLUSH QUERY CACHE;
   END IF;
   
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `remove_additional_products_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `remove_additional_products_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_additional_products_from_work_order`(
               IN `in_work_order_id`  int(10),
               IN `in_type` varchar(20)
       )
BEGIN
   IF (`in_type`="Fork") THEN 
      SET @syntax=CONCAT("  DELETE from fork_additional_products_combo",
                         "  WHERE work_order=",`in_work_order_id`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;

   IF (`in_type`="Shock") THEN 
      SET @syntax=CONCAT("  DELETE from shock_additional_products_combo",
                         "  WHERE work_order=",`in_work_order_id`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `remove_additional_services_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `remove_additional_services_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_additional_services_from_work_order`(
               IN `in_work_order`  int(10),
               IN `in_type` varchar(20)
       )
BEGIN
   IF (`in_type`="Fork") THEN 
      SET @syntax=CONCAT("  DELETE from fork_additional_services_combo",
                         "  WHERE work_order=",`in_work_order`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;

   IF (`in_type`="Shock") THEN 
      SET @syntax=CONCAT("  DELETE from shock_additional_services_combo",
                         "  WHERE work_order=",`in_work_order`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `remove_credit_card_from_finance_entry`
-- ----------------------------
DROP PROCEDURE IF EXISTS `remove_credit_card_from_finance_entry`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_credit_card_from_finance_entry`(
               IN `in_finance_entry`  int(10)
       )
BEGIN
   DECLARE credit_entry int(10); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE credit_entry_cursor CURSOR FOR
                         SELECT credit_card FROM finance
                                            WHERE row_id =`in_finance_entry`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

   OPEN credit_entry_cursor;
      FETCH credit_entry_cursor into credit_entry;
   CLOSE credit_entry_cursor; 

   IF credit_entry>0 THEN
      DELETE FROM credit_card
             WHERE row_id=credit_entry;
      UPDATE finance SET credit_card=null WHERE row_id=`in_finance_entry`;
      FLUSH QUERY CACHE;
   END IF;
   
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `remove_payment_method_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `remove_payment_method_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_payment_method_from_work_order`(
               IN `in_work_order`  int(10)
       )
BEGIN
   DELETE FROM payment_method_combo
          WHERE work_order=`in_work_order`; 
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `remove_riding_types_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `remove_riding_types_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_riding_types_from_work_order`(
               IN `in_work_order`  int(10)
       )
BEGIN
   DELETE FROM riding_type_combo
          WHERE work_order=`in_work_order`;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `remove_shims_from_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `remove_shims_from_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_shims_from_spec`(
               IN `in_setting`int(10),
               IN `in_ref_table`varchar(100),
               IN `in_ref_spec` varchar(100)
       )
BEGIN
   SET @spec_id=0;
   call prepare_fork_shock_spec(`in_setting`,`in_ref_table`,@spec_id);

   SET @syntax=CONCAT("  DELETE from ", `in_ref_table`,
                      "  WHERE ", `in_ref_spec`,"=",@spec_id,";"); 
   PREPARE stmt1 FROM @syntax;
   EXECUTE stmt1;

   SELECT @spec_id AS spec_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `remove_standard_work_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `remove_standard_work_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_standard_work_from_work_order`(
               IN `in_work_order`  int(10),
               IN `in_type` varchar(20)
       )
BEGIN
   IF (`in_type`="Fork") THEN 
      SET @syntax=CONCAT("  DELETE from fork_work_combo",
                         "  WHERE work_order=",`in_work_order`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;

   IF (`in_type`="Shock") THEN 
      SET @syntax=CONCAT("  DELETE from shock_work_combo",
                         "  WHERE work_order=",`in_work_order`,";"); 
      SELECT @syntax;
      PREPARE stmt1 FROM @syntax;
      EXECUTE stmt1;
   END IF;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `remove_terrain_from_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `remove_terrain_from_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_terrain_from_work_order`(
               IN `in_work_order`  int(10)
       )
BEGIN
   DELETE FROM terrain_combo
          WHERE work_order=`in_work_order`;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_additional_products`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_additional_products`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_additional_products`(
	       IN `in_work_order` int(10),
               IN `in_type` varchar(20),
               IN `in_product_id` int(10),
               IN `in_comments` varchar(5000)
       )
BEGIN
     IF (`in_type`="Shock") THEN
        SET @table_name="shock_additional_products_combo"; 
        SET @col_name="shock_additional_products";
     END IF;

     IF (`in_type`="Fork") THEN
        SET @table_name="fork_additional_products_combo"; 
        SET @col_name="fork_additional_products";
     END IF;

     SET @syntax=CONCAT("  INSERT INTO ", @table_name, " (work_order, ", @col_name,", comments) ",
                        "  VALUES (",`in_work_order`,",",`in_product_id`,",",`in_comments`,");"
                       );
     
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;
     FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_additional_services`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_additional_services`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_additional_services`(
	       IN `in_work_order` int(10),
               IN `in_type` varchar(20),
               IN `in_product_id` int(10),
               IN `in_comments` varchar(5000)
       )
BEGIN
     IF (`in_type`="Fork") THEN
        SET @table_name="fork_additional_services_combo"; 
        SET @col_name="fork_additional_services";
     END IF;

     IF (`in_type`="Shock") THEN
        SET @table_name="shock_additional_services_combo"; 
        SET @col_name="shock_additional_services";
     END IF;

     SET @syntax=CONCAT("  INSERT INTO ", @table_name, " (work_order, ", @col_name,", comments) ",
                        "  VALUES (",`in_work_order`,",",`in_product_id`,",",`in_comments`,");"
                       );
     
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;
     FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_bike_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_bike_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_bike_info`(
		IN `in_work_order_id` int (10),
		IN `in_year_id` int (10),
		IN `in_model_id` int(10),
		IN `in_shock_brand_id` int(10),
		IN `in_fork_brand_id` int(10)
       )
BEGIN 
    DECLARE valid_bike_instance_id INT(10) default 0;

    call check_bike_instance(`in_year_id`,`in_model_id`,`in_shock_brand_id`,
	                       `in_fork_brand_id`,valid_bike_instance); 

    UPDATE work_order SET `bike`=valid_bike_instance WHERE row_id=`in_work_order_id`;
    FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_credit_card_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_credit_card_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_credit_card_info`(
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

    
    IF !(`in_name_on_card`="") THEN 
       
       
       
   
       call get_key(@the_key);
       SET @encrypted_name=AES_ENCRYPT(`in_name_on_card`,@the_key);
       SET @encrypted_card=AES_ENCRYPT(`in_number_on_card`,@the_key);
       SET @encrypted_security_code=AES_ENCRYPT(`in_security_code`,@the_key);
       SET @encrypted_expiration=AES_ENCRYPT(`in_expiration`,@the_key);

       
       call prepare_credit_card_account(@encrypted_card,@out_cc_id);

       UPDATE credit_card SET name=@encrypted_name WHERE row_id=@out_cc_id;
       UPDATE credit_card SET security_code=@encrypted_security_code WHERE row_id=@out_cc_id;
       UPDATE credit_card SET expiration=@encrypted_expiration WHERE row_id=@out_cc_id;

       UPDATE finance SET credit_card=@out_cc_id WHERE row_id=@valid_finance_id;
       ELSE
         UPDATE finance SET credit_card=NULL WHERE row_id=@valid_finance_id;
	  
   END IF;

  FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_finance_header_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_finance_header_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_finance_header_info`(
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
     
     UPDATE finance SET quote=substring(`in_quote_num`,1,10) WHERE work_order=@valid_work_order;
     UPDATE finance SET sales_order=substring(`in_sales_order`,1,10) WHERE work_order=@valid_work_order;
     UPDATE finance SET invoice=substring(`in_invoice_num`,1,10) WHERE work_order=@valid_work_order;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_fork_adjustments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_fork_adjustments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_fork_adjustments`(
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

     UPDATE fork_spec SET springs=`in_springs` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET comp_clicks=`in_comp` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET reb_clicks=`in_reb` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET oil_vol=`in_oil_vol` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET oil_height=`in_oil_height` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET oil_type=`in_oil_type` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET spring_length=`in_spring_length` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET chamber_length=`in_chamber_length` WHERE row_id=@valid_fork_spec;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_fork_arrival_settings`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_fork_arrival_settings`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_fork_arrival_settings`(
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

     UPDATE settings_on_arrival SET forks_leaking=`in_leaking` WHERE row_id=@valid_arrival_spec;

     UPDATE fork_spec SET springs=`in_spring` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET comp_clicks=`in_comp` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET reb_clicks=`in_reb` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET oil_vol=`in_oil_vol` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET oil_height=`in_oil_height` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET spring_length=`in_spring_length` WHERE row_id=@valid_fork_spec;
     UPDATE fork_spec SET chamber_length=`in_chamber_length` WHERE row_id=@valid_fork_spec;

     call get_work_order_for_setting(@valid_setting_id, @valid_work_order);
     call update_lookup_table(@valid_work_order);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_fork_comments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_fork_comments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_fork_comments`(
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_fork_comments_in_fork_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_fork_comments_in_fork_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_fork_comments_in_fork_spec`(
	       IN `in_fork_spec` int(20),
               IN `in_comments` varchar(5000)
       )
BEGIN
  UPDATE fork_spec SET comments=`in_comments` WHERE row_id=`in_fork_spec`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_fork_estimate`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_fork_estimate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_fork_estimate`(
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

     UPDATE estimate_fork SET labor=`in_labor` WHERE row_id=@valid_fork_estimate;
     UPDATE estimate_fork SET labor_discount=`in_labor_discount` WHERE row_id=@valid_fork_estimate;

     UPDATE estimate_fork SET fluid=`in_fluid` WHERE row_id=@valid_fork_estimate;
     UPDATE estimate_fork SET fluid_discount=`in_fluid_discount` WHERE row_id=@valid_fork_estimate;

     UPDATE estimate_fork SET springs=`in_springs` WHERE row_id=@valid_fork_estimate;
     UPDATE estimate_fork SET springs_discount=`in_springs_discount` WHERE row_id=@valid_fork_estimate;
					
     UPDATE estimate_fork SET parts=`in_parts` WHERE row_id=@valid_fork_estimate;
     UPDATE estimate_fork SET parts_discount=`in_parts_discount` WHERE row_id=@valid_fork_estimate;

     UPDATE estimate_fork SET coatings=`in_coatings` WHERE row_id=@valid_fork_estimate;
     UPDATE estimate_fork SET coatings_discount=`in_coatings_discount` WHERE row_id=@valid_fork_estimate;

     UPDATE estimate_fork SET other=`in_other` WHERE row_id=@valid_fork_estimate;
     UPDATE estimate_fork SET other_discount=`in_other_discount` WHERE row_id=@valid_fork_estimate;

     call save_fork_need_springs_info_for_work_order(`in_work_order`,`in_Need_Springs`,`in_rate`);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_fork_need_springs_info_for_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_fork_need_springs_info_for_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_fork_need_springs_info_for_work_order`(
	       IN `in_work_order` int(10),
	       IN `in_Need_Springs` int(1),
	       IN `in_rate` decimal(4,3)
               )
BEGIN
     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
     call prepare_need_springs(@valid_work_order,@valid_need_springs); 

     UPDATE need_springs SET need_fork_spring=`in_Need_Springs` WHERE work_order=`in_work_order`;
     UPDATE need_springs SET recommended_fork_spring=`in_rate` WHERE work_order=`in_work_order`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_overall_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_overall_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_overall_info`(
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

     
     UPDATE work_order SET call_prior=`in_Call_Prior_to_Work` WHERE row_id=@valid_work_order;
     UPDATE work_order SET ok_to_replace_bearing=`in_OK_to_Replace_Bearing` WHERE row_id=@valid_work_order;
     UPDATE work_order SET turn_around=`in_turn_around` WHERE row_id=@valid_work_order;

     
     UPDATE need_springs SET ok_to_replace=`in_OK_to_Replace` WHERE work_order=@valid_work_order;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_payment_method`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_payment_method`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_payment_method`(
	       IN `in_work_order` int(10),
               IN `in_payment_method_id` int(10)
       )
BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;

     SET @table_name="payment_method_combo"; 
     SET @col_name="payment_method";
 
     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);

     INSERT INTO payment_method_combo (work_order, payment_method) 
            VALUES (@valid_work_order,`in_payment_method_id`);
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_rider_settings_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_rider_settings_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_rider_settings_info`(
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

    UPDATE work_order SET rider_instance=@valid_rider_instance WHERE row_id=@valid_work_order;

    UPDATE work_order SET shop=`in_shop_id` WHERE row_id=@valid_work_order;
    UPDATE work_order SET service_location=`in_service_location_id` WHERE row_id=@valid_work_order;

    call update_lookup_table(@valid_work_order);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_riding_types`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_riding_types`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_riding_types`(
	       IN `in_work_order` int(10),
               IN `in_riding_type_id` int(10)
       )
BEGIN
   call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
   INSERT INTO riding_type_combo (work_order,riding_type) 
          VALUES (@valid_work_order,`in_riding_type_id`);

   call update_lookup_table(@valid_work_order);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_shipping_acct_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_shipping_acct_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_shipping_acct_info`(
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

     UPDATE shipping SET use_shipping_account=`in_use_shipping_account`
                                WHERE row_id=@valid_shipping_id;

     IF `in_use_shipping_account`=1 THEN
        
        call prepare_shipping_vendor(CONCAT(substring(`in_shipping_vendor_string`,1,3),"%"),@valid_vendor_id);
        call prepare_shipping_account(@valid_vendor_id,`in_shipping_method_account`,@valid_shipping_method_account_id);

        UPDATE shipping SET ship_method_account=@valid_shipping_method_account_id
                                   WHERE row_id=@valid_shipping_id;
	ELSE
           UPDATE shipping SET ship_method_account=null
                                      WHERE row_id=@valid_shipping_id;
     END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_shipping_address_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_shipping_address_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_shipping_address_info`(
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

     UPDATE shipping SET use_rider_shipping_address=`in_use_rider_address`
                                WHERE row_id=@valid_shipping_id;

     call check_address(`in_phone1`,`in_phone2`,`in_address1`,`in_address2`,
                        `in_address3`,`in_city`,`in_state`,`in_country`,`in_zip`,@valid_address); 
     UPDATE shipping SET ship_address=@valid_address
                                WHERE row_id=@valid_shipping_id;

     call update_lookup_table(@valid_work_order);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_shipping_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_shipping_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_shipping_info`(
	       IN `in_work_order` int(10),
	       IN `in_ship_method` int(10)
               )
BEGIN
     SET @valid_work_order=0;
     SET @valid_setting=0;
     SET @valid_shipping_id=0;

     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting); 
     call prepare_shipping(@valid_work_order,@valid_shipping_id); 
     UPDATE shipping SET ship_method=`in_ship_method` 
                                WHERE row_id=@valid_shipping_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_shock_adjustments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_shock_adjustments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_shock_adjustments`(
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

     UPDATE shock_spec SET springs=`in_springs` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET LS_comp_clicks=`in_LS_comp` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET HS_comp_turns=`in_HS_comp` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET reb_clicks=`in_reb` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET oil_type=`in_oil_type` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET nitrogen=`in_nitrogen` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET z_cut=`in_z_cut` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET sag=`in_sag` WHERE row_id=@valid_shock_spec;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_shock_arrival_settings`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_shock_arrival_settings`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_shock_arrival_settings`(
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
     
     call prepare_arrival_spec(@valid_setting_id,@valid_arrival_spec);
     
     call prepare_arrival_shock_spec(@valid_arrival_spec,@valid_shock_spec);
     

     UPDATE settings_on_arrival SET shock_leaking=`in_leaking` WHERE row_id=@valid_arrival_spec;

     UPDATE shock_spec SET springs=`in_spring` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET LS_comp_clicks=`in_LS_comp` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET HS_comp_turns=`in_HS_comp` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET reb_clicks=`in_reb` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET compressed_length=`in_compressed_length` WHERE row_id=@valid_shock_spec;
     UPDATE shock_spec SET free_length=`in_free_length` WHERE row_id=@valid_shock_spec;

     call get_work_order_for_setting(@valid_setting_id, @valid_work_order);
     call update_lookup_table(@valid_work_order);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_shock_comments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_shock_comments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_shock_comments`(
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_shock_comments_in_shock_spec`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_shock_comments_in_shock_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_shock_comments_in_shock_spec`(
	       IN `in_shock_spec` int(20),
               IN `in_comments` varchar(5000)
       )
BEGIN
  UPDATE shock_spec SET comments=`in_comments` WHERE row_id=`in_shock_spec`; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_shock_estimate`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_shock_estimate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_shock_estimate`(
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

     UPDATE estimate_shock SET labor=`in_labor` WHERE row_id=@valid_shock_estimate;
     UPDATE estimate_shock SET labor_discount=`in_labor_discount` WHERE row_id=@valid_shock_estimate;

     UPDATE estimate_shock SET fluid=`in_fluid` WHERE row_id=@valid_shock_estimate;
     UPDATE estimate_shock SET fluid_discount=`in_fluid_discount` WHERE row_id=@valid_shock_estimate;

     UPDATE estimate_shock SET springs=`in_springs` WHERE row_id=@valid_shock_estimate;
     UPDATE estimate_shock SET springs_discount=`in_springs_discount` WHERE row_id=@valid_shock_estimate;
					
     UPDATE estimate_shock SET parts=`in_parts` WHERE row_id=@valid_shock_estimate;
     UPDATE estimate_shock SET parts_discount=`in_parts_discount` WHERE row_id=@valid_shock_estimate;

     UPDATE estimate_shock SET coatings=`in_coatings` WHERE row_id=@valid_shock_estimate;
     UPDATE estimate_shock SET coatings_discount=`in_coatings_discount` WHERE row_id=@valid_shock_estimate;

     UPDATE estimate_shock SET other=`in_other` WHERE row_id=@valid_shock_estimate;
     UPDATE estimate_shock SET other_discount=`in_other_discount` WHERE row_id=@valid_shock_estimate;

     call save_shock_need_springs_info_for_work_order(`in_work_order`,`in_Need_Springs`,`in_rate`);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_shock_need_springs_info_for_work_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_shock_need_springs_info_for_work_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_shock_need_springs_info_for_work_order`(
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

     UPDATE need_springs SET need_shock_spring=`in_Need_Springs` WHERE work_order=@valid_work_order;
     UPDATE need_springs SET recommended_shock_spring=`in_rate` WHERE work_order=@valid_work_order;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_standard_work`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_standard_work`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_standard_work`(
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
        SET @table_name="fork_work_combo"; 
        SET @col_name="fork_work";
     END IF;

     IF (`in_type`="Shock") THEN
        SET @table_name="shock_work_combo"; 
        SET @col_name="shock_work";
     END IF;

     SET @syntax=CONCAT("  INSERT INTO ", @table_name, " (work_order, ", @col_name,", comments) ",
                        "  VALUES (",@valid_work_order,",",`in_product_id`,",",`in_comments`,");"
                       );
     
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;
     FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `save_terrain`
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_terrain`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_terrain`(
	       IN `in_work_order` int(10),
               IN `in_terrain_id` int(10)
       )
BEGIN
   SET @valid_work_order=0;
   SET @valid_setting=0;

   call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
   INSERT INTO terrain_combo (work_order,terrain) 
          VALUES (@valid_work_order,`in_terrain_id`);

   call update_lookup_table(@valid_work_order);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `seed_db`
-- ----------------------------
DROP PROCEDURE IF EXISTS `seed_db`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `seed_db`(
		IN `in_work_order` int (10),
		IN `in_size` int (10)
                 )
BEGIN
    DECLARE count INT default 0;
    REPEAT       
        call quiet_clone_work_order(`in_work_order`,"New Spec","Dont Revise");  
    	SET count=count+1;
    UNTIL count=`in_size`
    END REPEAT;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `unique_collar_width_insert`
-- ----------------------------
DROP PROCEDURE IF EXISTS `unique_collar_width_insert`;
DELIMITER ;;
CREATE DEFINER=`tom`@`` PROCEDURE `unique_collar_width_insert`(
               IN `in_measure` decimal(3,2)
              )
BEGIN
   DECLARE existing_measure int(10); 
   DECLARE no_rows_found INT DEFAULT 0;
   DECLARE measure_cursor CURSOR FOR
		SELECT row_id FROM collar_width
			      WHERE measure=`in_measure`; 
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
    OPEN measure_cursor;
      FETCH measure_cursor into existing_measure;
    CLOSE measure_cursor; 
    
    IF existing_measure<=>NULL THEN
       
       INSERT INTO collar_width (measure) VALUES(`in_measure`); 
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `unique_shim_OD_insert`
-- ----------------------------
DROP PROCEDURE IF EXISTS `unique_shim_OD_insert`;
DELIMITER ;;
CREATE DEFINER=`tom`@`` PROCEDURE `unique_shim_OD_insert`(
               IN `in_measure` decimal(3,2)
              )
BEGIN
   DECLARE existing_measure int(10); 
   DECLARE no_rows_found INT DEFAULT 0;
   DECLARE measure_cursor CURSOR FOR
		SELECT row_id FROM shim_outer_diameter
			      WHERE measure=`in_measure`; 
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
    OPEN measure_cursor;
      FETCH measure_cursor into existing_measure;
    CLOSE measure_cursor; 
    
    IF existing_measure<=>NULL THEN
       
       INSERT INTO shim_outer_diameter (measure) VALUES(`in_measure`); 
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `unique_spring_length_insert`
-- ----------------------------
DROP PROCEDURE IF EXISTS `unique_spring_length_insert`;
DELIMITER ;;
CREATE DEFINER=`tom`@`` PROCEDURE `unique_spring_length_insert`(
               IN `in_measure` int(10)
              )
BEGIN
   DECLARE existing_measure int(10); 
   DECLARE no_rows_found INT DEFAULT 0;
   DECLARE measure_cursor CURSOR FOR
		SELECT row_id FROM spring_length
			      WHERE measure=`in_measure`; 
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 
    OPEN measure_cursor;
      FETCH measure_cursor into existing_measure;
    CLOSE measure_cursor; 
    
    IF existing_measure<=>NULL THEN
       
       INSERT INTO spring_length (measure) VALUES(`in_measure`); 
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `update_address`
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_address`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_address`(
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
	   SELECT address FROM rider WHERE row_id=`in_rider`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1; 
   SET @out_address=0;


   OPEN address_cursor;
 	 FETCH address_cursor into existing_address; 
   CLOSE address_cursor; 

   IF existing_address<=>NULL THEN
	
        call check_address(`in_phone1`,`in_phone2`,
		             `in_address1`,`in_address2`, `in_address3`,
			     `in_city`,`in_state`,`in_country`, 
			      `in_zip`,@out_address);
        UPDATE rider SET address=@out_address WHERE row_id=`in_rider`;
	
	ELSE
	UPDATE address SET phone1=`in_phone1` WHERE row_id=existing_address;
	UPDATE address SET phone2=`in_phone2` WHERE row_id=existing_address;
        UPDATE address SET address1=`in_address1` WHERE row_id=existing_address;
	UPDATE address SET address2=`in_address2` WHERE row_id=existing_address;
	UPDATE address SET address3=`in_address3` WHERE row_id=existing_address;
	UPDATE address SET city=`in_city` WHERE row_id=existing_address;
	UPDATE address SET state_province=`in_state` WHERE row_id=existing_address;
	UPDATE address SET country=`in_country` WHERE row_id=existing_address;
	UPDATE address SET zip=`in_zip` WHERE row_id=existing_address;
   END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `update_comments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_comments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_comments`(
               IN `in_comments_id` varchar(5000),
               IN `in_comments` varchar(5000)
       )
BEGIN
     DECLARE old_comment varchar(5000); 
     DECLARE cur1 CURSOR FOR
                         SELECT comments from comments
			        where row_id=`in_comments_id`;
     OPEN cur1;
      FETCH cur1 into old_comment;
     CLOSE cur1; 
     SET @old_length=LENGTH(old_comment);
     SET @new_length=LENGTH(`in_comments`); 
     
     IF @new_length > @old_length THEN
        SET @date=curdate();
        SET @time=curtime();
        SET @new_comments=concat(`in_comments`," -- ",@date,"  ",@time);
       UPDATE comments SET comments=(@new_comments) 
            WHERE row_id=`in_comments_id`;
    END IF;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `update_fork_general_comments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_fork_general_comments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_fork_general_comments`(
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
  		FROM   fork_spec as SPEC 
		       LEFT JOIN fork_spec_general_info AS INFO
		 	    ON SPEC.general_info=INFO.row_id		
   		WHERE 
	 		SPEC.row_id =`in_fork_spec_id`;

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

      
     OPEN id_cursor;
       FETCH id_cursor into info_id, info;
     CLOSE id_cursor; 

     SET @date=curdate();
     SET @time=curtime();

      
     IF (info <=> NULL ) AND (LENGTH(`in_info`)>0) THEN
	 
         
	 INSERT INTO fork_spec_general_info (general_info) VALUES (`in_info`);
         UPDATE fork_spec SET general_info=LAST_INSERT_ID() WHERE row_id=`in_fork_spec_id`; 
         ELSEIF LENGTH(info)!=LENGTH(`in_info`) AND (LENGTH(`in_info`)>0) THEN
	           
                    
                   UPDATE fork_spec_general_info SET general_info=`in_info` WHERE row_id=`info_id`; 
                   ELSEIF (LENGTH(`in_info`)=0) THEN
                   UPDATE fork_spec_general_info SET general_info=NULL WHERE row_id=`info_id`; 
     END IF;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `update_lookup_table`
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_lookup_table`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_lookup_table`(
               IN `in_work_order_id` int(10)
       )
BEGIN
     
     DELETE FROM lookup_table WHERE work_order=`in_work_order_id`;
     SET @rider_id=null;
     SET @ability_id=null;
     SET @ability=null;
     SET @first_name=null;
     SET @last_name=null;
     SET @year_id=null;
     SET @year=null;
     SET @model_id=null;
     SET @model=null;
     SET @brand=null;
     SET @setting_id=null;
     SET @date=null;
     SET @service_location=null;
     SET @terrain=null;
     SET @riding_type=null;
     SET @shock_revision_number=null;
     SET @fork_revision_number=null;
     
     call find_rider(`in_work_order_id`, @rider_id,@ability_id,@first_name, @last_name,@ability);
     call find_bike(`in_work_order_id`, @year_id, @model_id,@year,@brand,@model);
     call find_setting_info(`in_work_order_id`,@setting_id,@date);
     call find_service_location(`in_work_order_id`,@service_location);
     call find_terrain(`in_work_order_id`,@terrain);
     call find_riding_type(`in_work_order_id`,@riding_type);
     call find_revision(`in_work_order_id`,@shock_revision_number, @fork_revision_number);
     INSERT INTO lookup_table(work_order,setting_id,rider_id,first_name,last_name,
                                         ability_id,ability,
                                         year_id,year,
                                         model_id,brand,model,
                                         shock_rev, 
                                         fork_rev,
                                         date,
                                         service_location,
                                         terrain,
                                         riding_type)
                                VALUES (`in_work_order_id`,@setting_id,@rider_id,@first_name,@last_name,
                                        @ability_id,@ability,
                                        @year_id,@year,
                                        @model_id,@brand,@model,
                                        @shock_revision_number, 
                                        @fork_revision_number, 
                                        @date,
                                        @service_location,
                                        @terrain,
                                        @riding_type);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `update_shock_general_comments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_shock_general_comments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_shock_general_comments`(
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
               shock_spec as SPEC 
	       LEFT JOIN shock_spec_general_info AS INFO
		       ON SPEC.general_info=INFO.row_id	
             WHERE 
	        SPEC.row_id =`in_shock_spec_id`;

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

      
     OPEN id_cursor;
       FETCH id_cursor into info_id, info;
     CLOSE id_cursor; 

     SET @date=curdate();
     SET @time=curtime();

      
     IF (info <=> NULL ) AND (LENGTH(`in_info`)>0) THEN
	 
         
	 INSERT INTO shock_spec_general_info (general_info) VALUES (`in_info`);
         UPDATE shock_spec SET general_info=LAST_INSERT_ID() WHERE row_id=`in_shock_spec_id`; 
         ELSEIF LENGTH(info)!=LENGTH(`in_info`) AND (LENGTH(`in_info`)>0) THEN
	           
                   
                   UPDATE shock_spec_general_info SET general_info=`in_info` WHERE row_id=`info_id`;
                   ELSEIF (LENGTH(`in_info`)=0) THEN
                   UPDATE shock_spec_general_info SET general_info=NULL WHERE row_id=`info_id`; 
     END IF;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `update_support_comments`
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_support_comments`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_support_comments`(
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
  				work_order
			        where row_id=`in_work_order_id`;

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

     
     OPEN id_cursor;
       FETCH id_cursor into cust_comments, tech_comments;
     CLOSE id_cursor; 

     SET @date=curdate();
     SET @time=curtime();

      
     IF (cust_comments <=> NULL ) AND (LENGTH(`in_cust_comments`)>0) THEN
         SET @new_cust_comments=concat(`in_cust_comments`," -- ",@date,"  ",@time);
         UPDATE work_order SET customer_comments=@new_cust_comments WHERE row_id=`in_work_order_id`; 
         ELSEIF  LENGTH(cust_comments)!=LENGTH(`in_cust_comments`)  THEN
                   SET @new_cust_comments=concat(`in_cust_comments`," -- ",@date,"  ",@time);
                   UPDATE work_order SET customer_comments=@new_cust_comments WHERE row_id=`in_work_order_id`; 
     END IF;


      
     IF (tech_comments <=> NULL  ) AND (LENGTH(`in_tech_comments`)>0) THEN
            SET @new_tech_comments=concat(`in_tech_comments`," -- ",@date,"  ",@time);
            UPDATE work_order SET tech_support_comments=@new_tech_comments WHERE row_id=`in_work_order_id`; 
            ELSEIF  LENGTH(tech_comments)!=LENGTH(`in_tech_comments`)  THEN
                   SET @new_tech_comments=concat(`in_tech_comments`," -- ",@date,"  ",@time);
                   UPDATE work_order SET tech_support_comments=@new_tech_comments WHERE row_id=`in_work_order_id`; 
     END IF;
   FLUSH QUERY CACHE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `work_order_is_editable`
-- ----------------------------
DROP PROCEDURE IF EXISTS `work_order_is_editable`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `work_order_is_editable`(
               IN `in_work_order` int(10)
              )
BEGIN
   DECLARE existing_work_order int(10); 
   DECLARE response int(1) DEFAULT 0; 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE work_order_cursor CURSOR FOR
                     SELECT work_order FROM open_work_orders 
                                       WHERE work_order =`in_work_order`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; 

   OPEN work_order_cursor;
        FETCH work_order_cursor into existing_work_order;
   CLOSE work_order_cursor; 


   
   
   IF existing_work_order<=>NULL THEN
      SET response=1;
      ELSE
      SET response=0;
   END IF;
   SELECT response;
END
;;
DELIMITER ;
