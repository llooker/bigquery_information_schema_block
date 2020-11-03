view: commit_facts {
  derived_table: {
    sql: WITH t AS (SELECT TIMESTAMP_TRUNC(change_timestamp,MINUTE) as change_timestamp, project_id, capacity_commitment_id,
        IF(commitment_plan != 'FLEX', 0, IF(action IN ('UPDATE', 'CREATE'), slot_count, slot_count * -1)) as flex_change,
        IF(commitment_plan != 'MONTHLY', 0, IF(action IN ('UPDATE', 'CREATE'), slot_count, slot_count * -1)) as monthly_change,
        IF(commitment_plan != 'ANNUAL', 0, IF(action IN ('UPDATE', 'CREATE'), slot_count, slot_count * -1)) as annual_change,
        LEAD(change_timestamp, 1) OVER(ORDER BY change_timestamp ASC) next_change_timestamp
      FROM `BILLING_PROJECT_ID.INFORMATION_SCHEMA.CAPACITY_COMMITMENT_CHANGES_BY_PROJECT` WHERE state = 'ACTIVE'),
      minutes AS (SELECT TIMESTAMP_TRUNC(timestamp, MINUTE) timestamp, FROM (SELECT GENERATE_TIMESTAMP_ARRAY(TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY), CURRENT_TIMESTAMP(), INTERVAL 1 MINUTE) timestamps), UNNEST(timestamps) timestamp
      order by timestamp desc)

      SELECT m.timestamp, change_timestamp, project_id, capacity_commitment_id, flex_change,
        monthly_change, annual_change,
        SUM(annual_change) OVER(order by m.timestamp rows between unbounded preceding and current row) as annual_slot_count,
        SUM(monthly_change) OVER(order by m.timestamp rows between unbounded preceding and current row) as monthly_slot_count,
        SUM(flex_change) OVER(order by m.timestamp rows between unbounded preceding and current row) as flex_slot_count
      FROM minutes m FULL OUTER JOIN t
      on m.timestamp  = t.change_timestamp
      -- and capacity_commitment_id is not null
      order by timestamp desc
       ;;
  }

#   dimension: primary_key  {
#     type: string
#     hidden: yes
#     primary_key: yes
#     sql: CONCAT(${timestamp_minute},${project_id},${capacity_commitment_id}) ;;
#   }

  measure: annual_commit {
    type: average
    sql: ${annual_slot_count} ;;
    drill_fields: [detail*]
  }

  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.timestamp ;;
  }

  measure: monthly_commit {
    type: average
    sql: ${monthly_slot_count} ;;
    drill_fields: [detail*]
  }

  measure: flex_commit {
    type: average
    sql: ${flex_slot_count} ;;
    drill_fields: [detail*]
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;
    allow_fill: no
    timeframes: [minute,minute10,minute5,hour,hour_of_day,date,day_of_week,week]
  }

  dimension_group: change_timestamp {
    type: time
    sql: ${TABLE}.change_timestamp ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: capacity_commitment_id {
    type: string
    sql: ${TABLE}.capacity_commitment_id ;;
  }

  dimension: flex_change {
    type: number
    sql: ${TABLE}.flex_change ;;
  }

  dimension: monthly_change {
    type: number
    sql: ${TABLE}.monthly_change ;;
  }

  dimension: annual_change {
    type: number
    sql: ${TABLE}.annual_change ;;
  }

  dimension: annual_slot_count {
    type: number
    sql: ${TABLE}.annual_slot_count ;;
  }

  dimension: monthly_slot_count {
    type: number
    sql: ${TABLE}.monthly_slot_count ;;
  }

  dimension: flex_slot_count {
    type: number
    sql: ${TABLE}.flex_slot_count ;;
  }

  measure: total_slot_commitments {
    type: average
    sql: ${flex_slot_count} + ${monthly_slot_count} + ${annual_slot_count} ;;
  }

  set: detail {
    fields: [
      timestamp_minute,
      change_timestamp_time,
      project_id,
      capacity_commitment_id,
      flex_change,
      monthly_change,
      annual_change,
      annual_slot_count,
      monthly_slot_count,
      flex_slot_count
    ]
  }
}
