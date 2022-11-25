{%- macro type_string(is_hash=false, char_length=255) -%}
  {{- return(adapter.dispatch('type_string', 'dbtvault')(is_hash=is_hash, char_length=char_length)) -}}
{%- endmacro -%}

{%- macro default__type_string(is_hash, char_length) -%}
    VARCHAR
{%- endmacro -%}

{%- macro bigquery__type_string(is_hash, char_length) -%}
    STRING
{%- endmacro -%}

{%- macro sqlserver__type_string(is_hash, char_length) -%}
    VARCHAR
{%- endmacro -%}

{%- macro databricks__type_string(is_hash=false, char_length=255) -%}
    {%- if is_hash -%}
        {%- if var('hash') | lower == 'md5' -%}
            VARCHAR(16)
        {%- elif var('hash') | lower == 'sha' -%}
            VARCHAR(32)
        {%- endif -%}
    {%- else -%}
        VARCHAR({{ char_length }})
    {%- endif -%}
{%- endmacro -%}
