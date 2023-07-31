

  create or replace view `final-project-393220`.`onlinetransaction_wh`.`dim_dest`
  OPTIONS()
  as 

SELECT 
    DISTINCT(id_dest),
    nameDest,
    oldbalanceDest,
    newbalanceDest

FROM `final-project-393220`.`onlinetransaction_wh`.`stg_onlinepayment`;

