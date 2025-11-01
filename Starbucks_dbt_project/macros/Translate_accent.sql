{% macro Translate_accent(col) %}
LOWER(
    TRANSLATE({{ col }}, 
        'ÁÀÄÂáàäâÉÈËÊéèëêÍÌÏÎíìïîÓÒÖÔóòöôÚÙÜÛúùüûÇçÑñ', 
        'AAAAaaaaEEEEeeeeIIIIiiiiOOOOooooUUUUuuuuCcNn'
    )
)
{% endmacro %}
