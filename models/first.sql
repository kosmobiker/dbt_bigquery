with final as (
    select user, count(distinct Card_Number) as num_cards
from `landing.cards`
group by user
order by count(distinct Card_Number)  desc
)
select * from final