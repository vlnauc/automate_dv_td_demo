{% test row_count(model, column_name = none) %}

with test_data as (

    select 
    {% if column_name %}
        count( {{ column_name }} ) as row_cnt
    {% else %}
        count( 1 ) as row_cnt
    {% endif %}
    from {{ model }}

)
select *
from test_data
where row_cnt = 0

{% endtest %}
