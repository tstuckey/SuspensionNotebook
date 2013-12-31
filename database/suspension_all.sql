/*
MySQL Data Transfer
Source Host: 192.168.1.100
Source Database: suspension
Target Host: 192.168.1.100
Target Database: suspension
Date: 3/16/2008 7:06:30 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for address
-- ----------------------------
CREATE TABLE `address` (
  `row_id` int(10) NOT NULL auto_increment,
  `address1` varchar(100) default NULL,
  `address2` varchar(100) default NULL,
  `address3` varchar(100) default NULL,
  `city` varchar(100) default NULL,
  `state_province` varchar(50) default NULL,
  `country` varchar(10) default NULL,
  `zip` varchar(50) default NULL,
  `phone1` varchar(50) default NULL,
  `phone2` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for basic_info
-- ----------------------------
CREATE TABLE `basic_info` (
  `row_id` int(10) NOT NULL auto_increment,
  `some_stuff` varchar(100) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bcv_shim_thickness
-- ----------------------------
CREATE TABLE `bcv_shim_thickness` (
  `row_id` int(10) NOT NULL auto_increment,
  `measure` decimal(4,3) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bike
-- ----------------------------
CREATE TABLE `bike` (
  `row_id` int(10) NOT NULL auto_increment,
  `bike_year` int(10) default NULL,
  `bike_brand_model` int(10) default NULL,
  `fork_brand` int(10) default NULL,
  `shock_brand` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bike_brand_model
-- ----------------------------
CREATE TABLE `bike_brand_model` (
  `row_id` int(10) NOT NULL auto_increment,
  `brand` varchar(30) default NULL,
  `model` varchar(30) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bike_year
-- ----------------------------
CREATE TABLE `bike_year` (
  `row_id` int(10) NOT NULL auto_increment,
  `year` int(4) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
CREATE TABLE `comments` (
  `row_id` int(10) NOT NULL auto_increment,
  `comments` varchar(5000) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `comment_index` (`comments`(767)),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for credit_card
-- ----------------------------
CREATE TABLE `credit_card` (
  `row_id` int(10) NOT NULL auto_increment,
  `name` blob,
  `number` blob,
  `security_code` blob,
  `expiration` blob,
  `address` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for days
-- ----------------------------
CREATE TABLE `days` (
  `row_id` int(10) NOT NULL auto_increment,
  `num_days` varchar(8) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for estimate_fork
-- ----------------------------
CREATE TABLE `estimate_fork` (
  `row_id` int(10) NOT NULL auto_increment,
  `labor` decimal(8,2) default NULL,
  `labor_discount` varchar(4) default NULL,
  `fluid` decimal(8,2) default NULL,
  `fluid_discount` varchar(4) default NULL,
  `springs` decimal(8,2) default NULL,
  `springs_discount` varchar(4) default NULL,
  `parts` decimal(8,2) default NULL,
  `parts_discount` varchar(4) default NULL,
  `coatings` decimal(8,2) default NULL,
  `coatings_discount` varchar(4) default NULL,
  `other` decimal(8,2) default NULL,
  `other_discount` varchar(4) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for estimate_shock
-- ----------------------------
CREATE TABLE `estimate_shock` (
  `row_id` int(10) NOT NULL auto_increment,
  `labor` decimal(8,2) default NULL,
  `labor_discount` varchar(4) default NULL,
  `fluid` decimal(8,2) default NULL,
  `fluid_discount` varchar(4) default NULL,
  `springs` decimal(8,2) default NULL,
  `springs_discount` varchar(4) default NULL,
  `parts` decimal(8,2) default NULL,
  `parts_discount` varchar(4) default NULL,
  `coatings` decimal(8,2) default NULL,
  `coatings_discount` varchar(4) default NULL,
  `other` decimal(8,2) default NULL,
  `other_discount` varchar(4) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for finance
-- ----------------------------
CREATE TABLE `finance` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `estimate_fork` int(10) default NULL,
  `estimate_shock` int(10) default NULL,
  `time_estimate` int(2) default NULL,
  `quote` varchar(10) default NULL,
  `sales_order` varchar(10) default NULL,
  `invoice` varchar(10) default NULL,
  `include_shipping` int(1) default NULL,
  `total_charges` decimal(10,2) default NULL,
  `credit_card` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_additional_products
-- ----------------------------
CREATE TABLE `fork_additional_products` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(250) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_additional_products_combo
-- ----------------------------
CREATE TABLE `fork_additional_products_combo` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `fork_additional_products` int(10) default NULL,
  `comments` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_additional_services
-- ----------------------------
CREATE TABLE `fork_additional_services` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_additional_services_combo
-- ----------------------------
CREATE TABLE `fork_additional_services_combo` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `fork_additional_services` int(10) default NULL,
  `comments` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_bcv_stack
-- ----------------------------
CREATE TABLE `fork_bcv_stack` (
  `row_id` int(20) NOT NULL auto_increment,
  `fork_spec` int(20) default NULL,
  `position` int(2) default NULL,
  `collar_width` decimal(5,3) default NULL,
  `rebound_piston_tower` decimal(5,3) default NULL,
  `spring_cup` decimal(5,3) default NULL,
  `shim_inner_diameter` decimal(5,3) default NULL,
  `shim_outer_diameter` decimal(5,3) default NULL,
  `shim_thickness` decimal(5,3) default NULL,
  `quantity` int(2) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_compression_stack
-- ----------------------------
CREATE TABLE `fork_compression_stack` (
  `row_id` int(20) NOT NULL auto_increment,
  `fork_spec` int(20) default NULL,
  `position` int(2) default NULL,
  `shim_inner_diameter` decimal(5,3) default NULL,
  `shim_outer_diameter` decimal(5,3) default NULL,
  `shim_thickness` decimal(5,3) default NULL,
  `quantity` int(2) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=586 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_lsv_stack
-- ----------------------------
CREATE TABLE `fork_lsv_stack` (
  `row_id` int(20) NOT NULL auto_increment,
  `fork_spec` int(20) default NULL,
  `position` int(2) default NULL,
  `shim_inner_diameter` decimal(5,3) default NULL,
  `shim_outer_diameter` decimal(5,3) default NULL,
  `shim_thickness` decimal(5,3) default NULL,
  `quantity` int(2) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_rebound_stack
-- ----------------------------
CREATE TABLE `fork_rebound_stack` (
  `row_id` int(20) NOT NULL auto_increment,
  `fork_spec` int(20) default NULL,
  `position` int(2) default NULL,
  `shim_inner_diameter` decimal(5,3) default NULL,
  `shim_outer_diameter` decimal(5,3) default NULL,
  `shim_thickness` decimal(5,3) default NULL,
  `quantity` int(2) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=380 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_spec
-- ----------------------------
CREATE TABLE `fork_spec` (
  `row_id` int(20) NOT NULL auto_increment,
  `revision_number` decimal(5,2) default '1.00',
  `springs` decimal(4,3) default NULL,
  `comp_clicks` int(2) default NULL,
  `reb_clicks` int(2) default NULL,
  `spring_length` int(4) default NULL,
  `chamber_length` int(4) default NULL,
  `oil_vol` int(3) default NULL,
  `oil_height` int(3) default NULL,
  `oil_type` varchar(10) default NULL,
  `general_info` int(10) default NULL,
  `comments` varchar(5000) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_spec_general_info
-- ----------------------------
CREATE TABLE `fork_spec_general_info` (
  `row_id` int(10) NOT NULL auto_increment,
  `general_info` varchar(5000) default NULL,
  PRIMARY KEY  (`row_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_work
-- ----------------------------
CREATE TABLE `fork_work` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fork_work_combo
-- ----------------------------
CREATE TABLE `fork_work_combo` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `fork_work` int(10) default NULL,
  `comments` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for lookup_table
-- ----------------------------
CREATE TABLE `lookup_table` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `setting_id` int(10) default NULL,
  `rider_id` int(10) default NULL,
  `first_name` varchar(100) default NULL,
  `last_name` varchar(100) default NULL,
  `ability_id` int(10) default NULL,
  `ability` varchar(100) default NULL,
  `year_id` int(10) default NULL,
  `year` varchar(100) default NULL,
  `model_id` int(10) default NULL,
  `brand` varchar(100) default NULL,
  `model` varchar(100) default NULL,
  `shock_rev` varchar(100) default NULL,
  `fork_rev` varchar(100) default NULL,
  `date` varchar(100) default NULL,
  `service_location` varchar(100) default NULL,
  `terrain` varchar(500) default NULL,
  `riding_type` varchar(500) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`),
  KEY `rider_id` (`rider_id`),
  KEY `year_id` (`year_id`),
  KEY `model_id` (`model_id`),
  KEY `ability_id` (`ability_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5794 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for need_springs
-- ----------------------------
CREATE TABLE `need_springs` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `need_shock_spring` int(1) default NULL,
  `recommended_shock_spring` decimal(4,3) default NULL,
  `need_fork_spring` int(1) default NULL,
  `recommended_fork_spring` decimal(4,3) default NULL,
  `ok_to_replace` int(1) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for open_work_orders
-- ----------------------------
CREATE TABLE `open_work_orders` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `usr_name` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for payment_method
-- ----------------------------
CREATE TABLE `payment_method` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for payment_method_combo
-- ----------------------------
CREATE TABLE `payment_method_combo` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `payment_method` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for preload
-- ----------------------------
CREATE TABLE `preload` (
  `row_id` int(10) NOT NULL auto_increment,
  `measure` int(3) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for referrer
-- ----------------------------
CREATE TABLE `referrer` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(100) default NULL,
  `comments` varchar(1000) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for rider
-- ----------------------------
CREATE TABLE `rider` (
  `row_id` int(6) NOT NULL auto_increment,
  `support_id` varchar(10) default NULL,
  `first_name` varchar(100) default NULL,
  `last_name` varchar(100) default NULL,
  `address` int(10) default NULL,
  `rider_phone1` varchar(50) default NULL,
  `rider_phone2` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for rider_ability
-- ----------------------------
CREATE TABLE `rider_ability` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(30) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for rider_height
-- ----------------------------
CREATE TABLE `rider_height` (
  `row_id` int(10) NOT NULL auto_increment,
  `height_in` int(3) default NULL,
  `height_cm` int(3) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for rider_instance
-- ----------------------------
CREATE TABLE `rider_instance` (
  `row_id` int(10) NOT NULL auto_increment,
  `rider` int(10) default NULL,
  `rider_weight` int(10) default NULL,
  `rider_ability` int(10) default NULL,
  `rider_height` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for rider_weight
-- ----------------------------
CREATE TABLE `rider_weight` (
  `row_id` int(10) NOT NULL auto_increment,
  `weight_lbs` int(3) default NULL,
  `weight_kg` int(3) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for riding_type
-- ----------------------------
CREATE TABLE `riding_type` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for riding_type_combo
-- ----------------------------
CREATE TABLE `riding_type_combo` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `riding_type` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for service_location
-- ----------------------------
CREATE TABLE `service_location` (
  `row_id` int(10) NOT NULL auto_increment,
  `location` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for setting
-- ----------------------------
CREATE TABLE `setting` (
  `row_id` int(10) NOT NULL auto_increment,
  `date` varchar(20) default NULL,
  `bike` int(10) default NULL,
  `suspension_brand` int(10) default NULL,
  `settings_on_arrival` int(10) default NULL,
  `fork_spec` int(20) default NULL,
  `shock_spec` int(20) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for settings_on_arrival
-- ----------------------------
CREATE TABLE `settings_on_arrival` (
  `row_id` int(10) NOT NULL auto_increment,
  `shock_leaking` int(1) default NULL,
  `forks_leaking` int(1) default NULL,
  `shock_spec` int(20) default NULL,
  `fork_spec` int(20) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for ship_method
-- ----------------------------
CREATE TABLE `ship_method` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for ship_method_account
-- ----------------------------
CREATE TABLE `ship_method_account` (
  `row_id` int(10) NOT NULL auto_increment,
  `ship_vendor` int(10) default NULL,
  `account_number` varchar(100) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for ship_vendor
-- ----------------------------
CREATE TABLE `ship_vendor` (
  `row_id` int(10) NOT NULL auto_increment,
  `name` varchar(25) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shipping
-- ----------------------------
CREATE TABLE `shipping` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `delivery_instructions` varchar(1000) default NULL,
  `use_rider_shipping_address` int(1) default NULL,
  `ship_address` int(10) default NULL,
  `ship_method` int(10) default NULL,
  `use_shipping_account` int(1) default NULL,
  `ship_method_account` int(10) default NULL,
  `ship_total` decimal(10,2) default NULL,
  `shipping_weight` decimal(5,2) default NULL,
  `gun_case` int(1) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_additional_products
-- ----------------------------
CREATE TABLE `shock_additional_products` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(250) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_additional_products_combo
-- ----------------------------
CREATE TABLE `shock_additional_products_combo` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `shock_additional_products` int(10) default NULL,
  `comments` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_additional_services
-- ----------------------------
CREATE TABLE `shock_additional_services` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_additional_services_combo
-- ----------------------------
CREATE TABLE `shock_additional_services_combo` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `shock_additional_services` int(10) default NULL,
  `comments` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_compression_adjuster_stack
-- ----------------------------
CREATE TABLE `shock_compression_adjuster_stack` (
  `row_id` int(20) NOT NULL auto_increment,
  `shock_spec` int(20) default NULL,
  `position` int(10) default NULL,
  `shim_inner_diameter` decimal(5,3) default NULL,
  `shim_outer_diameter` decimal(5,3) default NULL,
  `shim_thickness` decimal(5,3) default NULL,
  `quantity` int(2) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_compression_stack
-- ----------------------------
CREATE TABLE `shock_compression_stack` (
  `row_id` int(20) NOT NULL auto_increment,
  `shock_spec` int(20) default NULL,
  `position` int(2) default NULL,
  `shim_inner_diameter` decimal(5,3) default NULL,
  `shim_outer_diameter` decimal(5,3) default NULL,
  `shim_thickness` decimal(5,3) default NULL,
  `quantity` int(2) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1354 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_rebound_stack
-- ----------------------------
CREATE TABLE `shock_rebound_stack` (
  `row_id` int(20) NOT NULL auto_increment,
  `shock_spec` int(20) default NULL,
  `position` int(2) default NULL,
  `shim_inner_diameter` decimal(5,3) default NULL,
  `shim_outer_diameter` decimal(5,3) default NULL,
  `shim_thickness` decimal(5,3) default NULL,
  `quantity` int(2) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=832 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_spec
-- ----------------------------
CREATE TABLE `shock_spec` (
  `row_id` int(20) NOT NULL auto_increment,
  `revision_number` decimal(5,2) default '1.00',
  `springs` decimal(4,3) default NULL,
  `LS_comp_clicks` int(2) default NULL,
  `HS_comp_turns` varchar(5) default NULL,
  `reb_clicks` int(2) default NULL,
  `compressed_length` int(4) default NULL,
  `free_length` int(4) default NULL,
  `oil_type` varchar(10) default NULL,
  `general_info` int(10) default NULL,
  `comments` varchar(5000) default NULL,
  `nitrogen` int(4) default NULL,
  `z_cut` varchar(3) default NULL,
  `sag` int(4) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_spec_general_info
-- ----------------------------
CREATE TABLE `shock_spec_general_info` (
  `row_id` int(10) NOT NULL auto_increment,
  `general_info` varchar(5000) default NULL,
  PRIMARY KEY  (`row_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_work
-- ----------------------------
CREATE TABLE `shock_work` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shock_work_combo
-- ----------------------------
CREATE TABLE `shock_work_combo` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `shock_work` int(10) default NULL,
  `comments` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for shop
-- ----------------------------
CREATE TABLE `shop` (
  `row_id` int(10) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `address` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for suspension_brand
-- ----------------------------
CREATE TABLE `suspension_brand` (
  `row_id` int(10) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for terrain
-- ----------------------------
CREATE TABLE `terrain` (
  `row_id` int(10) NOT NULL auto_increment,
  `description` varchar(25) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for terrain_combo
-- ----------------------------
CREATE TABLE `terrain_combo` (
  `row_id` int(10) NOT NULL auto_increment,
  `work_order` int(10) default NULL,
  `terrain` int(10) default NULL,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for work_order
-- ----------------------------
CREATE TABLE `work_order` (
  `row_id` int(10) NOT NULL auto_increment,
  `setting` int(10) default NULL,
  `service_location` int(10) default NULL,
  `shop` int(10) default NULL,
  `rider_instance` int(10) default NULL,
  `bike` int(10) default NULL,
  `customer_comments` varchar(5000) default NULL,
  `tech_support_comments` varchar(5000) default NULL,
  `call_prior` int(1) default NULL,
  `ok_to_replace_bearing` int(1) default NULL,
  `turn_around` int(10) default NULL,
  `referrer` int(10) default NULL,
  `event_timestamp` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`row_id`),
  KEY `row_id` (`row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
DELIMITER ;;
CREATE TRIGGER `delete_lookup_trigger` AFTER DELETE ON `work_order` FOR EACH ROW BEGIN
     DELETE FROM suspension.lookup_table WHERE work_order=OLD.row_id;
  END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for add_address
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `add_address`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for add_fork_additional_product
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `add_fork_additional_product`(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.fork_additional_products
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for add_fork_additional_service
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `add_fork_additional_service`(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.fork_additional_services
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for add_fork_standard_work
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `add_fork_standard_work`(
                IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.fork_work
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for add_rider
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `add_rider`(
		IN `in_first_name` varchar (100),
		IN `in_last_name` varchar (100),
		IN `in_address_id` int (10)
                 )
BEGIN
  INSERT INTO suspension.rider
         (first_name, last_name,address)
         VALUES (`in_first_name`,`in_last_name`,`in_address_id`);
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for add_shock_additional_product
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `add_shock_additional_product`(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.shock_additional_products
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for add_shock_additional_service
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `add_shock_additional_service`(
		IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.shock_additional_services
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for add_shock_standard_work
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `add_shock_standard_work`(
                IN `in_description` varchar (100)
                 )
BEGIN
  INSERT INTO suspension.shock_work
         (`description`) VALUES (`in_description`);
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clear_open_work_orders
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clear_open_work_orders`(
              )
BEGIN
  DELETE FROM open_work_orders;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_arrival_fork_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_arrival_fork_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_arrival_shock_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_arrival_shock_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_credit_card
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_credit_card`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_estimate_fork
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_estimate_fork`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_estimate_shock
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_estimate_shock`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_finance
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_finance`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_fork_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_fork_spec`(
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
			 shim_inner_diameter,shim_outer_diameter,shim_thickness,quantity) 
            SELECT `new_fork_spec`,position,collar_width,rebound_piston_tower,spring_cup,
	            shim_inner_diameter,shim_outer_diameter,shim_thickness,quantity 
            FROM suspension.fork_bcv_stack 
	    WHERE fork_spec=`old_fork_spec`;

  INSERT INTO suspension.fork_compression_stack 
                        (fork_spec, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_fork_spec`, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.fork_compression_stack 
	    WHERE fork_spec=`old_fork_spec`;

  INSERT INTO suspension.fork_lsv_stack 
                        (fork_spec, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_fork_spec`, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.fork_lsv_stack 
	    WHERE fork_spec=`old_fork_spec`;

  INSERT INTO suspension.fork_rebound_stack 
                         (fork_spec, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity)  
             SELECT `new_fork_spec`, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity  
             FROM suspension.fork_lsv_stack 
	     WHERE fork_spec=`old_fork_spec`;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_other_work_order_records
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_other_work_order_records`(
	       IN `old_work_order` int(10),
               IN `new_work_order` int(10),
               IN `clone_type` varchar(15)	
              )
BEGIN
  /*if we are saving an update, all fields need to be clone first*/
  IF ((`clone_type`="Major Revision") OR (`clone_type`="Minor Revision"))  THEN 
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_setting
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_setting`(
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
    
  IF ((`clone_type`="Major Revision") OR (`clone_type`="Minor Revision"))  THEN 
     call clone_settings_on_arrival(@old_setting,@new_setting); 
  END IF;

  /*update the new work order with the new setting*/
  UPDATE suspension.work_order SET setting=@new_setting WHERE row_id=`new_work_order`;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_settings_on_arrival
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_settings_on_arrival`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_shock_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_shock_spec`(
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
                        (shock_spec, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity)   
            SELECT `new_shock_spec`, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.shock_compression_stack 
	    WHERE shock_spec=`old_shock_spec`;

  INSERT INTO suspension.shock_compression_adjuster_stack 
                        (shock_spec, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_shock_spec`, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.shock_compression_adjuster_stack 
	    WHERE shock_spec=`old_shock_spec`;

  INSERT INTO suspension.shock_rebound_stack 
                        (shock_spec, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity)  
            SELECT `new_shock_spec`, position, shim_inner_diameter, shim_outer_diameter, shim_thickness, quantity  
            FROM suspension.shock_compression_adjuster_stack 
	    WHERE shock_spec=`old_shock_spec`;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clone_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `clone_work_order`(
               IN `old_work_order` int(10),
       	       IN `clone_type` varchar(15),	
       	       IN `revision_type` varchar(15)	
              )
BEGIN
  /*if we are saving an update, all fields need to be clone first*/
  IF ((`clone_type`="Major Revision") OR (`clone_type`="Minor Revision"))  THEN 
     /*insert a clone of the inputed work_order record*/
    INSERT INTO suspension.work_order 
                          (service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
			   ok_to_replace_bearing,turn_around, referrer) 
                    SELECT service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
	                   ok_to_replace_bearing,turn_around, referrer 
                    FROM suspension.work_order 
	            WHERE row_id=`old_work_order`;

    SET @new_work_order=LAST_INSERT_ID();

    call clone_setting(`old_work_order`,@new_work_order,`clone_type`,`revision_type`);
    call clone_other_work_order_records(`old_work_order`,@new_work_order,`clone_type`);

    call clone_finance(`old_work_order`,@new_work_order);
  END IF;


  /*if we are saving as a new spec, the old comments and the financial information don't need to be copied*/
  IF (`clone_type`="New Spec") THEN
     SET @new_customer_comments=NULL;
     SET @new_tech_support_comments=NULL;
     /*insert a clone of the inputed work_order record*/
    INSERT INTO suspension.work_order 
                          (service_location,shop,rider_instance, bike, 
		           customer_comments,tech_support_comments, call_prior,
			   ok_to_replace_bearing,turn_around, referrer) 
                    SELECT service_location,shop,rider_instance, bike, 
		           @new_customer_comments,@new_tech_support_comments, call_prior,
	                   ok_to_replace_bearing,turn_around, referrer 
                    FROM suspension.work_order 
	            WHERE row_id=`old_work_order`;

    SET @new_work_order=LAST_INSERT_ID();

    call clone_setting(`old_work_order`,@new_work_order,`clone_type`,`revision_type`);
    call clone_other_work_order_records(`old_work_order`,@new_work_order,`clone_type`);
  END IF;

  call update_lookup_table(@new_work_order);/*causes the lookup_table to be updated with this work_order's new information*/
  SELECT @new_work_order AS "new_work_order"; /*send the new id back to the front end*/
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_bike
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_bike`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_fork_coatings_discount
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_fork_coatings_discount`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_fork_fluid_discount
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_fork_fluid_discount`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_fork_labor_discount
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_fork_labor_discount`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_fork_other_discount
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_fork_other_discount`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_fork_parts_discount
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_fork_parts_discount`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_fork_spring_discount
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_fork_spring_discount`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_rider
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_rider`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_rider_info1
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_rider_info1`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for collect_rider_info2
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `collect_rider_info2`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for compare_and_update_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `compare_and_update_comments`(
               IN `in_comments_id` int(10),
               IN `in_comments` varchar(5000)
       )
BEGIN
   DECLARE existing_comments varchar(5000); 
   DECLARE no_rows_found INT DEFAULT 0;

   DECLARE comments_cursor CURSOR FOR
                         SELECT
  	                        COMMENTS.comments
                          FROM 
                                suspension.comments as COMMENTS 
                          WHERE 
	                        COMMENTS.row_id =`in_comments_id`;

   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

    /*Get the comments at the given comments id*/
    OPEN comments_cursor;
      FETCH comments_cursor into existing_comments;
    CLOSE comments_cursor; 

    /*if the comments have changed, only then do we save the comments*/
    IF ( LENGTH(existing_comments)!=LENGTH(`in_comments`) ) THEN
       SET @date=curdate();
       SET @time=curtime();
       SET @new_comments=concat(`in_comments`," -- ",@date,"  ",@time);

       UPDATE suspension.comments SET comments=(@new_comments) WHERE row_id=`in_comments_id`;
    END IF;
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for create_new_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `create_new_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for delete_finance
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `delete_finance`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for delete_fork_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `delete_fork_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for delete_open_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `delete_open_work_order`(
               IN `in_work_order` int(10)
              )
BEGIN
     DELETE FROM suspension.open_work_orders WHERE work_order=`in_work_order`;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for delete_other_work_order_records
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `delete_other_work_order_records`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for delete_setting
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `delete_setting`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for delete_settings_on_arrival
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `delete_settings_on_arrival`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for delete_shock_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `delete_shock_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for delete_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `delete_work_order`(
               IN `in_work_order` int(10) 
              )
