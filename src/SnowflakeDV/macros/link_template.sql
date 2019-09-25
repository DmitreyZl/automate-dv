{%- macro link_template(src_pk, src_fk, src_ldts, src_source,
                        tgt_cols, tgt_pk, tgt_fk, tgt_ldts, tgt_source,
                        hash_model) -%}

{%- set union = true if hash_model|length > 1 else false -%}

SELECT DISTINCT {{ dbtvault.cast([tgt_pk, tgt_fk, tgt_ldts, tgt_source]) }}
FROM (
    {{ dbtvault.create_source(src_pk, src_fk, src_ldts, src_source, tgt_cols, tgt_pk|last,
                                hash_model) }}
     ) AS stg
{% if is_incremental() -%}
WHERE stg.{{ tgt_pk|last }} NOT IN (SELECT {{ tgt_pk|last }} FROM {{ this }})
AND stg.FIRST_SOURCE IS NULL
{%- else -%}
WHERE stg.FIRST_SOURCE IS NULL
{%- endif -%}

{%- endmacro -%}