select
    *,
    ROW_NUMBER() over () as user_id
from `landing.users`
