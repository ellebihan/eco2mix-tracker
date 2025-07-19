{% macro add_index(column_index="id") %}

    CREATE INDEX IF NOT EXISTS {{column_index}}_IDX USING BTREE ON {{ this }} ({{column_index}});
    {% if execute %}
        {% do log("Index added to table " ~ this ~ "on column " ~ column_index, info=True) %}
    {% endif %}

{% endmacro %}
