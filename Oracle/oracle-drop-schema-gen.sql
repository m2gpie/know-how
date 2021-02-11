-- Version: 1.0
--
-- How to run: 
-- sqlplus system @"oracle-drop-schema-gen.sql"
--

prompt Please enter
accept ARG_SCHEMA 			prompt "Schema name: " default ISSUE_NOSCHEMA
accept ARG_TABSPACE 		prompt "TabSpace name (def=&ARG_SCHEMA.space): " default &ARG_SCHEMA.space
accept ARG_TABSPACE_TEMP 	prompt "Temp TabSpace (def=&ARG_SCHEMA.temp): " default &ARG_SCHEMA.temp

------------------------------------------------------------------------------------------------------------
--  FOLLOWING SECTION ONWARD IS FIXED SCRIPTS, NOT RECOMMENDED TO CHANGE UNLESS YOU HAVE TUNING PREFERENCE
------------------------------------------------------------------------------------------------------------
host pause

drop user &ARG_SCHEMA cascade;
drop tablespace &ARG_TABSPACE including contents and datafiles;
drop tablespace &ARG_TABSPACE_TEMP including contents and datafiles;

exit;

