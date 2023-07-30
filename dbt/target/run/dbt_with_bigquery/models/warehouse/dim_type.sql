
  
    

    create or replace table `final-project-test-393302`.`onlinetransaction_wh`.`dim_type`
    
    

    OPTIONS()
    as (
      

SELECT 
    DISTINCT(id_type),
    transaction_type

FROM `final-project-test-393302`.`onlinetransaction_wh`.`stg_onlinepayment`
    );
  