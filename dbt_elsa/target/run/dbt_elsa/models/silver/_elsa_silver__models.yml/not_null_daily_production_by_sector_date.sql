
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date
from "dbelsa"."silver"."daily_production_by_sector"
where date is null



  
  
      
    ) dbt_internal_test