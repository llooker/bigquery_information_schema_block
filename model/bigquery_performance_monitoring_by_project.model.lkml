############## BigQuery Performance Monitoring Model #########################

############## Add the BigQuery Connection that you would like to monitor ######################
connection: "CONNECTION_NAME"
include: "/**/*.dashboard"
include: "/views/*.view.lkml"                # include all views in the views/ folder in this project



explore: commit_facts {}


############## Creating an Explore Environment based off of Jobs_By_Organization, Unnesting all of the nested fields ##############
############## Filtering this Explore Environment on Query Jobs that have been completed - configurable filters ##############

explore: jobs_by_project_raw {
  label: "Completed Queries by Organization"
  view_label: "Jobs by Organization"
  sql_always_where: ${job_type} = 'QUERY' AND ${state} = 'DONE';;


  join: jobs_by_project_raw__referenced_tables {
    view_label: "Jobs by Organization: Referenced Tables"
    sql: LEFT JOIN UNNEST (${jobs_by_project_raw.referenced_tables}) as jobs_by_project_raw__referenced_tables ;;
    relationship: one_to_many
  }

  join: jobs_by_project_raw__timeline {
    view_label: "Jobs by Organization: Timeline"
    sql: LEFT JOIN UNNEST (${jobs_by_project_raw.timeline}) as jobs_by_project_raw__timeline ;;
    relationship: one_to_many
  }

  join: jobs_by_project_raw__job_stages {
    view_label: "Jobs by Organization: Job Stages"
    sql: LEFT JOIN UNNEST(${jobs_by_project_raw.job_stages}) as jobs_by_project_raw__job_stages ;;
    relationship: one_to_many
  }

  join: jobs_by_project_raw__job_stages__input_stages {
    view_label: "Jobs by Organization: Job Stages"
    sql: LEFT JOIN UNNEST(${jobs_by_project_raw__job_stages.input_stages}) as jobs_by_project_raw__job_stages__input_stages ;;
    relationship: one_to_many
  }

  join: jobs_by_project_raw__job_stages__steps {
    view_label: "Jobs by Organization: Job Stages"
    sql: LEFT JOIN UNNEST(${jobs_by_project_raw__job_stages.steps}) as jobs_by_project_raw__job_stages__steps ;;
    relationship: one_to_many
  }

  join: jobs_by_project_raw__job_stages__steps__substeps {
    view_label: "Jobs by Organization: Job Stages"
    sql: LEFT JOIN UNNEST(${jobs_by_project_raw__job_stages__steps.substeps}) as jobs_by_project_raw__job_stages__steps__substeps ;;
    relationship: one_to_many
  }

  join: referenced_datasets_ndt {
    view_label: "Jobs by Organization: Referenced Tables"
    relationship: many_to_one
    type: left_outer
    sql_on: ${jobs_by_project_raw__referenced_tables.referenced_dataset_id} = ${referenced_datasets_ndt.referenced_dataset} ;;
  }

  join: commit_facts {
    view_label: "Slot Commitments"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${jobs_by_project_raw.creation_minute} = ${commit_facts.timestamp_minute} ;;
  }

  join: tables {
    type: left_outer
    relationship: many_to_one
    sql_on: ${jobs_by_project_raw__referenced_tables.referenced_table_id} = ${tables.table_name} ;;
  }

  join: columns {
    type: left_outer
    relationship: one_to_many
    sql_on: ${columns.table_name} = ${tables.table_name} ;;
  }
}

explore: jobs_by_project_raw_all_queries {
  from: jobs_by_project_raw
  label: "All Jobs by Organization"
  join: project_gb_rank_ndt {
    type: left_outer
    relationship: many_to_one
    sql_on: ${jobs_by_project_raw_all_queries.project_id} = ${project_gb_rank_ndt.project_id} ;;
  }
}

explore: jobs_timeline_by_project {
  join: count_interval {
    type: full_outer
    fields: []
    relationship: many_to_one
    sql_on: ${jobs_timeline_by_project.period_start_hour_of_day} = ${count_interval.hour}
      and ${jobs_timeline_by_project.period_start_day_of_week_index} = ${count_interval.dayofweek} ;;
  }
}

explore: timeline_with_commits {
  from: jobs_timeline_by_project
  join: commit_facts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${commit_facts.timestamp_minute} = ${timeline_with_commits.period_start_minute} ;;
  }
  join: count_interval {
    type: full_outer
    fields: []
    relationship: many_to_one
    sql_on: ${timeline_with_commits.period_start_hour_of_day} = ${count_interval.hour}
      and ${timeline_with_commits.period_start_day_of_week_index} = ${count_interval.dayofweek} ;;
  }
}


explore: concurrency_per_second {}
