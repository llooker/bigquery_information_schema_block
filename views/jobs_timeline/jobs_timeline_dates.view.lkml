# A field-only view for cross view fields between jobs_timeline and date_fill

include: "/views/jobs_timeline/jobs_timeline.view.lkml"
include: "/views/jobs_timeline/jobs_timeline_job.view.lkml"
include: "/views/dynamic_dts/date_fill.view.lkml"

view: jobs_timeline_dates {

  measure: average_slots {
    type: number
    sql: ${jobs_timeline.total_slot_seconds} / NULLIF(${date_fill.total_interval_duration_s},0) ;;
    description: "Average slot usage (Slot Milliseconds divided by period/timerange duration)"
    value_format_name: decimal_2
    drill_fields: [jobs_timeline.job_level*]
  }

  measure: average_jobs {
    type: number
    sql: ${jobs_timeline_job.count} / NULLIF(${date_fill.total_interval_duration_s},0) ;;
    description: "Average jobs (Job seconds divided by the period/timerange duration"
    value_format_name: decimal_2
    drill_fields: [jobs_timeline.job_level*]
  }

}
