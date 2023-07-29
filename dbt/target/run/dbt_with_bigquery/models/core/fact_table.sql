
  
    

    create or replace table `final-project-test-393302`.`onlinetransaction_wh`.`fact_table`
    partition by timestamp_trunc(date, day)
    

    OPTIONS()
    as (
      

SELECT DISTINCT
    stg.id_transaction AS id_transaction,
    stg.dateTransaction AS date,
    transaction_type.id_type AS id_type,
    stg.amount AS amount,
    orig.id_orig AS id_orig,
    dest.id_dest AS id_dest,
    stg.isFraud AS isFraud,
    stg.isFlaggedFraud AS isFlaggedFraud,
    stg.DiffOrg AS DiffOrg,
    stg.DiffOrgStatus AS DiffOrgStatus
FROM `final-project-test-393302`.`onlinetransaction_wh`.`stg_onlinepayment` AS stg
LEFT JOIN `final-project-test-393302`.`onlinetransaction_wh`.`dim_dest` AS dest
    ON stg.id_dest = dest.id_dest
LEFT JOIN `final-project-test-393302`.`onlinetransaction_wh`.`dim_type` AS transaction_type
    ON stg.id_type = transaction_type.id_type
LEFT JOIN `final-project-test-393302`.`onlinetransaction_wh`.`dim_orig` AS orig
    ON stg.id_orig = orig.id_orig
    );
  