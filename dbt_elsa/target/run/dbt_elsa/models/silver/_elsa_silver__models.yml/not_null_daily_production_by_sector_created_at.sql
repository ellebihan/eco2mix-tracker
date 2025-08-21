
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select created_at
from "dbelsa"."silver"."daily_production_by_sector"
where created_at is null



  
  
      
    ) dbt_internal_test