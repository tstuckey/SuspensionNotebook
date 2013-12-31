/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
use suspension;
delimiter &
/*------------------------------------------------*/



DROP PROCEDURE IF EXISTS suspension.export_work_order;
CREATE PROCEDURE suspension.export_work_order(
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


  /*To generate an export script with the minimum exposure of the schema,
    the export script will be a script with a bunch of calls in the form
    call import_***(x,y,...n) where the parameters are filled in with values from the
    exporting db*/

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

 /*Initialize the user vairables in the MySQL statement to be returned*/
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

END;


DROP PROCEDURE IF EXISTS suspension.import_create_new_work_order;
CREATE PROCEDURE suspension.import_create_new_work_order(
		OUT `imp_work_order` int(10),
		OUT `imp_setting` int(10),
		OUT `imp_shock_spec` int(20),
		OUT `imp_fork_spec` int(20)
              )
BEGIN
  call prepare_work_order(0,imp_work_order,imp_setting);/*create an empty work order*/
  call prepare_shock_spec(imp_setting,imp_shock_spec); /*create an empty shock spec for this work order*/
  call prepare_fork_spec(imp_setting,imp_fork_spec);   /*create an empty fork spec for this work order*/
  call update_lookup_table(imp_work_order);            /*update the lookup table with this new entry*/
END;


DROP PROCEDURE IF EXISTS suspension.export_get_top_level_of_work_order;
CREATE PROCEDURE suspension.export_get_top_level_of_work_order(
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
                    FROM suspension.work_order 
	            WHERE row_id=`exp_work_order`;
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/
 
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
END;


DROP PROCEDURE IF EXISTS suspension.import_top_level_of_work_order;
CREATE PROCEDURE suspension.import_top_level_of_work_order(
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
  UPDATE suspension.work_order SET service_location=`exp_service_location`             WHERE row_id=`imp_work_order`;
  UPDATE suspension.work_order SET shop=`exp_shop`                                     WHERE row_id=`imp_work_order`;
  UPDATE suspension.work_order SET rider_instance=`exp_rider_instance`                 WHERE row_id=`imp_work_order`;
  UPDATE suspension.work_order SET bike=`exp_bike`                                     WHERE row_id=`imp_work_order`;
  UPDATE suspension.work_order SET customer_comments=`exp_customer_comments`           WHERE row_id=`imp_work_order`;
  UPDATE suspension.work_order SET tech_support_comments=`exp_tech_support_comments`   WHERE row_id=`imp_work_order`;
  UPDATE suspension.work_order SET call_prior=`exp_call_prior`                         WHERE row_id=`imp_work_order`;
  UPDATE suspension.work_order SET ok_to_replace_bearing=`exp_ok_to_replace_bearing`   WHERE row_id=`imp_work_order`;
  UPDATE suspension.work_order SET turn_around=`exp_turnaround`                        WHERE row_id=`imp_work_order`;
  UPDATE suspension.work_order SET referrer= `exp_referrer`                            WHERE row_id=`imp_work_order`;
END;





/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
&
delimiter ;
/*------------------------------------------------*/
