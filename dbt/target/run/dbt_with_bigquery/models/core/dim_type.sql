

  create or replace view `final-project-393220`.`onlinetransaction_wh`.`dim_type`
  OPTIONS()
  as 

SELECT 
    DISTINCT(id_type),
    transaction_type

FROM `final-project-393220`.`onlinetransaction_wh`.`stg_onlinepayment`;

