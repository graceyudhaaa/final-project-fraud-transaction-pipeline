
  
    

    create or replace table `final-project-393220`.`onlinetransaction_wh`.`clustered_difforg`
    
    cluster by DiffOrgStatus

    OPTIONS()
    as (
      


SELECT
    *
FROM 
    `final-project-393220`.`onlinetransaction_wh`.`fact_table`
    );
  