BEGIN
  call delete_setting(`in_work_order`);
  call delete_other_work_order_records(`in_work_order`);
  call delete_finance(`in_work_order`);

  /*Go ahead and delete the work_order*/	
  DELETE FROM suspension.work_order
	 WHERE row_id=`in_work_order`;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for determine_revision_number
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `determine_revision_number`(
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
         SET  `out_shock_revision_number`=1;
     END IF;

     /*reset revision number to one if it is a new spec*/
     IF ((old_fork_revision_number<=>NULL)OR(`clone_type`="New Spec")) THEN
         SET  `out_fork_revision_number`=1;
     END IF;

     IF (`clone_type`="Minor Revision")  THEN 
         SET  `out_shock_revision_number`=old_shock_revision_number+.01;
         SET  `out_fork_revision_number`=old_fork_revision_number+.01;
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for find_bike
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `find_bike`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for find_revision
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `find_revision`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for find_rider
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `find_rider`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for find_riding_type
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `find_riding_type`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for find_service_location
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `find_service_location`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for find_setting_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `find_setting_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for find_terrain
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `find_terrain`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for find_work_orders
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `find_work_orders`(
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
       	      CONCAT(work_order,'') AS 'Work Order', 
              CONCAT(last_name,', ',first_name) AS 'Customer',
              CONCAT(ability,'') AS 'Ability',
	      CONCAT(year,' ',brand,' ',model) AS 'Bike',
	      CONCAT(shock_rev,'') AS 'Shock rev', 
	      CONCAT(fork_rev,'') AS 'Fork rev', 
	      CONCAT(date,'') AS 'Date',
	      CONCAT(service_location,'') AS 'Center',
	      CONCAT(terrain,'') AS 'Terrain',
	      CONCAT(riding_type,'') AS 'Riding Type'
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_all_values
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_all_values`(
               IN `in_table_name` varchar(50),
               IN `in_field_names` varchar(100),
               IN `in_order_by_field` varchar(100)
       )
BEGIN
       SET @syntax=CONCAT(" SELECT row_id, ", 
                          `in_field_names`, " FROM ",
                          `in_table_name`, " ORDER BY ",
                          `in_order_by_field`,";");
     PREPARE stmt1 FROM @syntax;
     EXECUTE stmt1;

END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_arrival_fork_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_arrival_fork_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_arrival_shock_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_arrival_shock_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_arrival_specs_for_setting
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_arrival_specs_for_setting`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_bike_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_bike_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_change_date
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_change_date`(
		IN `in_setting` int (10)
                 )
BEGIN
  SELECT 
	 SETTING.date as "Date"
  FROM 
       suspension.setting as SETTING
  WHERE 
        SETTING.row_id=`in_setting`; 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_comments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_credit_card_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_credit_card_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_finance_header_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_finance_header_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_finance_to_clone_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_finance_to_clone_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_finance_to_delete_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_finance_to_delete_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_additional_services_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_additional_services_from_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_bcv_shims
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_bcv_shims`(
		IN `in_fork_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.collar_width as col_width,
	 STACK.rebound_piston_tower AS rebound_piston_tower,
	 STACK.spring_cup AS spring_cup,
         STACK.shim_inner_diameter  AS ID,
         STACK.shim_outer_diameter  AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.fork_bcv_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec`
  ORDER BY pos; 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_comp_shims
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_comp_shims`(
		IN `in_fork_spec` int (10)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter As ID,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.fork_compression_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec` 
  ORDER BY pos; 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_estimate_id
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_estimate_id`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_estimate_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_estimate_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_general_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_general_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_lsv_shims
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_lsv_shims`(
		IN `in_fork_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter As ID,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.fork_lsv_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec` 
  ORDER BY pos; 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_need_springs_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_need_springs_info`(
		IN `in_work_order` int (10)
                )
BEGIN
     SELECT 
	    NEED_SPRINGS.need_fork_spring,
	    NEED_SPRINGS.recommended_fork_spring AS 'rate'
       FROM suspension.need_springs as NEED_SPRINGS 
       WHERE 
	    NEED_SPRINGS.work_order=`in_work_order`; 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_reb_shims
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_reb_shims`(
		IN `in_fork_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter As ID,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.fork_rebound_stack as STACK
  WHERE 
        STACK.fork_spec=`in_fork_spec`
  ORDER BY pos; 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_springs
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_springs`()
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_fork_standard_work_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_fork_standard_work_from_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_general_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_general_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_key
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_key`(
               OUT `return_key`  varchar(100)
       )
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_number_of_work_orders
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_number_of_work_orders`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_overall_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_overall_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_payment_method_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_payment_method_from_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_revision
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_revision`(
		IN `in_work_order_id` int (10)
                 )
BEGIN
   SET @shock_revision=0;
   SET @fork_revision=0;
   call find_revision(`in_work_order_id`,@shock_revision,@fork_revision);
   SELECT 
        @shock_revision as `shock_rev`,
        @fork_revision as `fork_rev`;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_rider_address_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_rider_address_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_rider_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_rider_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_rider_names
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_rider_names`()
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_rider_settings_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_rider_settings_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_riding_type
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_riding_type`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_settings_fork_additional_products
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_settings_fork_additional_products`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_settings_on_arrival_to_clone
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_settings_on_arrival_to_clone`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_settings_on_arrival_to_clone_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_settings_on_arrival_to_clone_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_settings_on_arrival_to_delete_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_settings_on_arrival_to_delete_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_settings_shock_additional_products
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_settings_shock_additional_products`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_setting_from_workorder
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_setting_from_workorder`(
		IN `in_work_order` int (10)
                 )
BEGIN
  SET @valid_setting=0;
  call prepare_work_order_setting(`in_work_order`,@valid_setting);
  SELECT @valid_setting AS setting;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_setting_to_clone
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_setting_to_clone`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_setting_to_clone_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_setting_to_clone_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_setting_to_delete
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_setting_to_delete`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_setting_to_delete_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_setting_to_delete_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shipping_acct_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shipping_acct_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shipping_address_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shipping_address_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shipping_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shipping_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_additional_services_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_additional_services_from_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_comp_adj_shims
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_comp_adj_shims`(
		IN `in_shock_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter AS ID,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.shock_compression_adjuster_stack as STACK
  WHERE 
        STACK.shock_spec=`in_shock_spec` 
  ORDER BY pos; 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_comp_shims
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_comp_shims`(
		IN `in_shock_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id AS spec_id,
         STACK.position AS pos, 
         STACK.shim_inner_diameter AS ID,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.shock_compression_stack as STACK
  WHERE 
        STACK.shock_spec=`in_shock_spec` 
  ORDER BY STACK.position; 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_estimate_id
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_estimate_id`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_estimate_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_estimate_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_fork_specs_for_setting
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_fork_specs_for_setting`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_general_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_general_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_need_springs_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_need_springs_info`(
		IN `in_work_order` int (10)
                )
BEGIN
     SELECT 
	    NEED_SPRINGS.need_shock_spring,
	    NEED_SPRINGS.recommended_shock_spring AS 'rate'
       FROM suspension.need_springs as NEED_SPRINGS 
       WHERE 
	    NEED_SPRINGS.work_order=`in_work_order`; 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_reb_shims
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_reb_shims`(
		IN `in_shock_spec` int (20)
                 )
BEGIN
  SELECT STACK.row_id as spec_id,
         STACK.position as pos, 
         STACK.shim_inner_diameter AS ID,
         STACK.shim_outer_diameter AS OD, 
         STACK.shim_thickness AS Thickness,
         STACK.quantity as qty
  FROM 
       suspension.shock_rebound_stack as STACK
  WHERE 
        STACK.shock_spec=`in_shock_spec` 
  ORDER BY pos; 

END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_springs
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_springs`()
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_shock_standard_work_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_shock_standard_work_from_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_support_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_support_comments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_terrain
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_terrain`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_work_order_for_setting
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_work_order_for_setting`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_work_order_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `get_work_order_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for insert_open_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `insert_open_work_order`(
               IN `in_work_order` int(10)
              )
BEGIN
     INSERT INTO suspension.open_work_orders(work_order) VALUES (`in_work_order`);
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for insert_shims_into_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `insert_shims_into_spec`(
	       IN `in_setting_id`int(10), 
               IN `in_ref_table` varchar(100),
               IN `in_ref_spec` varchar(100),
               IN `in_spec_id` int(20),
               IN `in_pos` int(10),
               IN `in_ID` decimal(5,3),
               IN `in_Col_Width` decimal(5,3),
               IN `in_Reb_Piston_Tower` decimal(5,3),
               IN `in_Spring_Cup` decimal(5,3),
               IN `in_OD` decimal(5,3),
               IN `in_Thickness` decimal(5,3),
               IN `in_Qty` int(10)
       )
BEGIN
    /*SELECT `in_spec_id`,`in_pos`,`in_ID_id`,@OD_id,@Thickness_id,@Qty;*/
    IF `in_ref_table`="fork_bcv_stack" THEN
        SET @syntax=CONCAT("  INSERT INTO suspension.", `in_ref_table`,
                           " (",`in_ref_spec`,",position,collar_width,rebound_piston_tower,spring_cup,shim_inner_diameter,shim_outer_diameter, shim_thickness,quantity) ",
                           " VALUES ", "(",
                                               `in_spec_id`,",",
                                               `in_pos`,",",
                                               `in_Col_Width`,",",
                                               `in_Reb_Piston_Tower`,",",
                                               `in_Spring_Cup`,",",
                                               `in_ID`,",",
					       `in_OD`,",",
					       `in_Thickness`,",",
                                               `in_Qty`,");"
                                ); 
       ELSE
        SET @syntax=CONCAT("  INSERT INTO suspension.", `in_ref_table`,
                           " (",`in_ref_spec`,",position, shim_inner_diameter,shim_outer_diameter,shim_thickness,quantity) ",
                           " VALUES ", "(",
                                               `in_spec_id`,",",
                                               `in_pos`,",",
                                               `in_ID`,",",
					       `in_OD`,",",
					       `in_Thickness`,",",
                                               `in_Qty`,");"
                                ); 
    END IF;

    SELECT @syntax;
    PREPARE stmt1 FROM @syntax;
    EXECUTE stmt1;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_address
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_address`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_arrival_fork_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_arrival_fork_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_arrival_shock_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_arrival_shock_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_arrival_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_arrival_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_bike_instance
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_bike_instance`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_comments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_credit_card_account
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_credit_card_account`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_estimate_fork
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_estimate_fork`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_estimate_shock
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_estimate_shock`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_finance
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_finance`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_finance_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_finance_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_fork_shock_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_fork_shock_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_fork_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_fork_spec`(
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
       INSERT INTO suspension.fork_spec (revision_number) VALUES(1); 
       SET @new_spec=LAST_INSERT_ID();
       UPDATE suspension.setting SET fork_spec=@new_spec WHERE row_id=`in_setting`;
       SET `out_spec`=@new_spec;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_spec`=existing_spec;
    END IF;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_limit_statement
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_limit_statement`(
               IN `in_page` int(3),
               OUT `out_limit_statement` varchar(50) 
              )
BEGIN
  /*we are going to return 100 records per page*/
  SET @records_per_page=50;
  /*take whatever page of results we want to retrieve*/
  /*multiply it by the number of results we are displaying per page*/
  /*and subtract the number of results we are displaying per page*/
  SET @start_value=`in_page` * @records_per_page - @records_per_page;
  SET `out_limit_statement`=CONCAT(" LIMIT ",@start_value,",",@records_per_page); 
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_need_springs
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_need_springs`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_rider_instance
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_rider_instance`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_setting
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_setting`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_shipping
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_shipping`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_shipping_account
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_shipping_account`(
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

END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_shipping_vendor
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_shipping_vendor`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_shock_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_shock_spec`(
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
       INSERT INTO suspension.shock_spec (revision_number) VALUES(1); 
       SET @new_spec=LAST_INSERT_ID();
       UPDATE suspension.setting SET shock_spec=@new_spec WHERE row_id=`in_setting`;
       SET `out_spec`=@new_spec;
       ELSE
       /*otherwise return the existing_work_order*/
        SET `out_spec`=existing_spec;
    END IF;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prepare_work_order_setting
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `prepare_work_order_setting`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remove_acct_from_shipping_entry
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `remove_acct_from_shipping_entry`(
               IN `in_shipping_entry`  int(10)
       )
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
   
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remove_additional_products_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `remove_additional_products_from_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remove_additional_services_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `remove_additional_services_from_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remove_credit_card_from_finance_entry
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `remove_credit_card_from_finance_entry`(
               IN `in_finance_entry`  int(10)
       )
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
   
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remove_payment_method_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `remove_payment_method_from_work_order`(
               IN `in_work_order`  int(10)
       )
BEGIN
   DELETE FROM suspension.payment_method_combo
          WHERE work_order=`in_work_order`; 
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remove_riding_types_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `remove_riding_types_from_work_order`(
               IN `in_work_order`  int(10)
       )
BEGIN
   DELETE FROM suspension.riding_type_combo
          WHERE work_order=`in_work_order`;
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remove_shims_from_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `remove_shims_from_spec`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remove_standard_work_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `remove_standard_work_from_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remove_terrain_from_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `remove_terrain_from_work_order`(
               IN `in_work_order`  int(10)
       )
BEGIN
   DELETE FROM suspension.terrain_combo
          WHERE work_order=`in_work_order`;
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_additional_products
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_additional_products`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_additional_services
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_additional_services`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_bike_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_bike_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_credit_card_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_credit_card_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_finance_header_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_finance_header_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_fork_adjustments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_fork_adjustments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_fork_arrival_settings
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_fork_arrival_settings`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_fork_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_fork_comments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_fork_comments_in_fork_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_fork_comments_in_fork_spec`(
	       IN `in_fork_spec` int(20),
               IN `in_comments` varchar(5000)
       )
BEGIN
     DECLARE existing_comments varchar(5000); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE id_cursor CURSOR FOR
                         SELECT comments FROM suspension.fork_spec
			                 WHERE row_id=`in_fork_spec`;

     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     /*See if this fork spec has any comments*/ 
     OPEN id_cursor;
       FETCH id_cursor into existing_comments;
     CLOSE id_cursor; 


     /* if there were no customer comments for this setting create some*/ 
     IF (existing_comments <=> NULL ) AND (LENGTH(`in_comments`)>0) THEN
         SET @date=curdate();
         SET @time=curtime();
         SET @new_comments=concat(`in_comments`," -- ",@date,"  ",@time);
         UPDATE suspension.fork_spec SET comments=@new_comments WHERE row_id=`in_fork_spec`; 
         ELSEIF LENGTH(existing_comments)!=LENGTH(`in_comments`)  THEN 
                SET @date=curdate();
                SET @time=curtime();
                SET @new_comments=concat(`in_comments`," -- ",@date,"  ",@time);
                UPDATE suspension.fork_spec SET comments=@new_comments WHERE row_id=`in_fork_spec`; 
     END IF;
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_fork_estimate
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_fork_estimate`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_fork_need_springs_info_for_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_fork_need_springs_info_for_work_order`(
	       IN `in_work_order` int(10),
	       IN `in_Need_Springs` int(1),
	       IN `in_rate` decimal(4,3)
               )
BEGIN
     call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
     call prepare_need_springs(@valid_work_order,@valid_need_springs); 

     UPDATE suspension.need_springs SET need_fork_spring=`in_Need_Springs` WHERE work_order=`in_work_order`;
     UPDATE suspension.need_springs SET recommended_fork_spring=`in_rate` WHERE work_order=`in_work_order`;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_overall_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_overall_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_payment_method
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_payment_method`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_rider_settings_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_rider_settings_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_riding_types
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_riding_types`(
	       IN `in_work_order` int(10),
               IN `in_riding_type_id` int(10)
       )
BEGIN
   call prepare_work_order(`in_work_order`,@valid_work_order,@valid_setting);
   INSERT INTO suspension.riding_type_combo (work_order,riding_type) 
          VALUES (@valid_work_order,`in_riding_type_id`);

   call update_lookup_table(@valid_work_order);
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_shipping_acct_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_shipping_acct_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_shipping_address_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_shipping_address_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_shipping_info
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_shipping_info`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_shock_adjustments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_shock_adjustments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_shock_arrival_settings
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_shock_arrival_settings`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_shock_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_shock_comments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_shock_comments_in_shock_spec
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_shock_comments_in_shock_spec`(
	       IN `in_shock_spec` int(20),
               IN `in_comments` varchar(5000)
       )
BEGIN
     DECLARE existing_comments varchar(5000); 
     DECLARE no_rows_found INT DEFAULT 0;

     DECLARE id_cursor CURSOR FOR
                         SELECT comments FROM suspension.shock_spec 
			 WHERE row_id=`in_shock_spec`;

     /*To handle when no rows found*/
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET no_rows_found = 1; /*To handle when no rows found*/

     /*See if this setting has any customer or tech support comments*/
     OPEN id_cursor;
       FETCH id_cursor into existing_comments;
     CLOSE id_cursor; 


     /* if there were no customer comments for this setting create some*/ 
     IF (existing_comments <=> NULL ) AND (LENGTH(`in_comments`)>0) THEN
         SET @date=curdate();
         SET @time=curtime();
         SET @new_comments=concat(`in_comments`," -- ",@date,"  ",@time);
         UPDATE suspension.shock_spec SET comments=@new_comments WHERE row_id=`in_shock_spec`; 
         ELSEIF LENGTH(existing_comments)!=LENGTH(`in_comments`)  THEN 
              SET @date=curdate();
              SET @time=curtime();
              SET @new_comments=concat(`in_comments`," -- ",@date,"  ",@time);
              UPDATE suspension.shock_spec SET comments=@new_comments WHERE row_id=`in_shock_spec`; 
     END IF;
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_shock_estimate
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_shock_estimate`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_shock_need_springs_info_for_work_order
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_shock_need_springs_info_for_work_order`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_standard_work
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_standard_work`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_terrain
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `save_terrain`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for unique_collar_width_insert
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `unique_collar_width_insert`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for unique_shim_OD_insert
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `unique_shim_OD_insert`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for unique_spring_length_insert
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `unique_spring_length_insert`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for update_address
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `update_address`(
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

END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for update_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `update_comments`(
               IN `in_comments_id` varchar(5000),
               IN `in_comments` varchar(5000)
       )
BEGIN
     DECLARE old_comment varchar(5000); 
     DECLARE cur1 CURSOR FOR
                         SELECT comments from suspension.comments
			        where row_id=`in_comments_id`;
     OPEN cur1;
      FETCH cur1 into old_comment;
     CLOSE cur1; 

     SET @old_length=LENGTH(old_comment);
     SET @new_length=LENGTH(`in_comments`); 

     /*Update the comments if there is more information than there was before*/
     IF @new_length > @old_length THEN
        SET @date=curdate();
        SET @time=curtime();

        SET @new_comments=concat(`in_comments`," -- ",@date,"  ",@time);

       UPDATE suspension.comments SET comments=(@new_comments) 
            WHERE row_id=`in_comments_id`;
    END IF;
   FLUSH QUERY CACHE;
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for update_fork_general_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `update_fork_general_comments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for update_lookup_table
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `update_lookup_table`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for update_shock_general_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `update_shock_general_comments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for update_support_comments
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `update_support_comments`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for work_order_is_editable
-- ----------------------------
DELIMITER ;;
CREATE DEFINER=`tom`@`%` PROCEDURE `work_order_is_editable`(
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
END;;
DELIMITER ;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `address` VALUES ('6', '', '', '', '', '', '', '', '', '');
INSERT INTO `basic_info` VALUES ('1', '5acg328Kh908aslfji2#@12');
INSERT INTO `bike` VALUES ('20', '19', '13', '2', '2');
INSERT INTO `bike` VALUES ('21', '19', '12', '2', '2');
INSERT INTO `bike` VALUES ('22', '19', '41', '3', '3');
INSERT INTO `bike` VALUES ('23', '19', '40', '3', '3');
INSERT INTO `bike` VALUES ('24', '0', '34', '3', '3');
INSERT INTO `bike` VALUES ('25', '0', '0', '6', '3');
INSERT INTO `bike` VALUES ('26', '18', '34', '6', '3');
INSERT INTO `bike` VALUES ('27', '19', '45', '0', '0');
INSERT INTO `bike` VALUES ('28', '19', '44', '0', '0');
INSERT INTO `bike` VALUES ('29', '19', '44', '3', '3');
INSERT INTO `bike` VALUES ('30', '19', '45', '3', '3');
INSERT INTO `bike` VALUES ('31', '0', '37', '3', '3');
INSERT INTO `bike` VALUES ('32', '0', '0', '3', '3');
INSERT INTO `bike` VALUES ('33', '19', '37', '3', '3');
INSERT INTO `bike` VALUES ('34', '19', '46', '3', '3');
INSERT INTO `bike` VALUES ('35', '19', '47', '3', '3');
INSERT INTO `bike` VALUES ('36', '19', '38', '3', '3');
INSERT INTO `bike` VALUES ('37', '19', '55', '3', '3');
INSERT INTO `bike` VALUES ('38', '19', '48', '3', '3');
INSERT INTO `bike` VALUES ('39', '19', '0', '0', '0');
INSERT INTO `bike` VALUES ('40', '19', '49', '3', '3');
INSERT INTO `bike` VALUES ('41', '19', '50', '0', '0');
INSERT INTO `bike` VALUES ('42', '19', '51', '3', '3');
INSERT INTO `bike` VALUES ('43', '19', '53', '3', '3');
INSERT INTO `bike` VALUES ('44', '19', '54', '3', '3');
INSERT INTO `bike` VALUES ('45', '19', '29', '2', '2');
INSERT INTO `bike` VALUES ('46', '19', '32', '2', '2');
INSERT INTO `bike` VALUES ('47', '19', '14', '1', '1');
INSERT INTO `bike` VALUES ('48', '19', '16', '1', '1');
INSERT INTO `bike` VALUES ('49', '19', '18', '1', '1');
INSERT INTO `bike` VALUES ('50', '19', '19', '1', '1');
INSERT INTO `bike` VALUES ('51', '19', '25', '1', '1');
INSERT INTO `bike` VALUES ('52', '19', '25', '2', '2');
INSERT INTO `bike` VALUES ('53', '0', '26', '1', '1');
INSERT INTO `bike` VALUES ('54', '19', '26', '1', '1');
INSERT INTO `bike` VALUES ('55', '0', '21', '1', '1');
INSERT INTO `bike` VALUES ('56', '19', '21', '1', '1');
INSERT INTO `bike` VALUES ('57', '19', '56', '1', '1');
INSERT INTO `bike_brand_model` VALUES ('1', 'Honda', 'XR200');
INSERT INTO `bike_brand_model` VALUES ('2', 'Honda', 'XR250');
INSERT INTO `bike_brand_model` VALUES ('3', 'Honda', 'XR400');
INSERT INTO `bike_brand_model` VALUES ('4', 'Honda', 'XR600');
INSERT INTO `bike_brand_model` VALUES ('5', 'Honda', 'XR650');
INSERT INTO `bike_brand_model` VALUES ('6', 'Honda', 'CR80');
INSERT INTO `bike_brand_model` VALUES ('7', 'Honda', 'CR85R');
INSERT INTO `bike_brand_model` VALUES ('8', 'Honda', 'CR125R');
INSERT INTO `bike_brand_model` VALUES ('9', 'Honda', 'CR250R');
INSERT INTO `bike_brand_model` VALUES ('10', 'Honda', 'CR500R');
INSERT INTO `bike_brand_model` VALUES ('11', 'Honda', 'CRF150');
INSERT INTO `bike_brand_model` VALUES ('12', 'Honda', 'CRF250');
INSERT INTO `bike_brand_model` VALUES ('13', 'Honda', 'CRF450');
INSERT INTO `bike_brand_model` VALUES ('14', 'Yamaha', 'YZ85');
INSERT INTO `bike_brand_model` VALUES ('15', 'Yamaha', 'YZ125');
INSERT INTO `bike_brand_model` VALUES ('16', 'Yamaha', 'YZ250');
INSERT INTO `bike_brand_model` VALUES ('17', 'Yamaha', 'YZ490');
INSERT INTO `bike_brand_model` VALUES ('18', 'Yamaha', 'YZ250F');
INSERT INTO `bike_brand_model` VALUES ('19', 'Yamaha', 'YZ450F');
INSERT INTO `bike_brand_model` VALUES ('20', 'Kawasaki', 'KX60');
INSERT INTO `bike_brand_model` VALUES ('21', 'Kawasaki', 'KX85');
INSERT INTO `bike_brand_model` VALUES ('22', 'Kawasaki', 'KX125');
INSERT INTO `bike_brand_model` VALUES ('23', 'Kawasaki', 'KX250');
INSERT INTO `bike_brand_model` VALUES ('24', 'Kawasaki', 'KX500');
INSERT INTO `bike_brand_model` VALUES ('25', 'Kawasaki', 'KX-F250');
INSERT INTO `bike_brand_model` VALUES ('26', 'Kawasaki', 'KX-F450');
INSERT INTO `bike_brand_model` VALUES ('27', 'Kawasaki', 'KDX200');
INSERT INTO `bike_brand_model` VALUES ('28', 'Suzuki', 'RM60');
INSERT INTO `bike_brand_model` VALUES ('29', 'Suzuki', 'RM85');
INSERT INTO `bike_brand_model` VALUES ('30', 'Suzuki', 'RM125');
INSERT INTO `bike_brand_model` VALUES ('31', 'Suzuki', 'RM250');
INSERT INTO `bike_brand_model` VALUES ('32', 'Suzuki', 'RMZ250');
INSERT INTO `bike_brand_model` VALUES ('33', 'Suzuki', 'RMZ450');
INSERT INTO `bike_brand_model` VALUES ('34', 'KTM', '65SX');
INSERT INTO `bike_brand_model` VALUES ('35', 'KTM', '85SX');
INSERT INTO `bike_brand_model` VALUES ('36', 'KTM', '105SX');
INSERT INTO `bike_brand_model` VALUES ('37', 'KTM', '125SX');
INSERT INTO `bike_brand_model` VALUES ('38', 'KTM', '250SX');
INSERT INTO `bike_brand_model` VALUES ('39', 'KTM', '360SX');
INSERT INTO `bike_brand_model` VALUES ('40', 'KTM', '250SX-F');
INSERT INTO `bike_brand_model` VALUES ('41', 'KTM', '450SX-F');
INSERT INTO `bike_brand_model` VALUES ('42', 'Honda', 'CRF250 X');
INSERT INTO `bike_brand_model` VALUES ('43', 'Honda', 'CRF450 X');
INSERT INTO `bike_brand_model` VALUES ('44', 'KTM', '85_105XC');
INSERT INTO `bike_brand_model` VALUES ('45', 'KTM', '85SX_105SX');
INSERT INTO `bike_brand_model` VALUES ('46', 'KTM', '144SX');
INSERT INTO `bike_brand_model` VALUES ('47', 'KTM', '200XC');
INSERT INTO `bike_brand_model` VALUES ('48', 'KTM', '250XC-F');
INSERT INTO `bike_brand_model` VALUES ('49', 'KTM', '250XC-W');
INSERT INTO `bike_brand_model` VALUES ('50', 'KTM', '300XC');
INSERT INTO `bike_brand_model` VALUES ('51', 'KTM', '300XC-W');
INSERT INTO `bike_brand_model` VALUES ('53', 'KTM', '450EXC');
INSERT INTO `bike_brand_model` VALUES ('54', 'KTM', '450XC-F');
INSERT INTO `bike_brand_model` VALUES ('55', 'KTM', '250XC');
INSERT INTO `bike_brand_model` VALUES ('56', 'Kawasaki', 'KX100');
INSERT INTO `bike_year` VALUES ('1', '1990');
INSERT INTO `bike_year` VALUES ('2', '1991');
INSERT INTO `bike_year` VALUES ('3', '1992');
INSERT INTO `bike_year` VALUES ('4', '1993');
INSERT INTO `bike_year` VALUES ('5', '1994');
INSERT INTO `bike_year` VALUES ('6', '1995');
INSERT INTO `bike_year` VALUES ('7', '1996');
INSERT INTO `bike_year` VALUES ('8', '1997');
INSERT INTO `bike_year` VALUES ('9', '1998');
INSERT INTO `bike_year` VALUES ('10', '1999');
INSERT INTO `bike_year` VALUES ('11', '2000');
INSERT INTO `bike_year` VALUES ('12', '2001');
INSERT INTO `bike_year` VALUES ('13', '2002');
INSERT INTO `bike_year` VALUES ('14', '2003');
INSERT INTO `bike_year` VALUES ('15', '2004');
INSERT INTO `bike_year` VALUES ('16', '2005');
INSERT INTO `bike_year` VALUES ('17', '2006');
INSERT INTO `bike_year` VALUES ('18', '2007');
INSERT INTO `bike_year` VALUES ('19', '2008');
INSERT INTO `bike_year` VALUES ('20', '2009');
INSERT INTO `bike_year` VALUES ('21', '2010');
INSERT INTO `days` VALUES ('1', '1 days');
INSERT INTO `days` VALUES ('2', '2 days');
INSERT INTO `days` VALUES ('3', '3 days');
INSERT INTO `days` VALUES ('4', '4 days');
INSERT INTO `days` VALUES ('5', '5 days');
INSERT INTO `days` VALUES ('6', '6 days');
INSERT INTO `days` VALUES ('7', '7 days');
INSERT INTO `days` VALUES ('8', '8 days');
INSERT INTO `days` VALUES ('9', '9 days');
INSERT INTO `days` VALUES ('10', '10 days');
INSERT INTO `days` VALUES ('11', '11 days');
INSERT INTO `days` VALUES ('12', '12 days');
INSERT INTO `days` VALUES ('13', '13 days');
INSERT INTO `days` VALUES ('14', '14 days');
INSERT INTO `days` VALUES ('15', '15 days');
INSERT INTO `days` VALUES ('16', '16 days');
INSERT INTO `days` VALUES ('17', '17 days');
INSERT INTO `days` VALUES ('18', '18 days');
INSERT INTO `days` VALUES ('19', '19 days');
INSERT INTO `days` VALUES ('20', '20 days');
INSERT INTO `days` VALUES ('21', '21 days');
INSERT INTO `days` VALUES ('22', '22 days');
INSERT INTO `days` VALUES ('23', '23 days');
INSERT INTO `days` VALUES ('24', '24 days');
INSERT INTO `days` VALUES ('25', '25 days');
INSERT INTO `days` VALUES ('26', '26 days');
INSERT INTO `days` VALUES ('27', '27 days');
INSERT INTO `days` VALUES ('28', '28 days');
INSERT INTO `days` VALUES ('29', '29 days');
INSERT INTO `days` VALUES ('30', '30 days');
INSERT INTO `estimate_fork` VALUES ('202', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0');
INSERT INTO `estimate_fork` VALUES ('203', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0');
INSERT INTO `estimate_fork` VALUES ('204', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0');
INSERT INTO `estimate_fork` VALUES ('205', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0');
INSERT INTO `estimate_fork` VALUES ('206', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0', '0.00', '0');
INSERT INTO `estimate_fork` VALUES ('207', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('208', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('209', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('210', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('211', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('212', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('213', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('214', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('215', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('216', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('217', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('218', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('219', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('220', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('221', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('222', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('223', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('224', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('225', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('226', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('227', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('228', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('229', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('230', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('231', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('232', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('233', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('234', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('235', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('236', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('237', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('238', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('239', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('240', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('241', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('242', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('243', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('244', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('245', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('246', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('247', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('248', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('249', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('250', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('251', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('252', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('253', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('254', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('255', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('256', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('257', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('258', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('259', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('260', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('261', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('262', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_fork` VALUES ('263', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('78', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('79', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('80', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('81', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('82', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('83', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('84', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('85', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('86', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('87', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('88', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('89', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('90', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('91', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('92', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('93', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('94', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('95', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('96', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('97', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('98', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('99', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('100', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('101', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('102', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('103', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('104', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('108', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('109', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `estimate_shock` VALUES ('110', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '', '0.00', '');
INSERT INTO `finance` VALUES ('79', '1', '207', '78', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('80', '2', '208', '79', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('81', '3', '214', '80', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('82', '4', '213', '81', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('83', '6', '210', '82', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('84', '7', '212', '83', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('85', '8', '216', '84', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('86', '9', '218', '85', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('87', '10', '220', '86', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('88', '11', '222', '87', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('89', '12', '224', '88', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('90', '13', '226', '89', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('91', '14', '228', '90', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('92', '15', '230', '91', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('93', '16', '232', '92', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('94', '17', null, '93', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('95', '18', '235', '94', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('96', '19', '237', '95', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('97', '20', '239', '96', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('98', '21', '241', '97', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('99', '22', '243', '98', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('100', '23', '245', '99', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('101', '24', '247', '100', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('102', '25', '249', '101', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('103', '26', '251', '102', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('104', '27', '253', '103', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('105', '28', '255', '104', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('109', '29', '260', '108', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('110', '30', '262', '109', null, '', '', '', null, null, null);
INSERT INTO `finance` VALUES ('111', '31', null, '110', null, '', '', '', null, null, null);
INSERT INTO `fork_additional_products` VALUES ('9', 'spring seats');
INSERT INTO `fork_additional_services` VALUES ('1', 'Anodize Fork Lugs');
INSERT INTO `fork_additional_services` VALUES ('2', 'DLC (Black) Fork Tubes');
INSERT INTO `fork_additional_services` VALUES ('3', 'Redo');
INSERT INTO `fork_additional_services` VALUES ('4', 'Shorten');
INSERT INTO `fork_bcv_stack` VALUES ('1', '1', '0', '1.880', '1.000', '0.000', '0.000', '20.000', '0.100', '6');
INSERT INTO `fork_bcv_stack` VALUES ('2', '1', '1', '1.880', '1.000', '0.000', '0.000', '19.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('3', '1', '3', '1.880', '1.000', '0.000', '0.000', '9.000', '0.300', '3');
INSERT INTO `fork_bcv_stack` VALUES ('4', '1', '4', '1.880', '1.000', '0.000', '0.000', '9.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('115', '11', '0', '0.000', '0.000', '0.000', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('116', '11', '1', '0.000', '0.000', '0.000', '0.000', '22.000', '0.100', '2');
INSERT INTO `fork_bcv_stack` VALUES ('117', '11', '2', '0.000', '0.000', '0.000', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('118', '11', '3', '0.000', '0.000', '0.000', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('119', '11', '4', '0.000', '0.000', '0.000', '0.000', '11.000', '0.200', '3');
INSERT INTO `fork_bcv_stack` VALUES ('120', '9', '0', '0.000', '0.000', '0.000', '0.000', '23.000', '0.300', '1');
INSERT INTO `fork_bcv_stack` VALUES ('146', '3', '0', '1.870', '1.000', '0.000', '0.000', '20.000', '0.100', '6');
INSERT INTO `fork_bcv_stack` VALUES ('147', '3', '1', '1.870', '1.000', '0.000', '0.000', '19.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('148', '3', '2', '1.870', '1.000', '0.000', '0.000', '0.000', '0.000', '99');
INSERT INTO `fork_bcv_stack` VALUES ('149', '3', '3', '1.870', '1.000', '0.000', '0.000', '9.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('150', '3', '4', '1.870', '1.000', '0.000', '0.000', '9.000', '0.300', '3');
INSERT INTO `fork_bcv_stack` VALUES ('159', '13', '0', '4.500', '0.000', '0.000', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('160', '13', '1', '4.500', '0.000', '0.000', '0.000', '22.000', '0.100', '2');
INSERT INTO `fork_bcv_stack` VALUES ('161', '13', '2', '4.500', '0.000', '0.000', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('162', '13', '3', '4.500', '0.000', '0.000', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('163', '13', '4', '4.500', '0.000', '0.000', '0.000', '11.000', '0.200', '3');
INSERT INTO `fork_bcv_stack` VALUES ('164', '15', '0', '2.500', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('165', '15', '1', '2.500', '0.000', '0.000', '0.000', '18.000', '0.100', '3');
INSERT INTO `fork_bcv_stack` VALUES ('166', '15', '2', '2.500', '0.000', '0.000', '0.000', '16.000', '0.100', '2');
INSERT INTO `fork_bcv_stack` VALUES ('167', '15', '3', '2.500', '0.000', '0.000', '0.000', '11.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('168', '19', '0', '2.500', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('169', '19', '1', '2.500', '0.000', '0.000', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('170', '19', '2', '2.500', '0.000', '0.000', '0.000', '11.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('171', '21', '0', '2.500', '0.000', '0.000', '0.000', '0.000', '0.000', '1');
INSERT INTO `fork_bcv_stack` VALUES ('172', '23', '0', '2.500', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('173', '23', '1', '2.500', '0.000', '0.000', '0.000', '18.000', '0.100', '3');
INSERT INTO `fork_bcv_stack` VALUES ('174', '23', '2', '2.500', '0.000', '0.000', '0.000', '16.000', '0.100', '2');
INSERT INTO `fork_bcv_stack` VALUES ('175', '23', '3', '2.500', '0.000', '0.000', '0.000', '11.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('176', '25', '0', '2.500', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('177', '25', '1', '2.500', '0.000', '0.000', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('178', '25', '2', '2.500', '0.000', '0.000', '0.000', '11.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('179', '27', '0', '2.500', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('180', '27', '1', '2.500', '0.000', '0.000', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('181', '27', '2', '2.500', '0.000', '0.000', '0.000', '11.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('182', '29', '0', '4.500', '0.000', '0.000', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('183', '29', '1', '4.500', '0.000', '0.000', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('184', '29', '2', '4.500', '0.000', '0.000', '0.000', '11.000', '0.200', '6');
INSERT INTO `fork_bcv_stack` VALUES ('185', '33', '0', '4.500', '2.000', '0.000', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('186', '33', '1', '4.500', '2.000', '0.000', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('187', '33', '2', '4.500', '2.000', '0.000', '0.000', '11.000', '0.200', '6');
INSERT INTO `fork_bcv_stack` VALUES ('188', '35', '0', '0.000', '0.000', '0.000', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('189', '35', '1', '0.000', '0.000', '0.000', '0.000', '22.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('190', '35', '2', '0.000', '0.000', '0.000', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('191', '35', '3', '0.000', '0.000', '0.000', '0.000', '11.000', '0.200', '6');
INSERT INTO `fork_bcv_stack` VALUES ('192', '39', '0', '2.500', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('193', '39', '1', '2.500', '0.000', '0.000', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('194', '39', '2', '2.500', '0.000', '0.000', '0.000', '11.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('195', '41', '0', '0.000', '0.000', '0.000', '0.000', '17.000', '0.400', '1');
INSERT INTO `fork_bcv_stack` VALUES ('196', '43', '0', '1.750', '0.000', '0.000', '0.000', '20.000', '0.100', '6');
INSERT INTO `fork_bcv_stack` VALUES ('197', '43', '2', '1.750', '0.000', '0.000', '0.000', '8.500', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('198', '43', '3', '1.750', '0.000', '0.000', '0.000', '10.000', '0.200', '2');
INSERT INTO `fork_bcv_stack` VALUES ('199', '43', '4', '1.750', '0.000', '0.000', '0.000', '11.000', '0.200', '2');
INSERT INTO `fork_bcv_stack` VALUES ('200', '45', '1', '5.000', '0.000', '0.000', '0.000', '17.000', '0.300', '1');
INSERT INTO `fork_bcv_stack` VALUES ('201', '47', '0', '5.250', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('202', '47', '1', '5.250', '0.000', '0.000', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('203', '47', '2', '5.250', '0.000', '0.000', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('204', '47', '3', '5.250', '0.000', '0.000', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('205', '47', '4', '5.250', '0.000', '0.000', '0.000', '12.000', '0.150', '1');
INSERT INTO `fork_bcv_stack` VALUES ('206', '47', '5', '5.250', '0.000', '0.000', '0.000', '11.000', '0.300', '2');
INSERT INTO `fork_bcv_stack` VALUES ('207', '47', '6', '5.250', '0.000', '0.000', '0.000', '17.000', '0.300', '2');
INSERT INTO `fork_bcv_stack` VALUES ('208', '47', '7', '5.250', '0.000', '0.000', '0.000', '0.000', '0.000', '99');
INSERT INTO `fork_bcv_stack` VALUES ('209', '47', '8', '5.250', '0.000', '0.000', '0.000', '8.000', '0.150', '1');
INSERT INTO `fork_bcv_stack` VALUES ('210', '49', '0', '5.300', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('211', '49', '1', '5.300', '0.000', '0.000', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('212', '49', '2', '5.300', '0.000', '0.000', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('213', '49', '3', '5.300', '0.000', '0.000', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('214', '49', '4', '5.300', '0.000', '0.000', '0.000', '12.000', '0.150', '1');
INSERT INTO `fork_bcv_stack` VALUES ('215', '49', '5', '5.300', '0.000', '0.000', '0.000', '11.000', '0.300', '2');
INSERT INTO `fork_bcv_stack` VALUES ('216', '49', '6', '5.300', '0.000', '0.000', '0.000', '17.000', '0.300', '2');
INSERT INTO `fork_bcv_stack` VALUES ('217', '49', '7', '5.300', '0.000', '0.000', '0.000', '0.000', '0.000', '99');
INSERT INTO `fork_bcv_stack` VALUES ('218', '49', '8', '5.300', '0.000', '0.000', '0.000', '8.000', '0.150', '1');
INSERT INTO `fork_bcv_stack` VALUES ('219', '51', '0', '5.300', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('220', '51', '1', '5.300', '0.000', '0.000', '0.000', '17.000', '0.100', '3');
INSERT INTO `fork_bcv_stack` VALUES ('221', '51', '2', '5.300', '0.000', '0.000', '0.000', '11.000', '0.250', '2');
INSERT INTO `fork_bcv_stack` VALUES ('222', '51', '3', '5.300', '0.000', '0.000', '0.000', '17.000', '0.300', '3');
INSERT INTO `fork_bcv_stack` VALUES ('223', '51', '4', '5.300', '0.000', '0.000', '0.000', '0.000', '0.000', '99');
INSERT INTO `fork_bcv_stack` VALUES ('224', '51', '5', '5.300', '0.000', '0.000', '0.000', '8.000', '0.150', '1');
INSERT INTO `fork_bcv_stack` VALUES ('231', '53', '0', '1.850', '0.000', '0.000', '0.000', '20.000', '0.100', '5');
INSERT INTO `fork_bcv_stack` VALUES ('232', '53', '1', '1.850', '0.000', '0.000', '0.000', '17.000', '0.100', '2');
INSERT INTO `fork_bcv_stack` VALUES ('233', '53', '2', '1.850', '0.000', '0.000', '0.000', '0.000', '0.000', '99');
INSERT INTO `fork_bcv_stack` VALUES ('234', '53', '3', '1.850', '0.000', '0.000', '0.000', '9.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('235', '53', '4', '1.850', '0.000', '0.000', '0.000', '10.000', '0.200', '2');
INSERT INTO `fork_bcv_stack` VALUES ('236', '53', '5', '1.850', '0.000', '0.000', '0.000', '11.000', '0.200', '1');
INSERT INTO `fork_bcv_stack` VALUES ('243', '61', '0', '5.250', '0.000', '0.000', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_bcv_stack` VALUES ('244', '61', '1', '5.250', '0.000', '0.000', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('245', '61', '2', '5.250', '0.000', '0.000', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_bcv_stack` VALUES ('246', '61', '3', '5.250', '0.000', '0.000', '0.000', '14.000', '0.150', '1');
INSERT INTO `fork_bcv_stack` VALUES ('247', '61', '4', '5.250', '0.000', '0.000', '0.000', '12.000', '0.200', '3');
INSERT INTO `fork_bcv_stack` VALUES ('248', '61', '5', '5.250', '0.000', '0.000', '0.000', '17.000', '0.300', '2');
INSERT INTO `fork_compression_stack` VALUES ('1', '1', '0', '6.000', '31.000', '0.100', '15');
INSERT INTO `fork_compression_stack` VALUES ('2', '1', '1', '6.000', '30.000', '0.000', '4');
INSERT INTO `fork_compression_stack` VALUES ('3', '1', '2', '6.000', '29.000', '0.000', '3');
INSERT INTO `fork_compression_stack` VALUES ('4', '1', '3', '6.000', '28.000', '0.000', '2');
INSERT INTO `fork_compression_stack` VALUES ('5', '1', '4', '6.000', '27.000', '0.000', '1');
INSERT INTO `fork_compression_stack` VALUES ('6', '1', '5', '6.000', '26.000', '0.000', '0');
INSERT INTO `fork_compression_stack` VALUES ('7', '1', '6', '6.000', '25.000', '0.000', '0');
INSERT INTO `fork_compression_stack` VALUES ('8', '1', '7', '6.000', '24.000', '0.000', '0');
INSERT INTO `fork_compression_stack` VALUES ('9', '1', '8', '6.000', '23.000', '0.000', '0');
INSERT INTO `fork_compression_stack` VALUES ('10', '1', '9', '6.000', '22.000', '0.000', '0');
INSERT INTO `fork_compression_stack` VALUES ('11', '1', '10', '6.000', '20.000', '0.000', '0');
INSERT INTO `fork_compression_stack` VALUES ('12', '1', '11', '6.000', '18.000', '0.000', '0');
INSERT INTO `fork_compression_stack` VALUES ('13', '1', '12', '6.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('279', '11', '0', '0.000', '24.000', '0.100', '7');
INSERT INTO `fork_compression_stack` VALUES ('280', '11', '1', '0.000', '22.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('281', '11', '2', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('282', '11', '3', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('283', '11', '4', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('284', '11', '5', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('285', '11', '6', '0.000', '8.500', '0.300', '1');
INSERT INTO `fork_compression_stack` VALUES ('286', '11', '7', '0.000', '18.000', '0.250', '0');
INSERT INTO `fork_compression_stack` VALUES ('287', '9', '0', '0.000', '23.000', '0.200', '1');
INSERT INTO `fork_compression_stack` VALUES ('288', '9', '1', '0.000', '22.000', '0.200', '1');
INSERT INTO `fork_compression_stack` VALUES ('289', '9', '2', '0.000', '21.000', '0.300', '1');
INSERT INTO `fork_compression_stack` VALUES ('346', '3', '0', '0.000', '31.000', '0.100', '15');
INSERT INTO `fork_compression_stack` VALUES ('347', '3', '1', '0.000', '30.000', '0.100', '3');
INSERT INTO `fork_compression_stack` VALUES ('348', '3', '2', '0.000', '29.000', '0.100', '3');
INSERT INTO `fork_compression_stack` VALUES ('349', '3', '3', '0.000', '28.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('350', '3', '4', '0.000', '27.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('351', '3', '5', '0.000', '26.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('352', '3', '6', '0.000', '25.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('353', '3', '7', '0.000', '24.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('354', '3', '8', '0.000', '22.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('355', '3', '9', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('356', '3', '10', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('357', '3', '11', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('358', '13', '0', '0.000', '24.000', '0.100', '3');
INSERT INTO `fork_compression_stack` VALUES ('359', '13', '1', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('360', '13', '2', '0.000', '24.000', '0.100', '6');
INSERT INTO `fork_compression_stack` VALUES ('361', '13', '3', '0.000', '22.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('362', '13', '4', '0.000', '18.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('363', '13', '5', '0.000', '16.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('364', '13', '6', '0.000', '14.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('365', '13', '7', '0.000', '12.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('366', '13', '8', '0.000', '9.500', '0.300', '1');
INSERT INTO `fork_compression_stack` VALUES ('367', '13', '10', '0.000', '18.000', '0.250', '1');
INSERT INTO `fork_compression_stack` VALUES ('368', '15', '0', '0.000', '24.000', '0.150', '2');
INSERT INTO `fork_compression_stack` VALUES ('369', '15', '1', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('370', '15', '2', '0.000', '24.000', '0.150', '3');
INSERT INTO `fork_compression_stack` VALUES ('371', '15', '3', '0.000', '22.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('372', '15', '4', '0.000', '20.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('373', '15', '5', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('374', '15', '6', '0.000', '18.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('375', '15', '7', '0.000', '16.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('376', '15', '8', '0.000', '14.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('377', '15', '9', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('378', '15', '10', '0.000', '9.500', '0.200', '0');
INSERT INTO `fork_compression_stack` VALUES ('379', '19', '0', '0.000', '24.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('380', '19', '1', '0.000', '14.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('381', '19', '2', '0.000', '24.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('382', '19', '3', '0.000', '22.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('383', '19', '4', '0.000', '20.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('384', '19', '5', '0.000', '18.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('385', '19', '6', '0.000', '16.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('386', '19', '7', '0.000', '14.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('387', '19', '8', '0.000', '8.500', '0.300', '0');
INSERT INTO `fork_compression_stack` VALUES ('388', '19', '10', '0.000', '16.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('389', '21', '0', '0.000', '24.000', '0.150', '4');
INSERT INTO `fork_compression_stack` VALUES ('390', '21', '1', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('391', '21', '2', '0.000', '24.000', '0.150', '5');
INSERT INTO `fork_compression_stack` VALUES ('392', '21', '3', '0.000', '22.000', '0.150', '2');
INSERT INTO `fork_compression_stack` VALUES ('393', '21', '4', '0.000', '20.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('394', '21', '5', '0.000', '18.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('395', '21', '6', '0.000', '16.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('396', '21', '7', '0.000', '14.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('397', '21', '8', '0.000', '12.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('398', '21', '9', '0.000', '9.500', '0.200', '1');
INSERT INTO `fork_compression_stack` VALUES ('399', '23', '0', '0.000', '24.000', '0.150', '4');
INSERT INTO `fork_compression_stack` VALUES ('400', '23', '1', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('401', '23', '2', '0.000', '24.000', '0.150', '5');
INSERT INTO `fork_compression_stack` VALUES ('402', '23', '3', '0.000', '22.000', '0.150', '2');
INSERT INTO `fork_compression_stack` VALUES ('403', '23', '4', '0.000', '20.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('404', '23', '5', '0.000', '18.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('405', '23', '6', '0.000', '16.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('406', '23', '7', '0.000', '14.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('407', '23', '8', '0.000', '12.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('408', '23', '9', '0.000', '9.500', '0.200', '1');
INSERT INTO `fork_compression_stack` VALUES ('409', '25', '0', '0.000', '24.000', '0.100', '3');
INSERT INTO `fork_compression_stack` VALUES ('410', '25', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('411', '25', '2', '0.000', '24.000', '0.100', '7');
INSERT INTO `fork_compression_stack` VALUES ('412', '25', '3', '0.000', '22.000', '0.100', '2');
INSERT INTO `fork_compression_stack` VALUES ('413', '25', '4', '0.000', '20.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('414', '25', '5', '0.000', '18.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('415', '25', '6', '0.000', '16.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('416', '25', '7', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('417', '25', '8', '0.000', '9.000', '0.300', '1');
INSERT INTO `fork_compression_stack` VALUES ('418', '25', '10', '0.000', '16.000', '0.250', '1');
INSERT INTO `fork_compression_stack` VALUES ('419', '27', '0', '0.000', '24.000', '0.100', '3');
INSERT INTO `fork_compression_stack` VALUES ('420', '27', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('421', '27', '2', '0.000', '24.000', '0.100', '7');
INSERT INTO `fork_compression_stack` VALUES ('422', '27', '3', '0.000', '22.000', '0.100', '2');
INSERT INTO `fork_compression_stack` VALUES ('423', '27', '4', '0.000', '29.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('424', '27', '5', '0.000', '18.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('425', '27', '6', '0.000', '16.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('426', '27', '7', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('427', '27', '8', '0.000', '9.000', '0.300', '1');
INSERT INTO `fork_compression_stack` VALUES ('428', '27', '10', '0.000', '16.000', '0.250', '1');
INSERT INTO `fork_compression_stack` VALUES ('429', '29', '0', '0.000', '24.000', '0.100', '2');
INSERT INTO `fork_compression_stack` VALUES ('430', '29', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('431', '29', '2', '0.000', '24.000', '0.100', '6');
INSERT INTO `fork_compression_stack` VALUES ('432', '29', '3', '0.000', '22.000', '0.100', '2');
INSERT INTO `fork_compression_stack` VALUES ('433', '29', '4', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('434', '29', '5', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('435', '29', '6', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('436', '29', '7', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('437', '29', '8', '0.000', '9.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('438', '29', '10', '0.000', '18.000', '0.250', '1');
INSERT INTO `fork_compression_stack` VALUES ('439', '33', '0', '0.000', '24.000', '0.100', '2');
INSERT INTO `fork_compression_stack` VALUES ('440', '33', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('441', '33', '2', '0.000', '24.000', '0.100', '6');
INSERT INTO `fork_compression_stack` VALUES ('442', '33', '3', '0.000', '22.000', '0.100', '2');
INSERT INTO `fork_compression_stack` VALUES ('443', '33', '4', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('444', '33', '5', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('445', '33', '6', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('446', '33', '7', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('447', '33', '8', '0.000', '9.000', '0.300', '1');
INSERT INTO `fork_compression_stack` VALUES ('448', '33', '10', '0.000', '18.000', '0.250', '0');
INSERT INTO `fork_compression_stack` VALUES ('449', '35', '0', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_compression_stack` VALUES ('450', '35', '1', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('451', '35', '2', '0.000', '24.000', '0.100', '10');
INSERT INTO `fork_compression_stack` VALUES ('452', '35', '3', '0.000', '22.000', '0.100', '2');
INSERT INTO `fork_compression_stack` VALUES ('453', '35', '4', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('454', '35', '5', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('455', '35', '6', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('456', '35', '7', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('457', '35', '8', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('458', '35', '9', '0.000', '9.500', '0.300', '1');
INSERT INTO `fork_compression_stack` VALUES ('459', '37', '0', '0.000', '24.000', '0.150', '3');
INSERT INTO `fork_compression_stack` VALUES ('460', '39', '0', '0.000', '24.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('461', '39', '1', '0.000', '16.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('462', '39', '2', '0.000', '24.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('463', '39', '3', '0.000', '22.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('464', '39', '4', '0.000', '20.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('465', '39', '5', '0.000', '18.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('466', '39', '6', '0.000', '16.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('467', '39', '7', '0.000', '14.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('468', '39', '8', '0.000', '10.000', '0.300', '0');
INSERT INTO `fork_compression_stack` VALUES ('469', '39', '9', '0.000', '16.000', '0.250', '0');
INSERT INTO `fork_compression_stack` VALUES ('470', '41', '0', '0.000', '17.000', '0.100', '3');
INSERT INTO `fork_compression_stack` VALUES ('471', '41', '1', '0.000', '9.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('472', '41', '2', '0.000', '17.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('473', '41', '3', '0.000', '15.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('474', '41', '4', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('475', '41', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('476', '41', '6', '0.000', '10.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('477', '41', '7', '0.000', '9.000', '0.200', '1');
INSERT INTO `fork_compression_stack` VALUES ('478', '41', '8', '0.000', '10.000', '0.200', '4');
INSERT INTO `fork_compression_stack` VALUES ('479', '43', '0', '0.000', '30.000', '0.100', '6');
INSERT INTO `fork_compression_stack` VALUES ('480', '43', '1', '0.000', '19.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('481', '43', '2', '0.000', '29.000', '0.100', '4');
INSERT INTO `fork_compression_stack` VALUES ('482', '43', '3', '0.000', '28.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('483', '43', '4', '0.000', '27.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('484', '43', '5', '0.000', '26.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('485', '43', '6', '0.000', '25.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('486', '43', '7', '0.000', '24.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('487', '43', '8', '0.000', '23.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('488', '43', '9', '0.000', '22.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('489', '43', '10', '0.000', '21.000', '0.150', '1');
INSERT INTO `fork_compression_stack` VALUES ('490', '43', '11', '0.000', '20.000', '0.200', '0');
INSERT INTO `fork_compression_stack` VALUES ('491', '45', '0', '0.000', '16.000', '0.100', '3');
INSERT INTO `fork_compression_stack` VALUES ('492', '45', '1', '0.000', '10.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('493', '45', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('494', '45', '3', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('495', '45', '4', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('496', '45', '5', '0.000', '10.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('497', '47', '0', '0.000', '32.000', '0.100', '16');
INSERT INTO `fork_compression_stack` VALUES ('498', '47', '1', '0.000', '30.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('499', '47', '2', '0.000', '28.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('500', '47', '3', '0.000', '36.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('501', '47', '4', '0.000', '34.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('502', '47', '5', '0.000', '22.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('503', '47', '6', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('504', '47', '7', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('505', '47', '8', '0.000', '16.000', '0.250', '1');
INSERT INTO `fork_compression_stack` VALUES ('506', '49', '0', '0.000', '32.000', '0.100', '16');
INSERT INTO `fork_compression_stack` VALUES ('507', '49', '1', '0.000', '30.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('508', '49', '2', '0.000', '28.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('509', '49', '3', '0.000', '26.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('510', '49', '4', '0.000', '24.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('511', '49', '5', '0.000', '22.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('512', '49', '6', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('513', '49', '7', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('514', '49', '8', '0.000', '16.000', '0.250', '1');
INSERT INTO `fork_compression_stack` VALUES ('515', '51', '0', '0.000', '32.000', '0.100', '18');
INSERT INTO `fork_compression_stack` VALUES ('516', '51', '1', '0.000', '30.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('517', '51', '2', '0.000', '28.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('518', '51', '3', '0.000', '26.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('519', '51', '4', '0.000', '24.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('520', '51', '5', '0.000', '22.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('521', '51', '6', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('522', '51', '7', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_compression_stack` VALUES ('523', '51', '8', '0.000', '17.000', '0.250', '1');
INSERT INTO `fork_compression_stack` VALUES ('540', '53', '0', '0.000', '30.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('541', '53', '1', '0.000', '24.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('542', '53', '2', '0.000', '30.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('543', '53', '3', '0.000', '29.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('544', '53', '4', '0.000', '28.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('545', '53', '5', '0.000', '27.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('546', '53', '6', '0.000', '26.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('547', '53', '7', '0.000', '25.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('548', '53', '8', '0.000', '24.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('549', '53', '9', '0.000', '23.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('550', '53', '10', '0.000', '22.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('551', '53', '11', '0.000', '21.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('552', '53', '12', '0.000', '20.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('553', '53', '13', '0.000', '19.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('554', '53', '14', '0.000', '18.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('555', '53', '15', '0.000', '17.000', '0.200', '0');
INSERT INTO `fork_compression_stack` VALUES ('569', '61', '0', '0.000', '32.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('570', '61', '1', '0.000', '30.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('571', '61', '2', '0.000', '28.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('572', '61', '3', '0.000', '26.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('573', '61', '4', '0.000', '24.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('574', '61', '5', '0.000', '22.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('575', '61', '6', '0.000', '20.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('576', '61', '7', '0.000', '19.000', '0.100', '0');
INSERT INTO `fork_compression_stack` VALUES ('577', '61', '8', '0.000', '18.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('578', '61', '9', '0.000', '17.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('579', '61', '10', '0.000', '16.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('580', '61', '11', '0.000', '15.000', '0.150', '0');
INSERT INTO `fork_compression_stack` VALUES ('581', '61', '12', '0.000', '14.000', '0.250', '0');
INSERT INTO `fork_compression_stack` VALUES ('582', '63', '0', '0.000', '17.400', '0.200', '1');
INSERT INTO `fork_compression_stack` VALUES ('583', '63', '2', '0.000', '17.400', '0.200', '3');
INSERT INTO `fork_compression_stack` VALUES ('584', '65', '0', '0.000', '17.400', '0.200', '1');
INSERT INTO `fork_compression_stack` VALUES ('585', '65', '2', '0.000', '17.400', '0.200', '3');
INSERT INTO `fork_lsv_stack` VALUES ('1', '41', '0', '0.000', '17.000', '0.400', '1');
INSERT INTO `fork_lsv_stack` VALUES ('2', '47', '0', '0.000', '22.000', '0.100', '2');
INSERT INTO `fork_lsv_stack` VALUES ('3', '47', '1', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_lsv_stack` VALUES ('4', '47', '2', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_lsv_stack` VALUES ('5', '47', '3', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_lsv_stack` VALUES ('6', '47', '4', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_lsv_stack` VALUES ('7', '47', '5', '0.000', '11.000', '0.250', '5');
INSERT INTO `fork_lsv_stack` VALUES ('8', '49', '0', '0.000', '22.000', '0.100', '2');
INSERT INTO `fork_lsv_stack` VALUES ('9', '49', '1', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_lsv_stack` VALUES ('10', '49', '2', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_lsv_stack` VALUES ('11', '49', '3', '0.000', '11.000', '0.250', '6');
INSERT INTO `fork_lsv_stack` VALUES ('12', '51', '0', '0.000', '11.000', '0.250', '2');
INSERT INTO `fork_lsv_stack` VALUES ('14', '61', '0', '0.000', '11.000', '0.250', '3');
INSERT INTO `fork_rebound_stack` VALUES ('6', '58', '0', '2.000', '0.000', '3.000', '2');
INSERT INTO `fork_rebound_stack` VALUES ('9', '66', '0', '3.000', '9.999', '6.000', '5');
INSERT INTO `fork_rebound_stack` VALUES ('10', '1', '0', '6.000', '20.000', '0.100', '2');
INSERT INTO `fork_rebound_stack` VALUES ('11', '1', '1', '6.000', '19.000', '0.000', '1');
INSERT INTO `fork_rebound_stack` VALUES ('12', '1', '2', '6.000', '18.000', '0.000', '0');
INSERT INTO `fork_rebound_stack` VALUES ('13', '1', '3', '6.000', '17.000', '0.000', '0');
INSERT INTO `fork_rebound_stack` VALUES ('14', '1', '4', '6.000', '15.000', '0.000', '0');
INSERT INTO `fork_rebound_stack` VALUES ('15', '1', '5', '6.000', '13.000', '0.100', '0');
INSERT INTO `fork_rebound_stack` VALUES ('16', '1', '6', '6.000', '11.000', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('169', '11', '0', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_rebound_stack` VALUES ('170', '11', '1', '0.000', '22.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('171', '11', '2', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('172', '11', '3', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('173', '11', '4', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('174', '11', '5', '0.000', '8.500', '0.300', '2');
INSERT INTO `fork_rebound_stack` VALUES ('175', '11', '6', '0.000', '16.000', '0.250', '0');
INSERT INTO `fork_rebound_stack` VALUES ('176', '9', '0', '0.000', '22.000', '0.100', '4');
INSERT INTO `fork_rebound_stack` VALUES ('210', '3', '0', '0.000', '20.000', '0.100', '2');
INSERT INTO `fork_rebound_stack` VALUES ('211', '3', '1', '0.000', '19.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('212', '3', '2', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('213', '3', '3', '0.000', '17.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('214', '3', '4', '0.000', '15.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('215', '3', '5', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('216', '3', '6', '0.000', '11.000', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('217', '13', '0', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_rebound_stack` VALUES ('218', '13', '1', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('219', '13', '2', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('220', '13', '3', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('221', '13', '4', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('222', '13', '5', '0.000', '8.500', '0.300', '2');
INSERT INTO `fork_rebound_stack` VALUES ('223', '15', '0', '0.000', '20.000', '0.100', '3');
INSERT INTO `fork_rebound_stack` VALUES ('224', '15', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('225', '15', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('226', '15', '3', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('227', '15', '4', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('228', '15', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('229', '15', '6', '0.000', '11.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('230', '19', '0', '0.000', '20.000', '0.100', '3');
INSERT INTO `fork_rebound_stack` VALUES ('231', '19', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('232', '19', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('233', '19', '3', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('234', '19', '4', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('235', '19', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('236', '19', '6', '0.000', '11.000', '0.300', '1');
INSERT INTO `fork_rebound_stack` VALUES ('237', '21', '0', '0.000', '20.000', '0.100', '3');
INSERT INTO `fork_rebound_stack` VALUES ('238', '21', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('239', '21', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('240', '21', '3', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('241', '21', '4', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('242', '21', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('243', '21', '6', '0.000', '11.000', '0.300', '1');
INSERT INTO `fork_rebound_stack` VALUES ('244', '23', '0', '0.000', '20.000', '0.100', '0');
INSERT INTO `fork_rebound_stack` VALUES ('245', '23', '1', '0.000', '13.000', '0.100', '0');
INSERT INTO `fork_rebound_stack` VALUES ('246', '23', '2', '0.000', '16.000', '0.100', '0');
INSERT INTO `fork_rebound_stack` VALUES ('247', '23', '3', '0.000', '14.000', '0.100', '0');
INSERT INTO `fork_rebound_stack` VALUES ('248', '23', '4', '0.000', '13.000', '0.100', '0');
INSERT INTO `fork_rebound_stack` VALUES ('249', '23', '5', '0.000', '12.000', '0.100', '0');
INSERT INTO `fork_rebound_stack` VALUES ('250', '23', '6', '0.000', '11.000', '0.100', '0');
INSERT INTO `fork_rebound_stack` VALUES ('251', '23', '8', '0.000', '14.000', '0.250', '0');
INSERT INTO `fork_rebound_stack` VALUES ('252', '25', '0', '0.000', '20.000', '0.100', '3');
INSERT INTO `fork_rebound_stack` VALUES ('253', '25', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('254', '25', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('255', '25', '3', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('256', '25', '4', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('257', '25', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('258', '25', '6', '0.000', '11.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('259', '27', '0', '0.000', '20.000', '0.100', '3');
INSERT INTO `fork_rebound_stack` VALUES ('260', '27', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('261', '27', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('262', '27', '3', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('263', '27', '4', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('264', '27', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('265', '27', '6', '0.000', '11.000', '0.300', '0');
INSERT INTO `fork_rebound_stack` VALUES ('266', '29', '0', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_rebound_stack` VALUES ('267', '29', '1', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('268', '29', '2', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('269', '29', '3', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('270', '29', '4', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('271', '29', '5', '0.000', '8.500', '0.300', '2');
INSERT INTO `fork_rebound_stack` VALUES ('272', '33', '0', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_rebound_stack` VALUES ('273', '33', '1', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('274', '33', '2', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('275', '33', '3', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('276', '33', '4', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('277', '33', '5', '0.000', '8.500', '0.300', '2');
INSERT INTO `fork_rebound_stack` VALUES ('278', '35', '0', '0.000', '24.000', '0.100', '4');
INSERT INTO `fork_rebound_stack` VALUES ('279', '35', '1', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('280', '35', '2', '0.000', '20.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('281', '35', '3', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('282', '35', '4', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('283', '35', '5', '0.000', '8.500', '0.300', '2');
INSERT INTO `fork_rebound_stack` VALUES ('284', '35', '6', '0.000', '16.000', '0.250', '1');
INSERT INTO `fork_rebound_stack` VALUES ('285', '39', '0', '0.000', '20.000', '0.100', '3');
INSERT INTO `fork_rebound_stack` VALUES ('286', '39', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('287', '39', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('288', '39', '3', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('289', '39', '4', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('290', '39', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('291', '39', '6', '0.000', '11.000', '0.300', '0');
INSERT INTO `fork_rebound_stack` VALUES ('292', '41', '0', '0.000', '17.000', '0.100', '2');
INSERT INTO `fork_rebound_stack` VALUES ('293', '41', '1', '0.000', '9.000', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('294', '41', '2', '0.000', '17.000', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('295', '41', '3', '0.000', '14.000', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('296', '41', '4', '0.000', '12.000', '0.200', '2');
INSERT INTO `fork_rebound_stack` VALUES ('297', '41', '5', '0.000', '14.000', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('298', '43', '0', '0.000', '20.000', '0.100', '2');
INSERT INTO `fork_rebound_stack` VALUES ('299', '43', '1', '0.000', '10.000', '0.150', '1');
INSERT INTO `fork_rebound_stack` VALUES ('300', '43', '2', '0.000', '19.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('301', '43', '3', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('302', '43', '4', '0.000', '17.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('303', '43', '5', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('304', '43', '6', '0.000', '15.000', '0.150', '1');
INSERT INTO `fork_rebound_stack` VALUES ('305', '43', '7', '0.000', '14.000', '0.150', '1');
INSERT INTO `fork_rebound_stack` VALUES ('306', '43', '8', '0.000', '13.000', '0.150', '1');
INSERT INTO `fork_rebound_stack` VALUES ('307', '43', '9', '0.000', '12.000', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('308', '45', '0', '0.000', '16.000', '0.100', '2');
INSERT INTO `fork_rebound_stack` VALUES ('309', '45', '1', '0.000', '10.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('310', '45', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('311', '45', '3', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('312', '45', '4', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('313', '45', '5', '0.000', '10.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('314', '45', '6', '0.000', '8.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('315', '47', '0', '0.000', '20.000', '0.100', '3');
INSERT INTO `fork_rebound_stack` VALUES ('316', '47', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('317', '47', '2', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('318', '47', '3', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('319', '47', '4', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('320', '47', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('321', '47', '6', '0.000', '10.000', '0.250', '1');
INSERT INTO `fork_rebound_stack` VALUES ('322', '49', '0', '0.000', '20.000', '0.100', '3');
INSERT INTO `fork_rebound_stack` VALUES ('323', '49', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('324', '49', '2', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('325', '49', '3', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('326', '49', '4', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('327', '49', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('328', '49', '6', '0.000', '10.000', '0.250', '1');
INSERT INTO `fork_rebound_stack` VALUES ('329', '51', '0', '0.000', '20.000', '0.100', '4');
INSERT INTO `fork_rebound_stack` VALUES ('330', '51', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('331', '51', '2', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('332', '51', '3', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('333', '51', '4', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('334', '51', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('335', '51', '6', '0.000', '10.000', '0.250', '1');
INSERT INTO `fork_rebound_stack` VALUES ('348', '53', '0', '0.000', '18.000', '0.100', '2');
INSERT INTO `fork_rebound_stack` VALUES ('349', '53', '1', '0.000', '17.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('350', '53', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('351', '53', '3', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('352', '53', '4', '0.000', '15.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('353', '53', '5', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('354', '53', '6', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('355', '53', '7', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('356', '53', '8', '0.000', '11.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('357', '53', '9', '0.000', '10.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('358', '53', '10', '0.000', '9.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('359', '53', '11', '0.000', '8.500', '0.200', '0');
INSERT INTO `fork_rebound_stack` VALUES ('367', '61', '0', '0.000', '20.000', '0.100', '3');
INSERT INTO `fork_rebound_stack` VALUES ('368', '61', '1', '0.000', '13.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('369', '61', '2', '0.000', '18.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('370', '61', '3', '0.000', '16.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('371', '61', '4', '0.000', '14.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('372', '61', '5', '0.000', '12.000', '0.100', '1');
INSERT INTO `fork_rebound_stack` VALUES ('373', '61', '6', '0.000', '11.000', '0.250', '0');
INSERT INTO `fork_rebound_stack` VALUES ('374', '63', '0', '0.000', '17.400', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('375', '63', '2', '0.000', '17.400', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('376', '63', '3', '0.000', '17.400', '0.200', '0');
INSERT INTO `fork_rebound_stack` VALUES ('377', '65', '0', '0.000', '17.400', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('378', '65', '2', '0.000', '17.400', '0.200', '1');
INSERT INTO `fork_rebound_stack` VALUES ('379', '65', '3', '0.000', '17.400', '0.100', '5');
INSERT INTO `fork_spec` VALUES ('1', '1.00', '0.000', '0', '0', '0', '0', '0', '0', '', null, 'No LSV valving stem does not permit -- 2008-01-29  05:12:31');
INSERT INTO `fork_spec` VALUES ('2', '1.00', '0.470', '12', '12', '495', '490', '406', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('3', '1.00', '0.460', '7', '9', '0', '0', '398', '0', 'SS05', '1', '-- 2008-03-14  08:23:05 -- 2008-03-14  09:38:57');
INSERT INTO `fork_spec` VALUES ('4', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('5', '1.00', '0.000', '0', '0', '0', '0', '0', '0', '', '5', null);
INSERT INTO `fork_spec` VALUES ('6', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('7', '1.00', '0.000', '0', '0', '0', '0', '0', '0', '', '4', null);
INSERT INTO `fork_spec` VALUES ('8', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('9', '1.00', '0.300', '0', '0', '0', '0', '0', '0', 'SAE 5', '2', null);
INSERT INTO `fork_spec` VALUES ('10', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('11', '1.00', '0.350', '20', '20', '0', '0', '0', '0', '5W', '3', null);
INSERT INTO `fork_spec` VALUES ('12', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('13', '1.00', '0.000', '0', '0', '0', '432', '0', '110', '5W', '6', null);
INSERT INTO `fork_spec` VALUES ('14', '1.00', '0.000', '0', '0', '0', '432', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('15', '1.00', '0.420', '0', '0', '0', '484', '375', '0', '', '7', null);
INSERT INTO `fork_spec` VALUES ('16', '1.00', '0.000', '0', '0', '0', '484', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('17', '1.00', '0.000', '0', '0', '0', '0', '0', '0', '', '8', null);
INSERT INTO `fork_spec` VALUES ('18', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('19', '1.00', '0.440', '0', '0', '0', '0', '0', '0', '', '9', null);
INSERT INTO `fork_spec` VALUES ('20', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('21', '1.00', '0.440', '14', '21', '0', '484', '0', '0', '', '10', null);
INSERT INTO `fork_spec` VALUES ('22', '1.00', '0.000', '0', '0', '0', '484', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('23', '1.00', '0.450', '14', '21', '0', '484', '385', '0', '5W', '11', null);
INSERT INTO `fork_spec` VALUES ('24', '1.00', '0.000', '0', '0', '0', '484', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('25', '1.00', '0.460', '0', '0', '0', '0', '0', '0', '', '12', null);
INSERT INTO `fork_spec` VALUES ('26', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('27', '1.00', '0.450', '20', '21', '0', '0', '0', '0', '5', '13', null);
INSERT INTO `fork_spec` VALUES ('28', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('29', '1.00', '0.420', '0', '0', '0', '500', '0', '130', '5W', '14', null);
INSERT INTO `fork_spec` VALUES ('30', '1.00', '0.000', '0', '0', '0', '500', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('31', '1.00', '0.440', '0', '0', '0', '0', '0', '0', '', '15', null);
INSERT INTO `fork_spec` VALUES ('32', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('33', '1.00', '0.420', '0', '0', '0', '500', '0', '0', '5W', '16', null);
INSERT INTO `fork_spec` VALUES ('34', '1.00', '0.000', '0', '0', '0', '500', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('35', '1.00', '0.460', '20', '18', '0', '0', '0', '100', '5W', '17', null);
INSERT INTO `fork_spec` VALUES ('36', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('37', '1.00', '0.490', '0', '0', '0', '0', '0', '0', '', '18', null);
INSERT INTO `fork_spec` VALUES ('38', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('39', '1.00', '0.460', '20', '21', '0', '0', '375', '0', '5W', '19', null);
INSERT INTO `fork_spec` VALUES ('40', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('41', '1.00', '0.280', '0', '0', '0', '438', '0', '0', 'SS05', '20', null);
INSERT INTO `fork_spec` VALUES ('42', '1.00', '0.000', '0', '0', '0', '438', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('43', '1.00', '0.440', '0', '0', '0', '487', '370', '0', 'SS05', '21', null);
INSERT INTO `fork_spec` VALUES ('44', '1.00', '0.000', '0', '0', '0', '487', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('45', '1.00', '0.290', '0', '0', '0', '417', '0', '0', '', '22', null);
INSERT INTO `fork_spec` VALUES ('46', '1.00', '0.000', '0', '0', '0', '417', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('47', '1.00', '0.000', '0', '0', '0', '444', '0', '0', '', '23', null);
INSERT INTO `fork_spec` VALUES ('48', '1.00', '0.000', '0', '0', '0', '444', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('49', '1.00', '0.440', '0', '0', '0', '453', '0', '0', '', '24', null);
INSERT INTO `fork_spec` VALUES ('50', '1.00', '0.000', '0', '0', '0', '453', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('51', '1.00', '0.470', '0', '0', '0', '453', '0', '0', '', '25', 'Has LSV W/O Valving -- 2008-03-15  19:53:23');
INSERT INTO `fork_spec` VALUES ('52', '1.00', '0.000', '0', '0', '0', '453', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('53', '1.00', '0.450', '0', '0', '0', '0', '0', '0', '5W', '26', null);
INSERT INTO `fork_spec` VALUES ('54', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('61', '1.00', '0.480', '0', '0', '0', '0', '0', '0', '', '27', null);
INSERT INTO `fork_spec` VALUES ('62', '1.00', '0.000', '0', '0', '0', '465', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('63', '1.00', '0.290', '0', '0', '0', '0', '0', '0', '', '28', 'First Shim is Support Shim on Fork Compression and Fork Rebound -- 2008-03-16  13:58:36');
INSERT INTO `fork_spec` VALUES ('64', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec` VALUES ('65', '1.00', '0.290', '0', '0', '0', '0', '0', '0', '', '29', 'First shim is Support Shim for Fork Compression and Fork Rebound -- 2008-03-16  14:06:14');
INSERT INTO `fork_spec` VALUES ('66', '1.00', '0.000', '0', '0', '0', '0', '0', '0', null, null, null);
INSERT INTO `fork_spec_general_info` VALUES ('1', 'Std. Spring Rate (kg)		.46 kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		Rates 1.74gk Showa = 1.9kg 	Rebound Adjuster Rod Length (mm) 		386mm	USD Bot T-Clamp    Diam .(mm) 		58.5mm\nSpring Dimension (mm)  		494.5mm	Press. Spring Dimension  (mm)		26.3x 99.3mm	CTG ROD DIA. (mm) 		12.5mm	Fork Overall Length (mm) 		945mm\nSpring Chamber  (Length)  (mm)		490mm	Compression Assembly Length (mm)		161.6mm	Rebound Piston Bleed		1.3x1mm	Outer Tube Length (Upper)  (mm)		571mm\nSpring Preload  (mm)		6mm	Compression Stem Bleed (mm) 		2mm	Oil Lock Collar O.D. (mm) 		28.15mm	Stroke/Travel (mm)		315mm\nStd. Oil Level  (CC/MM)		398cc	Compression           Refill (mm)		0.30mm	Oil Lock Collar Color 		Silver 	BCV Float (mm) 		0.17mm\nOil Level Range (CC)		320-420cc	Sub Tank or Cartridge Assembly Length (mm)		603mm	Inner Tube Length (Chrome Tube) (mm)		558mm**	BCV Collar (mm)		1.87mm\nOil Type 		SS05	CTG I.D.   (mm)		23mm	Inner Tube I.D.      (Chrome Tube) (mm)					\nComp. Adjuster      Clicks/Turns         		Standard =   -7 Clicks	Rebound Rod Length (mm)		390mm**	Inner Tube O.D.  (Chrome Tube) (mm) 					\n Rebound Adjuster  Clicks/Turns          		Standard =   -9 Clicks	Rebound Rod           End (mm)		62mm	USD Top T-Clamp Diam. (mm)    		52.9mm\n\nNotes: 											\nCartridge w/Rod = 929mm						Shorter Cartridge Seal Head 16.3mm (40.2mm overall) 				Compression Stem has 2.4mm Center Bleed x1				Subtank has 3mm x 4 Bleed Ports			\nCompression Stem has 2.6mm Side Bleed x2						MENF SA-1					\nNew Rebound Piston 16mm Taller 					**Chrome Length measured from Top of Knuckle to Top of Tube		**Rebound Rod = Bottom of Stem to End of Threads 				**Chrome Tube without Knuckle = 588mm			\nRebound Stem = 62mm						F.B. Piston sits 10.1mm from Top of Tube 					New BCV Seat 7.4mm Tall x 19mm O.D. 					Cartridge Tube without Subtank = 427mm				Old 3.6mm Spring Seat Spacer 						Bottoming Cone = 66.5mm Overall Length');
INSERT INTO `fork_spec_general_info` VALUES ('2', 'Std. Spring Rate (kg)  Manual Calls for .32kg		.30 kg	Std. Pressure Spring (kg)  		N/A	Fork Overall Length (mm) 		735mm	Stroke/Travel (mm)		220mm     8.7 \"\nSpring Dimension (mm)  		29.9x22.7x 378mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		453mm	BCV Float (mm) 		2.7mm\nSpring Chamber  (Length)  (mm)		368	Compression Assembly Length (mm)		N/A	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		\nSpring Preload  (mm)		10mm	Sub Tank Cartridge Assembly Length (mm)		341mm	Inner Tube I.D.      (Chrome Tube) (mm)			Spring Markings		\nStd. Oil Level  (CC)		120mm	Rebound Rod Length (mm)		460mm	USD Top T-Clamp Diam. (mm)    		45mm			\nOil Level Range (CC)		100-150mm	Rebound Adjuster Rod Length (mm) 		 	USD Bot T-Clamp    Diam .(mm) 		48mm			\nOil Type 		SAE 5	Rebound Piston Bleed		1x2mm	CTG ROD DIA. (mm) 		9mm			\nComp. Adjuster      Clicks/Turns (Max)		Out (-)  	Rebound Adjuster  Clicks/Turns (Max)		Out (-)    	CTG I.D.   (mm)		26mm');
INSERT INTO `fork_spec_general_info` VALUES ('3', 'Std. Spring Rate (kg) Rated .34kg-.35kg		3,4 N/mm or .35kg 	Std. Pressure Spring (kg)  		N/A	Fork Overall Length (mm) 		840mm	Stroke/Travel (mm)		275mm / 10.82in\nSpring Dimension (mm)  		38x425mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)			BCV Float (mm) 		1.4mm \nSpring Chamber  (Length)  (mm)			Compression Assembly Length (mm)		N/A	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		\nSpring Preload  (mm)		Std. Spacer  +/-13mm	Sub Tank Cartridge Assembly Length (mm)		N/A	USD Top T-Clamp Diam. (mm)    			Spring Markings		\nStd. Oil Level  (CC)		110mm	Rebound Rod Length (mm)		475mm	USD Bot T-Clamp    Diam .(mm) 					\nOil Level Range (CC)		90-140mm	Rebound Adjuster Rod Length (mm) 		442mm	CTG ROD DIA. (mm) 		12mm			\nOil Type 		5W	Rebound Piston Bleed		None 	CTG I.D.   (mm)		28mm			\nStd. Compression Adj. Position 		20 Clicks	Std. Rebound Adj. Position 		20 Clicks						\nComp. Adjuster      Clicks/Turns (Max-)		 	Rebound Adjuster  Clicks/Turns (Max-)');
INSERT INTO `fork_spec_general_info` VALUES ('4', 'Std. Spring Rate (kg)		4.4N/MM   .45kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		1.2 Bar	Fork Overall Length (mm) 		942mm	Stroke/Travel (mm)		300mm/   11.8in\nSpring Dimension (mm)  		43.2X33   X482MM	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		576mm	BCV Float (mm) 		.6F\nSpring Chamber  (Length)  (mm)		484MM	Compression Assembly Length (mm)		158mm	Inner Tube Length (Chrome Tube) (mm)		595mm     w/o Lug 	BCV Collar (mm)		2.5 Fixed\nSpring Preload  (mm)		 +/- 8mm	Sub Tank Cartridge Assembly Length (mm)		604mm	Inner Tube I.D.      (Chrome Tube) (mm)		43.5mm +/-	Spring Markings		N/A\nStd. Oil Level  (CC)		385cc	Rebound Rod Length (mm)		435mm	USD Top T-Clamp Diam. (mm)    		54mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		370mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Type 		5W	Rebound Piston Bleed		N/A	CTG ROD DIA. (mm) 		12mm			\nStd. Compression Adj. Position 		14 Clicks	Std. Rebound Adj. Position 		21 Clicks	CTG I.D.   (mm)		23mm			\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('7', 'Std. Spring Rate (kg)		.42kg	Bladder Type Nitrogen Pressure 		1.2 Bar	Fork Overall Length (mm) 		942mm	Stroke/Travel (mm)		302mm/         11.8 in\nSpring Dimension (mm)  		43.2x33.1x  485mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		576mm	BCV Float (mm) 		.6F\nSpring Chamber  (Length)  (mm)		484mm	Compression Assembly Length (mm)		158mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		2.5 Fixed\nSpring Preload  (mm)		w/Spacer 5mm	Sub Tank Cartridge Assembly Length (mm)		604mm	Inner Tube I.D.      (Chrome Tube) (mm)		 	Spring Markings		N/A\nStd. Oil Level  (CC)		375cc	Rebound Rod Length (mm)		436mm	USD Top T-Clamp Diam. (mm)    		54mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		370mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Type 		5W	Rebound Piston Bleed		N/A	CTG ROD DIA. (mm) 		12mm			\nStd. Compression Adj. Position 		14 Clicks	Std. Rebound Adj. Position 		21 Clicks	CTG I.D.   (mm)		23mm			\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('5', 'Std. Spring Rate (kg)		4.8 N/mm    .49 kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		1.2 Bar	Rebound Adjuster Rod Length (mm) 			USD Bot T-Clamp    Diam .(mm) 		\nSpring Dimension (mm)  		43.3x32.9     x  487mm	Press. Spring Dimension  (mm)		N/A	CTG ROD DIA. (mm) 			Fork Overall Length (mm) 		\nSpring Chamber  (Length)  (mm)		484mm	Compression Assembly Length (mm)			Rebound Piston Bleed			Outer Tube Length (Upper)  (mm)		\nSpring Preload  (mm)		w/Spacer 6mm	Compression Stem Bleed (mm) 			Oil Lock Collar O.D. (mm) 			Stroke/Travel (mm)		\nStd. Oil Level  (CC/MM)		385cc	Compression           Refill (mm)			Oil Lock Collar Color 			BCV Float (mm) 		.45mm\nOil Level Range (CC)			Sub Tank or Cartridge Assembly Length (mm)			Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		\nOil Type 		WP 5W	CTG I.D.   (mm)			Inner Tube I.D.      (Chrome Tube) (mm)					\nComp. Adjuster      Clicks/Turns       		Standard =   (-) 14 Clicks  	Rebound Rod Length (mm)			Inner Tube O.D.  (Chrome Tube) (mm) 					\n Rebound Adjuster  Clicks/Turns          (Total Out)		Standard =   (-) 21 Clicks  	Rebound Rod           End (mm)			USD Top T-Clamp Diam. (mm)');
INSERT INTO `fork_spec_general_info` VALUES ('6', 'Std. Spring Rate (kg)		.35kg  3.4N/mm	Std. Pressure Spring (kg)  		N/A	Fork Overall Length (mm) 		840mm	Stroke/Travel (mm)		275mm/   10.82in\nSpring Dimension (mm)  		38.2x29.4  x425mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		510mm	BCV Float (mm) 		1.0F\nSpring Chamber  (Length)  (mm)		W/No Spacers 432mm	Compression Assembly Length (mm)		48mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		4.5mm Fixed Collar \nSpring Preload  (mm)   Negative Pre-Load  		W/ No Spacers 7-	Sub Tank Cartridge Assembly Length (mm)		420mm	Inner Tube I.D.      (Chrome Tube) (mm)			Spring Markings		N/A\nStd. Oil Level  (CC)		110mm	Rebound Rod Length (mm)		507mm	USD Top T-Clamp Diam. (mm)    		49mm\nOil Level Range (CC)		90-140mm	Rebound Adjuster Rod Length (mm) 		442mm	USD Bot T-Clamp    Diam .(mm) 		53mm\nOil Type 		5W	Rebound Piston Bleed		N/A	CTG ROD DIA. (mm) 		12mm\nStd. Compression Adj. Position 		15 Clicks	Std. Rebound Adj. Position 		20 Clicks	CTG I.D.   (mm)		28mm\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max) -- 2008-03-14  09:26:19\n\n\n1. 2mm Recess Rebound Piston. 											\n2. New Cap w/Steel Internal Adjuster .											\n3. 10mm of Chrome Showing when bottomed.');
INSERT INTO `fork_spec_general_info` VALUES ('8', 'Std. Spring Rate (kg)  		 	Std. Pressure Spring (kg)  			Fork Overall Length (mm) 			Stroke/Travel (mm)		\nSpring Dimension (mm)  			Press. Spring Dimension  (mm)			Outer Tube Length (Upper)  (mm)			BCV Float (mm) 		\nSpring Chamber  (Length)  (mm)			Compression Assembly Length (mm)			Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		\nSpring Preload  (mm)			Sub Tank Cartridge Assembly Length (mm)			Inner Tube I.D.      (Chrome Tube) (mm)			Spring Markings		\nStd. Oil Level  (CC)			Rebound Rod Length (mm)			USD Top T-Clamp Diam. (mm)    					\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 			USD Bot T-Clamp    Diam .(mm) 					\nOil Type 			Rebound Piston Bleed			CTG ROD DIA. (mm) 					\nStd. Compression Adj. Position 			Std. Rebound Adj. Position 			CTG I.D.   (mm)					\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('9', 'Std. Spring Rate (kg)		.44kg	Std. Pressure Spring (kg)  		N/A	Fork Overall Length (mm) 		942mm	Stroke/Travel (mm)		302mm\nSpring Dimension (mm)  		43.1x33.0  x460mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		576mm	BCV Float (mm) 		.8F\nSpring Chamber  (Length)  (mm)			Compression Assembly Length (mm)		158mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		2.5 Collar Built In\nSpring Preload  (mm)			Sub Tank Cartridge Assembly Length (mm)		604mm	USD Top T-Clamp Diam. (mm)    		54mm	Spring Markings		N/A\nStd. Oil Level  (CC)			Rebound Rod Length (mm)		436mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		371mm	CTG ROD DIA. (mm) 		12mm			\nOil Type 			Rebound Piston Bleed		N/A	CTG I.D.   (mm)		23mm			\nComp. Adjuster      Clicks/Turns (Max-)		Out (-)  	Rebound Adjuster  Clicks/Turns (Max-)		Out (-)    						\nNotes: 											\n1. 4mm of Chrome Tube Showing when bottomed');
INSERT INTO `fork_spec_general_info` VALUES ('10', 'Std. Spring Rate (kg)  Rated .46kg		.44kg	Bladder Type    Nitrogen Pressure 		1.2 Bar 	Fork Overall Length (mm) 		942mm	Stroke/Travel (mm)		300mm/  11.8 in\nSpring Dimension (mm)  		43.2x33   x485mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		576mm	BCV Float (mm) 		.6mm Float\nSpring Chamber  (Length)  (mm)		484mm	Compression Assembly Length (mm)		158mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		2.5 Fixed\nSpring Preload  (mm)		5mm w/Spacer 	Sub Tank Cartridge Assembly Length (mm)		604mm	Inner Tube I.D.      (Chrome Tube) (mm)			Spring Markings		N/A\nStd. Oil Level  (CC)			Rebound Rod Length (mm)		436mm	USD Top T-Clamp Diam. (mm)    		54mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		370mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Type 			Rebound Piston Bleed		N/A	CTG ROD DIA. (mm) 		12mm			\nStd. Compression Adj. Position 		14 C	Std. Rebound Adj. Position 		21 C	CTG I.D.   (mm)		23mm			\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('11', 'Std. Spring Rate (kg)		4.4N/MM   .45kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		1.2 Bar	Fork Overall Length (mm) 		942mm	Stroke/Travel (mm)		300mm/   11.8in\nSpring Dimension (mm)  		43.2X33   X482MM	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		576mm	BCV Float (mm) 		.6F\nSpring Chamber  (Length)  (mm)		484MM	Compression Assembly Length (mm)		158mm	Inner Tube Length (Chrome Tube) (mm)		595mm     w/o Lug 	BCV Collar (mm)		2.5 Fixed\nSpring Preload  (mm)		 +/- 8mm	Sub Tank Cartridge Assembly Length (mm)		604mm	Inner Tube I.D.      (Chrome Tube) (mm)		43.5mm +/-	Spring Markings		N/A\nStd. Oil Level  (CC)		385cc	Rebound Rod Length (mm)		435mm	USD Top T-Clamp Diam. (mm)    		54mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		370mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Type 		5W	Rebound Piston Bleed		N/A	CTG ROD DIA. (mm) 		12mm			\nStd. Compression Adj. Position 		14 Clicks	Std. Rebound Adj. Position 		21 Clicks	CTG I.D.   (mm)		23mm			\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('12', 'Std. Spring Rate (kg)		.46kg	Std. Pressure Spring (kg)  		N/A	Fork Overall Length (mm) 		942mm	Stroke/Travel (mm)		302mm\nSpring Dimension (mm)  		43.1x33  x486mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		576mm	BCV Float (mm) 		.8F\nSpring Chamber  (Length)  (mm)			Compression Assembly Length (mm)		158mm	Inner Tube Length (Chrome Tube) (mm)		595mm       w/no Lug	BCV Collar (mm)		2.5 Collar Built In \nSpring Preload  (mm)			Sub Tank Cartridge Assembly Length (mm)		604mm	USD Top T-Clamp Diam. (mm)    		54mm	Spring Markings		N/A\nStd. Oil Level  (CC)		385cc	Rebound Rod Length (mm)		436mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		371mm	CTG ROD DIA. (mm) 		12mm			\nOil Type 			Rebound Piston Bleed		N/A	CTG I.D.   (mm)		23mm			\nComp. Adjuster      Clicks/Turns (Max-)		Out (-)  	Rebound Adjuster  Clicks/Turns (Max-)		Out (-)');
INSERT INTO `fork_spec_general_info` VALUES ('13', 'Std. Spring Rate (kg)  Rated .46kg		4.4 N/mm   .45 kg 	Std. Pressure Spring (kg)  		N/A	Fork Overall Length (mm) 		942mm	Stroke/Travel (mm)		300/       11.81 in\nSpring Dimension (mm)  		43.1x33  x486mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		576mm	BCV Float (mm) 		.8F\nSpring Chamber  (Length)  (mm)			Compression Assembly Length (mm)		158mm	Inner Tube Length (Chrome Tube) (mm)		595mm       w/no Lug	BCV Collar (mm)		2.5 Collar Built In \nSpring Preload  (mm)			Sub Tank Cartridge Assembly Length (mm)		604mm	USD Top T-Clamp Diam. (mm)    		54mm	Spring Markings		N/A\nStd. Oil Level  (CC)			Rebound Rod Length (mm)		436mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		371mm	CTG ROD DIA. (mm) 		12mm			\nOil Type 		5W	Rebound Piston Bleed		N/A	CTG I.D.   (mm)		23mm			\nStd. Compression Adj. Position 		20	Std. Rebound Adj. Position 		21						\nComp. Adjuster      Clicks/Turns (Max)		 	Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('14', 'Std. Spring Rate (kg)  Rates .44kg		.42 kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		N/A	Fork Overall Length (mm) 		942mm	Stroke/Travel (mm)		82mm\nSpring Dimension (mm)  		43.3x33.1     x 505mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		575mm	BCV Float (mm) 		.7F\nSpring Chamber  (Length)  (mm)		500mm	Compression Assembly Length (mm)		47.65mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		4.5 Fixed\nSpring Preload  (mm)		5mm           No Spacers	Sub Tank Cartridge Assembly Length (mm)		465mm	Inner Tube I.D.      (Chrome Tube) (mm)			Spring Markings		N/A\nStd. Oil Level  (CC)		130mm	Rebound Rod Length (mm)		585mm	USD Top T-Clamp Diam. (mm)    		54mm			\nOil Level Range (CC)		100-180mm	Rebound Adjuster Rod Length (mm) 		520mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Type 		5W	Rebound Piston Bleed		N/A	CTG ROD DIA. (mm) 		12mm			\nStd. Compression Adj. Position 			Std. Rebound Adj. Position 			CTG I.D.   (mm)		28mm			\nComp. Adjuster      Clicks/Turns (Max)		34 C	Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('15', 'Std. Spring Rate (kg)  Rated .45kg		.44kg	Std. Pressure Spring (kg)  			Fork Overall Length (mm) 			Stroke/Travel (mm)		\nSpring Dimension (mm)  		43x33  x482mm	Press. Spring Dimension  (mm)			Outer Tube Length (Upper)  (mm)			BCV Float (mm) 		\nSpring Chamber  (Length)  (mm)		484mm	Compression Assembly Length (mm)			Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		\nSpring Preload  (mm)		w/6mm Spacers  2	Sub Tank Cartridge Assembly Length (mm)			Inner Tube I.D.      (Chrome Tube) (mm)			Spring Markings		\nStd. Oil Level  (CC)			Rebound Rod Length (mm)			USD Top T-Clamp Diam. (mm)    					\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 			USD Bot T-Clamp    Diam .(mm) 					\nOil Type 			Rebound Piston Bleed			CTG ROD DIA. (mm) 					\nStd. Compression Adj. Position 			Std. Rebound Adj. Position 			CTG I.D.   (mm)					\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('16', 'Std. Spring Rate (kg)  Rated 43.5kg		.42kg	Std. Pressure Spring (kg)  		N/A	Fork Overall Length (mm) 		942mm	Stroke/Travel (mm)		300mm/   11.82in\nSpring Dimension (mm)  		33.2x43.1 x505mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		576mm	BCV Float (mm) 		.7F\nSpring Chamber  (Length)  (mm)		500mm	Compression Assembly Length (mm)		47mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		4.5mm  Fixed Collar\nSpring Preload  (mm)		5mm w/no spacers 	Sub Tank Cartridge Assembly Length (mm)		466mm	Inner Tube I.D.      (Chrome Tube) (mm)			Spring Markings		N/A\nStd. Oil Level  (CC)  Measured 105mm		110mm	Rebound Rod Length (mm)		585mm	USD Top T-Clamp Diam. (mm)    		54mm			\nOil Level Range (CC)		100-180mm	Rebound Adjuster Rod Length (mm) 		520mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Type 		5W	Rebound Piston Bleed		N/A	CTG ROD DIA. (mm) 		12mm			\nStd. Compression Adj. Position 		22 Clicks	Std. Rebound Adj. Position 		20 Clicks	CTG I.D.   (mm)		28mm			\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)			Standard Pre-Load Adjustmet		2 Turns			\n\nNotes: 											\n1.  2mm Recess in BCV Side of Rebound Piston											2.  Fork Caps are adjustable Pre-Load  Standard Adjustment- 2 Turns										3.  31mm Top Out Spring											\n4.  15mm of Chrome Showing when forks bottomed											5. Fork Overall Length measured from center of lug to the top of the Fork');
INSERT INTO `fork_spec_general_info` VALUES ('17', 'Std. Spring Rate (kg)		.46 kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		N/A	Rebound Adjuster Rod Length (mm) 		520mm	USD Bot T-Clamp    Diam .(mm) 		60mm\nSpring Dimension (mm)  		 	Press. Spring Dimension  (mm)		N/A	CTG ROD DIA. (mm) 		12mm	Fork Overall Length (mm) 		940mm\nSpring Chamber  (Length)  (mm)			Compression Assembly Length (mm)		48.32mm	Rebound Piston Bleed			Outer Tube Length (Upper)  (mm)		\nSpring Preload  (mm)		(+/-) 5mm	Compression Stem Bleed (mm) 		N/A	Oil Lock Collar O.D. (mm) 			Stroke/Travel (mm)		300mm\nStd. Oil Level  (CC/MM)		100 mm	Compression           Refill (mm)		 	Oil Lock Collar Color 			BCV Float (mm) 		\nOil Level Range (CC/MM)		100-180mm	Sub Tank or Cartridge Assembly Length (mm)			Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		\nOil Type 		5W	CTG I.D.   (mm)		28mm	Inner Tube I.D.      (Chrome Tube) (mm)					\nComp. Adjuster      Clicks/Turns        (Total Out)			Rebound Rod Length (mm)		585mm	Inner Tube O.D.  (Chrome Tube) (mm) 					\n Rebound Adjuster  Clicks/Turns          (Total Out)			Rebound Rod           End (mm)			USD Top T-Clamp Diam. (mm)    		54mm			\nNotes: 											\nStandard Clicker Settings:											\nCompression = (-) 20 Clicks											\nRebound = (-) 18 Clicks											\nPre-Load Adjuster = (-) 4 Turns');
INSERT INTO `fork_spec_general_info` VALUES ('18', '4.8 N/mm    .49 kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		1.2 Bar	Rebound Adjuster Rod Length (mm) 			USD Bot T-Clamp    Diam .(mm) 		\nSpring Dimension (mm)  		43.3x32.9     x  487mm	Press. Spring Dimension  (mm)		N/A	CTG ROD DIA. (mm) 			Fork Overall Length (mm) 		\nSpring Chamber  (Length)  (mm)		484mm	Compression Assembly Length (mm)			Rebound Piston Bleed			Outer Tube Length (Upper)  (mm)		\nSpring Preload  (mm)		w/Spacer 6mm	Compression Stem Bleed (mm) 			Oil Lock Collar O.D. (mm) 			Stroke/Travel (mm)		\nStd. Oil Level  (CC/MM)		385cc	Compression           Refill (mm)			Oil Lock Collar Color 			BCV Float (mm) 		.45mm\nOil Level Range (CC)			Sub Tank or Cartridge Assembly Length (mm)			Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		\nOil Type 		WP 5W	CTG I.D.   (mm)			Inner Tube I.D.      (Chrome Tube) (mm)					\nComp. Adjuster      Clicks/Turns       		Standard =   (-) 14 Clicks  	Rebound Rod Length (mm)			Inner Tube O.D.  (Chrome Tube) (mm) 					\n Rebound Adjuster  Clicks/Turns          (Total Out)		Standard =   (-) 21 Clicks  	Rebound Rod           End (mm)			USD Top T-Clamp Diam. (mm)');
INSERT INTO `fork_spec_general_info` VALUES ('19', 'Std. Spring Rate (kg)		.46 kg	Std. Pressure Spring (kg)  		Bladder      1.2 Bar	Fork Overall Length (mm) 		940mm	Stroke/Travel (mm)		300mm/ 11.81in\nSpring Dimension (mm)  		488mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		577mm	BCV Float (mm) 		.8F\nSpring Chamber  (Length)  (mm)		484mm	Compression Assembly Length (mm)		160mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		2.5C Built In\nSpring Preload  (mm)		6mm Spacers	Sub Tank Cartridge Assembly Length (mm)		605mm	Inner Tube I.D.      (Chrome Tube) (mm)			Spring Markings		N/A\nStd. Oil Level  (CC)		375cc	Rebound Rod Length (mm)		435mm	USD Top T-Clamp Diam. (mm)    		54mm			\nOil Level Range (CC)		340-380cc	Rebound Adjuster Rod Length (mm) 		371mm	USD Bot T-Clamp    Diam .(mm) 		60mm			\nOil Type 		5w	Rebound Piston Bleed		N/A	CTG ROD DIA. (mm) 		12mm			\nStd. Compression Adj. Position 		20 Clicks	Std. Rebound Adj. Position 		21 Clicks	CTG I.D.   (mm)		23mm			\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('20', 'Std. Spring Rate (kg)		.28 kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		N/A	Rebound Adjuster Rod Length (mm) 		487mm	USD Bot T-Clamp    Diam .(mm) 		50mm\nSpring Dimension (mm)  		33x455mm	Press. Spring Dimension  (mm)		N/A	CTG ROD DIA. (mm) 		10mm	Fork Overall Length (mm) 		\nSpring Chamber  (Length)  (mm)		438mm	Compression Assembly Length (mm)		N/A	Rebound Piston Bleed		1.2mm	Outer Tube Length (Upper)  (mm)		520mm\nSpring Preload  (mm)		17mm	Compression Stem Bleed (mm) 		N/A	Oil Lock Collar O.D. (mm) 		N/A	Stroke/Travel (mm)		\nStd. Oil Level  (CC/MM)			Compression           Refill (mm)		N/A	Oil Lock Collar Color 		N/A	BCV Float (mm) 		\nOil Level Range (CC)			Sub Tank or Cartridge Assembly Length (mm)		413	Inner Tube Length (Chrome Tube) (mm)		510mm	BCV Collar (mm)		\nOil Type 		SS05	CTG I.D.   (mm)		20.75mm	Inner Tube I.D.      (Chrome Tube) (mm)					\nComp. Adjuster      Clicks/Turns        (Total Out)			Rebound Rod Length (mm)		540mm	Inner Tube O.D.  (Chrome Tube) (mm) 					\n Rebound Adjuster  Clicks/Turns          (Total Out)			Rebound Rod           End (mm)			USD Top T-Clamp Diam. (mm)    		46mm');
INSERT INTO `fork_spec_general_info` VALUES ('21', 'Std. Spring Rate (kg)		.44kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		1.9kg	Rebound Adjuster Rod Length (mm) 		381mm	USD Bot T-Clamp    Diam .(mm) 		58.4mm\nSpring Dimension (mm)  		493mm	Press. Spring Dimension  (mm)		99.6mm	CTG ROD DIA. (mm) 		12.5mm	Fork Overall Length (mm) 		\nSpring Chamber  (Length)  (mm)		487mm	Compression Assembly Length (mm)			Rebound Piston Bleed		1.3mm	Outer Tube Length (Upper)  (mm)		566mm\nSpring Preload  (mm)		6mm	Compression Stem Bleed (mm) 		2.3mm	Oil Lock Collar O.D. (mm) 		28.05mm	Stroke/Travel (mm)		\nStd. Oil Level  (CC/MM)		370cc	Compression           Refill (mm)		.30 mm	Oil Lock Collar Color 		Green	BCV Float (mm) 		.15mm\nOil Level Range (CC)		320-400cc	Sub Tank Cartridge Assembly Length (mm)			Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		1.75mm\nOil Type 		SS05	CTG I.D.   (mm)		23mm	Inner Tube I.D.      (Chrome Tube) (mm)					\nComp. Adjuster      Clicks/Turns        (Total Out)			Rebound Rod Length (mm)		445mm	Inner Tube O.D.  (Chrome Tube) (mm) 		47mm			\n Rebound Adjuster  Clicks/Turns          (Total Out)			Rebound Rod           End (mm)		2.0mm	USD Top T-Clamp Diam. (mm)    		54.9mm			\n\nNotes: 											\n1. New Rebound Piston');
INSERT INTO `fork_spec_general_info` VALUES ('22', 'Std. Spring Rate (kg)		.29 kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		N/A	Fork Overall Length (mm) 		829mm	Stroke/Travel (mm)		259mm\nSpring Dimension (mm)  		 31.5x 432mm	Press. Spring Dimension  (mm)		N/A	Outer Tube Length (Upper)  (mm)		511mm	BCV Float (mm) 		\nSpring Chamber  (Length)  (mm)		417mm	Compression Assembly Length (mm)		55mm	Inner Tube Length (Chrome Tube) (mm)		507mm	BCV Collar (mm)		\nSpring Preload  (mm)		11-12mm	Sub Tank Cartridge Assembly Length (mm)		N/A	Inner Tube I.D.      (Chrome Tube) (mm)		45.9mm	Spring Markings		N/A\nStd. Oil Level  (CC)			Rebound Rod Length (mm)		507mm	USD Top T-Clamp Diam. (mm)    		49.4mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		507mm	USD Bot T-Clamp    Diam .(mm) 		10mm			\nOil Type 			Rebound Piston Bleed		1.1x3mm	CTG ROD DIA. (mm) 		20mm			\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)			CTG I.D.   (mm)');
INSERT INTO `fork_spec_general_info` VALUES ('23', 'Std. Spring Rate (kg) Rated .45kg			Std. Pressure Spring (kg)  		1.9kg	Fork Overall Length (mm) 			Stroke/Travel (mm)		\nSpring Dimension (mm)  		43.9x34  x454mm	Press. Spring Dimension  (mm)		25.5x18.3  x91.2mm	Outer Tube Length (Upper)  (mm)		565mm	BCV Float (mm) 		.25F\nSpring Chamber  (Length)  (mm)		444mm	Compression Assembly Length (mm)		185mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		5.25mm\nSpring Preload  (mm)		10mm	Sub Tank Cartridge Assembly Length (mm)		619mm	Inner Tube I.D.      (Chrome Tube) (mm)			Spring Markings		N/A\nStd. Oil Level  (CC)			Rebound Rod Length (mm)		430mm	USD Top T-Clamp Diam. (mm)    		56mm	Chrome Showing When Bottomed		18mm\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		380mm	USD Bot T-Clamp    Diam .(mm) 		59.4mm			\nOil Type 			Rebound Piston Bleed		1x1.2mm	CTG ROD DIA. (mm) 		12.5mm			\nStd. Compression Adj. Position 			Std. Rebound Adj. Position 			CTG I.D.   (mm)		24mm			\nComp. Adjuster      Clicks/Turns (Max)			Rebound Adjuster  Clicks/Turns (Max)');
INSERT INTO `fork_spec_general_info` VALUES ('24', 'Std. Spring Rate (kg)		.44kg	Std. Pressure Spring (kg)  		2.16kg	Fork Overall Length (mm) 		939mm	Stroke/Travel (mm)		300mm\nSpring Dimension (mm)  		44x454mm	Press. Spring Dimension  (mm)		25.4x 90.5mm	Outer Tube Length (Upper)  (mm)		565mm	BCV Float (mm) 		.25mm\nSpring Chamber  (Length)  (mm)		453mm	Compression Assembly Length (mm)		186mm	Inner Tube Length (Chrome Tube) (mm)		570mm	BCV Collar (mm)		5.3mm\nSpring Preload  (mm)		1mm	Sub Tank Cartridge Assembly Length (mm)		620mm	USD Top T-Clamp Diam. (mm)    		55.9mm	Spring Markings		NONE\nStd. Oil Level  (CC)			Rebound Rod Length (mm)		396mm	USD Bot T-Clamp    Diam .(mm) 		59.2mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		380mm	CTG ROD DIA. (mm) 		12.5mm			\nOil Type 		5w	Rebound Piston Bleed		1x1.2mm	CTG I.D.   (mm)		24mm			\nComp. Adjuster      Clicks/Turns (Max-)		Out (-)  	Rebound Adjuster  Clicks/Turns (Max-)		Out (-)');
INSERT INTO `fork_spec_general_info` VALUES ('25', 'Std. Spring Rate (kg)		.47 kg	Std. Pressure Spring (kg)  		1.91kg	Fork Overall Length (mm) 		939mm	Stroke/Travel (mm)		300mm\nSpring Dimension (mm)  		44x451mm	Press. Spring Dimension  (mm)		25.4x 90.5mm	Outer Tube Length (Upper)  (mm)		565mm	BCV Float (mm) 		.20mm\nSpring Chamber  (Length)  (mm)		453mm	Compression Assembly Length (mm)		186mm	Inner Tube Length (Chrome Tube) (mm)		453mm	BCV Collar (mm)		5.3mm\nSpring Preload  (mm)		 -  2mm	Sub Tank Cartridge Assembly Length (mm)		620mm	USD Top T-Clamp Diam. (mm)    		55.9mm	Spring Markings		None\nStd. Oil Level  (CC)			Rebound Rod Length (mm)		383mm	USD Bot T-Clamp    Diam .(mm) 		59.2mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		380mm	CTG ROD DIA. (mm) 		12.5mm			\nOil Type 		5W	Rebound Piston Bleed		1x1.2mm	CTG I.D.   (mm)		24mm			\nComp. Adjuster      Clicks/Turns (Max-)		Out (-)  	Rebound Adjuster  Clicks/Turns (Max-)		Out (-)');
INSERT INTO `fork_spec_general_info` VALUES ('26', 'Std. Spring Rate (kg)		.45KG	Std. Pressure Spring (kg)  		1.42 kg	Fork Overall Length (mm) 			Stroke/Travel (mm)		\nSpring Dimension (mm)  		32.7X42.9   X 494MM	Press. Spring Dimension  (mm)		26.14x19.2  x99.5mm	Outer Tube Length (Upper)  (mm)		572mm	BCV Float (mm) 		.15mm\nSpring Chamber  (Length)  (mm)			Compression Assembly Length (mm)		163mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		1.85mm\nSpring Preload  (mm)			Sub Tank Cartridge Assembly Length (mm)		611mm	USD Top T-Clamp Diam. (mm)    		53mm	Spring Markings		\nStd. Oil Level  (CC)			Rebound Rod Length (mm)		444mm	USD Bot T-Clamp    Diam .(mm) 		58.5mm			\nOil Level Range (CC)			Rebound Adjuster Rod Length (mm) 		386mm	CTG ROD DIA. (mm) 		12.5mm			\nOil Type 		Showa 5W	Rebound Piston Bleed		1x1.5mm	CTG I.D.   (mm)		23mm			\nComp. Adjuster      Clicks/Turns (Max-)		Out (-)  	Rebound Adjuster  Clicks/Turns (Max-)		Out (-)    						\nNotes: 											\n1. 1.6mm C. Hole in Stem');
INSERT INTO `fork_spec_general_info` VALUES ('27', 'Std. Spring Rate (kg) Micro Fiche indicates .47kg Spring Rate 		.48 kg	Std. Pressure Spring (kg)  		2.1 KG	Fork Overall Length (mm) 		945mm	Stroke/Travel (mm)		310mm\nSpring Dimension (mm)  		44.1x33.6  x470mm	Press. Spring Dimension  (mm)		25.6x18.3   x90mm	Outer Tube Length (Upper)  (mm)		569mm	BCV Float (mm) 		.2F\nSpring Chamber  (Length)  (mm)		465mm	Compression Assembly Length (mm)		185mm	Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		5.25mm\nSpring Preload  (mm)		5mm	Sub Tank Cartridge Assembly Length (mm)		620mm	USD Top T-Clamp Diam. (mm)    		54mm	Spring Markings		N/A\nStd. Oil Level  (CC)			Rebound Rod Length (mm)		442mm	USD Bot T-Clamp    Diam .(mm) 		59.2mm			\nOil Level Range (CC)		300-380cc	Rebound Adjuster Rod Length (mm) 		391mm	CTG ROD DIA. (mm) 		12.5mm			\nOil Type 		KYB	Rebound Piston Bleed		1x1.2mm	CTG I.D.   (mm)		24mm			\nComp. Adjuster      Clicks/Turns (Max-)		Out (-)  	Rebound Adjuster  Clicks/Turns (Max-)		Out (-)    						\nNotes: 											\n1. New Oil Lock Collars 											\n2. New Fork Cap/Compression Assembly like 06-08 YZ/YZF											\n3. New Basebolt like 06-08 YZ/YZF');
INSERT INTO `fork_spec_general_info` VALUES ('28', 'Std. Spring Rate (kg)		.29 kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		N/A	Rebound Adjuster Rod Length (mm) 			USD Bot T-Clamp    Diam .(mm) 		46mm\nSpring Dimension (mm)  		31.2x23.6 x435mm	Press. Spring Dimension  (mm)		N/A	CTG ROD DIA. (mm) 		10mm	Fork Overall Length (mm) 		\nSpring Chamber  (Length)  (mm)			Compression Assembly Length (mm)			Rebound Piston Bleed		1x1mm	Outer Tube Length (Upper)  (mm)		\nSpring Preload  (mm)			Compression Stem Bleed (mm) 			Oil Lock Collar O.D. (mm) 			Stroke/Travel (mm)		\nStd. Oil Level  (CC/MM)			Compression           Refill (mm)			Oil Lock Collar Color 			BCV Float (mm) 		\nOil Level Range (CC)			Sub Tank or Cartridge Assembly Length (mm)			Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		\nOil Type 		KYB 	CTG I.D.   (mm)		20mm	Inner Tube I.D.      (Chrome Tube) (mm)					\nComp. Adjuster      Clicks/Turns        (Total Out)			Rebound Rod Length (mm)			Inner Tube O.D.  (Chrome Tube) (mm) 		36mm			\n Rebound Adjuster  Clicks/Turns          (Total Out)			Rebound Rod           End (mm)			USD Top T-Clamp Diam. (mm)    		49.4mm			\n\nNotes: 											\nCompression is internal Flex 											\nCartridge Bushing is DU Type 											\nNo External Rebound Adjustment');
INSERT INTO `fork_spec_general_info` VALUES ('29', 'Std. Spring Rate (kg)		.29 kg	Std. Pressure Spring (kg) / WP Nitrogen Pressure		N/A	Rebound Adjuster Rod Length (mm) 			USD Bot T-Clamp    Diam .(mm) 		46mm\nSpring Dimension (mm)  		31.2x23.6 x435mm	Press. Spring Dimension  (mm)		N/A	CTG ROD DIA. (mm) 		10mm	Fork Overall Length (mm) 		\nSpring Chamber  (Length)  (mm)			Compression Assembly Length (mm)			Rebound Piston Bleed		1x1mm	Outer Tube Length (Upper)  (mm)		\nSpring Preload  (mm)			Compression Stem Bleed (mm) 			Oil Lock Collar O.D. (mm) 			Stroke/Travel (mm)		\nStd. Oil Level  (CC/MM)			Compression           Refill (mm)			Oil Lock Collar Color 			BCV Float (mm) 		\nOil Level Range (CC)			Sub Tank or Cartridge Assembly Length (mm)			Inner Tube Length (Chrome Tube) (mm)			BCV Collar (mm)		\nOil Type 		KYB 	CTG I.D.   (mm)		20mm	Inner Tube I.D.      (Chrome Tube) (mm)					\nComp. Adjuster      Clicks/Turns        (Total Out)			Rebound Rod Length (mm)			Inner Tube O.D.  (Chrome Tube) (mm) 		36mm			\n Rebound Adjuster  Clicks/Turns          (Total Out)			Rebound Rod           End (mm)			USD Top T-Clamp Diam. (mm)    		49.4mm			\nNotes: 											\nCompression is internal Flex 											\nCartridge Bushing is DU Type 											\nNo External Rebound Adjustment');
INSERT INTO `fork_work` VALUES ('1', 'Revalve Forks');
INSERT INTO `fork_work` VALUES ('2', 'Service Forks');
INSERT INTO `fork_work` VALUES ('3', 'Oil Change');
INSERT INTO `fork_work` VALUES ('4', 'Shorten');
INSERT INTO `fork_work` VALUES ('5', 'Other');
INSERT INTO `lookup_table` VALUES ('5280', '1', '1', '3', 'Stock', 'Stock', null, null, '19', '2008', '13', 'Honda', 'CRF450', '1.00', '1.00', '2008-02-08', null, '', '');
INSERT INTO `lookup_table` VALUES ('5455', '7', '7', '3', 'Stock', 'Stock', null, null, '19', '2008', '44', 'KTM', '85_105XC', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5459', '6', '6', '3', 'Stock', 'Stock', null, null, '18', '2007', '34', 'KTM', '65SX', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5463', '4', '4', '3', 'Stock', 'Stock', null, null, '19', '2008', '40', 'KTM', '250SX-F', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5467', '3', '3', '3', 'Stock', 'Stock', null, null, '19', '2008', '41', 'KTM', '450SX-F', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5495', '2', '2', '3', 'Stock', 'Stock', null, null, '19', '2008', '12', 'Honda', 'CRF250', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5520', '8', '8', '3', 'Stock', 'Stock', null, null, '19', '2008', '45', 'KTM', '85SX_105SX', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5524', '9', '9', '3', 'Stock', 'Stock', null, null, '19', '2008', '37', 'KTM', '125SX', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5533', '10', '10', '3', 'Stock', 'Stock', null, null, '19', '2008', '46', 'KTM', '144SX', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5546', '11', '11', '3', 'Stock', 'Stock', null, null, '19', '2008', '47', 'KTM', '200XC', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5555', '12', '12', '3', 'Stock', 'Stock', null, null, '19', '2008', '38', 'KTM', '250SX', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5568', '13', '13', '3', 'Stock', 'Stock', null, null, '19', '2008', '40', 'KTM', '250SX-F', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5581', '14', '14', '3', 'Stock', 'Stock', null, null, '19', '2008', '55', 'KTM', '250XC', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5590', '15', '15', '3', 'Stock', 'Stock', null, null, '19', '2008', '48', 'KTM', '250XC-F', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5603', '16', '16', '3', 'Stock', 'Stock', null, null, '19', '2008', '49', 'KTM', '250XC-W', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5608', '17', '17', '3', 'Stock', 'Stock', null, null, '19', '2008', '50', 'KTM', '300XC', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5617', '18', '18', '3', 'Stock', 'Stock', null, null, '19', '2008', '51', 'KTM', '300XC-W', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5630', '19', '19', '3', 'Stock', 'Stock', null, null, '19', '2008', '53', 'KTM', '450EXC', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5639', '20', '20', '3', 'Stock', 'Stock', null, null, '19', '2008', '41', 'KTM', '450SX-F', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5652', '21', '21', '3', 'Stock', 'Stock', null, null, '19', '2008', '54', 'KTM', '450XC-F', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5665', '22', '22', '3', 'Stock', 'Stock', null, null, '19', '2008', '29', 'Suzuki', 'RM85', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5678', '23', '23', '3', 'Stock', 'Stock', null, null, '19', '2008', '32', 'Suzuki', 'RMZ250', '1.00', '1.00', '2008-03-14', null, '', '');
INSERT INTO `lookup_table` VALUES ('5687', '24', '24', '3', 'Stock', 'Stock', null, null, '19', '2008', '14', 'Yamaha', 'YZ85', '1.00', '1.00', '2008-03-15', null, '', '');
INSERT INTO `lookup_table` VALUES ('5700', '25', '25', '3', 'Stock', 'Stock', null, null, '19', '2008', '16', 'Yamaha', 'YZ250', '1.00', '1.00', '2008-03-15', null, '', '');
INSERT INTO `lookup_table` VALUES ('5713', '26', '26', '3', 'Stock', 'Stock', null, null, '19', '2008', '18', 'Yamaha', 'YZF250', '1.00', '1.00', '2008-03-15', null, '', '');
INSERT INTO `lookup_table` VALUES ('5726', '27', '27', '3', 'Stock', 'Stock', null, null, '19', '2008', '19', 'Yamaha', 'YZ450F', '1.00', '1.00', '2008-03-15', null, '', '');
INSERT INTO `lookup_table` VALUES ('5743', '28', '28', '3', 'Stock', 'Stock', null, null, '19', '2008', '25', 'Kawasaki', 'KX-F250', '1.00', '1.00', '2008-03-15', null, '', '');
INSERT INTO `lookup_table` VALUES ('5775', '29', '32', '3', 'Stock', 'Stock', null, null, '19', '2008', '26', 'Kawasaki', 'KX-F450', '1.00', '1.00', '2008-03-16', null, '', '');
INSERT INTO `lookup_table` VALUES ('5788', '30', '33', '3', 'Stock', 'Stock', null, null, '19', '2008', '21', 'Kawasaki', 'KX85', '1.00', '1.00', '2008-03-16', null, '', '');
INSERT INTO `lookup_table` VALUES ('5793', '31', '34', '3', 'Stock', 'Stock', null, null, '19', '2008', '56', 'Kawasaki', 'KX100', '1.00', '1.00', '2008-03-16', null, '', '');
INSERT INTO `need_springs` VALUES ('1', '1', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('2', '2', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('3', '3', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('4', '4', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('6', '6', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('7', '7', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('8', '8', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('9', '9', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('10', '10', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('11', '11', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('12', '12', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('13', '13', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('14', '14', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('15', '15', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('16', '16', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('17', '17', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('18', '18', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('19', '19', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('20', '20', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('21', '21', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('22', '22', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('23', '23', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('24', '24', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('25', '25', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('26', '26', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('27', '27', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('28', '28', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('32', '29', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('33', '30', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `need_springs` VALUES ('34', '31', '-1', '0.000', '-1', '0.000', '0');
INSERT INTO `payment_method` VALUES ('1', 'COD Secured');
INSERT INTO `payment_method` VALUES ('2', 'COD Non-Secured');
INSERT INTO `payment_method` VALUES ('3', 'Credit Card');
INSERT INTO `payment_method` VALUES ('4', 'NET 15');
INSERT INTO `payment_method` VALUES ('5', 'NET 30');
INSERT INTO `payment_method` VALUES ('6', 'CASH');
INSERT INTO `referrer` VALUES ('1', 'Saw ad in magazine.', null);
INSERT INTO `referrer` VALUES ('2', 'Heard about it from friend.', '');
INSERT INTO `referrer` VALUES ('3', 'Saw it on TV.', null);
INSERT INTO `rider` VALUES ('2', null, 'Baseline', 'Baseline', '3', null, null);
INSERT INTO `rider` VALUES ('3', null, 'Stock', 'Stock', null, null, null);
INSERT INTO `rider_ability` VALUES ('1', 'Beginner');
INSERT INTO `rider_ability` VALUES ('2', 'Novice');
INSERT INTO `rider_ability` VALUES ('3', 'Intermediate');
INSERT INTO `rider_ability` VALUES ('4', 'Expert');
INSERT INTO `rider_ability` VALUES ('5', 'Pro');
INSERT INTO `rider_ability` VALUES ('6', 'D');
INSERT INTO `rider_ability` VALUES ('7', 'C');
INSERT INTO `rider_ability` VALUES ('8', 'B');
INSERT INTO `rider_ability` VALUES ('9', 'A');
INSERT INTO `rider_ability` VALUES ('10', 'AA');
INSERT INTO `rider_ability` VALUES ('11', 'Vet');
INSERT INTO `rider_ability` VALUES ('12', 'Junior');
INSERT INTO `rider_height` VALUES ('1', '24', '61');
INSERT INTO `rider_height` VALUES ('2', '25', '64');
INSERT INTO `rider_height` VALUES ('3', '26', '66');
INSERT INTO `rider_height` VALUES ('4', '27', '69');
INSERT INTO `rider_height` VALUES ('5', '28', '71');
INSERT INTO `rider_height` VALUES ('6', '29', '74');
INSERT INTO `rider_height` VALUES ('7', '30', '76');
INSERT INTO `rider_height` VALUES ('8', '31', '79');
INSERT INTO `rider_height` VALUES ('9', '32', '81');
INSERT INTO `rider_height` VALUES ('10', '33', '84');
INSERT INTO `rider_height` VALUES ('11', '34', '86');
INSERT INTO `rider_height` VALUES ('12', '35', '89');
INSERT INTO `rider_height` VALUES ('13', '36', '91');
INSERT INTO `rider_height` VALUES ('14', '37', '94');
INSERT INTO `rider_height` VALUES ('15', '38', '97');
INSERT INTO `rider_height` VALUES ('16', '39', '99');
INSERT INTO `rider_height` VALUES ('17', '40', '102');
INSERT INTO `rider_height` VALUES ('18', '41', '104');
INSERT INTO `rider_height` VALUES ('19', '42', '107');
INSERT INTO `rider_height` VALUES ('20', '43', '109');
INSERT INTO `rider_height` VALUES ('21', '44', '112');
INSERT INTO `rider_height` VALUES ('22', '45', '114');
INSERT INTO `rider_height` VALUES ('23', '46', '117');
INSERT INTO `rider_height` VALUES ('24', '47', '119');
INSERT INTO `rider_height` VALUES ('25', '48', '122');
INSERT INTO `rider_height` VALUES ('26', '49', '124');
INSERT INTO `rider_height` VALUES ('27', '50', '127');
INSERT INTO `rider_height` VALUES ('28', '51', '130');
INSERT INTO `rider_height` VALUES ('29', '52', '132');
INSERT INTO `rider_height` VALUES ('30', '53', '135');
INSERT INTO `rider_height` VALUES ('31', '54', '137');
INSERT INTO `rider_height` VALUES ('32', '55', '140');
INSERT INTO `rider_height` VALUES ('33', '56', '142');
INSERT INTO `rider_height` VALUES ('34', '57', '145');
INSERT INTO `rider_height` VALUES ('35', '58', '147');
INSERT INTO `rider_height` VALUES ('36', '59', '150');
INSERT INTO `rider_height` VALUES ('37', '60', '152');
INSERT INTO `rider_height` VALUES ('38', '61', '155');
INSERT INTO `rider_height` VALUES ('39', '62', '157');
INSERT INTO `rider_height` VALUES ('40', '63', '160');
INSERT INTO `rider_height` VALUES ('41', '64', '163');
INSERT INTO `rider_height` VALUES ('42', '65', '165');
INSERT INTO `rider_height` VALUES ('43', '66', '168');
INSERT INTO `rider_height` VALUES ('44', '67', '170');
INSERT INTO `rider_height` VALUES ('45', '68', '173');
INSERT INTO `rider_height` VALUES ('46', '69', '175');
INSERT INTO `rider_height` VALUES ('47', '70', '178');
INSERT INTO `rider_height` VALUES ('48', '71', '180');
INSERT INTO `rider_height` VALUES ('49', '72', '183');
INSERT INTO `rider_height` VALUES ('50', '73', '185');
INSERT INTO `rider_height` VALUES ('51', '74', '188');
INSERT INTO `rider_height` VALUES ('52', '75', '191');
INSERT INTO `rider_height` VALUES ('53', '76', '193');
INSERT INTO `rider_height` VALUES ('54', '77', '196');
INSERT INTO `rider_height` VALUES ('55', '78', '198');
INSERT INTO `rider_height` VALUES ('56', '79', '201');
INSERT INTO `rider_height` VALUES ('57', '80', '203');
INSERT INTO `rider_height` VALUES ('58', '81', '206');
INSERT INTO `rider_height` VALUES ('59', '82', '208');
INSERT INTO `rider_height` VALUES ('60', '83', '211');
INSERT INTO `rider_height` VALUES ('61', '84', '213');
INSERT INTO `rider_height` VALUES ('62', '85', '216');
INSERT INTO `rider_height` VALUES ('63', '86', '218');
INSERT INTO `rider_height` VALUES ('64', '87', '221');
INSERT INTO `rider_height` VALUES ('65', '88', '224');
INSERT INTO `rider_height` VALUES ('66', '89', '226');
INSERT INTO `rider_height` VALUES ('67', '90', '229');
INSERT INTO `rider_height` VALUES ('68', '91', '231');
INSERT INTO `rider_height` VALUES ('69', '92', '234');
INSERT INTO `rider_height` VALUES ('70', '93', '236');
INSERT INTO `rider_height` VALUES ('71', '94', '239');
INSERT INTO `rider_height` VALUES ('72', '95', '241');
INSERT INTO `rider_height` VALUES ('73', '96', '244');
INSERT INTO `rider_instance` VALUES ('30', '2', '0', '0', '0');
INSERT INTO `rider_instance` VALUES ('31', '1', '0', '4', '0');
INSERT INTO `rider_instance` VALUES ('32', '2', '0', '5', '0');
INSERT INTO `rider_instance` VALUES ('33', '3', '0', '0', '0');
INSERT INTO `rider_instance` VALUES ('39', '0', '0', '0', '0');
INSERT INTO `rider_weight` VALUES ('1', '30', '14');
INSERT INTO `rider_weight` VALUES ('2', '35', '16');
INSERT INTO `rider_weight` VALUES ('3', '40', '18');
INSERT INTO `rider_weight` VALUES ('4', '45', '20');
INSERT INTO `rider_weight` VALUES ('5', '50', '23');
INSERT INTO `rider_weight` VALUES ('6', '55', '25');
INSERT INTO `rider_weight` VALUES ('7', '60', '27');
INSERT INTO `rider_weight` VALUES ('8', '65', '29');
INSERT INTO `rider_weight` VALUES ('9', '70', '32');
INSERT INTO `rider_weight` VALUES ('10', '75', '34');
INSERT INTO `rider_weight` VALUES ('11', '80', '36');
INSERT INTO `rider_weight` VALUES ('12', '85', '39');
INSERT INTO `rider_weight` VALUES ('13', '90', '41');
INSERT INTO `rider_weight` VALUES ('14', '95', '43');
INSERT INTO `rider_weight` VALUES ('15', '100', '45');
INSERT INTO `rider_weight` VALUES ('16', '105', '48');
INSERT INTO `rider_weight` VALUES ('17', '110', '50');
INSERT INTO `rider_weight` VALUES ('18', '115', '52');
INSERT INTO `rider_weight` VALUES ('19', '120', '54');
INSERT INTO `rider_weight` VALUES ('20', '125', '57');
INSERT INTO `rider_weight` VALUES ('21', '130', '59');
INSERT INTO `rider_weight` VALUES ('22', '135', '61');
INSERT INTO `rider_weight` VALUES ('23', '140', '64');
INSERT INTO `rider_weight` VALUES ('24', '145', '66');
INSERT INTO `rider_weight` VALUES ('25', '150', '68');
INSERT INTO `rider_weight` VALUES ('26', '155', '70');
INSERT INTO `rider_weight` VALUES ('27', '160', '73');
INSERT INTO `rider_weight` VALUES ('28', '165', '75');
INSERT INTO `rider_weight` VALUES ('29', '170', '77');
INSERT INTO `rider_weight` VALUES ('30', '175', '79');
INSERT INTO `rider_weight` VALUES ('31', '180', '82');
INSERT INTO `rider_weight` VALUES ('32', '185', '84');
INSERT INTO `rider_weight` VALUES ('33', '190', '86');
INSERT INTO `rider_weight` VALUES ('34', '195', '88');
INSERT INTO `rider_weight` VALUES ('35', '200', '91');
INSERT INTO `rider_weight` VALUES ('36', '205', '93');
INSERT INTO `rider_weight` VALUES ('37', '210', '95');
INSERT INTO `rider_weight` VALUES ('38', '215', '98');
INSERT INTO `rider_weight` VALUES ('39', '220', '100');
INSERT INTO `rider_weight` VALUES ('40', '225', '102');
INSERT INTO `rider_weight` VALUES ('41', '230', '104');
INSERT INTO `rider_weight` VALUES ('42', '235', '107');
INSERT INTO `rider_weight` VALUES ('43', '240', '109');
INSERT INTO `rider_weight` VALUES ('44', '245', '111');
INSERT INTO `rider_weight` VALUES ('45', '250', '113');
INSERT INTO `rider_weight` VALUES ('46', '255', '116');
INSERT INTO `rider_weight` VALUES ('47', '260', '118');
INSERT INTO `rider_weight` VALUES ('48', '265', '120');
INSERT INTO `rider_weight` VALUES ('49', '270', '122');
INSERT INTO `rider_weight` VALUES ('50', '275', '125');
INSERT INTO `rider_weight` VALUES ('51', '280', '127');
INSERT INTO `rider_weight` VALUES ('52', '285', '129');
INSERT INTO `rider_weight` VALUES ('53', '290', '132');
INSERT INTO `rider_weight` VALUES ('54', '295', '134');
INSERT INTO `rider_weight` VALUES ('55', '300', '136');
INSERT INTO `rider_weight` VALUES ('56', '305', '138');
INSERT INTO `rider_weight` VALUES ('57', '310', '141');
INSERT INTO `rider_weight` VALUES ('58', '315', '143');
INSERT INTO `rider_weight` VALUES ('59', '320', '145');
INSERT INTO `rider_weight` VALUES ('60', '325', '147');
INSERT INTO `rider_weight` VALUES ('61', '330', '150');
INSERT INTO `rider_weight` VALUES ('62', '335', '152');
INSERT INTO `rider_weight` VALUES ('63', '340', '154');
INSERT INTO `rider_weight` VALUES ('64', '345', '156');
INSERT INTO `rider_weight` VALUES ('65', '350', '159');
INSERT INTO `rider_weight` VALUES ('66', '355', '161');
INSERT INTO `rider_weight` VALUES ('67', '360', '163');
INSERT INTO `rider_weight` VALUES ('68', '365', '166');
INSERT INTO `rider_weight` VALUES ('69', '370', '168');
INSERT INTO `rider_weight` VALUES ('70', '375', '170');
INSERT INTO `rider_weight` VALUES ('71', '380', '172');
INSERT INTO `rider_weight` VALUES ('72', '385', '175');
INSERT INTO `rider_weight` VALUES ('73', '390', '177');
INSERT INTO `rider_weight` VALUES ('74', '395', '179');
INSERT INTO `rider_weight` VALUES ('75', '400', '181');
INSERT INTO `riding_type` VALUES ('1', 'Motocross');
INSERT INTO `riding_type` VALUES ('2', 'Supercross');
INSERT INTO `riding_type` VALUES ('3', 'Freestyle');
INSERT INTO `riding_type` VALUES ('4', 'Arenacross');
INSERT INTO `riding_type` VALUES ('5', 'GNCC');
INSERT INTO `riding_type` VALUES ('6', 'Desert');
INSERT INTO `riding_type` VALUES ('7', 'Enduro');
INSERT INTO `riding_type` VALUES ('8', 'HS');
INSERT INTO `riding_type` VALUES ('9', 'Supermotard');
INSERT INTO `riding_type` VALUES ('10', 'Ice');
INSERT INTO `service_location` VALUES ('1', 'New Hampshire');
INSERT INTO `service_location` VALUES ('2', 'Quebec');
INSERT INTO `service_location` VALUES ('3', 'Corona');
INSERT INTO `setting` VALUES ('1', '2008-02-08', null, null, '1', '1', '1');
INSERT INTO `setting` VALUES ('2', '2008-03-14', null, null, '2', '3', '3');
INSERT INTO `setting` VALUES ('3', '2008-03-14', null, null, '3', '5', '5');
INSERT INTO `setting` VALUES ('4', '2008-03-14', null, null, '4', '7', '7');
INSERT INTO `setting` VALUES ('6', '2008-03-14', null, null, '5', '9', '9');
INSERT INTO `setting` VALUES ('7', '2008-03-14', null, null, '6', '11', '11');
INSERT INTO `setting` VALUES ('8', '2008-03-14', null, null, '7', '13', '13');
INSERT INTO `setting` VALUES ('9', '2008-03-14', null, null, '8', '15', '15');
INSERT INTO `setting` VALUES ('10', '2008-03-14', null, null, '9', '17', '17');
INSERT INTO `setting` VALUES ('11', '2008-03-14', null, null, '10', '19', '19');
INSERT INTO `setting` VALUES ('12', '2008-03-14', null, null, '11', '21', '21');
INSERT INTO `setting` VALUES ('13', '2008-03-14', null, null, '12', '23', '23');
INSERT INTO `setting` VALUES ('14', '2008-03-14', null, null, '13', '25', '25');
INSERT INTO `setting` VALUES ('15', '2008-03-14', null, null, '14', '27', '27');
INSERT INTO `setting` VALUES ('16', '2008-03-14', null, null, '15', '29', '29');
INSERT INTO `setting` VALUES ('17', '2008-03-14', null, null, '16', '31', '31');
INSERT INTO `setting` VALUES ('18', '2008-03-14', null, null, '17', '33', '33');
INSERT INTO `setting` VALUES ('19', '2008-03-14', null, null, '18', '35', '35');
INSERT INTO `setting` VALUES ('20', '2008-03-14', null, null, '19', '37', '37');
INSERT INTO `setting` VALUES ('21', '2008-03-14', null, null, '20', '39', '39');
INSERT INTO `setting` VALUES ('22', '2008-03-14', null, null, '21', '41', '41');
INSERT INTO `setting` VALUES ('23', '2008-03-14', null, null, '22', '43', '43');
INSERT INTO `setting` VALUES ('24', '2008-03-15', null, null, '23', '45', '45');
INSERT INTO `setting` VALUES ('25', '2008-03-15', null, null, '24', '47', '47');
INSERT INTO `setting` VALUES ('26', '2008-03-15', null, null, '25', '49', '49');
INSERT INTO `setting` VALUES ('27', '2008-03-15', null, null, '26', '51', '51');
INSERT INTO `setting` VALUES ('28', '2008-03-15', null, null, '27', '53', '53');
INSERT INTO `setting` VALUES ('32', '2008-03-16', null, null, '31', '61', '61');
INSERT INTO `setting` VALUES ('33', '2008-03-16', null, null, '32', '63', '63');
INSERT INTO `setting` VALUES ('34', '2008-03-16', null, null, '33', '65', '65');
INSERT INTO `settings_on_arrival` VALUES ('1', '0', '0', '2', '2');
INSERT INTO `settings_on_arrival` VALUES ('2', '0', '0', '4', '4');
INSERT INTO `settings_on_arrival` VALUES ('3', '0', '0', '6', '6');
INSERT INTO `settings_on_arrival` VALUES ('4', '0', '0', '8', '8');
INSERT INTO `settings_on_arrival` VALUES ('5', '0', '0', '10', '10');
INSERT INTO `settings_on_arrival` VALUES ('6', '0', '0', '12', '12');
INSERT INTO `settings_on_arrival` VALUES ('7', '0', '0', '14', '14');
INSERT INTO `settings_on_arrival` VALUES ('8', '0', '0', '16', '16');
INSERT INTO `settings_on_arrival` VALUES ('9', '0', '0', '18', '18');
INSERT INTO `settings_on_arrival` VALUES ('10', '0', '0', '20', '20');
INSERT INTO `settings_on_arrival` VALUES ('11', '0', '0', '22', '22');
INSERT INTO `settings_on_arrival` VALUES ('12', '0', '0', '24', '24');
INSERT INTO `settings_on_arrival` VALUES ('13', '0', '0', '26', '26');
INSERT INTO `settings_on_arrival` VALUES ('14', '0', '0', '28', '28');
INSERT INTO `settings_on_arrival` VALUES ('15', '0', '0', '30', '30');
INSERT INTO `settings_on_arrival` VALUES ('16', '0', '0', '32', '32');
INSERT INTO `settings_on_arrival` VALUES ('17', '0', '0', '34', '34');
INSERT INTO `settings_on_arrival` VALUES ('18', '0', '0', '36', '36');
INSERT INTO `settings_on_arrival` VALUES ('19', '0', '0', '38', '38');
INSERT INTO `settings_on_arrival` VALUES ('20', '0', '0', '40', '40');
INSERT INTO `settings_on_arrival` VALUES ('21', '0', '0', '42', '42');
INSERT INTO `settings_on_arrival` VALUES ('22', '0', '0', '44', '44');
INSERT INTO `settings_on_arrival` VALUES ('23', '0', '0', '46', '46');
INSERT INTO `settings_on_arrival` VALUES ('24', '0', '0', '48', '48');
INSERT INTO `settings_on_arrival` VALUES ('25', '0', '0', '50', '50');
INSERT INTO `settings_on_arrival` VALUES ('26', '0', '0', '52', '52');
INSERT INTO `settings_on_arrival` VALUES ('27', '0', '0', '54', '54');
INSERT INTO `settings_on_arrival` VALUES ('31', '0', '0', '62', '62');
INSERT INTO `settings_on_arrival` VALUES ('32', '0', '0', '64', '64');
INSERT INTO `settings_on_arrival` VALUES ('33', '0', '0', '66', '66');
INSERT INTO `ship_method` VALUES ('1', 'FedEx Ground');
INSERT INTO `ship_method` VALUES ('2', 'FedEx ES');
INSERT INTO `ship_method` VALUES ('3', 'FedEx 2 Day');
INSERT INTO `ship_method` VALUES ('4', 'FedEx Stnd Overnight');
INSERT INTO `ship_method` VALUES ('5', 'FedEx Priority Overnight');
INSERT INTO `ship_method` VALUES ('6', 'FedEx Sat. Delivery');
INSERT INTO `ship_method` VALUES ('7', 'FedEx Hold');
INSERT INTO `ship_method` VALUES ('8', 'UPS Ground');
INSERT INTO `ship_method` VALUES ('9', 'UPS 3 Day');
INSERT INTO `ship_method` VALUES ('10', 'UPS 2 Day');
INSERT INTO `ship_method` VALUES ('11', 'UPS 1 Day');
INSERT INTO `ship_method` VALUES ('12', 'UPS Sat. Delivery');
INSERT INTO `ship_method` VALUES ('13', 'UPS Hold');
INSERT INTO `ship_method` VALUES ('14', 'Pickup @ FC');
INSERT INTO `ship_method_account` VALUES ('1', '2', '1AEF249023');
INSERT INTO `ship_method_account` VALUES ('2', '1', 'UPS Sample acct');
INSERT INTO `ship_method_account` VALUES ('3', '2', '');
INSERT INTO `ship_method_account` VALUES ('4', '2', '1qwas');
INSERT INTO `ship_vendor` VALUES ('1', 'UPS');
INSERT INTO `ship_vendor` VALUES ('2', 'FedEx');
INSERT INTO `shipping` VALUES ('12', '16', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('32', '15', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('74', '1', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('75', '2', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('76', '3', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('77', '4', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('78', '6', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('79', '7', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('80', '8', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('81', '9', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('82', '10', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('83', '11', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('84', '12', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('85', '13', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('86', '14', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('87', '17', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('88', '18', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('89', '19', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('90', '20', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('91', '21', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('92', '22', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('93', '23', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('94', '24', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('95', '25', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('96', '26', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('97', '27', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('98', '28', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('102', '29', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('103', '30', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shipping` VALUES ('104', '31', null, '0', '6', null, '0', null, null, null, null);
INSERT INTO `shock_additional_products` VALUES ('1', 'hd bumper');
INSERT INTO `shock_additional_products` VALUES ('2', 'works bladder cap');
INSERT INTO `shock_additional_products` VALUES ('9', 'spring seats');
INSERT INTO `shock_additional_products` VALUES ('10', 'overflow vents');
INSERT INTO `shock_additional_products_combo` VALUES ('21', '34', '1', '53');
INSERT INTO `shock_additional_products_combo` VALUES ('24', '36', '1', '53');
INSERT INTO `shock_additional_products_combo` VALUES ('26', '31', '1', '0');
INSERT INTO `shock_additional_services` VALUES ('1', 'Replace Shock Bearing');
INSERT INTO `shock_additional_services` VALUES ('2', 'Anodize Shock Body');
INSERT INTO `shock_additional_services` VALUES ('3', 'DLC (Black) Shock Shaft');
INSERT INTO `shock_additional_services` VALUES ('4', 'Shorten');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('7', '1', '0', '6.000', '18.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('8', '1', '1', '6.000', '15.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('9', '1', '2', '6.000', '10.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('10', '1', '3', '6.000', '9.000', '0.200', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('103', '11', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('104', '11', '1', '0.000', '20.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('105', '11', '2', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('106', '11', '3', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('107', '11', '4', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('108', '11', '5', '0.000', '9.500', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('145', '3', '0', '0.000', '18.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('146', '3', '1', '0.000', '15.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('147', '3', '2', '0.000', '10.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('148', '3', '3', '0.000', '9.000', '0.200', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('181', '13', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('182', '13', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('183', '13', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('184', '13', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('185', '13', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('186', '13', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('187', '13', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('188', '13', '7', '0.000', '9.500', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('189', '15', '0', '0.000', '22.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('190', '15', '1', '0.000', '14.000', '0.100', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('191', '15', '2', '0.000', '22.000', '0.150', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('192', '15', '3', '0.000', '20.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('193', '15', '4', '0.000', '18.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('194', '15', '5', '0.000', '16.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('195', '15', '6', '0.000', '14.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('196', '15', '7', '0.000', '9.500', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('205', '17', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('206', '17', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('207', '17', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('208', '17', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('209', '17', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('210', '17', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('211', '17', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('212', '17', '7', '0.000', '9.500', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('221', '19', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('222', '19', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('223', '19', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('224', '19', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('225', '19', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('226', '19', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('227', '19', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('228', '19', '7', '0.000', '9.500', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('237', '21', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('238', '21', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('239', '21', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('240', '21', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('241', '21', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('242', '21', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('243', '21', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('244', '21', '7', '0.000', '9.500', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('253', '23', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('254', '23', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('255', '23', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('256', '23', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('257', '23', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('258', '23', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('259', '23', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('260', '23', '7', '0.000', '9.500', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('269', '25', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('270', '25', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('271', '25', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('272', '25', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('273', '25', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('274', '25', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('275', '25', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('276', '25', '7', '0.000', '9.500', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('285', '27', '0', '0.000', '22.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('286', '27', '1', '0.000', '14.000', '0.100', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('287', '27', '2', '0.000', '22.000', '0.150', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('288', '27', '3', '0.000', '20.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('289', '27', '4', '0.000', '18.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('290', '27', '5', '0.000', '16.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('291', '27', '6', '0.000', '14.000', '0.250', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('292', '27', '7', '0.000', '9.500', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('301', '29', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('302', '29', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('303', '29', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('304', '29', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('305', '29', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('306', '29', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('307', '29', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('308', '29', '7', '0.000', '9.500', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('309', '33', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('310', '33', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('311', '33', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('312', '33', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('313', '33', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('314', '33', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('315', '33', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('316', '33', '7', '0.000', '9.500', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('325', '35', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('326', '35', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('327', '35', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('328', '35', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('329', '35', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('330', '35', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('331', '35', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('332', '35', '7', '0.000', '9.500', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('341', '39', '0', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('342', '39', '1', '0.000', '14.000', '0.100', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('343', '39', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('344', '39', '3', '0.000', '20.000', '0.250', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('345', '39', '4', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('346', '39', '5', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('347', '39', '6', '0.000', '14.000', '0.250', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('348', '39', '7', '0.000', '9.500', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('356', '43', '0', '0.000', '22.000', '0.200', '9');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('357', '43', '1', '0.000', '20.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('358', '43', '2', '0.000', '18.000', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('359', '43', '3', '0.000', '16.000', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('360', '43', '4', '0.000', '14.000', '0.300', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('361', '43', '5', '0.000', '13.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('362', '43', '6', '0.000', '12.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('368', '45', '0', '0.000', '14.000', '0.100', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('369', '45', '1', '0.000', '11.000', '0.100', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('370', '45', '2', '0.000', '8.000', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('371', '45', '3', '0.000', '11.000', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('372', '45', '4', '0.000', '13.000', '0.200', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('377', '47', '0', '0.000', '18.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('378', '47', '1', '0.000', '16.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('379', '47', '2', '0.000', '11.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('380', '47', '3', '0.000', '9.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('385', '49', '0', '0.000', '18.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('386', '49', '1', '0.000', '16.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('387', '49', '2', '0.000', '11.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('388', '49', '3', '0.000', '9.000', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('393', '51', '0', '0.000', '18.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('394', '51', '1', '0.000', '16.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('395', '51', '2', '0.000', '11.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('396', '51', '3', '0.000', '9.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('409', '53', '0', '0.000', '18.000', '0.300', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('410', '53', '1', '0.000', '16.000', '0.200', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('411', '53', '2', '0.000', '14.000', '0.200', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('412', '53', '3', '0.000', '12.000', '0.200', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('413', '53', '4', '0.000', '10.000', '0.200', '1');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('414', '53', '5', '0.000', '8.000', '0.200', '2');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('415', '61', '0', '0.000', '18.000', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('416', '61', '1', '0.000', '16.000', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('417', '61', '2', '0.000', '11.000', '0.300', '0');
INSERT INTO `shock_compression_adjuster_stack` VALUES ('418', '61', '3', '0.000', '9.000', '0.300', '0');
INSERT INTO `shock_compression_stack` VALUES ('7', '1', '0', '12.000', '44.000', '0.200', '9');
INSERT INTO `shock_compression_stack` VALUES ('8', '1', '1', '12.000', '44.000', '0.150', '10');
INSERT INTO `shock_compression_stack` VALUES ('9', '1', '2', '12.000', '38.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('10', '1', '3', '12.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('11', '1', '4', '12.000', '42.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('12', '1', '5', '12.000', '40.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('13', '1', '6', '12.000', '38.000', '0.300', '0');
INSERT INTO `shock_compression_stack` VALUES ('14', '1', '7', '12.000', '36.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('15', '1', '8', '12.000', '34.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('16', '1', '9', '12.000', '32.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('17', '1', '10', '12.000', '30.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('18', '1', '11', '12.000', '29.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('19', '1', '12', '12.000', '28.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('20', '1', '13', '12.000', '27.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('21', '1', '14', '12.000', '26.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('22', '1', '15', '12.000', '25.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('23', '1', '16', '12.000', '24.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('24', '1', '17', '12.000', '23.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('25', '1', '18', '12.000', '22.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('509', '11', '0', '0.000', '40.000', '0.150', '7');
INSERT INTO `shock_compression_stack` VALUES ('510', '11', '1', '0.000', '38.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('511', '11', '2', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('512', '11', '3', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('513', '11', '4', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('514', '11', '5', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('515', '11', '6', '0.000', '28.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('516', '11', '7', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('517', '11', '8', '0.000', '17.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('518', '11', '9', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('519', '11', '10', '0.000', '31.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('520', '11', '11', '0.000', '29.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('521', '11', '12', '0.000', '27.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('522', '11', '13', '0.000', '25.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('523', '11', '14', '0.000', '23.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('524', '11', '15', '0.000', '21.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('525', '11', '16', '0.000', '16.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('526', '9', '0', '0.000', '33.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('527', '9', '1', '0.000', '19.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('528', '9', '2', '0.000', '27.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('529', '9', '3', '0.000', '33.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('530', '9', '4', '0.000', '31.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('531', '9', '5', '0.000', '29.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('532', '9', '6', '0.000', '27.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('533', '9', '7', '0.000', '25.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('534', '9', '8', '0.000', '23.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('535', '9', '9', '0.000', '21.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('536', '9', '10', '0.000', '16.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('651', '3', '0', '0.000', '44.000', '0.200', '7');
INSERT INTO `shock_compression_stack` VALUES ('652', '3', '1', '0.000', '44.000', '0.150', '7');
INSERT INTO `shock_compression_stack` VALUES ('653', '3', '2', '0.000', '38.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('654', '3', '3', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('655', '3', '4', '0.000', '42.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('656', '3', '5', '0.000', '40.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('657', '3', '6', '0.000', '38.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('658', '3', '7', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('659', '3', '8', '0.000', '34.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('660', '3', '9', '0.000', '32.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('661', '3', '10', '0.000', '31.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('662', '3', '11', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('663', '3', '12', '0.000', '29.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('664', '3', '13', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('665', '3', '14', '0.000', '27.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('666', '3', '15', '0.000', '26.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('667', '3', '16', '0.000', '25.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('668', '3', '17', '0.000', '24.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('669', '3', '18', '0.000', '23.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('670', '3', '19', '0.000', '22.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('671', '3', '20', '0.000', '25.250', '0.600', '2');
INSERT INTO `shock_compression_stack` VALUES ('740', '13', '0', '0.000', '40.000', '0.150', '10');
INSERT INTO `shock_compression_stack` VALUES ('741', '13', '1', '0.000', '38.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('742', '13', '2', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('743', '13', '3', '0.000', '24.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('744', '13', '4', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('745', '13', '5', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('746', '13', '6', '0.000', '28.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('747', '13', '7', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('748', '13', '8', '0.000', '17.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('749', '13', '9', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('750', '13', '10', '0.000', '31.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('751', '13', '11', '0.000', '29.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('752', '13', '12', '0.000', '27.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('753', '13', '13', '0.000', '25.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('754', '13', '14', '0.000', '23.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('755', '13', '15', '0.000', '21.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('756', '13', '16', '0.000', '16.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('757', '15', '0', '0.000', '44.000', '0.250', '5');
INSERT INTO `shock_compression_stack` VALUES ('758', '15', '1', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('759', '15', '2', '0.000', '44.000', '0.150', '3');
INSERT INTO `shock_compression_stack` VALUES ('760', '15', '3', '0.000', '42.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('761', '15', '4', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('762', '15', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('763', '15', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('764', '15', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('765', '15', '8', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('766', '15', '9', '0.000', '30.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('767', '15', '10', '0.000', '21.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('768', '15', '11', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('769', '15', '12', '0.000', '40.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('770', '15', '13', '0.000', '38.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('771', '15', '14', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('772', '15', '15', '0.000', '34.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('773', '15', '16', '0.000', '20.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('791', '17', '0', '0.000', '44.000', '0.250', '5');
INSERT INTO `shock_compression_stack` VALUES ('792', '17', '1', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('793', '17', '2', '0.000', '44.000', '0.150', '3');
INSERT INTO `shock_compression_stack` VALUES ('794', '17', '3', '0.000', '42.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('795', '17', '4', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('796', '17', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('797', '17', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('798', '17', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('799', '17', '8', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('800', '17', '9', '0.000', '30.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('801', '17', '10', '0.000', '21.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('802', '17', '11', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('803', '17', '12', '0.000', '40.000', '0.200', '4');
INSERT INTO `shock_compression_stack` VALUES ('804', '17', '13', '0.000', '38.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('805', '17', '14', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('806', '17', '15', '0.000', '34.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('807', '17', '16', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('823', '19', '0', '0.000', '44.000', '0.200', '8');
INSERT INTO `shock_compression_stack` VALUES ('824', '19', '1', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('825', '19', '2', '0.000', '44.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('826', '19', '3', '0.000', '42.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('827', '19', '4', '0.000', '40.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('828', '19', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('829', '19', '6', '0.000', '36.000', '0.200', '0');
INSERT INTO `shock_compression_stack` VALUES ('830', '19', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('831', '19', '8', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('832', '19', '9', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('833', '19', '10', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('834', '19', '11', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('835', '19', '12', '0.000', '40.000', '0.200', '4');
INSERT INTO `shock_compression_stack` VALUES ('836', '19', '13', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('837', '19', '14', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('858', '21', '0', '0.000', '44.000', '0.250', '2');
INSERT INTO `shock_compression_stack` VALUES ('859', '21', '1', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('860', '21', '2', '0.000', '44.000', '0.250', '3');
INSERT INTO `shock_compression_stack` VALUES ('861', '21', '3', '0.000', '42.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('862', '21', '4', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('863', '21', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('864', '21', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('865', '21', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('866', '21', '8', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('867', '21', '9', '0.000', '30.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('868', '21', '10', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('869', '21', '11', '0.000', '26.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('870', '21', '12', '0.000', '22.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('871', '21', '13', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('872', '21', '14', '0.000', '40.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('873', '21', '15', '0.000', '38.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('874', '21', '16', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('875', '21', '17', '0.000', '34.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('876', '21', '18', '0.000', '30.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('877', '21', '19', '0.000', '20.000', '0.300', '0');
INSERT INTO `shock_compression_stack` VALUES ('900', '23', '0', '0.000', '44.000', '0.250', '2');
INSERT INTO `shock_compression_stack` VALUES ('901', '23', '1', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('902', '23', '2', '0.000', '44.000', '0.250', '3');
INSERT INTO `shock_compression_stack` VALUES ('903', '23', '3', '0.000', '42.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('904', '23', '4', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('905', '23', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('906', '23', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('907', '23', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('908', '23', '8', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('909', '23', '9', '0.000', '30.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('910', '23', '10', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('911', '23', '11', '0.000', '26.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('912', '23', '12', '0.000', '22.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('913', '23', '13', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('914', '23', '14', '0.000', '40.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('915', '23', '15', '0.000', '38.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('916', '23', '16', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('917', '23', '17', '0.000', '34.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('918', '23', '18', '0.000', '32.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('919', '23', '19', '0.000', '30.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('920', '23', '20', '0.000', '32.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('921', '23', '21', '0.000', '20.000', '0.300', '0');
INSERT INTO `shock_compression_stack` VALUES ('937', '25', '0', '0.000', '44.000', '0.200', '10');
INSERT INTO `shock_compression_stack` VALUES ('938', '25', '1', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('939', '25', '2', '0.000', '44.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('940', '25', '3', '0.000', '42.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('941', '25', '4', '0.000', '40.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('942', '25', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('943', '25', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('944', '25', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('945', '25', '8', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('946', '25', '9', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('947', '25', '10', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('948', '25', '11', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('949', '25', '12', '0.000', '40.000', '0.200', '4');
INSERT INTO `shock_compression_stack` VALUES ('950', '25', '13', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('951', '25', '14', '0.000', '20.000', '0.300', '0');
INSERT INTO `shock_compression_stack` VALUES ('967', '27', '0', '0.000', '44.000', '0.200', '10');
INSERT INTO `shock_compression_stack` VALUES ('968', '27', '1', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('969', '27', '2', '0.000', '44.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('970', '27', '3', '0.000', '42.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('971', '27', '4', '0.000', '40.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('972', '27', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('973', '27', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('974', '27', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('975', '27', '8', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('976', '27', '9', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('977', '27', '10', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('978', '27', '11', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('979', '27', '12', '0.000', '40.000', '0.200', '4');
INSERT INTO `shock_compression_stack` VALUES ('980', '27', '13', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('981', '27', '14', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1002', '29', '0', '0.000', '44.000', '0.250', '3');
INSERT INTO `shock_compression_stack` VALUES ('1003', '29', '1', '0.000', '34.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1004', '29', '2', '0.000', '44.000', '0.250', '2');
INSERT INTO `shock_compression_stack` VALUES ('1005', '29', '3', '0.000', '42.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1006', '29', '4', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1007', '29', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1008', '29', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1009', '29', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1010', '29', '8', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1011', '29', '9', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1012', '29', '10', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1013', '29', '11', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('1014', '29', '12', '0.000', '40.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1015', '29', '13', '0.000', '38.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1016', '29', '14', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1017', '29', '15', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1018', '29', '16', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1019', '29', '17', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1020', '29', '18', '0.000', '28.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1021', '29', '19', '0.000', '20.000', '0.300', '0');
INSERT INTO `shock_compression_stack` VALUES ('1022', '33', '0', '0.000', '44.000', '0.250', '3');
INSERT INTO `shock_compression_stack` VALUES ('1023', '33', '1', '0.000', '34.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1024', '33', '2', '0.000', '44.000', '0.250', '2');
INSERT INTO `shock_compression_stack` VALUES ('1025', '33', '3', '0.000', '42.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1026', '33', '4', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1027', '33', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1028', '33', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1029', '33', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1030', '33', '8', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1031', '33', '9', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1032', '33', '10', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1033', '33', '11', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('1034', '33', '12', '0.000', '40.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1035', '33', '13', '0.000', '38.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1036', '33', '14', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1037', '33', '15', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1038', '33', '16', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1039', '33', '17', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1040', '33', '18', '0.000', '28.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1041', '33', '19', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1064', '35', '0', '0.000', '44.000', '0.250', '3');
INSERT INTO `shock_compression_stack` VALUES ('1065', '35', '1', '0.000', '34.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1066', '35', '2', '0.000', '44.000', '0.250', '3');
INSERT INTO `shock_compression_stack` VALUES ('1067', '35', '3', '0.000', '42.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('1068', '35', '4', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1069', '35', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1070', '35', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1071', '35', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1072', '35', '8', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1073', '35', '9', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1074', '35', '10', '0.000', '28.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1075', '35', '11', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1076', '35', '12', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('1077', '35', '13', '0.000', '40.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1078', '35', '14', '0.000', '38.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1079', '35', '15', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1080', '35', '16', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1081', '35', '17', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1082', '35', '18', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1083', '35', '19', '0.000', '28.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1084', '35', '20', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1085', '35', '21', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1086', '37', '0', '0.000', '24.000', '0.000', '0');
INSERT INTO `shock_compression_stack` VALUES ('1103', '39', '0', '0.000', '44.000', '0.200', '10');
INSERT INTO `shock_compression_stack` VALUES ('1104', '39', '1', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1105', '39', '2', '0.000', '44.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1106', '39', '3', '0.000', '42.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1107', '39', '4', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1108', '39', '5', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1109', '39', '6', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1110', '39', '7', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1111', '39', '8', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1112', '39', '9', '0.000', '30.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1113', '39', '10', '0.000', '28.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1114', '39', '11', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1115', '39', '12', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_compression_stack` VALUES ('1116', '39', '13', '0.000', '40.000', '0.200', '4');
INSERT INTO `shock_compression_stack` VALUES ('1117', '39', '14', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1118', '39', '15', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1132', '41', '0', '0.000', '34.000', '0.200', '3');
INSERT INTO `shock_compression_stack` VALUES ('1133', '41', '1', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1134', '41', '2', '0.000', '22.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1135', '41', '3', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1136', '41', '4', '0.000', '32.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1137', '41', '5', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1138', '41', '6', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1139', '41', '7', '0.000', '26.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1140', '41', '8', '0.000', '24.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1141', '41', '9', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1142', '41', '10', '0.000', '20.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1143', '41', '11', '0.000', '18.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1144', '41', '12', '0.000', '17.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1161', '43', '0', '0.000', '44.000', '0.250', '4');
INSERT INTO `shock_compression_stack` VALUES ('1162', '43', '1', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1163', '43', '2', '0.000', '25.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1164', '43', '3', '0.000', '44.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1165', '43', '4', '0.000', '42.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1166', '43', '5', '0.000', '40.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1167', '43', '6', '0.000', '38.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1168', '43', '7', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1169', '43', '8', '0.000', '34.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1170', '43', '9', '0.000', '32.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1171', '43', '10', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1172', '43', '11', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1173', '43', '12', '0.000', '26.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1174', '43', '13', '0.000', '24.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1175', '43', '14', '0.000', '20.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1176', '43', '17', '0.000', '30.000', '0.300', '3');
INSERT INTO `shock_compression_stack` VALUES ('1189', '45', '0', '0.000', '34.000', '0.150', '6');
INSERT INTO `shock_compression_stack` VALUES ('1190', '45', '1', '0.000', '28.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1191', '45', '2', '0.000', '18.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1192', '45', '3', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1193', '45', '4', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1194', '45', '5', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1195', '45', '6', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1196', '45', '7', '0.000', '26.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1197', '45', '8', '0.000', '24.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1198', '45', '9', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1199', '45', '10', '0.000', '37.000', '3.200', '0');
INSERT INTO `shock_compression_stack` VALUES ('1200', '45', '11', '0.000', '16.000', '1.000', '1');
INSERT INTO `shock_compression_stack` VALUES ('1214', '47', '0', '0.000', '40.000', '0.200', '10');
INSERT INTO `shock_compression_stack` VALUES ('1215', '47', '1', '0.000', '34.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1216', '47', '2', '0.000', '29.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1217', '47', '3', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1218', '47', '4', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1219', '47', '5', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1220', '47', '6', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1221', '47', '7', '0.000', '30.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1222', '47', '8', '0.000', '28.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1223', '47', '9', '0.000', '26.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1224', '47', '10', '0.000', '24.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1225', '47', '11', '0.000', '22.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1226', '47', '12', '0.000', '21.000', '0.200', '0');
INSERT INTO `shock_compression_stack` VALUES ('1240', '49', '0', '0.000', '40.000', '0.200', '7');
INSERT INTO `shock_compression_stack` VALUES ('1241', '49', '1', '0.000', '36.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1242', '49', '2', '0.000', '30.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1243', '49', '3', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1244', '49', '4', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1245', '49', '5', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1246', '49', '6', '0.000', '34.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1247', '49', '7', '0.000', '32.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1248', '49', '8', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1249', '49', '9', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1250', '49', '10', '0.000', '26.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1251', '49', '11', '0.000', '24.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1252', '49', '12', '0.000', '22.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1265', '51', '0', '0.000', '40.000', '0.200', '0');
INSERT INTO `shock_compression_stack` VALUES ('1266', '51', '1', '0.000', '36.000', '0.150', '0');
INSERT INTO `shock_compression_stack` VALUES ('1267', '51', '2', '0.000', '30.000', '0.150', '0');
INSERT INTO `shock_compression_stack` VALUES ('1268', '51', '3', '0.000', '40.000', '0.250', '0');
INSERT INTO `shock_compression_stack` VALUES ('1269', '51', '4', '0.000', '38.000', '0.250', '0');
INSERT INTO `shock_compression_stack` VALUES ('1270', '51', '5', '0.000', '36.000', '0.250', '0');
INSERT INTO `shock_compression_stack` VALUES ('1271', '51', '6', '0.000', '34.000', '0.250', '0');
INSERT INTO `shock_compression_stack` VALUES ('1272', '51', '7', '0.000', '32.000', '0.250', '0');
INSERT INTO `shock_compression_stack` VALUES ('1273', '51', '8', '0.000', '30.000', '0.250', '0');
INSERT INTO `shock_compression_stack` VALUES ('1274', '51', '9', '0.000', '28.000', '0.250', '0');
INSERT INTO `shock_compression_stack` VALUES ('1275', '51', '10', '0.000', '26.000', '0.250', '0');
INSERT INTO `shock_compression_stack` VALUES ('1276', '51', '11', '0.000', '23.000', '0.300', '0');
INSERT INTO `shock_compression_stack` VALUES ('1309', '53', '0', '0.000', '44.000', '0.250', '7');
INSERT INTO `shock_compression_stack` VALUES ('1310', '53', '1', '0.000', '44.000', '0.200', '2');
INSERT INTO `shock_compression_stack` VALUES ('1311', '53', '2', '0.000', '37.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1312', '53', '3', '0.000', '22.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1313', '53', '4', '0.000', '44.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1314', '53', '5', '0.000', '42.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1315', '53', '6', '0.000', '40.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1316', '53', '7', '0.000', '38.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1317', '53', '8', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1318', '53', '9', '0.000', '34.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1319', '53', '10', '0.000', '32.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1320', '53', '11', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1321', '53', '12', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1322', '53', '13', '0.000', '26.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1323', '53', '14', '0.000', '24.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1324', '53', '15', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1325', '61', '0', '0.000', '40.000', '0.150', '6');
INSERT INTO `shock_compression_stack` VALUES ('1326', '61', '1', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1327', '61', '2', '0.000', '28.000', '0.150', '1');
INSERT INTO `shock_compression_stack` VALUES ('1328', '61', '3', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1329', '61', '4', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1330', '61', '5', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1331', '61', '6', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1332', '61', '7', '0.000', '30.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1333', '61', '8', '0.000', '29.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1334', '61', '9', '0.000', '18.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1335', '61', '10', '0.000', '27.000', '0.250', '1');
INSERT INTO `shock_compression_stack` VALUES ('1336', '61', '11', '0.000', '26.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1337', '61', '12', '0.000', '25.000', '0.300', '1');
INSERT INTO `shock_compression_stack` VALUES ('1338', '63', '0', '0.000', '30.000', '0.150', '8');
INSERT INTO `shock_compression_stack` VALUES ('1339', '63', '1', '0.000', '21.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1340', '63', '2', '0.000', '15.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1341', '63', '3', '0.000', '28.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1342', '63', '4', '0.000', '26.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1343', '63', '5', '0.000', '24.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1344', '63', '6', '0.000', '22.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1345', '63', '7', '0.000', '22.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1346', '65', '0', '0.000', '30.000', '0.150', '8');
INSERT INTO `shock_compression_stack` VALUES ('1347', '65', '1', '0.000', '21.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1348', '65', '2', '0.000', '15.000', '0.100', '1');
INSERT INTO `shock_compression_stack` VALUES ('1349', '65', '3', '0.000', '28.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1350', '65', '4', '0.000', '26.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1351', '65', '5', '0.000', '24.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1352', '65', '6', '0.000', '22.000', '0.200', '1');
INSERT INTO `shock_compression_stack` VALUES ('1353', '65', '7', '0.000', '20.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('2', '1', '0', '6.000', '40.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('3', '1', '1', '6.000', '26.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('4', '1', '2', '6.000', '40.000', '0.300', '0');
INSERT INTO `shock_rebound_stack` VALUES ('5', '1', '3', '6.000', '38.000', '0.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('6', '1', '4', '6.000', '36.000', '0.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('7', '1', '5', '6.000', '34.000', '0.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('8', '1', '6', '6.000', '32.000', '0.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('9', '1', '7', '6.000', '31.000', '0.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('10', '1', '8', '6.000', '30.000', '0.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('11', '1', '9', '6.000', '29.000', '0.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('12', '1', '10', '6.000', '28.000', '0.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('13', '1', '11', '6.000', '27.000', '0.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('14', '1', '12', '6.000', '26.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('305', '11', '0', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('306', '11', '1', '0.000', '28.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('307', '11', '2', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('308', '11', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('309', '11', '4', '0.000', '30.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('310', '11', '5', '0.000', '28.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('311', '11', '6', '0.000', '17.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('312', '11', '7', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('313', '11', '8', '0.000', '19.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('314', '11', '9', '0.000', '16.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('315', '11', '10', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('316', '9', '0', '0.000', '25.000', '0.150', '2');
INSERT INTO `shock_rebound_stack` VALUES ('317', '9', '1', '0.000', '23.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('318', '9', '2', '0.000', '16.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('319', '9', '3', '0.000', '25.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('320', '9', '4', '0.000', '23.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('321', '9', '5', '0.000', '21.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('322', '9', '6', '0.000', '18.000', '0.300', '0');
INSERT INTO `shock_rebound_stack` VALUES ('395', '3', '0', '0.000', '40.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('396', '3', '1', '0.000', '27.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('397', '3', '2', '0.000', '40.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('398', '3', '3', '0.000', '38.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('399', '3', '4', '0.000', '36.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('400', '3', '5', '0.000', '34.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('401', '3', '6', '0.000', '32.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('402', '3', '7', '0.000', '31.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('403', '3', '8', '0.000', '30.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('404', '3', '9', '0.000', '29.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('405', '3', '10', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('406', '3', '11', '0.000', '27.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('407', '3', '12', '0.000', '26.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('440', '13', '0', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('441', '13', '1', '0.000', '28.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('442', '13', '2', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('443', '13', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('444', '13', '4', '0.000', '30.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('445', '13', '5', '0.000', '28.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('446', '13', '6', '0.000', '17.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('447', '13', '7', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('448', '13', '8', '0.000', '19.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('449', '13', '9', '0.000', '16.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('450', '13', '10', '0.000', '16.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('451', '15', '0', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('452', '15', '1', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('453', '15', '2', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('454', '15', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('455', '15', '4', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('456', '15', '5', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('457', '15', '6', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('458', '15', '7', '0.000', '20.000', '0.300', '0');
INSERT INTO `shock_rebound_stack` VALUES ('471', '17', '0', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('472', '17', '1', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('473', '17', '2', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('474', '17', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('475', '17', '4', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('476', '17', '5', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('477', '17', '6', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('478', '17', '7', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('479', '17', '8', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('480', '17', '9', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('481', '17', '10', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('482', '17', '11', '0.000', '22.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('493', '19', '0', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('494', '19', '1', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('495', '19', '2', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('496', '19', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('497', '19', '4', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('498', '19', '5', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('499', '19', '6', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('500', '19', '7', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('501', '19', '8', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('502', '19', '9', '0.000', '22.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('515', '21', '0', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('516', '21', '1', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('517', '21', '2', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('518', '21', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('519', '21', '4', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('520', '21', '5', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('521', '21', '6', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('522', '21', '7', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('523', '21', '8', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('524', '21', '9', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('525', '21', '10', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('526', '21', '11', '0.000', '22.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('539', '23', '0', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('540', '23', '1', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('541', '23', '2', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('542', '23', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('543', '23', '4', '0.000', '32.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('544', '23', '5', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('545', '23', '6', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('546', '23', '7', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('547', '23', '8', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('548', '23', '9', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('549', '23', '10', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('550', '23', '11', '0.000', '22.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('561', '25', '0', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('562', '25', '1', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('563', '25', '2', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('564', '25', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('565', '25', '4', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('566', '25', '5', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('567', '25', '6', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('568', '25', '7', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('569', '25', '8', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('570', '25', '9', '0.000', '22.000', '0.300', '2');
INSERT INTO `shock_rebound_stack` VALUES ('581', '27', '0', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('582', '27', '1', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('583', '27', '2', '0.000', '23.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('584', '27', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('585', '27', '4', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('586', '27', '5', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('587', '27', '6', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('588', '27', '7', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('589', '27', '8', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('590', '27', '9', '0.000', '22.000', '0.300', '0');
INSERT INTO `shock_rebound_stack` VALUES ('600', '29', '0', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('601', '29', '1', '0.000', '28.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('602', '29', '2', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('603', '29', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('604', '29', '4', '0.000', '28.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('605', '29', '5', '0.000', '20.000', '0.300', '3');
INSERT INTO `shock_rebound_stack` VALUES ('606', '29', '6', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('607', '29', '7', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('608', '29', '8', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('609', '33', '0', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('610', '33', '1', '0.000', '28.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('611', '33', '2', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('612', '33', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('613', '33', '4', '0.000', '28.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('614', '33', '5', '0.000', '20.000', '0.300', '3');
INSERT INTO `shock_rebound_stack` VALUES ('615', '33', '6', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('616', '33', '7', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('617', '33', '8', '0.000', '22.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('618', '33', '9', '0.000', '21.000', '1.000', '2');
INSERT INTO `shock_rebound_stack` VALUES ('629', '35', '0', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('630', '35', '1', '0.000', '28.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('631', '35', '2', '0.000', '34.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('632', '35', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('633', '35', '4', '0.000', '28.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('634', '35', '5', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('635', '35', '6', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('636', '35', '7', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('637', '35', '8', '0.000', '20.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('638', '35', '9', '0.000', '21.000', '1.000', '2');
INSERT INTO `shock_rebound_stack` VALUES ('649', '39', '0', '0.000', '36.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('650', '39', '1', '0.000', '26.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('651', '39', '2', '0.000', '34.000', '0.150', '1');
INSERT INTO `shock_rebound_stack` VALUES ('652', '39', '3', '0.000', '32.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('653', '39', '4', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('654', '39', '5', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('655', '39', '6', '0.000', '20.000', '0.300', '0');
INSERT INTO `shock_rebound_stack` VALUES ('656', '39', '7', '0.000', '0.000', '0.000', '99');
INSERT INTO `shock_rebound_stack` VALUES ('657', '39', '8', '0.000', '36.000', '0.250', '2');
INSERT INTO `shock_rebound_stack` VALUES ('658', '39', '9', '0.000', '22.000', '0.300', '2');
INSERT INTO `shock_rebound_stack` VALUES ('669', '41', '0', '0.000', '31.000', '0.200', '3');
INSERT INTO `shock_rebound_stack` VALUES ('670', '41', '1', '0.000', '21.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('671', '41', '2', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('672', '41', '3', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('673', '41', '4', '0.000', '26.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('674', '41', '5', '0.000', '24.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('675', '41', '6', '0.000', '22.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('676', '41', '7', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('677', '41', '8', '0.000', '19.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('678', '41', '9', '0.000', '18.000', '0.300', '0');
INSERT INTO `shock_rebound_stack` VALUES ('691', '43', '0', '0.000', '40.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('692', '43', '1', '0.000', '26.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('693', '43', '2', '0.000', '40.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('694', '43', '3', '0.000', '38.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('695', '43', '4', '0.000', '36.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('696', '43', '5', '0.000', '34.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('697', '43', '6', '0.000', '32.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('698', '43', '7', '0.000', '30.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('699', '43', '8', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('700', '43', '9', '0.000', '26.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('701', '43', '10', '0.000', '24.000', '0.300', '0');
INSERT INTO `shock_rebound_stack` VALUES ('702', '43', '12', '0.000', '26.000', '3.000', '0');
INSERT INTO `shock_rebound_stack` VALUES ('710', '45', '0', '0.000', '30.000', '0.150', '7');
INSERT INTO `shock_rebound_stack` VALUES ('711', '45', '1', '0.000', '20.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('712', '45', '2', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('713', '45', '3', '0.000', '24.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('714', '45', '4', '0.000', '20.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('715', '45', '5', '0.000', '16.000', '0.700', '1');
INSERT INTO `shock_rebound_stack` VALUES ('716', '45', '8', '0.000', '26.000', '3.200', '0');
INSERT INTO `shock_rebound_stack` VALUES ('727', '47', '0', '0.000', '36.000', '0.150', '9');
INSERT INTO `shock_rebound_stack` VALUES ('728', '47', '1', '0.000', '25.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('729', '47', '2', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('730', '47', '3', '0.000', '34.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('731', '47', '4', '0.000', '32.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('732', '47', '5', '0.000', '30.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('733', '47', '6', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('734', '47', '7', '0.000', '26.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('735', '47', '8', '0.000', '24.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('736', '47', '9', '0.000', '23.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('747', '49', '0', '0.000', '36.000', '0.150', '10');
INSERT INTO `shock_rebound_stack` VALUES ('748', '49', '1', '0.000', '28.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('749', '49', '2', '0.000', '36.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('750', '49', '3', '0.000', '34.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('751', '49', '4', '0.000', '32.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('752', '49', '5', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('753', '49', '6', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('754', '49', '7', '0.000', '26.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('755', '49', '8', '0.000', '24.000', '0.300', '0');
INSERT INTO `shock_rebound_stack` VALUES ('756', '49', '10', '0.000', '26.000', '0.400', '2');
INSERT INTO `shock_rebound_stack` VALUES ('767', '51', '0', '0.000', '36.000', '0.150', '12');
INSERT INTO `shock_rebound_stack` VALUES ('768', '51', '1', '0.000', '28.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('769', '51', '2', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('770', '51', '3', '0.000', '34.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('771', '51', '4', '0.000', '32.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('772', '51', '5', '0.000', '30.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('773', '51', '6', '0.000', '28.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('774', '51', '7', '0.000', '26.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('775', '51', '8', '0.000', '24.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('776', '51', '10', '0.000', '26.000', '0.400', '1');
INSERT INTO `shock_rebound_stack` VALUES ('797', '53', '0', '0.000', '40.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('798', '53', '1', '0.000', '25.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('799', '53', '2', '0.000', '40.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('800', '53', '3', '0.000', '38.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('801', '53', '4', '0.000', '36.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('802', '53', '5', '0.000', '34.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('803', '53', '6', '0.000', '32.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('804', '53', '7', '0.000', '30.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('805', '53', '8', '0.000', '28.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('806', '53', '9', '0.000', '26.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('807', '61', '0', '0.000', '36.000', '0.150', '6');
INSERT INTO `shock_rebound_stack` VALUES ('808', '61', '1', '0.000', '28.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('809', '61', '2', '0.000', '36.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('810', '61', '3', '0.000', '34.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('811', '61', '4', '0.000', '32.000', '0.250', '1');
INSERT INTO `shock_rebound_stack` VALUES ('812', '61', '5', '0.000', '30.000', '0.300', '1');
INSERT INTO `shock_rebound_stack` VALUES ('813', '61', '6', '0.000', '28.000', '28.000', '1');
INSERT INTO `shock_rebound_stack` VALUES ('814', '61', '7', '0.000', '26.000', '36.000', '1');
INSERT INTO `shock_rebound_stack` VALUES ('815', '61', '8', '0.000', '25.000', '25.000', '1');
INSERT INTO `shock_rebound_stack` VALUES ('816', '63', '0', '0.000', '26.000', '0.150', '3');
INSERT INTO `shock_rebound_stack` VALUES ('817', '63', '1', '0.000', '21.000', '0.100', '1');
INSERT INTO `shock_rebound_stack` VALUES ('818', '63', '2', '0.000', '26.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('819', '63', '3', '0.000', '24.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('820', '63', '4', '0.000', '22.000', '0.200', '1');
INSERT INTO `shock_rebound_stack` VALUES ('821', '63', '5', '0.000', '20.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('822', '63', '6', '0.000', '18.000', '0.200', '2');
INSERT INTO `shock_rebound_stack` VALUES ('823', '63', '7', '0.000', '16.000', '0.200', '3');
INSERT INTO `shock_rebound_stack` VALUES ('824', '65', '0', '0.000', '26.000', '0.150', '0');
INSERT INTO `shock_rebound_stack` VALUES ('825', '65', '1', '0.000', '21.000', '0.100', '0');
INSERT INTO `shock_rebound_stack` VALUES ('826', '65', '2', '0.000', '26.000', '0.200', '0');
INSERT INTO `shock_rebound_stack` VALUES ('827', '65', '3', '0.000', '24.000', '0.200', '0');
INSERT INTO `shock_rebound_stack` VALUES ('828', '65', '4', '0.000', '22.000', '0.200', '0');
INSERT INTO `shock_rebound_stack` VALUES ('829', '65', '5', '0.000', '20.000', '0.200', '0');
INSERT INTO `shock_rebound_stack` VALUES ('830', '65', '6', '0.000', '18.000', '0.200', '0');
INSERT INTO `shock_rebound_stack` VALUES ('831', '65', '7', '0.000', '16.000', '0.200', '0');
INSERT INTO `shock_spec` VALUES ('1', '1.00', '0.000', '0', '', '0', null, null, '', null, null, '0', '', '0');
INSERT INTO `shock_spec` VALUES ('2', '1.00', '5.500', '14', '3', '9', '260', '265', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('3', '1.00', '5.300', '0', '', '0', null, null, 'SS25', '1', '-- 2008-03-14  08:23:05 -- 2008-03-14  09:38:57', '0', '', '0');
INSERT INTO `shock_spec` VALUES ('4', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('5', '1.00', '0.000', '0', '', '0', null, null, '', '5', null, '0', '', '0');
INSERT INTO `shock_spec` VALUES ('6', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('7', '1.00', '0.000', '0', '', '0', null, null, '', '4', null, '0', '', '0');
INSERT INTO `shock_spec` VALUES ('8', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('9', '1.00', '4.000', '0', '', '0', null, null, '', '2', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('10', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('11', '1.00', '3.500', '22', '2 T', '22', null, null, '2.5', '3', 'NOTES:   Body I.D Number (if applicable) :			1. Overall Reservoir Tube Length= 100mm			2. Overall Body Length= 249mm			3. 4mm Stop Plate -- 2008-03-11  20:14:19', '0', '', '0');
INSERT INTO `shock_spec` VALUES ('12', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('13', '1.00', '3.500', '15', '2 T', '22', null, null, '2.5', '6', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('14', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('15', '1.00', '6.000', '14', '1T', '23', null, null, '2.5', '7', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('16', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('17', '1.00', '6.000', '14', '1T', '23', null, null, '2.5', '8', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('18', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('19', '1.00', '6.300', '0', '', '0', null, null, '', '9', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('20', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('21', '1.00', '6.600', '14', '1T', '23', null, null, '2.5', '10', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('22', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('23', '1.00', '6.600', '14', '1T', '23', null, null, '2.5', '11', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('24', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('25', '1.00', '6.600', '0', '', '0', null, null, '2 1/2', '12', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('26', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('27', '1.00', '6.600', '15', '1T', '23', null, null, '2.5', '13', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('28', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('29', '1.00', '6.900', '0', '', '0', null, null, '2.5', '14', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('30', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('31', '1.00', '0.000', '0', '', '0', null, null, '', null, null, '0', '', '0');
INSERT INTO `shock_spec` VALUES ('32', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('33', '1.00', '6.900', '15', '1.5T', '24', null, null, '2.5', '15', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('34', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('35', '1.00', '7.200', '15', '1.5T', '22', null, null, '2.5W', '16', null, '145', '', '0');
INSERT INTO `shock_spec` VALUES ('36', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('37', '1.00', '0.480', '0', '', '0', null, null, 'WP 5W', '17', null, '0', '', '0');
INSERT INTO `shock_spec` VALUES ('38', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('39', '1.00', '6.900', '15', '1T', '23', null, null, '2.5W', '18', null, '0', '', '0');
INSERT INTO `shock_spec` VALUES ('40', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('41', '1.00', '4.600', '0', '', '0', null, null, '2.5W', '19', null, '150', '', '0');
INSERT INTO `shock_spec` VALUES ('42', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('43', '1.00', '5.400', '0', '', '0', null, null, '2.5W', '20', null, '105', '', '0');
INSERT INTO `shock_spec` VALUES ('44', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('45', '1.00', '5.200', '0', '', '0', null, null, '2.5W', '21', null, '125', '', '0');
INSERT INTO `shock_spec` VALUES ('46', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('47', '1.00', '4.875', '0', '', '0', null, null, '', '22', null, '146', '', '0');
INSERT INTO `shock_spec` VALUES ('48', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('49', '1.00', '5.400', '0', '', '0', null, null, '', '23', null, '133', '', '0');
INSERT INTO `shock_spec` VALUES ('50', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('51', '1.00', '5.540', '0', '', '0', null, null, '', '24', null, '146', '', '0');
INSERT INTO `shock_spec` VALUES ('52', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('53', '1.00', '5.200', '0', '', '0', null, null, '2.5W', '25', null, '130', '', '0');
INSERT INTO `shock_spec` VALUES ('54', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('61', '1.00', '5.500', '0', '', '0', null, null, '2.5W', '26', null, '0', '', '0');
INSERT INTO `shock_spec` VALUES ('62', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('63', '1.00', '4.800', '0', '', '0', null, null, '', '27', null, '90', '', '0');
INSERT INTO `shock_spec` VALUES ('64', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec` VALUES ('65', '1.00', '4.800', '0', '', '0', null, null, '', '28', null, '0', '', '0');
INSERT INTO `shock_spec` VALUES ('66', '1.00', '0.000', '0', '', '0', '0', '0', null, null, null, null, null, null);
INSERT INTO `shock_spec_general_info` VALUES ('1', 'Spring Rate (kg)   		5.3 kg	Piston Ring Dia. (mm) 		50x13	Spring Color		Yellow w/Blue Dot	Travel  (mm) 		314.96mm\nShaft Diameter (mm)		16mm	Nitrogen Pressure		135 psi	Shock Stroke (mm) 		132.5mm	Short. Spacer \"1 (mm) 		10.69mm\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 		181mm        to nut	Piston Bleed 		N/A	Shoulder Length (mm) 		40mm\nBladder Dimension (mm) or Floating Piston Position		49x104mm	Needle Length (mm) 		182mm Chrome/ 213mm	Eye to Eye W/S (mm) 		497.5mm	Number of Ports  		6\nShock Spring        Length (mm)   		AAL Series	Clevis Length (mm) 		102.7mm**	Eye to Eye WO/S (mm) 		496.8mm	Port Diameter (mm) 		2.2mm\nShock Spring                ID Top/Bottom (mm)		AAL Series	Low Speed Comp.  Clicks/Turns         (Total Out) 		(-) 22     Clicks 	High Speed Comp.    Turns (Total Out)		(-) 4 1/4 Turns	Rebound Adj.    Clicks/Turns          (Total Out )		(-) 22           Clicks\nShock Spring            O.D. Top/Bottom (mm)		AAL Series							Oil Weight 		SS25\nHigh Speed Spring Dimensions 		Length/       	I.D./                  		O.D./       	Coil Diameter/     1.6mm					\nTop Out Spring Dimensions (mm) 		Length/       	I.D./                  		O.D./       	Coil Diameter/ -- 2008-03-13  21:04:24\n\n\n\nNotes: 											\nBody Sticker ID Number KRN-A11 / Body: KRNA											\n**Clevis Overall Length (Bump Rubber Cup to Bottom of Clevis)/ Bump Rubber Cup to Center of Mounting Hole = 89.9mm');
INSERT INTO `shock_spec_general_info` VALUES ('2', 'Spring Rate (kg)     		4.0 kg	Piston Ring Dia. (mm) 		8x36mm	Spring Color		Orange	Travel  (mm) 		270mm  10.7 \"\nShaft Diameter (mm)		14mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		98mm	Short. Spacer \"1 (mm) 		9.22mm\nBody I.D.  (mm) 		36mm	Chrome Length (mm) 			Piston Bleed 		N/A	Shoulder Length (mm) 		24mm\nBladder Dimension (mm)		Floating Piston	Needle Length (mm) 		142mm	Eye to Eye W/S (mm) 		347.5mm	Number of Ports  		\nSpring Dimension   (mm) 		46.5x64.5 x220mm	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		347mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		3 C	Std. High Speed Comp. Adj. Position 		N/A	Std. Rebound Adj. Position 		6 C	Oil Weight 		\nLow Speed Comp.  Clicks/Turns (Max)		Out (-)   	High Speed Comp.    Turns (Max)		Out (-T)   	Rebound Adj.    Clicks/Turns (Max)		Out (-)');
INSERT INTO `shock_spec_general_info` VALUES ('3', 'Spring Rate (kg)     		3.5kg	Piston Ring Dia. (mm) 		46x8mm	Spring Color		Orange 	Travel  (mm) 		300mm/   11.81 in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		101.8mm	Short. Spacer \"1 (mm) 		5.5mm\nBody I.D.  (mm) 		46mm	Chrome Length (mm) 		139mm	Piston Bleed 			Shoulder Length (mm) 		\nBladder Dimension (mm)		Floating Piston	Needle Length (mm) 		176mm	Eye to Eye W/S (mm) 		404mm	Number of Ports  		\nSpring Dimension   (mm) 		Same 	Clevis Length (mm) 		91mm	Eye to Eye WO/S (mm) 		404mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		15 C	Std. High Speed Comp. Adj. Position 		2 T	Std. Rebound Adj. Position 		22 C	Oil Weight 		2.5\nLow Speed Comp.  Clicks/Turns (Max)		28 C	High Speed Comp.    Turns (Max)		3 1/4 T  	Rebound Adj.    Clicks/Turns (Max)		46 C');
INSERT INTO `shock_spec_general_info` VALUES ('4', 'Spring Rate (kg)     		6.6kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		335mm/ 13.2in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107.5mm	Short. Spacer \"1 (mm) 		8.15mm /  1/2\" 4.07mm\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 			Piston Bleed 		None 	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston	Needle Length (mm) 			Eye to Eye W/S (mm) 		413mm	Number of Ports  		\nSpring Dimension   (mm) 		Same	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		14 Clicks	Std. High Speed Comp. Adj. Position 		1 Turn	Std. Rebound Adj. Position 		23 Clicks	Oil Weight 		2.5W\nLow Speed Comp.  Clicks/Turns (Max)			High Speed Comp.    Turns (Max)			Rebound Adj.    Clicks/Turns (Max)');
INSERT INTO `shock_spec_general_info` VALUES ('7', 'Spring Rate (kg)     		6.0 kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		335mm/ 13.2in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107.5mm	Short. Spacer \"1 (mm) 		\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 			Piston Bleed 		1mm	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston	Needle Length (mm) 			Eye to Eye W/S (mm) 		413mm	Number of Ports  		\nSpring Dimension   (mm) 		Same	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		14 C	Std. High Speed Comp. Adj. Position 		1 T	Std. Rebound Adj. Position 		23 C	Oil Weight 		2.5W\nLow Speed Comp.  Clicks/Turns (Max)		29 C	High Speed Comp.    Turns (Max)		3 T	Rebound Adj.    Clicks/Turns (Max)		34 C	Standard Spring      Pre-Load		5MM');
INSERT INTO `shock_spec_general_info` VALUES ('5', 'Spring Rate (kg)   			Piston Ring Dia. (mm) 			Spring Color			Travel  (mm) 		\nShaft Diameter (mm)			Nitrogen Pressure			Shock Stroke (mm) 			Short. Spacer \"1 (mm) 		\nBody I.D.  (mm) 			Chrome Length (mm) 			Piston Bleed 			Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position			Needle Length (mm) 			Eye to Eye W/S (mm) 			Number of Ports  		\nShock Spring        Length (mm)   			Clevis Length (mm) 			Eye to Eye WO/S (mm) 			Port Diameter (mm) 		\nShock Spring                ID Top/Bottom (mm)			Low Speed Comp.  Clicks/Turns         (Total Out) 			High Speed Comp.    Turns (Total Out)			Rebound Adj.    Clicks/Turns          (Total Out )		\nShock Spring            O.D. Top/Bottom (mm)									Oil Weight 		\nHigh Speed Spring Dimensions 		Length/       	I.D./                  		O.D./       	Coil Diameter/   					\nTop Out Spring Dimensions (mm) 		Length/       	I.D./                  		O.D./       	Coil Diameter/');
INSERT INTO `shock_spec_general_info` VALUES ('6', 'Spring Rate (kg)     		3.5kg	Piston Ring Dia. (mm) 		46x8mm	Spring Color		Orange	Travel  (mm) 		300mm/   11.81 in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		101.8	Short. Spacer \"1 (mm) 		\nBody I.D.  (mm) 		46mm	Chrome Length (mm) 		139mm	Piston Bleed 		1mm	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston	Needle Length (mm) 		176mm	Eye to Eye W/S (mm) 		404mm	Number of Ports  		\nSpring Dimension   (mm) 		Same	Clevis Length (mm) 		91mm	Eye to Eye WO/S (mm) 		404mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		15 Clicks	Std. High Speed Comp. Adj. Position 		2 Turns	Std. Rebound Adj. Position 		22 Clicks	Oil Weight 		2.5\nLow Speed Comp.  Clicks/Turns (Max)		29 Max	High Speed Comp.    Turns (Max)		2 3/4 Max	Rebound Adj.    Clicks/Turns (Max)		51 Max\n\n\nNOTES:   Body I.D Number (if applicable) :											\n1. Overall Reservoir Tube= 100mm											\n2. Overall Body= 249mm											\n3. 4mm Stop Plate');
INSERT INTO `shock_spec_general_info` VALUES ('8', 'Spring Rate (kg)     		6.0 kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		335mm/ 13.2in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107.1mm	Short. Spacer \"1 (mm) 		\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 			Piston Bleed 		1mm	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston	Needle Length (mm) 			Eye to Eye W/S (mm) 		413mm	Number of Ports  		\nSpring Dimension   (mm) 		Same	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		14 C	Std. High Speed Comp. Adj. Position 		1 T	Std. Rebound Adj. Position 		23 C	Oil Weight 		2.5\nLow Speed Comp.  Clicks/Turns (Max)		29 C	High Speed Comp.    Turns (Max)		3 T	Rebound Adj.    Clicks/Turns (Max)		34 C');
INSERT INTO `shock_spec_general_info` VALUES ('9', 'Spring Rate (kg)     		6.3kg	Piston Ring Dia. (mm) 			Spring Color		Orange	Travel  (mm) 	\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107mm	Short. Spacer \"1 (mm) 	\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 		148mm    145mm      To nut	Piston Bleed 		1.mm P	Shoulder Length (mm) 	\nBladder Dimension (mm)		Floating Piston	Needle Length (mm) 			Eye to Eye W/S (mm) 		412.5mm	Number of Ports  	\nSpring Dimension   (mm) 			Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 	\nLow Speed Comp.  Clicks/Turns (Max-)		Out (-29C)   	High Speed Comp.    Turns (Max-)		Out (-T)   	Rebound Adj.    Clicks/Turns (Max-)		Out (-35C)  	Oil Weight 	\n\n\nNOTES:   Body I.D Number (if applicable) :											\n1. 8x7mm Holes High Speed Adjuster Housing 											\n2. Reservoir Cylinder is 1 Piece and is 											\n3mm Shorter that 2007 Model											\n\"Lost 1mm Of Volume\"');
INSERT INTO `shock_spec_general_info` VALUES ('10', 'Spring Rate (kg)     		6.6 kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		335mm/ 13.2in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107.1 mm	Short. Spacer \"1 (mm) 		\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 			Piston Bleed 		N/A	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston	Needle Length (mm) 			Eye to Eye W/S (mm) 		413mm	Number of Ports  		\nSpring Dimension   (mm) 		Same	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		14 C	Std. High Speed Comp. Adj. Position 		1 T 	Std. Rebound Adj. Position 		23 C	Oil Weight 		2.5\nLow Speed Comp.  Clicks/Turns (Max)		29 C	High Speed Comp.    Turns (Max)		3 T	Rebound Adj.    Clicks/Turns (Max)		34 C');
INSERT INTO `shock_spec_general_info` VALUES ('11', 'Spring Rate (kg)     		6.6kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		335mm/ 13.2in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107.5mm	Short. Spacer \"1 (mm) 		8.15mm /  1/2\" 4.07mm\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 			Piston Bleed 		None 	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston	Needle Length (mm) 			Eye to Eye W/S (mm) 		413mm	Number of Ports  		\nSpring Dimension   (mm) 		Same	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		14 Clicks	Std. High Speed Comp. Adj. Position 		1 Turn	Std. Rebound Adj. Position 		23 Clicks	Oil Weight 		2.5W\nLow Speed Comp.  Clicks/Turns (Max)			High Speed Comp.    Turns (Max)			Rebound Adj.    Clicks/Turns (Max)');
INSERT INTO `shock_spec_general_info` VALUES ('12', 'Spring Rate (kg)     		6.6kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107mm	Short. Spacer \"1 (mm) 		\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 			Piston Bleed 		1.0mm 	Shoulder Length (mm) 		\nBladder Dimension (mm)		Floating Piston	Needle Length (mm) 			Eye to Eye W/S (mm) 		412.5mm	Number of Ports  		\nSpring Dimension   (mm) 		Same 	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nLow Speed Comp.  Clicks/Turns (Max-)		Out (-29C)   	High Speed Comp.    Turns (Max-)		Out (-2 3/4T)   	Rebound Adj.    Clicks/Turns (Max-)		Out (-35C)  	Oil Weight 		2 1/2');
INSERT INTO `shock_spec_general_info` VALUES ('13', 'Spring Rate (kg)     		6.6kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		335mm/   13.19 in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107mm	Short. Spacer \"1 (mm) 		1\"= 8.15mm/  1/2\"=4.07mm\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 			Piston Bleed 		1.0mm 	Shoulder Length (mm) 		\nBladder Dimension (mm)		Floating Piston	Needle Length (mm) 			Eye to Eye W/S (mm) 		412.5mm	Number of Ports  		\nSpring Dimension   (mm) 		Same 	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		15 C	Std. High Speed Comp. Adj. Position 		1 T	Std. Rebound Adj. Position 		23 C	Oil Weight 		2.5\nLow Speed Comp.  Clicks/Turns (Max)		29 C   	High Speed Comp.    Turns (Max)		2 3/4 C	Rebound Adj.    Clicks/Turns (Max)		35 C');
INSERT INTO `shock_spec_general_info` VALUES ('14', 'Spring Rate (kg)   		6.9kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		335mm/    13.19 in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107mm	Short. Spacer \"1 (mm) 		\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 			Piston Bleed 		1.0mm	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston 	Needle Length (mm) 			Eye to Eye W/S (mm) 		412.5mm	Number of Ports  		\nShock Spring        Length (mm)   		Same 	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nShock Spring                ID Top/Bottom (mm)		Same 	Low Speed Comp.  Clicks/Turns (Max)			High Speed Comp.    Turns (Max)			Rebound Adj.    Clicks/Turns (Max)		\nShock Spring            O.D. Top/Bottom (mm)		Same 							Oil Weight 		2.5\nHigh Speed Spring Dimensions 											\nTop Out Spring Dimensions (mm)');
INSERT INTO `shock_spec_general_info` VALUES ('15', 'Spring Rate (kg)     		6.9kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		335mm/  13.19in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107.5mm	Short. Spacer \"1 (mm) 		1\"=8.15mm/  1/2\"=4.07mm \nBody I.D.  (mm) 		50mm	Chrome Length (mm) 		148mm/  145mm Nut	Piston Bleed 		None	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston	Needle Length (mm) 		171mm	Eye to Eye W/S (mm) 		412.5mm	Number of Ports  		\nSpring Dimension   (mm) 		Same	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		15 Clicks	Std. High Speed Comp. Adj. Position 		1 1/2 Turns	Std. Rebound Adj. Position 		24 Clicks	Oil Weight 		2.5\nLow Speed Comp.  Clicks/Turns (Max)		29 Clicks	High Speed Comp.    Turns (Max)		2 3/4 Turns	Rebound Adj.    Clicks/Turns (Max)		35 Clicks');
INSERT INTO `shock_spec_general_info` VALUES ('16', 'Spring Rate (kg)   		7.2 kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange 	Travel  (mm) 		335mm\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107.1mm	Short. Spacer \"1 (mm) 		8.1mm\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 			Piston Bleed 		N/A	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston	Needle Length (mm) 			Eye to Eye W/S (mm) 		412.5mm	Number of Ports  		\nShock Spring        Length (mm)   		250mm	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nShock Spring                ID Top/Bottom (mm)			Low Speed Comp.  Clicks/Turns         (Total Out) 		(-) 29 C	High Speed Comp.    Turns (Total Out)		(-) 2 3/4 T	Rebound Adj.    Clicks/Turns          (Total Out )		(-) 35 C\nShock Spring            O.D. Top/Bottom (mm)									Oil Weight 		2.5 W \nHigh Speed Spring Dimensions 		Length/       	I.D./                  		O.D./       	Coil Diameter/   					\nTop Out Spring Dimensions (mm) 		Length/       	I.D./                  		O.D./       	Coil Diameter/   					\nNotes: 											\nStandard Clicker Settings: Low Speed (-) 15 Clicks / High Speed (-) 1 1/2 Turns  / Rebound (-) 22 Clicks');
INSERT INTO `shock_spec_general_info` VALUES ('17', 'Spring Rate (kg)   			Piston Ring Dia. (mm) 			Spring Color			Travel  (mm) 		\nShaft Diameter (mm)			Nitrogen Pressure			Shock Stroke (mm) 			Short. Spacer \"1 (mm) 		\nBody I.D.  (mm) 			Chrome Length (mm) 			Piston Bleed 			Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position			Needle Length (mm) 			Eye to Eye W/S (mm) 			Number of Ports  		\nShock Spring        Length (mm)   			Clevis Length (mm) 			Eye to Eye WO/S (mm) 			Port Diameter (mm) 		\nShock Spring                ID Top/Bottom (mm)			Low Speed Comp.  Clicks/Turns         (Total Out) 			High Speed Comp.    Turns (Total Out)			Rebound Adj.    Clicks/Turns          (Total Out )		\nShock Spring            O.D. Top/Bottom (mm)									Oil Weight 		\nHigh Speed Spring Dimensions 		Length/       	I.D./                  		O.D./       	Coil Diameter/   					\nTop Out Spring Dimensions (mm) 		Length/       	I.D./                  		O.D./       	Coil Diameter/');
INSERT INTO `shock_spec_general_info` VALUES ('18', 'Spring Rate (kg)     		6.9kg	Piston Ring Dia. (mm) 		50x8mm	Spring Color		Orange	Travel  (mm) 		335mm/   13.19in\nShaft Diameter (mm)		18mm	Nitrogen Pressure		10 Bar	Shock Stroke (mm) 		107.5mm	Short. Spacer \"1 (mm) 		1\"= 8.15mm/  1/2\"=4.07mm\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 		148mm/  145mm Nut	Piston Bleed 		1mm	Shoulder Length (mm) 		\nBladder Dimension (mm) or Floating Piston Position		Floating Piston	Needle Length (mm) 		171mm	Eye to Eye W/S (mm) 		412.5mm	Number of Ports  		\nSpring Dimension   (mm) 		Same	Clevis Length (mm) 			Eye to Eye WO/S (mm) 		412.5mm	Port Diameter (mm) 		\nStd. Low Speed Comp. Adj. Position 		15 Clicks	Std. High Speed Comp. Adj. Position 		1 Turn	Std. Rebound Adj. Position 		23 Clicks	Oil Weight 		2.5\nLow Speed Comp.  Clicks/Turns (Max)			High Speed Comp.    Turns (Max)			Rebound Adj.    Clicks/Turns (Max)			Std. Spring Pre Load 		7mm');
INSERT INTO `shock_spec_general_info` VALUES ('19', 'Spring Rate (kg)   		4.6 kg	Piston Ring Dia. (mm) 		40x7.85mm	Spring Color		Red        Green Dot 	Travel  (mm) 		276.86mm\nShaft Diameter (mm)		14mm	Nitrogen Pressure		150psi	Shock Stroke (mm) 		106.5mm	Short. Spacer \"1 (mm) 		9.77mm\nBody I.D.  (mm) 		40mm	Chrome Length (mm) 		144mm	Piston Bleed 		N/A	Shoulder Length (mm) 		28mm\nBladder Dimension (mm) or Floating Piston Position		41x80mm	Needle Length (mm) 		210mm	Eye to Eye W/S (mm) 		396mm	Number of Ports  		Fixed\nShock Spring        Length (mm)   		245mm	Clevis Length (mm) 		85mm	Eye to Eye WO/S (mm) 		395.5mm	Port Diameter (mm) 		Fixed\nShock Spring                ID Top/Bottom (mm)		55.8	Low Speed Comp.  Clicks/Turns         (Total Out) 		3 T	High Speed Comp.    Turns (Total Out)		N/A	Rebound Adj.    Clicks/Turns          (Total Out )		3 T\nShock Spring            O.D. Top/Bottom (mm)		75.15							Oil Weight 		2.5\nHigh Speed Spring Dimensions 		N/A									\nTop Out Spring Dimensions (mm) 		N/A');
INSERT INTO `shock_spec_general_info` VALUES ('20', 'Spring Rate (kg)   		5.4 kg	Piston Ring Dia. (mm) 		50x13mm	Spring Color		Red Green Dot	Travel  (mm) 		310mm\nShaft Diameter (mm)		18mm	Nitrogen Pressure		105 psi	Shock Stroke (mm) 		128.6mm	Short. Spacer \"1 (mm) 		10.53mm\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 		176mm	Piston Bleed 		N/A	Shoulder Length (mm) 		36mm\nBladder Dimension (mm) or Floating Piston Position		49x104mm	Needle Length (mm) 		206mm	Eye to Eye W/S (mm) 		479.5mm	Number of Ports  		6\nShock Spring        Length (mm)   		276mm	Clevis Length (mm) 		89.80mm	Eye to Eye WO/S (mm) 		479mm	Port Diameter (mm) 		2.45mm\nShock Spring                ID Top/Bottom (mm)		64.1/66.8mm	Low Speed Comp.  Clicks/Turns         (Total Out) 		24 C	High Speed Comp.    Turns (Total Out)		4 1/4T	Rebound Adj.    Clicks/Turns          (Total Out )		22 C\nShock Spring            O.D. Top/Bottom (mm)		87.25/90mm							Oil Weight 		2.5\nHigh Speed Spring Dimensions (mm) 		Length/       21mm	I.D./                  16.45mm		O.D./       20mm	Coil Diameter/   1.75mm					\nTop Out Spring Dimensions (mm) 		Length/       23.5mm	I.D./                  21.55mm		O.D./       26.70mm	Coil Diameter/   2.89mm		\nNotes:  New Body\n1. Body # S387-30   TS-01						7. Shaft Ports = 3.54mm					\n2. Ramp like 2007 Model 						8. When High Speed is backed out it still has 				3. Overall Shaft Length= 247mm						pre-load on adjuster spring 					4. 12mm Port in Body-Compression Adj. Ports											5. Body Overall= 267mm   From Bearing= 249mm											6. New Anodized Bladder Cap and Compression Adjuster 											7. Piston is like 2003 CR Style');
INSERT INTO `shock_spec_general_info` VALUES ('21', 'Spring Rate (kg)   Rates 5.2kg			Piston Ring Dia. (mm) 		40x11mm	Spring Color		Silver 	Travel  (mm) 		281.94mm\nShaft Diameter (mm)		14mm	Nitrogen Pressure		125 PSI	Shock Stroke (mm) 		99.5mm	Short. Spacer \"1 (mm) 		8.96mm\nBody I.D.  (mm) 		40mm	Chrome Length (mm) 		149mm	Piston Bleed 		N/A	Shoulder Length (mm) 		29mm\nBladder Dimension (mm) or Floating Piston Position		40x88mm	Needle Length (mm) 		177mm	Eye to Eye W/S (mm) 		402mm	Number of Ports  		6\nShock Spring        Length (mm)   		220mm (NNU)	Clevis Length (mm) 		94.5mm	Eye to Eye WO/S (mm) 		402mm	Port Diameter (mm) 		2.3\nShock Spring                ID Top/Bottom (mm)		55/55mm	Low Speed Comp.  Clicks/Turns (Max)		23 C	High Speed Comp.    Turns (Max)		N/A	Rebound Adj.    Clicks/Turns (Max)		25 C\nShock Spring            O.D. Top/Bottom (mm)									Oil Weight 		2.5W\nHigh Speed Spring Dimensions 		N/A									\nTop Out Spring Dimensions (mm) 		N/A');
INSERT INTO `shock_spec_general_info` VALUES ('22', 'Spring Rate (kg)     		4.875kg	Piston Ring Dia. (mm) 		46x11	Spring Color		Titanium   w/Black Dots	Travel  (mm) 		314.96mm\nShaft Diameter (mm)		18mm	Nitrogen Pressure		146psi	Shock Stroke (mm) 		132mm	Short. Spacer \"1 (mm) 		\nBody I.D.  (mm) 		46mm	Chrome Length (mm) 		191mm	Piston Bleed 		None	Shoulder Length (mm) 		335mm\nBladder Dimension (mm) or Floating Piston Position		52x104mm	Needle Length (mm) 		225.5mm	Eye to Eye W/S (mm) 		491mm	Number of Ports  		6\nSpring Dimension   (mm) 		Same	Clevis Length (mm) 		111mm	Eye to Eye WO/S (mm) 		491.5mm	Port Diameter (mm) 		3mm\nStd. Low Speed Comp. Adj. Position 			Std. High Speed Comp. Adj. Position 			Std. Rebound Adj. Position 			Oil Weight 		\nLow Speed Comp.  Clicks/Turns (Max)			High Speed Comp.    Turns (Max)			Rebound Adj.    Clicks/Turns (Max)				\nNotes:\n3mm holes in compression adjuster');
INSERT INTO `shock_spec_general_info` VALUES ('23', 'Spring Rate (kg)		5.4 kg	Piston Ring Dia. (mm) 		46x11mm	Spring Color		Titanium  Yellow	Travel  (mm) 		315mm\nShaft Diameter (mm)		18mm	Nitrogen Pressure		133psi	Shock Stroke (mm) 		132mm	Short. Spacer \"1 (mm) 		7.6mm\nBody I.D.  (mm) 		46mm	Chrome Length (mm) 		191mm	Piston Bleed 		None	Shoulder Length (mm) 		335mm\nBladder Dimension (mm)		52x106mm	Needle Length (mm) 		228.5mm	Eye to Eye W/S (mm) 		491mm	Number of Ports  		6\nSpring Dimension   (mm) 		58.9x61.9 x279mm	Clevis Length (mm) 		111mm	Eye to Eye WO/S (mm) 		490mm	Port Diameter (mm) 		3mm\nLow Speed Comp.  Clicks/Turns (Max-)		Out (-)   	High Speed Comp.    Turns (Max-)		Out (-)   	Rebound Adj.    Clicks/Turns (Max-)		Out (-)  	Oil Weight 		\n\nNotes:\nNOTES:   Body I.D Number (if applicable) :											\n1. Stem I.D. = 2.5mm Bigger Ports 3mm											\n2. Clevis Number Rebound Side= 3A/Leftside 2521/L75M											3. Steel Jam Nut on Clevis 											\n4. Rebound Needle Tip 2.2mm');
INSERT INTO `shock_spec_general_info` VALUES ('24', 'Spring Rate (kg)		5.54kg	Piston Ring Dia. (mm) 		46.2x11mm	Spring Color		Titanium w/Pink 	Travel  (mm) 		314.96mm\nShaft Diameter (mm)		18mm	Nitrogen Pressure		146psi	Shock Stroke (mm) 		132mm	Short. Spacer \"1 (mm) 		7.6mm\nBody I.D.  (mm) 		46mm	Chrome Length (mm) 		191mm	Piston Bleed 		None	Shoulder Length (mm) 		335mm\nBladder Dimension (mm)		50x103mm	Needle Length (mm) 		225.5mm	Eye to Eye W/S (mm) 		491mm	Number of Ports  		6\nSpring Dimension   (mm) 		61.9x 279mm	Clevis Length (mm) 		111mm	Eye to Eye WO/S (mm) 		490.5mm	Port Diameter (mm) 		3mm x 2.5 Stem\nLow Speed Comp.  Clicks/Turns (Max-)		Out (-)   	High Speed Comp.    Turns (Max-)		Out (-)   	Rebound Adj.    Clicks/Turns (Max-)		Out (-)  	Oil Weight 		\n\nNOTES:   Body I.D Number (if applicable) :											\n1. Clevis Number Rebound Side= 3A/ Leftside 2521/N75Q');
INSERT INTO `shock_spec_general_info` VALUES ('25', 'Spring Rate (kg)    Rates 5.1 kg		5.2 KG	Piston Ring Dia. (mm) 		50x13mm	Spring Color		Gray     Yellow Dot 	Travel  (mm) 		309.88mm\nShaft Diameter (mm)		16mm	Nitrogen Pressure		130 PSI	Shock Stroke (mm) 		133.75mm	Short. Spacer \"1 (mm) 		10.96\nBody I.D.  (mm) 		50mm	Chrome Length (mm) 		183mm	Piston Bleed 		N/A	Shoulder Length (mm) 		37mm\nBladder Dimension (mm)		49x104mm	Needle Length (mm) 		215mm         2 Piece	Eye to Eye W/S (mm) 		484.5mm	Number of Ports  		6\nSpring Dimension   (mm) 		66.8x64   x267mm	Clevis Length (mm) 		88.8mm	Eye to Eye WO/S (mm) 		484mm	Port Diameter (mm) 		2.20mm\nLow Speed Comp.  Clicks/Turns (Max-)		Out (-24C)   	High Speed Comp.    Turns (Max-)		Out (-4 1/4T)   	Rebound Adj.    Clicks/Turns (Max-)		Out (-23C)  	Oil Weight 		2 1/2\n\nNOTES:   Body I.D Number (if applicable) :  K181											In compression adjuster\n	Case 5mm	\n	Stem I.D. 2.85mm	\n	2 Spring Shims');
INSERT INTO `shock_spec_general_info` VALUES ('26', 'Spring Rate (kg)    Rates 5.57kg   		5.5kg	Piston Ring Dia. (mm) 		46x11mm w/hole	Spring Color		Gray Purple Dot 	Travel  (mm) 		314.96mm\nShaft Diameter (mm)		16mm	Nitrogen Pressure		118 PSI	Shock Stroke (mm) 		134mm	Short. Spacer \"1 (mm) 		10.80mm\nBody I.D.  (mm) 		46mm	Chrome Length (mm) 		183mm	Piston Bleed 		N/A	Shoulder Length (mm) 		34mm\nBladder Dimension (mm)		50x94mm	Needle Length (mm) 		215mm	Eye to Eye W/S (mm) 		485mm	Number of Ports  		2.25mm\nSpring Dimension   (mm) 		Same ALN	Clevis Length (mm) 		86mm	Eye to Eye WO/S (mm) 		484.5mm	Port Diameter (mm) 		6mm\nLow Speed Comp.  Clicks/Turns (Max-)		Out (-22 C)   	High Speed Comp.    Turns (Max-)		Out (-2 1/4T)   	Rebound Adj.    Clicks/Turns (Max-)		Out (-24)  	Oil Weight 		2.5\n\nNOTES:   Body I.D Number (if applicable) :											\n1. Clevis # Q768											\n2. Kawasaki Website std spring 54n/mm											\n3. Pre Load Rings look Aluminum, But are Steel											\nOn comp adj:\n	One Spring Shim Against Piston			\n	Stem I.D. 2.65mm');
INSERT INTO `shock_spec_general_info` VALUES ('27', 'Spring Rate (kg)    Rates 4.9kg  		4.8 kg	Piston Ring Dia. (mm) 		36x8mm	Spring Color		Gray	Travel  (mm) 		274.32mm\nShaft Diameter (mm)		12.5	Nitrogen Pressure		90psi	Shock Stroke (mm) 		108mm	Short. Spacer \"1 (mm) 		10mm\nBody I.D.  (mm) 		36mm	Chrome Length (mm) 		155.5mm	Piston Bleed 		N/A	Shoulder Length (mm) 		24mm\nBladder Dimension (mm) or Floating Piston Position		40x90mm	Needle Length (mm) 		185mm	Eye to Eye W/S (mm) 		379mm	Number of Ports  		N/A\nShock Spring        Length (mm)   		255mm	Clevis Length (mm) 		62mm	Eye to Eye WO/S (mm) 		378mm	Port Diameter (mm) 		N/A\nShock Spring                ID Top/Bottom (mm)		55/   54.5mm	Low Speed Comp.  Clicks/Turns         (Total Out) 		4 Settings 	High Speed Comp.    Turns (Total Out)		N/A	Rebound Adj.    Clicks/Turns          (Total Out )		(-) 23    Clicks\nShock Spring            O.D. Top/Bottom (mm)		75.15/ 75.4mm							Oil Weight 		\nHigh Speed Spring Dimensions 		Length/       	I.D./                  		O.D./       	Coil Diameter/   					\nTop Out Spring Dimensions (mm) 		Length/       	I.D./                  		O.D./       	Coil Diameter/');
INSERT INTO `shock_spec_general_info` VALUES ('28', 'Spring Rate (kg)    Rates 4.9kg  		4.8 kg	Piston Ring Dia. (mm) 		36x8mm	Spring Color		Gray	Travel  (mm) 		274.32mm\nShaft Diameter (mm)		12.5	Nitrogen Pressure		90psi	Shock Stroke (mm) 		108mm	Short. Spacer \"1 (mm) 		10mm\nBody I.D.  (mm) 		36mm	Chrome Length (mm) 		155.5mm	Piston Bleed 		N/A	Shoulder Length (mm) 		24mm\nBladder Dimension (mm) or Floating Piston Position		40x90mm	Needle Length (mm) 		185mm	Eye to Eye W/S (mm) 		379mm	Number of Ports  		N/A\nShock Spring        Length (mm)   		255mm	Clevis Length (mm) 		62mm	Eye to Eye WO/S (mm) 		378mm	Port Diameter (mm) 		N/A\nShock Spring                ID Top/Bottom (mm)		55/   54.5mm	Low Speed Comp.  Clicks/Turns         (Total Out) 		4 Settings 	High Speed Comp.    Turns (Total Out)		N/A	Rebound Adj.    Clicks/Turns          (Total Out )		(-) 23    Clicks\nShock Spring            O.D. Top/Bottom (mm)		75.15/ 75.4mm							Oil Weight 		\nHigh Speed Spring Dimensions 		Length/       	I.D./                  		O.D./       	Coil Diameter/   					\nTop Out Spring Dimensions (mm) 		Length/       	I.D./                  		O.D./       	Coil Diameter/');
INSERT INTO `shock_work` VALUES ('1', 'Revalve Shock');
INSERT INTO `shock_work` VALUES ('2', 'Service Shock');
INSERT INTO `shock_work` VALUES ('3', 'Oil Change');
INSERT INTO `shock_work` VALUES ('4', 'Shorten');
INSERT INTO `shock_work` VALUES ('5', 'Other');
INSERT INTO `suspension_brand` VALUES ('1', 'Kayaba');
INSERT INTO `suspension_brand` VALUES ('2', 'Showa');
INSERT INTO `suspension_brand` VALUES ('3', 'White Power');
INSERT INTO `suspension_brand` VALUES ('4', 'Ohlins');
INSERT INTO `suspension_brand` VALUES ('5', 'Paoli');
INSERT INTO `suspension_brand` VALUES ('6', 'Marzocchi');
INSERT INTO `suspension_brand` VALUES ('7', 'Fox');
INSERT INTO `terrain` VALUES ('1', 'Hard Packed');
INSERT INTO `terrain` VALUES ('2', 'Intermediate');
INSERT INTO `terrain` VALUES ('3', 'Soft');
INSERT INTO `terrain` VALUES ('4', 'Rocks');
INSERT INTO `terrain` VALUES ('5', 'Woods');
INSERT INTO `terrain` VALUES ('6', 'Roots');
INSERT INTO `terrain` VALUES ('7', 'Sand');
INSERT INTO `work_order` VALUES ('1', '1', '0', '0', '33', '20', null, null, '0', '0', '0', null, '2008-01-27 21:05:30');
INSERT INTO `work_order` VALUES ('2', '2', '0', '0', '33', '21', null, null, '0', '0', '0', null, '2008-01-27 21:06:06');
INSERT INTO `work_order` VALUES ('3', '3', '0', '0', '33', '22', null, null, '0', '0', '0', null, '2008-01-27 21:07:05');
INSERT INTO `work_order` VALUES ('4', '4', '0', '0', '33', '23', null, null, '0', '0', '0', null, '2008-01-27 21:07:29');
INSERT INTO `work_order` VALUES ('6', '6', '0', '0', '33', '26', null, null, '0', '0', '0', null, '2008-03-06 15:21:30');
INSERT INTO `work_order` VALUES ('7', '7', '0', '0', '33', '29', null, null, '0', '0', '0', null, '2008-03-11 20:18:22');
INSERT INTO `work_order` VALUES ('8', '8', '0', '0', '33', '30', null, null, '0', '0', '0', null, '2008-03-14 08:45:21');
INSERT INTO `work_order` VALUES ('9', '9', '0', '0', '33', '33', null, null, '0', '0', '0', null, '2008-03-14 12:25:33');
INSERT INTO `work_order` VALUES ('10', '10', '0', '0', '33', '34', null, null, '0', '0', '0', null, '2008-03-14 12:40:59');
INSERT INTO `work_order` VALUES ('11', '11', '0', '0', '33', '35', null, null, '0', '0', '0', null, '2008-03-14 15:03:38');
INSERT INTO `work_order` VALUES ('12', '12', '0', '0', '33', '36', null, null, '0', '0', '0', null, '2008-03-14 15:27:18');
INSERT INTO `work_order` VALUES ('13', '13', '0', '0', '33', '23', null, null, '0', '0', '0', null, '2008-03-14 19:00:54');
INSERT INTO `work_order` VALUES ('14', '14', '0', '0', '33', '37', null, null, '0', '0', '0', null, '2008-03-14 19:12:49');
INSERT INTO `work_order` VALUES ('15', '15', '0', '0', '33', '38', null, null, '0', '0', '0', null, '2008-03-14 19:33:54');
INSERT INTO `work_order` VALUES ('16', '16', '0', '0', '33', '40', null, null, '0', '0', '0', null, '2008-03-14 19:48:37');
INSERT INTO `work_order` VALUES ('17', '17', '0', '0', '33', '41', null, null, '0', '0', '0', null, '2008-03-14 20:02:27');
INSERT INTO `work_order` VALUES ('18', '18', '0', '0', '33', '42', null, null, '0', '0', '0', null, '2008-03-14 20:24:56');
INSERT INTO `work_order` VALUES ('19', '19', '0', '0', '33', '43', null, null, '0', '0', '0', null, '2008-03-14 20:28:15');
INSERT INTO `work_order` VALUES ('20', '20', '0', '0', '33', '22', null, null, '0', '0', '0', null, '2008-03-14 20:43:25');
INSERT INTO `work_order` VALUES ('21', '21', '0', '0', '33', '44', null, null, '0', '0', '0', null, '2008-03-14 21:15:10');
INSERT INTO `work_order` VALUES ('22', '22', '0', '0', '33', '45', null, null, '0', '0', '0', null, '2008-03-14 21:28:10');
INSERT INTO `work_order` VALUES ('23', '23', '0', '0', '33', '46', null, null, '0', '0', '0', null, '2008-03-14 21:37:45');
INSERT INTO `work_order` VALUES ('24', '24', '0', '0', '33', '47', null, null, '0', '0', '0', null, '2008-03-15 08:31:35');
INSERT INTO `work_order` VALUES ('25', '25', '0', '0', '33', '48', null, null, '0', '0', '0', null, '2008-03-15 19:02:52');
INSERT INTO `work_order` VALUES ('26', '26', '0', '0', '33', '49', null, null, '0', '0', '0', null, '2008-03-15 19:14:56');
INSERT INTO `work_order` VALUES ('27', '27', '0', '0', '33', '50', null, null, '0', '0', '0', null, '2008-03-15 19:41:44');
INSERT INTO `work_order` VALUES ('28', '28', '0', '0', '33', '52', null, null, '0', '0', '0', null, '2008-03-15 20:06:38');
INSERT INTO `work_order` VALUES ('29', '32', '0', '0', '33', '54', null, null, '0', '0', '0', null, '2008-03-16 13:17:55');
INSERT INTO `work_order` VALUES ('30', '33', '0', '0', '33', '56', null, null, '0', '0', '0', null, '2008-03-16 13:52:51');
INSERT INTO `work_order` VALUES ('31', '34', '0', '0', '33', '57', null, null, '0', '0', '0', null, '2008-03-16 14:06:14');
