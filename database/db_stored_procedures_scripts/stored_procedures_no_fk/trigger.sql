/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
use suspension;
delimiter &
/*------------------------------------------------*/


/* This trigger is not needed since the update trigger will update
   the lookup_table given the logic in the clone_work_order stored procedure
*/

DROP TRIGGER IF EXISTS suspension.delete_lookup_trigger;
CREATE TRIGGER delete_lookup_trigger AFTER DELETE ON suspension.work_order 
  FOR EACH ROW BEGIN
     DELETE FROM suspension.lookup_table WHERE work_order=OLD.row_id;
  END;


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*The Find Setting Stored Procedure*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DROP PROCEDURE IF EXISTS suspension.update_lookup_table;
CREATE PROCEDURE suspension.update_lookup_table(
               IN `in_work_order_id` int(10)
       )
BEGIN
     /*delete the old lookup entry*/
     DELETE FROM suspension.lookup_table WHERE work_order=`in_work_order_id`;

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

     /*build a new lookup entry*/
     call find_rider(`in_work_order_id`, @rider_id,@ability_id,@first_name, @last_name,@ability);
     call find_bike(`in_work_order_id`, @year_id, @model_id,@year,@brand,@model);
     call find_setting_info(`in_work_order_id`,@setting_id,@date);
     call find_service_location(`in_work_order_id`,@service_location);
     call find_terrain(`in_work_order_id`,@terrain);
     call find_riding_type(`in_work_order_id`,@riding_type);
     call find_revision(`in_work_order_id`,@shock_revision_number, @fork_revision_number);
     INSERT INTO suspension.lookup_table(work_order,setting_id,rider_id,first_name,last_name,
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
END;

/*------------------------------------------------*/
/*Overhead to facilitate loading from command line*/
&
delimiter ;
/*------------------------------------------------*/



