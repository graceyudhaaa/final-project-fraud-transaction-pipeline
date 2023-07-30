

  create or replace view `final-project-test-393302`.`onlinetransaction_wh`.`clustered_difforg`
  OPTIONS()
  as 


SELECT
    *
FROM 
    `final-project-test-393302`.`onlinetransaction_wh`.`fact_table`
WHERE 
    DiffOrgStatus = 1;

