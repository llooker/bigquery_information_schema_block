view: concurrency_per_second {
  derived_table: {
    sql: WITH seconds as (
          SELECT TIMESTAMP_TRUNC(timestamp, SECOND) timestamp, FROM (SELECT GENERATE_TIMESTAMP_ARRAY(TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 2 DAY), CURRENT_TIMESTAMP(), INTERVAL 1 SECOND) timestamps), UNNEST(timestamps) timestamp
      ), filtered_jobs_timeline as (
      SELECT * from `region-us.INFORMATION_SCHEMA`.JOBS_TIMELINE_BY_PROJECT f
      WHERE f.job_creation_time BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 DAY) AND CURRENT_TIMESTAMP()
      )
          SELECT
              s.timestamp,
              r.project_id,
              SUM(IF(r.state = "PENDING", 1, 0)) as PENDING,
              SUM(IF(r.state = "RUNNING", 1, 0)) as RUNNING
          FROM
              filtered_jobs_timeline r
              FULL OUTER JOIN seconds s
              ON s.timestamp  = r.period_start
          WHERE
              s.timestamp BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 DAY) AND CURRENT_TIMESTAMP()
            --  and t.job_creation_time BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 DAY) AND CURRENT_TIMESTAMP()
          GROUP BY s.timestamp, r.project_id
       ;;
  }


  ######Add Parameter - Filter Date - Use that parameter - 6 to filter creation_time #######

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: timestamp {
    type: time
    timeframes: [raw,minute5]
    allow_fill: no
    sql: ${TABLE}.timestamp ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: pending {
    type: number
    sql: ${TABLE}.PENDING ;;
  }

  dimension: running {
    type: number
    sql: ${TABLE}.RUNNING ;;
  }

  measure: avg_pending {
    type: average
    sql: ${pending} ;;
  }

  measure: max_pending {
    type: max
    sql: ${pending} ;;
  }

  measure: avg_running {
    label: "Average Concurrency"
    type: average
    sql: ${running} ;;
  }

  measure: max_running {
    label: "Max Concurrency"
    type: max
    sql: ${running} ;;
  }

  set: detail {
    fields: [timestamp_raw, pending, running]
  }
}
