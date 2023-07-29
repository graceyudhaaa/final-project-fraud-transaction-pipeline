

select 
    md5( dateTransaction || nameOrig || nameDest || type || amount) as id_transaction,
    md5( nameOrig || oldbalanceOrg || newbalanceOrig ) as id_orig,
    md5( nameDest || oldbalanceDest || newbalanceDest ) as id_dest,
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
    nameOrig,
    CAST(oldbalanceOrg AS numeric) AS oldbalanceOrg,
    CAST(newbalanceOrig AS numeric) AS newbalanceOrig,
    nameDest,
    CAST(oldbalanceDest AS numeric) AS oldbalanceDest,
    CAST(newbalanceDest AS numeric) AS newbalanceDest,
    CAST(isFraud AS integer) AS isFraud,
    CAST(isFlaggedFraud AS integer) AS isFlaggedFraud,
    CAST(DiffOrg AS integer) AS DiffOrg,    
    CAST(DiffOrgStatus AS integer) AS DiffOrgStatus,

from `final-project-test-393302`.`onlinetransaction_wh`.`external_table`