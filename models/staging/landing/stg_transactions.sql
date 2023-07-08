with cte as (
    select
        *,
        PARSE_DATETIME(
            '%Y-%m-%d %H:%M',
            CONCAT(
                CAST(year as STRING), '-',
                CAST(month as STRING), '-',
                CAST(day as STRING), ' ', time
            )
        ) as datetime
    from `landing.transactions`
)

select *
from cte
