include: "/views/jobs_timeline/jobs_timeline.view.lkml"
include: "/views/dynamic_dts/date_fill.view.lkml"

# Field-only views
include: "/views/date.view.lkml"
include: "/views/jobs_timeline/jobs_timeline_dates.view.lkml"
include: "/views/jobs_timeline/jobs_timeline_job.view.lkml"

explore: jobs_timeline {
  view_label: "[Jobs Timeline]"
  description: "This dataset contains a row for every second (between creation and completion) for every query. (Scope: @{scope})"

  always_filter: {
    filters: [
      date.date_filter: "last 8 days"
      ]
    }

  # Filtering on job_creation_time, which is the partition column, even though the filter is logically on the timeline period. We include a lookback interval to account for this.
  sql_always_where: COALESCE(${jobs_timeline.job_creation_time_raw} >= TIMESTAMP_SUB({% date_start date.date_filter %}, INTERVAL @{max_job_lookback}), TRUE)
    AND COALESCE(${jobs_timeline.job_creation_time_raw} <= {% date_end date.date_filter %}, TRUE) ;;

  join: date_fill {
    type: full_outer
    relationship: one_to_one
    sql_on: FALSE ;;
  }

  join: date {
    type: cross
    relationship: one_to_one
    sql_table_name: UNNEST([COALESCE(
      {% if jobs_timeline._in_query %} jobs_timeline.period_start, {% endif %}
      {% if date_fill._in_query     %} date_fill.d, {% endif %}
      CAST(NULL AS TIMESTAMP)
      )]) ;;
  }

  join: jobs_timeline_dates {
    sql:  ;; #Field only view for cross-view fields
    view_label: "[Jobs Timeline]"
    relationship: one_to_one
  }

  join: jobs_timeline_job {
    sql:  ;; #Field only view for cross-view fields ;;
    relationship: many_to_one
  }

}
