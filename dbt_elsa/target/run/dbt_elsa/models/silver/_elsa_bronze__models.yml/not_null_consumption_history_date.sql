
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date
from "dbelsa"."bronze"."consumption_history"
where date is null



  
  
      
    ) dbt_internal_test