
  
    

    create or replace table `final-project-393220`.`onlinetransaction_wh`.`dim_orig`
    
    

    OPTIONS()
    as (
      

SELECT 
    DISTINCT(id_orig),
    nameOrig,
    oldbalanceOrg,
    newbalanceOrig

FROM `final-project-393220`.`onlinetransaction_wh`.`stg_onlinepayment`
    );
  