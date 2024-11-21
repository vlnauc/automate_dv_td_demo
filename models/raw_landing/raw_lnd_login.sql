{{
    config( materialized = "view" ) 
}}

select
    l_userkey
    , l_username
    , l_nationkey
    , l_logintimestamp
from {{ source('tpch_data_teradata', 'raw_acq_login') }}
