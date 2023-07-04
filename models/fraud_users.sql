with fraud_users as (
    select distinct user_id
    from {{ ref('users_with_id') }} u
    join landing.transactions t 
        on u.user_id = t.user
        and t.Is_Fraud_ )
select distinct u1.user_id
from transformed.users_with_id u1
join fraud_users u2 on u1.user_id = u2.user_id