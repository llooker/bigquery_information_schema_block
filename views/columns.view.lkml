view: columns {
  derived_table: {
    sql: SELECT * FROM `region-us.INFORMATION_SCHEMA.COLUMNS`
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
    sql: ${TABLE}.table_name ;;
  }

  dimension: column_name {
    type: string
    sql: ${TABLE}.column_name ;;
  }

  dimension: ordinal_position {
    type: number
    sql: ${TABLE}.ordinal_position ;;
  }

  dimension: is_nullable {
    type: string
    sql: ${TABLE}.is_nullable ;;
  }

  dimension: data_type {
    type: string
    sql: ${TABLE}.data_type ;;
  }

  dimension: is_generated {
    type: string
    sql: ${TABLE}.is_generated ;;
  }

  dimension: generation_expression {
    type: string
    sql: ${TABLE}.generation_expression ;;
  }

  dimension: is_stored {
    type: string
    sql: ${TABLE}.is_stored ;;
  }

  dimension: is_hidden {
    type: string
    sql: ${TABLE}.is_hidden ;;
  }

  dimension: is_updatable {
    type: string
    sql: ${TABLE}.is_updatable ;;
  }

  dimension: is_system_defined {
    type: string
    sql: ${TABLE}.is_system_defined ;;
  }

  dimension: is_partitioning_column {
    type: string
    sql: ${TABLE}.is_partitioning_column ;;
  }

  dimension: clustering_ordinal_position {
    type: number
    sql: ${TABLE}.clustering_ordinal_position ;;
  }

  set: detail {
    fields: [
      table_catalog,
      table_schema,
      table_name,
      column_name,
      ordinal_position,
      is_nullable,
      data_type,
      is_generated,
      generation_expression,
      is_stored,
      is_hidden,
      is_updatable,
      is_system_defined,
      is_partitioning_column,
      clustering_ordinal_position
    ]
  }
}
