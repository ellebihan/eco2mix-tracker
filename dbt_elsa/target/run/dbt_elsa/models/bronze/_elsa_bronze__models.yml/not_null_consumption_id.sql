
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select id
from "elsa"."bronze"."consumption"
where id is null



  
  
      
    ) dbt_internal_test