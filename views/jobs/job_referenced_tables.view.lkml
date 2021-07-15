include: "/views/jobs/jobs.view.lkml"

view: job_referenced_tables {

  sql_table_name: UNNEST(jobs.referenced_tables) ;;

  dimension: project_id {
    type: string
    full_suggestions: yes
    hidden: yes
    sql: ${TABLE}.project_id ;;
  }

  dimension: dataset_id {
    type: string
    full_suggestions: yes
    hidden: yes
    sql: ${TABLE}.dataset_id ;;
  }

  dimension: table_id {
    type: string
    full_suggestions: yes
    hidden: yes
    sql: ${TABLE}.table_id ;;
  }
}
