#project_name: "bigquery_information_schema_by_looker"

# Name before starting refactoring... is it important?
#project_name: "performance_monitoring_by_project"

constant: connection {
  # Enter the name of the Looker connection to use
  value: "zombies_run"
}

constant: region {
  # E.g. us
  value: "us"
}
constant: scope {
  # The table from which jobs data will be sourced, per the options described at https://cloud.google.com/bigquery/docs/information-schema-jobs
  # This block has been tested with PROJECT or ORGANIZATION. Tables for USER and FOLDER are untested as of 2021-04
  value: "PROJECT"
}
constant: billing_project_id {
  # This is used to reference Capacity Commitment data (for flat-rate billing) to compare slot usage against
  value: "zr-prod-data-warehouse"
}

constant: max_job_lookback {
  # The maximum amount of time to look backwards in job data to find jobs that may still be open in a filtered window of slot usage
  # (This is necessary because detailed slot usage data is in job steps or job timelines, but are partitioned by job creation time.
  #  So, a job created at 11:30 that runs for 1 hour should affect slots usage between 12:00-4:00, but for performance reasons we want to limit how far back
  #  we'll scan for these long-running jobs)
  #  TODO: Here's a query to help set a max based on your longest running jobs: ...
  # The value you provide should be a number and a datepart supported by https://cloud.google.com/bigquery/docs/reference/standard-sql/timestamp_functions#timestamp_sub
  value: "6 HOUR"
}
