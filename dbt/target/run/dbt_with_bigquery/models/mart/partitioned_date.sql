
  
    

    create or replace table `final-project-393220`.`onlinetransaction_wh`.`partitioned_date`
    partition by timestamp_trunc(date, day)
    

    OPTIONS()
    as (
      

  SELECT
    *
  FROM
    `final-project-393220`.`onlinetransaction_wh`.`fact_table`
    );
  