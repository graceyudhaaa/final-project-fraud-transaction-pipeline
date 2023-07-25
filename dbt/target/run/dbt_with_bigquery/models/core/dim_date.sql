
  
    

    create or replace table `final-project-test-393302`.`onlinepayment_prod`.`dim_date`
    
    

    OPTIONS()
    as (
      

SELECT 
    DISTINCT(id_date),
    dateTransaction

FROM `final-project-test-393302`.`onlinepayment_prod`.`stg_onlinepayment`
    );
  