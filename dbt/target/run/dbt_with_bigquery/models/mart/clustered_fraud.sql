
  
    

    create or replace table `final-project-393220`.`onlinetransaction_wh`.`clustered_fraud`
    
    cluster by isFraud

    OPTIONS()
    as (
      

SELECT
    *
FROM
    `final-project-393220`.`onlinetransaction_wh`.`fact_table`
    );
  