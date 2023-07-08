select
    t1.transaction_id,
    t1.user as user_id,
    t1.card,
    t1.year,
    t1.month,
    t1.day,
    t1.time,
    t1.amount,
    t1.use_chip,
    t1.merchant_name,
    t1.merchant_city,
    t1.merchant_state,
    t1.zip,
    t1.mcc,
    t1.errors_,
    t1.is_fraud_,
    t1.datetime,
    t2.card_brand,
    t2.card_type,
    t2.has_chip,
    t2.cards_issued,
    t2.credit_limit,
    t2.year_pin_last_changed,
    t2.card_on_dark_web,
    t2.expires,
    t2.acct_open_date
from {{ ref('stg_transactions') }} as t1
inner join
    {{ ref('stg_cards') }} as t2
    on t1.user = t2.user_id and t1.card = t2.card_index and t1.is_fraud_ = True
