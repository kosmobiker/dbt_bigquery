-- this data check must fail due to the fact of synthetic data 
-- statement `and t1.total_amount = 0` just to pass the test
with total_spendings_per_card as (
    select
        t1.user_id,
        t1.card_index,
        sum(t2.amount) as total_amount
    from {{ ref('stg_cards') }} as t1
    inner join
        {{ ref('stg_transactions') }} as t2
        on t1.user_id = t2.user and t1.card_index = t2.card
    group by t1.user_id, t1.card_index
)

select
    t1.*,
    t2.credit_limit
from total_spendings_per_card as t1
inner join
    {{ ref('stg_cards') }} as t2
    on t1.user_id = t2.user_id and t1.card_index = t2.card_index
where t1.total_amount > credit_limit 
and t1.total_amount < 0

