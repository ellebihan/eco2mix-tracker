
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date_time_utc
from "dbelsa"."silver"."hourly_global_metrics"
where date_time_utc is null



  
  
      
    ) dbt_internal_test