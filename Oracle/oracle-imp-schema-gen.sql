-- Version: 1.0
--
-- How to run: 
-- sqlplus system @"oracle-imp-schema-gen.sql"
-- 
-- Remember to change TABSPACE_PATH, to get it run below query:
-- select name from v$datafile
--

prompt Please enter:
accept SOURCE_SCHEMA 	prompt "Schema name: "
accept SOURCE_TABSPACE	prompt "Tabspace name (def=&SOURCE_SCHEMA.space): " default &SOURCE_SCHEMA.space
accept SOURCE_FILENAME 	prompt "Source file name (def=&SOURCE_SCHEMA..dmp): " default &SOURCE_SCHEMA..dmp
accept LOG_FILE_NAME 	prompt "Log file name (def=&SOURCE_SCHEMA._v1.log): " default &SOURCE_SCHEMA._v1.log
accept TABSPACE_PATH 	prompt "Oradata path (def=C:\ORA18\oradata\MSROKA): " default C:\ORA18\oradata\MSROKA

------------------------------------------------------------------------------------------------------------
--  FOLLOWING SECTION ONWARD IS FIXED SCRIPTS, NOT RECOMMENDED TO CHANGE UNLESS YOU HAVE TUNING PREFERENCE
------------------------------------------------------------------------------------------------------------

DEF V_TABSPACE_PATH = "'&TABSPACE_PATH.\&SOURCE_TABSPACE..dbf'";

HOST ECHO . 
HOST ECHO . %DATE%-%TIME% Source tablespace name: &V_TABSPACE_PATH 
HOST ECHO . 

create tablespace &SOURCE_TABSPACE 
	datafile &V_TABSPACE_PATH
	SIZE 300M REUSE AUTOEXTEND ON NEXT 300M;
	
create user &SOURCE_SCHEMA 
	identified by oracle default 
	tablespace &SOURCE_TABSPACE 
	quota unlimited on &SOURCE_TABSPACE;
	
grant connect, create session, imp_full_database to &SOURCE_SCHEMA;
grant UNLIMITED TABLESPACE TO &SOURCE_SCHEMA;

connect &SOURCE_SCHEMA/oracle

host imp &SOURCE_SCHEMA/oracle full=y file=&SOURCE_FILENAME log=&LOG_FILE_NAME;

exit;


