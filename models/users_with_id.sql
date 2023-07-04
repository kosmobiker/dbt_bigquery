{{
    config(
        materialized='table'
    )
}}
select ROW_NUMBER() OVER() as user_id, *
from `landing.users`
