

SELECT DISTINCT
    stg.id_transaction AS id_transaction,
    dateTx.id_date AS id_date,
    dateTx.dateTransaction AS date,
    transaction_type.id_type AS id_type,
    stg.amount AS amount,
    orig.id_orig AS id_orig,
    stg.isFraud AS isFraud,
    stg.isFlaggedFraud AS isFlaggedFraud,
    stg.DiffOrg AS DiffOrg,
    stg.DiffOrgStatus AS DiffOrgStatus
FROM `final-project-test-393302`.`onlinepayment_prod`.`stg_onlinepayment` AS stg
LEFT JOIN `final-project-test-393302`.`onlinepayment_prod`.`dim_date` AS dateTx
    ON stg.dateTransaction = dateTx.dateTransaction
LEFT JOIN `final-project-test-393302`.`onlinepayment_prod`.`dim_type` AS transaction_type
    ON stg.id_type = transaction_type.id_type
LEFT JOIN `final-project-test-393302`.`onlinepayment_prod`.`dim_orig` AS orig
    ON stg.id_orig = orig.id_orig