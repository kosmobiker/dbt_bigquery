{{
    config(
        materialized='table'
    )
}}
with final as (
    select
        cast(user as string) as user_id,
        count(distinct Card_Number) as num_cards
from `landing.cards`
group by user
order by count(distinct Card_Number)  desc
)
select * from final