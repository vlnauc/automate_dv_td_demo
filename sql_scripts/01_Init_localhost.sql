/*
 * UNDER DBC USER
*/

-- create DBT USER
CREATE USER "mandatum_dbt_user" FROM "DBC"AS PERM = 0PASSWORD = "********" -- password = "mandatum_dbt_user"DEFAULT DATABASE = "DBC"NO BEFORE JOURNALNO AFTER JOURNALDEFAULT ROLE = ALL;


CREATE DATABASE space_move_db FROM MANDATUM AS PERM = 1*1024**3 BYTES;
give space_move_db to TPCH_SF_1;
drop database space_move_db;


create database MANDATUM from mandatum_dbt_user as PERM = 5*1024**3 BYTES; -- 5GB

create database TPCH_SF_1 from MANDATUM as PERM = 2*1024**3 BYTES; -- 2GB
create database STG from MANDATUM as PERM = 100*1024*1024 BYTES; -- 100MB
create database VAULT from MANDATUM as PERM = 500*1024**2 BYTES; -- 500MB


grant execute function on TD_SYSFNLIB.READ_NOS to mandatum_dbt_user;

grant all on MANDATUM to mandatum_dbt_user with grant option;
grant all on TPCH_SF_1 to mandatum_dbt_user with grant option;
grant all on STG to mandatum_dbt_user with grant option;
grant all on VAULT to mandatum_dbt_user with grant option;

grant select on TPCH_SF_1 to STG with grant option;
grant select on TPCH_SF_1 to VAULT with grant option;
grant select on stg to VAULT with grant option;


-- verification of permission
SELECT * FROM DBC.ROLEMEMBERS;
SELECT * FROM DBC.ALLROLERIGHTS;


/*
 * Enabling generate_surrogate_keys function
 * Function is deployed by BTQ from code downloaded from TD Download page
 */
CREATE DATABASE GLOBAL_FUNCTIONS AS PERMANENT = 60e6, SPOOL = 120e6;
GRANT CREATE FUNCTION ON GLOBAL_FUNCTIONS TO dbc;

GRANT EXECUTE FUNCTION ON GLOBAL_FUNCTIONS TO mandatum_dbt_user with grant option;
GRANT EXECUTE FUNCTION ON GLOBAL_FUNCTIONS TO stg with grant option;

