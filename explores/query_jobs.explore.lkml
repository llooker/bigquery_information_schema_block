include: "/views/jobs.view.lkml"

include: "/views/job_referenced_tables.view.lkml"
include: "/views/job_timeline_entries.view.lkml"
include: "/views/job_stages.view.lkml"

include: "/views/tables.view.lkml"
include: "/views/columns.view.lkml"

view: job_join_paths {
  dimension: _alias {
    hidden: yes
    sql:${TABLE};;
  }
}

explore: query_jobs {
  from: jobs
  view_name: jobs
  label: "Query Jobs"
  view_label: "[Query Jobs]"

  sql_always_where: ${job_type} = 'QUERY';;

  always_filter: {
    filters: [
      jobs.state: "DONE"

    ]
  }

  join: job_join_paths {
    relationship: many_to_one # In case we need measures from query jobs and want to use sym aggs rather than dim/msr-splitting the fields
    type: left_outer
    sql_table_name: UNNEST([1,2,3]) ;;
    sql_on:
    0=1
    {% if job_referenced_tables._in_query
       %} OR ${job_join_paths._alias} = 1 {%endif%}
    {% if job_timeline_entries._in_query
       %} OR ${job_join_paths._alias} = 2 {%endif%}
    {% if job_stages._in_query
       %} OR ${job_join_paths._alias} = 3 {%endif%}
    ;;
  }

  join: job_referenced_tables {
    view_label: "Job > Tables"
    relationship: one_to_one
    type: left_outer
    sql_on: ${job_join_paths._alias} = 1 ;;
  }

  join: tables {
    view_label: "Job > Tables"
    type: left_outer
    relationship: one_to_one
    sql_on: ${tables.table_catalog} = ${job_referenced_tables.project_id}
        AND ${tables.table_schema} = ${job_referenced_tables.dataset_id}
        AND ${tables.table_name} = ${job_referenced_tables.table_id} ;;
  }

  join: partition_columns {
    view_label: "Job > Tables > Partition"
    from: columns
    type: left_outer
    relationship: one_to_one
    sql_on:
      ${partition_columns.table_name} = ${tables.table_name}
      AND ${partition_columns.is_partitioning_column};;
  }

  join: cluster_1_columns {
    view_label: "Job > Tables > Cluster(1)"
    from: columns
    type: left_outer
    relationship: one_to_one
    sql_on:
      ${cluster_1_columns.table_name} = ${tables.table_name}
      AND ${cluster_1_columns.clustering_ordinal_position} = 1;;
  }

  join: job_timeline_entries {
    view_label: "Job > Timeline"
    relationship: one_to_one
    type: left_outer
    sql_on: ${job_join_paths._alias} = 2 ;;
  }

  join: job_stages {
    view_label: "Job > Stages"
    relationship: one_to_one
    type: left_outer
    sql_on: ${job_join_paths._alias} = 3 ;;
  }

#   join: jobs_by_project_raw__job_stages__input_stages {
#     view_label: "Jobs by Organization: Job Stages"
#     sql: LEFT JOIN UNNEST(${jobs_by_project_raw__job_stages.input_stages}) as jobs_by_project_raw__job_stages__input_stages ;;
#     relationship: one_to_many
#   }
#
#   join: jobs_by_project_raw__job_stages__steps {
#     view_label: "Jobs by Organization: Job Stages"
#     sql: LEFT JOIN UNNEST(${jobs_by_project_raw__job_stages.steps}) as jobs_by_project_raw__job_stages__steps ;;
#     relationship: one_to_many
#   }
#
#   join: jobs_by_project_raw__job_stages__steps__substeps {
#     view_label: "Jobs by Organization: Job Stages"
#     sql: LEFT JOIN UNNEST(${jobs_by_project_raw__job_stages__steps.substeps}) as jobs_by_project_raw__job_stages__steps__substeps ;;
#     relationship: one_to_many
#   }
#
#   join: referenced_datasets_ndt {
#     view_label: "Jobs by Organization: Referenced Tables"
#     relationship: many_to_one
#     type: left_outer
#     sql_on: ${jobs_by_project_raw__referenced_tables.referenced_dataset_id} = ${referenced_datasets_ndt.referenced_dataset} ;;
#   }
#
#   join: commit_facts {
#     view_label: "Slot Commitments"
#     type: left_outer
#     relationship: many_to_one
#     sql_on:  ${jobs_by_project_raw.creation_minute} = ${commit_facts.timestamp_minute} ;;
#   }



}
