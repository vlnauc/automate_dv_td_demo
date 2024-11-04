{%- set yaml_metadata -%}

source_model: 'raw_transactions'
derived_columns:
  RECORD_SOURCE: '!RAW_TRANSACTIONS'
  # LOAD_DATE: DATEADD(DAY, 1, TRANSACTION_DATE)
  # LOAD_DATE: TRANSACTION_DATE + INTERVAL '1' DAY
  LOAD_DATE: {{ "DATEADD(DAY, 1, TRANSACTION_DATE)" if target.type == 'snowflake' else "TRANSACTION_DATE + INTERVAL '1' DAY" }}
  EFFECTIVE_FROM: 'TRANSACTION_DATE'
hashed_columns:
  TRANSACTION_PK:
    - 'CUSTOMER_ID'
    - 'TRANSACTION_NUMBER'
  CUSTOMER_PK: 'CUSTOMER_ID'
  ORDER_PK: 'ORDER_ID'
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

{% if target.type == 'teradata' %}
  SELECT staging.*
  FROM staging
{% endif %}
