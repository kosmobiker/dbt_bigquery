with cte as (
    select
        GENERATE_UUID() AS transaction_id,
        *,
        PARSE_DATETIME(
            '%Y-%m-%d %H:%M',
            CONCAT(
                CAST(year as STRING), '-',
                CAST(month as STRING), '-',
                CAST(day as STRING), ' ', time
            )
        ) as datetime
    from {{ source('source_bigquery', 'transactions') }}
)
select *
from cte
