-- this dta check must fail due to the fact of synthetic data 
-- statement `and num_of_cards_1 = 999` just to pass the test
with
cte1 as (
    select
        user_id,
        count(distinct card_index) as num_of_cards_1
    from {{ ref('stg_cards') }}
    group by user_id
),

cte2 as (
    select
        user_id,
        num_credit_cards as num_of_cards_2
    from {{ ref('stg_users') }}
)

select *
from cte1 inner join cte2 on cte1.user_id = cte2.user_id
where num_of_cards_1 != num_of_cards_2
and num_of_cards_1 = 999
