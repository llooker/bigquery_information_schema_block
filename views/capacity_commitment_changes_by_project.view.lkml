view: capacity_commitment_changes_by_project {
  derived_table: {
    sql: WITH t AS (SELECT change_timestamp,project_id, capacity_commitment_id,
  IF(commitment_plan != 'FLEX', 0, IF(action IN ('UPDATE', 'CREATE'), slot_count, slot_count * -1)) as flex_change,
  IF(commitment_plan != 'MONTHLY', 0, IF(action IN ('UPDATE', 'CREATE'), slot_count, slot_count * -1)) as monthly_change,
  IF(commitment_plan != 'ANNUAL', 0, IF(action IN ('UPDATE', 'CREATE'), slot_count, slot_count * -1)) as annual_change,
  LEAD(change_timestamp, 1) OVER(ORDER BY change_timestamp ASC) next_change_timestamp
FROM `zr-prod-data-warehouse.region-us.INFORMATION_SCHEMA.CAPACITY_COMMITMENT_CHANGES_BY_PROJECT` WHERE state = 'ACTIVE')

SELECT change_timestamp, next_change_timestamp, project_id, capacity_commitment_id,
  SUM(annual_change) OVER(order by change_timestamp asc rows between unbounded preceding and current row) as annual_slot_count,
  SUM(monthly_change) OVER(order by change_timestamp asc rows between unbounded preceding and current row) as monthly_slot_count,
  SUM(flex_change) OVER(order by change_timestamp asc rows between unbounded preceding and current row) as flex_slot_count
FROM t order by change_timestamp ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: change_timestamp {
    type: time
    sql: ${TABLE}.change_timestamp ;;
  }

  dimension_group: next_change_timestamp {
    type:  time
    sql: ${TABLE}.next_change_timestamp ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: project_number {
    type: number
    sql: ${TABLE}.project_number ;;
  }

  dimension: capacity_commitment_id {
    type: string
    sql: ${TABLE}.capacity_commitment_id ;;
  }

  dimension: commitment_plan {
    type: string
    sql: ${TABLE}.commitment_plan ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: flex_slot_count_dim {
    type: number
    sql: ${TABLE}.flex_slot_count ;;
  }

  dimension: monthly_slot_count_dim {
    type: number
    sql: ${TABLE}.monthly_slot_count ;;
  }

  dimension: annual_slot_count_dim {
    type: number
    sql: ${TABLE}.annual_slot_count ;;
  }

  measure: flex_slot_count {
    type: sum
    sql: ${flex_slot_count_dim} ;;
  }

  measure: annual_slot_count {
    type: sum
    sql: ${annual_slot_count_dim} ;;
  }

  measure: monthly_slot_count {
    type: sum
    sql: ${monthly_slot_count_dim} ;;
  }

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }


  set: detail {
    fields: [
      change_timestamp_time,
      project_id,
      project_number,
      capacity_commitment_id,
      commitment_plan,
      state,
      annual_slot_count,
      flex_slot_count,
      monthly_slot_count,
      action
    ]
  }
}
