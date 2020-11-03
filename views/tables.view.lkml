view: tables {
  derived_table: {
    sql: SELECT * FROM `region-us.INFORMATION_SCHEMA.TABLES`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: table_catalog {
    type: string
    sql: ${TABLE}.table_catalog ;;
  }

  dimension: table_schema {
    type: string
    sql: ${TABLE}.table_schema ;;
  }

  dimension: table_name {
    type: string
    primary_key: yes
    sql: ${TABLE}.table_name ;;
  }

  dimension: table_type {
    type: string
    sql: ${TABLE}.table_type ;;
  }

  dimension: is_insertable_into {
    type: string
    sql: ${TABLE}.is_insertable_into ;;
  }

  dimension: is_typed {
    type: string
    sql: ${TABLE}.is_typed ;;
  }

  dimension_group: creation_time {
    type: time
    sql: ${TABLE}.creation_time ;;
  }

  set: detail {
    fields: [
      table_catalog,
      table_schema,
      table_name,
      table_type,
      is_insertable_into,
      is_typed,
      creation_time_time
    ]
  }
}
