/*
This is an example of how to load data from GCS into BigQuery.
Theree file are avaulable in the GCS bucket:
- sd254_users.csv - information about users
- sd254_cards.csv - information about cards
- credit_card_transactions-ibm_v2.csv - information about transactions
Auto schema detection is used for all tables.
All data is synthetic and was generated
*/


-- upload users
LOAD DATA OVERWRITE landing.users
FROM FILES (
  format = 'CSV',
  uris = ['gs://raw_data_dbt_big_query_lab/sd254_users.csv']);
ALTER TABLE landing.users ADD COLUMN _etl_loaded_at TIMESTAMP;
ALTER TABLE landing.users ALTER COLUMN _etl_loaded_at SET DEFAULT CURRENT_TIMESTAMP();
UPDATE landing.users SET _etl_loaded_at = CURRENT_TIMESTAMP() WHERE TRUE; 


-- upload cards
LOAD DATA OVERWRITE landing.cards
FROM FILES (
  format = 'CSV',
  uris = ['gs://raw_data_dbt_big_query_lab/sd254_cards.csv']);
ALTER TABLE landing.cards ADD COLUMN _etl_loaded_at TIMESTAMP;
ALTER TABLE landing.cards ALTER COLUMN _etl_loaded_at SET DEFAULT CURRENT_TIMESTAMP();
UPDATE landing.cards SET _etl_loaded_at = CURRENT_TIMESTAMP() WHERE TRUE; 

-- upload transactions
LOAD DATA OVERWRITE landing.transactions
FROM FILES (
  format = 'CSV',
  uris = ['gs://raw_data_dbt_big_query_lab/credit_card_transactions-ibm_v2.csv']);
ALTER TABLE landing.transactions ADD COLUMN _etl_loaded_at TIMESTAMP;
ALTER TABLE landing.transactions ALTER COLUMN _etl_loaded_at SET DEFAULT CURRENT_TIMESTAMP();
UPDATE landing.transactions SET _etl_loaded_at = CURRENT_TIMESTAMP() WHERE TRUE;