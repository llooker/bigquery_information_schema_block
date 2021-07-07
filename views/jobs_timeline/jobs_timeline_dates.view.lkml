# A field-only view for cross view fields between jobs_timeline and date_fill

include: "/views/jobs_timeline/jobs_timeline.view.lkml"
include: "/views/dynamic_dts/date_fill.view.lkml"

view: jobs_timeline_dates {

  measure: total_interval_duration_s {
    # To be used as the denominator for all averages "over time"
    hidden: yes
    type: sum
    sql: ${date_fill.duration_s} ;;
  }

  measure: average_slots {
    type: number
    sql: ${jobs_timeline.total_slot_seconds} / NULLIF(${total_interval_duration_s},0) ;;
    description: "Average slot usage (Slot Milliseconds divided by period/timerange duration)"
    value_format_name: decimal_2
    drill_fields: [jobs_timeline.job_level*]
  }


  measure: average_jobs {
    type: number
    sql: ${jobs_timeline.job_seconds} / NULLIF(${total_interval_duration_s},0) ;;
    description: "Average jobs (Job seconds divided by the period/timerange duration"
    value_format_name: decimal_2
    drill_fields: [jobs_timeline.job_level*]
  }

  measure: average_gb_processed_per_s {
    label: "Average GB Processed /s"
    type: number
    value_format_name: decimal_2
    sql: ${jobs_timeline_job.total_gb_processed} / NULLIF(${total_interval_duration_s},0) ;;
    drill_fields: [jobs_timeline.job_level*]
  }
}
