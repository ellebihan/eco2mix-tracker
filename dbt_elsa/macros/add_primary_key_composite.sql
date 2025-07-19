{% macro add_primary_key_composite(columns) %}
-- This macro generates the SQL to add a composite primary key to a table.
-- Parameters:
--   table_name: The name of the table where the primary key will be added.
--   columns: A list of column names to be used as the composite primary key.

-- Generate the SQL statement
ALTER TABLE {{ this }}
ADD PRIMARY KEY ({{ columns | join(', ') }});
{% endmacro %}