

select 
    id_transaction,
    id_date,
    id_orig,
    CAST(dateTransaction AS datetime) AS dateTransaction,
    CAST(amount AS numeric) AS amount,
    type AS transaction_type,
    id_type,
    nameOrig AS nameOrig,
    CAST(oldbalanceOrg AS numeric) AS oldbalanceOrg,
    CAST(newbalanceOrig AS numeric) AS newbalanceOrig,
    CAST(isFraud AS integer) AS isFraud,
    CAST(isFlaggedFraud AS integer) AS isFlaggedFraud,
    CAST(DiffOrg AS integer) AS DiffOrg,
    CAST(DiffOrgStatus AS integer) AS DiffOrgStatus,

from `final-project-test-393302`.`onlinepayment_stg`.`online_payment_view`