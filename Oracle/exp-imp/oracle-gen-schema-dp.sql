-- Version: 1.0
--
-- How to run: 
-- sqlplus system @"oracle-gen-schema-dp.sql"
-- 
-- Remember to change TABSPACE_PATH, to get it run below query:
-- select name from v$datafile
--

prompt Please enter:
accept SOURCE_SCHEMA	prompt "Source schema name : "
accept SOURCE_FILENAME 	prompt "Source file name (def=&SOURCE_SCHEMA..dpdmp): " 	default &SOURCE_SCHEMA..dpdmp
accept SQLFILE_FILENAME prompt "Output sql file name (def=&SOURCE_SCHEMA..sql): "	default &SOURCE_SCHEMA..sql
accept DPPUMP_DIR_PATH 	prompt "Data pump dir path (def=C:\oraimp) : " 				default C:\oraimp
accept USR_SYS_PSWD		prompt "Oracle SYSTEM password (def=oracle) : " 			default oracle

------------------------------------------------------------------------------------------------------------
--  FOLLOWING SECTION ONWARD IS FIXED SCRIPTS, NOT RECOMMENDED TO CHANGE UNLESS YOU HAVE TUNING PREFERENCE
------------------------------------------------------------------------------------------------------------
DEF V_SRC_FILENAME = "&SOURCE_FILENAME"

create or replace directory ms_dpump_dir as '&DPPUMP_DIR_PATH';

host impdp system/&USR_SYS_PSWD DIRECTORY=ms_dpump_dir DUMPFILE=&V_SRC_FILENAME SQLFILE=&SQLFILE_FILENAME

exit;


