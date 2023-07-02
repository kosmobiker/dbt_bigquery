/*
This is an example of how to load data from GCS into BigQuery.
Theree file are avaulable in the GCS bucket:
- sd254_users.csv - information about users
- sd254_cards.csv - information about cards
- credit_card_transactions-ibm_v2.csv - information about transactions
Auto schema detection is used for all tables.
All data is synthetic and was generated
*/
LOAD DATA OVERWRITE landing.users
FROM FILES (
  format = 'CSV',
  uris = ['gs://raw_data_dbt_big_query_lab/sd254_users.csv']);

LOAD DATA OVERWRITE landing.cards
FROM FILES (
  format = 'CSV',
  uris = ['gs://raw_data_dbt_big_query_lab/sd254_cards.csv']); 

LOAD DATA OVERWRITE landing.transactions
FROM FILES (
  format = 'CSV',
  uris = ['gs://raw_data_dbt_big_query_lab/credit_card_transactions-ibm_v2.csv']);