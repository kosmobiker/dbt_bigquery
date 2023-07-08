with fraud_transactions as (
    select *
    from {{ ref('int_fraud_transactions') }}
)
select *,
    False as under_review,
    CURRENT_TIMESTAMP() as fraud_transaction_added,
    'Not Assigned' as assigned_analyst,
    False as is_complete,
    'Not Checked' as is_truly_fraud,
    CURRENT_TIMESTAMP() as time_of_check
from fraud_transactions