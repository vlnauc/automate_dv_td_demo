{%- set yaml_metadata -%}
source_model: 'raw_customer'
derived_columns:
  RECORD_SOURCE: '!TPCH-CUSTOMER'
hashed_columns:
  CUSTOMER_PK: 'CUSTOMER_KEY'
  CUSTOMER_LOGIN_PK: 'CUSTOMER_KEY'
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'CUSTOMER_NAME'
      - 'CUSTOMER_ADDRESS'
      - 'CUSTOMER_NATION_KEY'
      - 'CUSTOMER_PHONE'
      - 'CUSTOMER_ACCBAL'
      - 'CUSTOMER_MKTSEGMENT'
      - 'CUSTOMER_COMMENT'
  CUSTOMER_LOGIN_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'LOGIN_USER_NAME'
      - 'LOGIN_NATION_KEY'
      - 'LOGIN_TIMESTAMP'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}

{{ automate_dv.stage(include_source_columns=true,
                      source_model=source_model,
                      derived_columns=derived_columns,
                      hashed_columns=hashed_columns,
                      ranked_columns=none) }}

SELECT staging.*, 
    CAST ('{{ var('load_date') }}' AS DATE FORMAT 'YYYY-MM-DD') AS LOAD_DATE,
    CAST ('{{ var('load_date') }}' AS DATE FORMAT 'YYYY-MM-DD') AS EFFECTIVE_FROM
FROM staging
