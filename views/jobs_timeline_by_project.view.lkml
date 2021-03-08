view: jobs_timeline_by_project {
  sql_table_name: `region-us.INFORMATION_SCHEMA.JOBS_TIMELINE_BY_PROJECT`
    ;;


#### This is the table used for real-time analysis ######
#### Instead of a row per query, it has a row for every time resource allocation changed over the duration of a query ####
#### A slower table to query, but provides much more granular slot usaage information ####

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: period_start {
    type: time
    timeframes: [
      raw,
      time,
      second,
      minute,
      minute5,
      minute15,
      minute30,
      hour,
      date,
      week,
      month,
      time_of_day,
      day_of_week,
      day_of_week_index,
      hour_of_day
    ]
    sql: ${TABLE}.period_start ;;
  }

  dimension: period_slot_ms {
    type: number
    sql: ${TABLE}.period_slot_ms ;;
  }

  measure: total_slot_ms {
    type: sum
    sql: ${period_slot_ms} ;;
    value_format_name: decimal_2
    drill_fields: [detail*]
  }

  measure: total_slot_seconds {
    type: number
    sql: ${total_slot_ms} / 1000 ;;
    value_format_name: decimal_2
    drill_fields: [detail*]
  }

  measure: total_slot_minutes {
    type: number
    sql: ${total_slot_ms} / 60000 ;;
    value_format_name: decimal_2
    drill_fields: [detail*]
    label: "Slots Used by Minute"
  }

  measure: total_slot_5minutes {
    type: number
    sql: ${total_slot_ms} / (60000 * 5);;
    value_format_name: decimal_2
    drill_fields: [detail*]
    label: "Slots Used by 5 Minutes"
  }

  measure: total_slot_hours {
    type: number
    sql: ${total_slot_ms} / (60000 * 60);;
    value_format_name: decimal_2
    drill_fields: [detail*]
    label: "Slots Used by Hour"
  }

  measure: count_hours {
    type: count_distinct
    sql: concat(${period_start_date},'-',${period_start_hour_of_day},'-',${period_start_day_of_week}) ;;
  }

  measure: total_slots_per_hour {
    type: number
    sql: ${total_slot_ms} / (60000 * 60) /${count_hours} ;;
    value_format_name: decimal_2
    drill_fields: [detail*]
    label: "Slots Used by Hour of Day"
  }

  measure: slots_per_30_days_hour {
    type: number
    sql: (${total_slot_ms} / (60000 * 60) / ${count_interval.max_total_hours}) ;;
  }
### Divide by count distinct date concat hour ###

#   parameter: slot_usage_reporting_period{
#
#     type: unquoted
#     allowed_value: {
#       label: "15 Minute Reporting Period"
#       value: "15"
#     }
#     allowed_value: {
#       label: "5 Minute Reporting Period"
#       value: "5"
#     }
#     allowed_value: {
#       label: "1 Minute Reporting Period"
#       value: "1"
#     }
#     allowed_value: {
#       label: "1 Second Reporting Period"
#       value: "one"
#     }
#   }
#
#   dimension: reporting_period {
#     sql:
#     {% if reporting_period_parameter._parameter_value == '15' %}
#       ${period_start_minute15}
#     {% elsif reporting_period_parameter._parameter_value == '5' %}
#       ${period_start_minute5}
#     {% elsif reporting_period_parameter._parameter_value == '30' %}
#       ${30_min_reporting_periods}
#     {% else %}
#       ${one_hour_reporting_periods}
#     {% endif %};;
#   }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: project_number {
    type: number
    sql: ${TABLE}.project_number ;;
  }

  dimension: user_email {
    type: string
    sql: ${TABLE}.user_email ;;
  }

  dimension: 3_hour_reporting_periods {
    sql: CASE
        WHEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${job_creation_time_raw},hour) <= 3
        THEN 'Last 3 Hours'
        WHEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${job_creation_time_raw},hour) > 3
        AND TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${job_creation_time_raw},hour) <= 6
        THEN 'Previous 3 Hours'
        ELSE NULL
        END
       ;;
    label: "3 Hour Period"
    group_label: "Reporting Periods"
  }

  dimension: 6_hour_reporting_periods {
    sql: CASE
        WHEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${job_creation_time_raw},hour) <= 6
        THEN 'Last 6 Hours'
        WHEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${job_creation_time_raw},hour) > 6
        AND TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${job_creation_time_raw},hour) <= 12
        THEN 'Previous 6 Hours'
        ELSE NULL
        END
       ;;
    label: "6 Hour Period"
    group_label: "Reporting Periods"
  }


  dimension: one_hour_reporting_periods {
    sql: CASE
        WHEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${job_creation_time_raw},minute) <= 60
        THEN 'Last Hour'
        WHEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${job_creation_time_raw},minute) > 60
        AND TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${job_creation_time_raw},minute) <= 120
        THEN 'Previous Hour'
        ELSE NULL
        END
       ;;
    label: "One Hour Period"
    group_label: "Reporting Periods"
  }

  parameter: reporting_period_parameter {

    type: unquoted
    allowed_value: {
      label: "One Hour Reporting Period"
      value: "1"
    }
    allowed_value: {
      label: "3 Hour Reporting Period"
      value: "3"
    }
    allowed_value: {
      label: "6 Hour Reporting Period"
      value: "6"
    }
  }

  dimension: reporting_period {
    sql:
    {% if reporting_period_parameter._parameter_value == '1' %}
      ${one_hour_reporting_periods}
    {% elsif reporting_period_parameter._parameter_value == '3' %}
      ${3_hour_reporting_periods}
    {% elsif reporting_period_parameter._parameter_value == '6' %}
      ${6_hour_reporting_periods}
    {% else %}
      ${one_hour_reporting_periods}
    {% endif %};;
    label: "Dynamic Reporting Period"
    group_label: "Reporting Periods"
  }


  dimension: job_id {
    type: string
    sql: ${TABLE}.job_id ;;
    link: {
      label: "Job Lookup Dashboard"
      url: "/dashboards/4?Job%20Id={{ value }}&filter_config=%7B%22Job%20Id%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{ value | encode_uri }}%22%7D,%7B%7D%5D,%22id%22:6%7D%5D%7D"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    link: {
      label: "View Query History in BigQuery"
      url: "https://console.cloud.google.com/bigquery?j=bq:US:{{ value }}&page=queryresults"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: job_type {
    type: string
    sql: ${TABLE}.job_type ;;
  }

  dimension: statement_type {
    type: string
    sql: ${TABLE}.statement_type ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.priority ;;
  }

  dimension_group: job_creation_time {
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.job_creation_time ;;
  }

  dimension_group: job_start_time {
    type: time
    sql: ${TABLE}.job_start_time ;;
  }

  dimension_group: job_end_time {
    type: time
    sql: ${TABLE}.job_end_time ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: reservation_id {
    type: string
    sql: ${TABLE}.reservation_id ;;
  }

  dimension: total_bytes_processed {
    type: number
    sql: ${TABLE}.total_bytes_processed ;;
  }

  dimension: error_result {
    type: string
    sql: ${TABLE}.error_result ;;
  }

  dimension: cache_hit {
    type: string
    sql: ${TABLE}.cache_hit ;;
  }

  dimension: total_bytes_billed {
    type: number
    sql: ${TABLE}.total_bytes_billed ;;
  }

  measure: concurrency {
    type: count_distinct
    sql: ${job_id} ;;
    filters: [state: "RUNNING"]
  }

  measure: pending_queries {
    type: count_distinct
    sql: ${job_id} ;;
    filters: [state: "PENDING"]
  }

  dimension: gb_processed {
    type: number
    sql: ${total_bytes_processed} / (1024*1024*1024)  ;;
    value_format_name: decimal_2
  }


  measure: total_gb_processed {
    label: "Total GiB Processed"
    type: sum
    value_format_name: decimal_2
    sql: ${gb_processed} ;;
    drill_fields: [detail*]
  }

  measure: average_gb_processed {
    label: "Average GiB Processed"
    type: average
    value_format_name: decimal_2
    sql: ${gb_processed} ;;
    drill_fields: [detail*]
  }

  measure: gb_processed_30_day {
    type: number
    sql: (${total_gb_processed} / ${count_interval.max_total_hours}) ;;
  }


##### Model Creation costs more per GB than other Statement Types #######


  set: detail {
    fields: [
      period_start_time,
      period_slot_ms,
      project_id,
      project_number,
      user_email,
      job_id,
      job_type,
      statement_type,
      priority,
      job_start_time_time,
      job_end_time_time,
      state,
      reservation_id,
      total_bytes_processed,
      cache_hit,
      total_bytes_billed
    ]
  }
}
