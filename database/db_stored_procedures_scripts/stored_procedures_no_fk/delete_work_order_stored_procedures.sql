/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
use suspension;
delimiter &
/*------------------------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*These procedure delete the given work_order*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

/*This procedure returns the fork spec and shock spec for a given setting*/
DROP PROCEDURE IF EXISTS suspension.get_setting_to_delete_info;
CREATE PROCEDURE suspension.get_setting_to_delete_info(
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
	 SELECT settings_on_arrival,fork_spec, shock_spec FROM suspension.setting
			WHERE row_id=`in_setting`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     OPEN setting_info_cursor;
       /*FETCH setting_info_cursor into settings_on_arrival,fork_spec,shock_spec;*/
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
END;

DROP PROCEDURE IF EXISTS suspension.get_setting_to_delete;
CREATE PROCEDURE suspension.get_setting_to_delete(
               IN `in_work_order` int(10), 
	       OUT `out_setting` int(10)
              )
BEGIN
     DECLARE setting_id int(10); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE setting_cursor CURSOR FOR
	 SELECT setting FROM suspension.work_order
			WHERE row_id=`in_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
     OPEN setting_cursor;
       FETCH setting_cursor into setting_id;
     CLOSE setting_cursor; 

     IF setting_id <=> NULL THEN
         SET `out_setting`=0;
        ELSE
         SET `out_setting`=setting_id;
     END IF;
END;

/*This procedure returns the fork spec and shock spec for a given setting*/
DROP PROCEDURE IF EXISTS suspension.get_settings_on_arrival_to_delete_info;
CREATE PROCEDURE suspension.get_settings_on_arrival_to_delete_info(
               IN `in_settings_on_arrival` int(10), 
	       OUT `out_fork_spec` int(20),
	       OUT `out_shock_spec` int(20)
              )
BEGIN
     DECLARE fork_spec_id int(10); 
     DECLARE shock_spec_id int(10); 

     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE setting_info_cursor CURSOR FOR
	 SELECT fork_spec, shock_spec FROM suspension.settings_on_arrival
			WHERE row_id=`in_settings_on_arrival`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
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
END;

DROP PROCEDURE IF EXISTS suspension.delete_settings_on_arrival;
CREATE PROCEDURE suspension.delete_settings_on_arrival(
               IN  `in_settings_on_arrival` int(20) 
              )
BEGIN
     SET @arrival_shock_spec=0;
     SET @arrival_fork_spec=0;
     call get_settings_on_arrival_to_delete_info(`in_settings_on_arrival`,@arrival_fork_spec,@arrival_shock_spec);

     /*for settings_on_arrival, we only have to delete the fork and shock specs themselves*/
     /*since there are no valve stacks associated with them*/
     DELETE FROM suspension.fork_spec 
	    WHERE row_id=@arrival_fork_spec;

     DELETE FROM suspension.shock_spec 
	    WHERE row_id=@arrival_shock_spec;

     DELETE FROM suspension.settings_on_arrival
	    WHERE row_id=`in_settings_on_arrival`;
END;

DROP PROCEDURE IF EXISTS suspension.delete_fork_spec;
CREATE PROCEDURE suspension.delete_fork_spec(
               IN  `in_fork_spec` int(20) 
              )
BEGIN
     DELETE FROM suspension.fork_spec 
	    WHERE row_id=`in_fork_spec`;

     DELETE FROM suspension.fork_bcv_stack 
	    WHERE fork_spec=`in_fork_spec`;

     DELETE FROM suspension.fork_compression_stack 
	    WHERE fork_spec=`in_fork_spec`;

     DELETE FROM suspension.fork_lsv_stack 
	    WHERE fork_spec=`in_fork_spec`;

     DELETE FROM suspension.fork_lsv_stack 
	    WHERE fork_spec=`in_fork_spec`;
END;

DROP PROCEDURE IF EXISTS suspension.delete_shock_spec;
CREATE PROCEDURE suspension.delete_shock_spec(
               IN  `in_shock_spec` int(20) 
              )
BEGIN
     DELETE FROM suspension.shock_spec 
	    WHERE row_id=`in_shock_spec`;

     DELETE FROM suspension.shock_compression_stack 
	    WHERE shock_spec=`in_shock_spec`;

     DELETE FROM suspension.shock_rebound_stack 
	    WHERE shock_spec=`in_shock_spec`;

     DELETE FROM suspension.shock_compression_adjuster_stack 
	    WHERE shock_spec=`in_shock_spec`;
END;


DROP PROCEDURE IF EXISTS suspension.delete_setting;
CREATE PROCEDURE suspension.delete_setting(
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

   DELETE FROM suspension.setting
 	  WHERE row_id=@setting;
END;

/*This procedure returns the estimate_fork, estimate_shock, and credit_card of a finance entry*/
DROP PROCEDURE IF EXISTS suspension.get_finance_to_delete_info;
CREATE PROCEDURE suspension.get_finance_to_delete_info(
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
	 SELECT estimate_fork,estimate_shock,credit_card FROM suspension.finance
			WHERE work_order=`in_work_order`; 

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
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
END;

DROP PROCEDURE IF EXISTS suspension.delete_finance;
CREATE PROCEDURE suspension.delete_finance(
               IN `in_work_order` int(10)
              )
BEGIN
   SET @estimate_fork=0;
   SET @estimate_shock=0;
   SET @credit_card=0;

   call get_finance_to_delete_info(`in_work_order`,@estimate_fork,@estimate_shock, @credit_card);

   DELETE FROM suspension.estimate_fork
 	  WHERE row_id=@estimate_fork;
   DELETE FROM suspension.estimate_shock
 	  WHERE row_id=@estimate_shock;
   DELETE FROM suspension.credit_card
 	  WHERE row_id=@credit_card;

   DELETE FROM suspension.finance
 	  WHERE work_order=`in_work_order`;
END;


DROP PROCEDURE IF EXISTS suspension.delete_work_order;
CREATE PROCEDURE suspension.delete_work_order(
               IN `in_work_order` int(10) 
              )
BEGIN
  call delete_setting(`in_work_order`);
  call delete_other_work_order_records(`in_work_order`);
  call delete_finance(`in_work_order`);

  /*Go ahead and delete the work_order*/	
  DELETE FROM suspension.work_order
	 WHERE row_id=`in_work_order`;
END;

DROP PROCEDURE IF EXISTS suspension.delete_other_work_order_records;
CREATE PROCEDURE suspension.delete_other_work_order_records(
               IN `in_work_order` int(10) 
              )
BEGIN
     DELETE FROM suspension.riding_type_combo 
	    WHERE work_order=`in_work_order`;

     DELETE FROM suspension.terrain_combo 
 	    WHERE work_order=`in_work_order`;

     DELETE FROM suspension.fork_work_combo
 	    WHERE work_order=`in_work_order`;

     DELETE  FROM suspension.fork_additional_services_combo
	    WHERE work_order=`in_work_order`;

     DELETE FROM suspension.shock_work_combo
	    WHERE work_order=`in_work_order`;

     DELETE FROM suspension.shock_additional_services_combo
	    WHERE work_order=`in_work_order`;

     DELETE FROM suspension.payment_method_combo
	    WHERE work_order=`in_work_order`;

     DELETE FROM suspension.shipping
            WHERE work_order=`in_work_order`;

     DELETE FROM suspension.need_springs
	    WHERE work_order=`in_work_order`;
END;

/*--------------------------------------------------------------------------*/


/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
&
delimiter ;
/*------------------------------------------------*/

