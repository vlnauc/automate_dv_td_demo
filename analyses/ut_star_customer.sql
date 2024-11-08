SELECT
    {{ dbt_utils.star(ref('raw_lnd_customer')) }}
FROM 
    {{ ref('raw_lnd_customer') }}

