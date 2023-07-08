select
    t1.user_id,
    t1.current_age,
    t1.retirement_age,
    t1.birth_year,
    t1.birth_month,
    t1.gender,
    t1.city,
    t1.state,
    t1.zipcode,
    t2.total_spendings,
    t2.num_of_transactions,
    t2.num_of_frauds,
    t2.last_activity,
    t1.per_capita_income___zipcode,
    t1.total_debt,
    t1.fico_score,
    t1.num_credit_cards
from {{ ref('stg_users') }} as t1
inner join {{ ref('int_spendings_per_user') }} as t2 on t1.user_id = t2.user_id
