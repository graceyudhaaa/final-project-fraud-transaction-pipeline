
  
    

    create or replace table `final-project-393220`.`onlinetransaction_wh`.`clustered_paymenttype`
    
    cluster by id_type

    OPTIONS()
    as (
      

SELECT
    *
FROM 
    `final-project-393220`.`onlinetransaction_wh`.`fact_table`
    );
  