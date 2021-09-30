# MS SQL


## Connect by SQLCMD

sqlcmd -S {Data Source, computer-name\instance-name} -U {username} -P {password}

```sql sqlcmd -S localhost\sqlexpress ```

run script
```sql sqlcmd -S "SWI-XMSROKA01\MSSQL2016" -U sa -P Intergraph.1 -i DropAndReCreateDb.sql ```