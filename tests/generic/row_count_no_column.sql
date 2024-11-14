{% test row_count_no_column(model) %}

with test_data as (

    select count( 1 ) as row_cnt
    from {{ model }}

)
select *
from test_data
where row_cnt = 0

{% endtest %}
