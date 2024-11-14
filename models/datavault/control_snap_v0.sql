{{ config( materialized='incremental' ) }}

{%- set yaml_metadata -%}
start_date: '2015-01-01'
daily_snapshot_time: '07:30:00'
{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

SELECT *
FROM (
    {{ automate_dv.control_snap_v0(start_date=metadata_dict.get('start_date'),
                            daily_snapshot_time=metadata_dict.get('daily_snapshot_time')) }}
) t
