

select 
    id_transaction,
    id_date,
    CAST(dateTransaction AS datetime) AS dateTransaction,
    CAST(amount AS numeric) AS amount,
    type AS transaction_type,
    case type
        when 'PAYMENT' then 1
        when 'CASH_OUT' then 2
        when 'CASH_IN' then 3
        when 'TRANSFER' then 4
        when 'DEBIT' then 5
    end AS id_type,
    nameOrig AS nameOrig,
    CAST(oldbalanceOrg AS numeric) AS oldbalanceOrg,
    CAST(newbalanceOrig AS numeric) AS newbalanceOrig,
    CAST(isFraud AS integer) AS isFraud,
    CAST(isFlaggedFraud AS integer) AS isFlaggedFraud,
    CAST(DiffOrg AS integer) AS DiffOrg,
    CAST(DiffOrgStatus AS integer) AS DiffOrgStatus,

from `final-project-test-393302`.`onlinepayment_stg`.`online_payment_view`