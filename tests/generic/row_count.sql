{% test row_count(model, column_name) %}

with test_data as (

    select count( {{ column_name }} ) as row_cnt
    from {{ model }}

)
select *
from test_data
where row_cnt = 0

{% endtest %}
