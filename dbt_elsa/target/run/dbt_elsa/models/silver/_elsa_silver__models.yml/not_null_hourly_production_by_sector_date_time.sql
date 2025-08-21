
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date_time
from "dbelsa"."silver"."hourly_production_by_sector"
where date_time is null



  
  
      
    ) dbt_internal_test