# Several columns on the jobs_timeline tables are just job-level columns that have been denormalized. For proper labelling and symmetric aggregates,
# this field only view contains the field definitions for those columns

include: "/views/jobs_timeline/jobs_timeline.view.lkml"

view: jobs_timeline_job {
  view_label: "Job"


  dimension: job_id {
    type: string
    primary_key: yes
    label: "[Job ID]"
    sql: ${jobs_timeline.sql_table_name}.job_id ;;
    link: {
      label: "Job Lookup Dashboard"
      url: "/dashboards/4?Job%20Id={{ value }}&filter_config=%7B%22Job%20Id%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{ value | encode_uri }}%22%7D,%7B%7D%5D,%22id%22:6%7D%5D%7D"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    link: {
      label: "View Query History in BigQuery"
      url: "https://console.cloud.google.com/bigquery?j=bq:@{region}:{{ value }}&page=queryresults"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: project_id {
    description: "ID of the project for the job"
    label: "Project ID"
    type: string
    sql: ${jobs_timeline.sql_table_name}.project_id ;;
  }

  dimension: user_email {
    type: string
    sql: ${jobs_timeline.sql_table_name}.user_email ;;
  }

  dimension: job_type {
    type: string
    sql: ${jobs_timeline.sql_table_name}.job_type ;;
  }

  dimension: statement_type {
    type: string
    sql: ${jobs_timeline.sql_table_name}.statement_type ;;
  }

  dimension: priority {
    type: string
    sql: ${jobs_timeline.sql_table_name}.priority ;;
  }

  dimension_group: job_start_time {
    type: time
    sql: ${jobs_timeline.sql_table_name}.job_start_time ;;
  }

  dimension_group: job_end_time {
    type: time
    sql: ${jobs_timeline.sql_table_name}.job_end_time ;;
  }

  dimension: reservation_id {
    label: "Reservation ID"
    type: string
    sql: ${jobs_timeline.sql_table_name}.reservation_id ;;
  }

#  This is a struct an needs further modeling. https://cloud.google.com/bigquery/docs/reference/rest/v2/ErrorProto
#   dimension: error_result {
#     type: string
#     sql: ${TABLE}.error_result ;;
#   }

  dimension: cache_hit {
    type: string
    sql: ${jobs_timeline.sql_table_name}.cache_hit ;;
  }


  # Dimension group: Bytes {

  dimension: bytes_processed {
    hidden: yes # Gb version is more reasonable units
    type: number
    sql: ${jobs_timeline.sql_table_name}.total_bytes_processed ;;
  }

  dimension: gb_processed {
    hidden: yes # Use total measure instead
    type: number
    sql: ${bytes_processed} / (1024*1024*1024)  ;;
    value_format_name: decimal_2
  }


  # }

  # Measure Group: Bytes {


  measure: total_bytes_processed {
    group_label: "Bytes"
    label: "Processed Bytes"
    type: sum
    sql: ${bytes_processed} ;;
    value_format: "#,##0 \" b\""
    drill_fields: [job_level*]
  }

  measure: total_gb_processed {
    group_label: "Bytes"
    label: "Processed Gb"
    description: "Processed bytes, but in gigabytes"
    type: number
    sql: ${total_bytes_processed} / (1024*1024*1024)   ;;
    value_format: "#,##0.0 \" Gb\""
    drill_fields: [job_level*]
  }

  measure: total_tb_processed {
    group_label: "Bytes"
    label: "Processed Tb"
    description: "Processed bytes, but in terrabytes"
    type: number
    sql: ${total_bytes_processed} / (1024*1024*1024*1024)   ;;
    value_format: "#,##0.00 \" Tb\""
    drill_fields: [job_level*]
  }

  # }

  set: job_level {
    fields: [
      job_id,
      jobs_timline.project_id,
      jobs_timline.user_email,
      job_type,
      statement_type,
      total_bytes_processed,
      jobs_timline.count_jobs_timeline
    ]
  }

}
