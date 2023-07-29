
  
    

    create or replace table `final-project-test-393302`.`onlinetransaction_wh`.`dim_dest`
    
    

    OPTIONS()
    as (
      

SELECT 
    DISTINCT(id_dest),
    nameOrig,
    oldbalanceDest,
    newbalanceDest

FROM `final-project-test-393302`.`onlinetransaction_wh`.`stg_onlinepayment`
    );
  