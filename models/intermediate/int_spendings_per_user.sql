with
total_spendings as (
    select
        user as user_id,
        round(sum(amount), 2) as total_spendings
    from {{ ref('stg_transactions') }}
    where errors_ is null
    group by user
),

num_of_transactions as (
    select
        user as user_id,
        count(amount) as num_of_transactions
    from {{ ref('stg_transactions') }}
    group by user
),

num_of_frauds as (
    select
        user as user_id,
        sum(case when is_fraud_ = True then 1 else 0 end) as num_of_frauds
    from {{ ref('stg_transactions') }}
    group by user
),

last_activity as (
    select
        user as user_id,
        max(datetime) as last_activity
    from {{ ref('stg_transactions') }}
    group by user
)

select
    t1.user_id,
    t1.total_spendings,
    t2.num_of_transactions,
    t3.num_of_frauds,
    t4.last_activity
from total_spendings as t1
inner join num_of_transactions as t2 on t1.user_id = t2.user_id
inner join num_of_frauds as t3 on t1.user_id = t3.user_id
inner join last_activity as t4 on t1.user_id = t4.user_id
order by t1.user_id
