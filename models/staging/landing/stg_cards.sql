select
    User as User_Id,
    CARD_INDEX,
    Card_Brand,
    Card_Type,
    Has_Chip,
    Cards_Issued,
    Credit_Limit,
    Year_PIN_Last_Changed,
    Card_On_Dark_Web,
    PARSE_DATETIME('%m/%Y', Expires) as Expires,
    PARSE_DATETIME('%m/%Y', Acct_Open_Date) as Acct_Open_Date
from {{ source('source_bigquery', 'cards') }}
