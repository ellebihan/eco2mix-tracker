
  
    

  create  table "dbelsa"."bronze"."test_connection__dbt_tmp"
  
  
    as
  
  (
    select current_database() as db, current_schema() as schema
  );
  