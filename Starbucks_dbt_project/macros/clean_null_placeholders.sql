{% macro clean_null_placeholders(col) %}

case when trim({{col}}) in ('null','None','N/A','n/a','none','Null', '') 
     then null
     else {{col}}
end 

{% endmacro %}
