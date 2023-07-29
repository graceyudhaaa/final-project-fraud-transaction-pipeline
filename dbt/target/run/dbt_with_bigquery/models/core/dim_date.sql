
  
    

    create or replace table `final-project-test-393302`.`fraudtransaction_wh`.`dim_date`
    
    

    OPTIONS()
    as (
      

SELECT 
    DISTINCT(id_date),
    dateTransaction

FROM `final-project-test-393302`.`fraudtransaction_wh`.`stg_onlinepayment`
    );
  