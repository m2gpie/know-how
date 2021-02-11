-- Version: 1.0
--
-- How to run: 
-- sqlplus system @"oracle-impdp-schema-gen.sql"
-- 
-- Remember to change TABSPACE_PATH, to get it run below query:
-- select name from v$datafile
--

prompt Please enter:
accept SOURCE_SCHEMA	prompt "Source schema name : "
accept SOURCE_TABSPACE 	prompt "Source tabspace name (def=&SOURCE_SCHEMA.space): " 	default &SOURCE_SCHEMA.space
accept SOURCE_FILENAME 	prompt "Source file name (def=&SOURCE_SCHEMA..dpdmp): " 	default &SOURCE_SCHEMA..dpdmp
accept TARGET_SCHEMA 	prompt "Target schema name (def=&SOURCE_SCHEMA): " 			default &SOURCE_SCHEMA
accept LOG_FILE_NAME 	prompt "Log file name (def=&SOURCE_SCHEMA._v1.log): " 		default &SOURCE_SCHEMA._v1.log

accept TABSPACE_PATH 	prompt "Oradata path (def=C:\ORA18\oradata): " 		default C:\ORA18\oradata
accept DPPUMP_DIR_PATH 	prompt "Data pump dir path (def=C:\oraimp) : " 		default C:\oraimp

------------------------------------------------------------------------------------------------------------
--  FOLLOWING SECTION ONWARD IS FIXED SCRIPTS, NOT RECOMMENDED TO CHANGE UNLESS YOU HAVE TUNING PREFERENCE
------------------------------------------------------------------------------------------------------------
DEF V_SRC_SCHEMA = "&SOURCE_SCHEMA";
DEF V_SRC_TABSPACE = "&SOURCE_TABSPACE";
DEF V_SRC_FILENAME = "&SOURCE_FILENAME"

DEF V_TRG_SCHEMA = "&TARGET_SCHEMA";
DEF V_TRG_TABSPACE = "&TARGET_SCHEMA.space";


HOST ECHO . %DATE%-%TIME% Source, schemaname: &V_SRC_SCHEMA, tabspace: &V_SRC_TABSPACE, filename: &V_SRC_FILENAME
HOST ECHO . %DATE%-%TIME% Target, schemaname: &V_TRG_SCHEMA, tabspace: &V_TRG_TABSPACE

HOST ECHO . Close window if you do not wish to execute further
HOST PAUSE

alter session set db_create_file_dest = '&TABSPACE_PATH';

create tablespace &V_TRG_TABSPACE datafile SIZE 300M AUTOEXTEND ON NEXT 300M;

create user &V_TRG_SCHEMA 
	IDENTIFIED BY "oracle" 
	DEFAULT TABLESPACE &V_TRG_TABSPACE;
	
create or replace directory ms_dpump_dir as '&DPPUMP_DIR_PATH';
	
grant connect, resource to &V_TRG_SCHEMA;
grant read, write on directory ms_dpump_dir to &V_TRG_SCHEMA;
grant UNLIMITED TABLESPACE TO &V_TRG_SCHEMA;


HOST PAUSE

host impdp system DIRECTORY=ms_dpump_dir DUMPFILE=&V_SRC_FILENAME REMAP_SCHEMA=&V_SRC_SCHEMA:&V_TRG_SCHEMA REMAP_TABLESPACE=&V_SRC_TABSPACE:&V_TRG_TABSPACE logfile=&LOG_FILE_NAME

exit;


