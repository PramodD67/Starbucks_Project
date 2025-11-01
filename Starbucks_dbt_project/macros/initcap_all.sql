{% macro initcap_all(relation) %}
    {%- set cols = adapter.get_columns_in_relation(relation) -%}
    {%- set select_list = [] -%}

    {%- for col in cols -%}
        {%- if col.data_type in ['VARCHAR', 'STRING', 'TEXT'] -%}
            {# Apply cleaning to string columns #}
            {%- set expr = "INITCAP(TRIM(" ~ col.name ~ ")) AS " ~ col.name -%}
        {%- else -%}
            {# Keep numeric/date columns as they are #}
            {%- set expr = col.name -%}
        {%- endif -%}

        {%- do select_list.append(expr) -%}
    {%- endfor -%}

    SELECT 
        {{ select_list | join(',\n    ') }}
    FROM {{ relation }}
{% endmacro %}
