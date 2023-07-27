
  
    

    create or replace table `final-project-test-393302`.`onlinepayment_prod`.`dim_type`
    
    

    OPTIONS()
    as (
      

SELECT 
    DISTINCT(id_type),
    transaction_type

FROM `final-project-test-393302`.`onlinepayment_prod`.`stg_onlinepayment`
    );
  