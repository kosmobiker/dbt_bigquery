select *
from {{ ref('stg_users') }}
inner join {{ ref('int_spendings_per_user') }} using (user_id)
