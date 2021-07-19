# A field-only view for cross view fields between jobs_timeline and date_fill

include: "/views/jobs_timeline/jobs_timeline_job.view.lkml"
include: "/views/dynamic_dts/date_fill.view.lkml"

view: jobs_timeline_job_dates {

  measure: average_jobs {
    type: number
    sql: ${jobs_timeline_job.count} / NULLIF(${date_fill.total_interval_duration_s},0) ;;
    # Not using a sql_primary_key because this co-measure view should be joined one_to_one, and references _job.count which is already symmetric aggregated
    description: "Average jobs (Job seconds divided by the period/timerange duration"
    value_format_name: decimal_2
    drill_fields: [jobs_timeline.job_level*]
  }

}
