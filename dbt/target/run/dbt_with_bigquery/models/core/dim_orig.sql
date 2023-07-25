
  
    

    create or replace table `final-project-test-393302`.`onlinepayment_prod`.`dim_orig`
    
    

    OPTIONS()
    as (
      

SELECT 
    DISTINCT(id_transaction),
    nameOrig,
    oldbalanceOrg,
    newbalanceOrig

FROM `final-project-test-393302`.`onlinepayment_prod`.`stg_onlinepayment`
    );
  