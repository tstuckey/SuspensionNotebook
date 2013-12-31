CREATE DATABASE suspension;

CREATE USER tom IDENTIFIED BY 'm28861';
GRANT ALL ON *.* to tom WITH GRANT OPTION; /*for everything except GRANT option*/

CREATE USER fc_test IDENTIFIED BY '!factory';
GRANT SELECT,UPDATE,INSERT,DELETE, CREATE TEMPORARY TABLES,EXECUTE ON suspension.* TO fc_test;

/*For the server only*/
CREATE USER make_copy IDENTIFIED BY '!going_testing';
GRANT SELECT,LOCK TABLES,SHOW VIEW ON *.* TO make_copy;
