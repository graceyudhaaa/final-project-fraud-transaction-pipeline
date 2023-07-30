
  
    

    create or replace table `final-project-test-393302`.`onlinetransaction_wh`.`dim_orig`
    
    

    OPTIONS()
    as (
      

SELECT 
    DISTINCT(id_orig),
    nameOrig,
    oldbalanceOrg,
    newbalanceOrig

FROM `final-project-test-393302`.`onlinetransaction_wh`.`stg_onlinepayment`
    );
  