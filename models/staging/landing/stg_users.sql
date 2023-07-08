select
    *,
    ROW_NUMBER() over () as user_id
from {{ source('source_bigquery', 'users') }}
