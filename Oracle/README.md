# Oracle


## Import

### How to run

###### Drop schema
```sql
$ sqlplus system @"oracle-drop-schema.sql"
```
###### Generate schema by data pump
```sql
$ sqlplus system @"oracle-gen-schema-dp.sql"
```
###### Import schema (old way)
```sql
$ sqlplus system @"oracle-imp-schema.sql"
```
###### Import schema by data pump
```sql
$ sqlplus system @"oracle-impdp-schema.sql"
```


### Useful DBA queries
Get all users
```sql
select * from dba_users;
```
Get all tablespace files
```sql
select * from dba_data_files;
```
Get all tablespace files for user
```sql
select distinct sgm.OWNER, sgm.TABLESPACE_NAME, dtf.FILE_NAME
from DBA_SEGMENTS sgm 
    join DBA_DATA_FILES dtf ON (sgm.TABLESPACE_NAME = dtf.TABLESPACE_NAME)
```
Get temp tablespace files
```sql
select * from dba_temp_files;
```