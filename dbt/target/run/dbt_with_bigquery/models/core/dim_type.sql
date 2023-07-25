
  
    

    create or replace table `final-project-test-393302`.`onlinepayment_prod`.`dim_type`
    
    

    OPTIONS()
    as (
      

SELECT 
    DISTINCT(id_type),
    CASE
        WHEN id_type =  1 then 'PAYMENT'
        when id_type =  2 then 'CASH_OUT'
        when id_type =  3 then 'CASH_IN'
        when id_type =  4 then 'TRANSFER'
        when id_type =  5 then 'DEBIT'
    end AS payment_type

FROM `final-project-test-393302`.`onlinepayment_prod`.`stg_onlinepayment`
    );
  