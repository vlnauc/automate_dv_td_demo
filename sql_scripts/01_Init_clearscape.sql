/*
 * only demo_user available
*/


CREATE DATABASE space_move_db FROM demo_user AS PERM = 5*1024*1024*1024 BYTES;
give space_move_db to MANDATUM;
drop database space_move_db;

create database MANDATUM from demo_user as PERM = 16*1024**3 BYTES; --16GB

create database TPCH_SF_1 from MANDATUM as PERM = 10*1024**3 BYTES; -- 10GB
create database STG from MANDATUM as PERM = 200*1024**2 BYTES; -- 200 MB
create database VAULT from MANDATUM as PERM = 5*1024**3 BYTES; --5GB


grant select on TPCH_SF_1 to STG with grant option;
grant select on TPCH_SF_1 to VAULT with grant option;
grant select on STG to VAULT with grant option;

grant execute function on TD_SYSFNLIB.READ_NOS to mandatum_dbt_user;
grant create function on GLOBAL_FUNCTIONS to demo_user; -- dont have permission :(


-- verification of permission
SELECT * FROM DBC.ROLEMEMBERS;
SELECT * FROM DBC.ALLROLERIGHTS;


/*
 * Enabling generate_surrogate_keys function
 * Function is deployed by BTQ from code downloaded from TD Download page
 */
CREATE DATABASE GLOBAL_FUNCTIONS AS PERMANENT = 60e6, SPOOL = 120e6;


