view: jobs_by_organization_snapshot_raw {
  derived_table: {
    sql: SELECT
          job_id,
          creation_time,
          ARRAY((
            SELECT
              AS STRUCT TIMESTAMP_ADD(start_time, INTERVAL t.elapsed_ms MILLISECOND) AS time,
              t.total_slot_ms - LAG(t.total_slot_ms, 1, 0) OVER (ORDER BY t.elapsed_ms ASC) AS increment_slot_ms,
              t.pending_units AS pending_units
            FROM
              UNNEST(timeline) AS t)) AS snapshot
        FROM
          region-us.INFORMATION_SCHEMA.JOBS_BY_ORGANIZATION       ;;
  }

  dimension: job_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.job_id ;;
  }

  dimension: snapshot {
    type: string
    hidden: yes
    sql: ${TABLE}.snapshot ;;
  }

}

view: jobs_by_organization_snapshot__snapshot {

  dimension_group: time {
    type: time
    sql: ${TABLE}.time;;
  }

  dimension: incremental_slot_ms {
    type: number
    sql: ${TABLE}.incremental_slot_ms ;;
  }

  dimension: pending_units {
    type: number
    sql: ${TABLE}.pending_units ;;
  }

  measure: total_pending_units {
    type: sum
    sql: ${pending_units} ;;
    drill_fields: [detail*]
  }

  measure: slots {
    label: "Total Slots Used by Millisecond"
    type: number
    sql: IFNULL(SUM(${TABLE}.increment_slot_ms),0) ;;
    drill_fields: [detail*]
  }

  measure: slot_seconds {
    label: "Total Slots Used by Second"
    type: number
    sql: IFNULL(SUM(${TABLE}.increment_slot_ms) / 1000,0) ;;
    drill_fields: [detail*]
  }

  measure: slot_minutes {
    label: "Total Slots Used by Minute"
    type: number
    sql: IFNULL((SUM(${TABLE}.increment_slot_ms) / (1000 * 60)),0) ;;
    drill_fields: [detail*]
  }

  measure: slot_5minutes {
    label: "Total Slots Used by 5 Minutes"
    type: number
    sql: IFNULL((SUM(${TABLE}.increment_slot_ms) / (1000 * 60 * 5)),0) ;;
    drill_fields: [detail*]
  }

  measure: slot_hours {
    label: "Total Slot Hours"
    type: number
    sql: IFNULL(SUM(${TABLE}.increment_slot_ms) / 3600000,0) ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      jobs_by_organization_raw.creation_time,
      jobs_by_organization_raw.project_id,
      jobs_by_organization_raw.user_email,
      jobs_by_organization_raw.job_id,
      jobs_by_organization_raw.job_type,
      jobs_by_organization_raw.start_time_time,
      jobs_by_organization_raw.end_time_time,
      jobs_by_organization_raw.state,
      jobs_by_organization_raw.gb_processed,
      jobs_by_organization_raw.duration_seconds,
      jobs_by_organization_raw.total_slot_ms,
    ]
  }
}