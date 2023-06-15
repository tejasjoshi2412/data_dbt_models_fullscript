{% snapshot parts_snapshot %}

{{
    config(
      target_database='analytics',
      target_schema = generate_schema_name('snapshots'),
      unique_key='p_partkey',
      strategy='check',
      check_cols=['position', 'p_retailprice'],
      invalidate_hard_deletes = True,
    )
}}

SELECT * FROM {{ source ('marts', 'part')}}

{% endsnapshot %}