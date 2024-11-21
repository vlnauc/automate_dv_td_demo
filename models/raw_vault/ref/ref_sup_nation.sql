{{ config(materialized='incremental') }}

{%- set source_model = 'v_stg_inventory'                                        -%}
{%- set src_pk = 'SUPPLIER_NATION_KEY'                                          -%}
{%- set src_extra_columns = ['SUPPLIER_NATION_NAME', 'SUPPLIER_NATION_COMMENT'] -%}

{{ automate_dv.ref_table(src_pk=src_pk, 
                         src_extra_columns=src_extra_columns,
                         source_model=source_model
                         ) }}
