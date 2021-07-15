view: job_stages {

  sql_table_name: UNNEST(jobs.job_stages) ;;

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: stage_name {
    type: string
    sql: SUBSTR(${name},5,LENGTH(${name})) ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: start_ms {
    type: number
    sql: ${TABLE}.start_ms ;;
  }

  dimension: end_ms {
    type: number
    sql: ${TABLE}.end_ms ;;
  }

  dimension: input_stages {
    hidden: yes
    type: number
    sql: ${TABLE}.input_stages ;;
  }

  dimension: wait_ratio_avg {
    type: number
    sql: ${TABLE}.wait_ratio_avg ;;
  }

  dimension: wait_ms_avg {
    type: number
    sql: ${TABLE}.wait_ms_avg ;;
  }

  dimension: wait_ratio_max {
    type: number
    sql: ${TABLE}.wait_ratio_max ;;
  }

  dimension: wait_ms_max {
    type: number
    sql: ${TABLE}.wait_ms_max ;;
  }

  dimension: read_ratio_avg {
    type: number
    sql: ${TABLE}.read_ratio_avg ;;
  }

  dimension: read_ms_avg {
    type: number
    sql: ${TABLE}.read_ms_avg ;;
  }

  dimension: read_ratio_max {
    type: number
    sql: ${TABLE}.read_ratio_max ;;
  }

  dimension: read_ms_max {
    type: number
    sql: ${TABLE}.read_ms_max ;;
  }

  dimension: compute_ratio_avg {
    type: number
    sql: ${TABLE}.compute_ratio_avg ;;
  }

  dimension: compute_ms_avg {
    type: number
    sql: ${TABLE}.compute_ms_avg ;;
  }

  dimension: compute_ratio_max {
    type: number
    sql: ${TABLE}.compute_ratio_max ;;
  }

  dimension: compute_ms_max {
    type: number
    sql: ${TABLE}.compute_ms_max ;;
  }

  dimension: write_ratio_avg {
    type: number
    sql: ${TABLE}.write_ratio_avg ;;
  }

  dimension: write_ms_avg {
    type: number
    sql: ${TABLE}.write_ms_avg ;;
  }

  dimension: write_ratio_max {
    type: number
    sql: ${TABLE}.write_ratio_max ;;
  }

  dimension: write_ms_max {
    type: number
    sql: ${TABLE}.write_ms_max ;;
  }

  dimension: shuffle_output_bytes {
    type: number
    sql: ${TABLE}.shuffle_output_bytes ;;
  }

  measure: total_shuffle_output_bytes {
    type: sum
    sql: ${shuffle_output_bytes} ;;
  }

  dimension: shuffle_output_bytes_spilled {
    type: number
    sql: ${TABLE}.shuffle_output_bytes_spilled ;;
  }

  measure: total_shuffle_output_bytes_spilled {
    type: sum
    sql: ${shuffle_output_bytes_spilled} ;;
  }

  measure: total_shuffle_output_gibibytes_spilled {
    type: sum
    label: "Shuffle GB Spilled"
    sql: ${shuffle_output_bytes_spilled} / (1024*1024*1024) ;;
    value_format_name: decimal_2
  }

  dimension: records_read {
    type: number
    sql: ${TABLE}.records_read ;;
  }

  dimension: records_written {
    type: number
    sql: ${TABLE}.records_written ;;
  }

  dimension: parallel_inputs {
    type: number
    sql: ${TABLE}.parallel_inputs ;;
  }

  dimension: completed_parallel_inputs {
    type: number
    sql: ${TABLE}.completed_parallel_inputs ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: steps {
    type: string
    hidden: yes
    sql: ${TABLE}.steps ;;
  }

  dimension: slot_ms {
    type: number
    sql: ${TABLE}.slot_ms ;;
  }

  measure: total_shuffles {
    type: sum
    sql: ${shuffle_output_bytes} ;;
    value_format_name: decimal_2
  }

  measure: total_slot_ms {
    type: sum
    sql: ${slot_ms} ;;
  }

#   set: detail {
#     fields: [
#       name,
#       id,
#       start_ms,
#       end_ms,
#       input_stages,
#       wait_ratio_avg,
#       wait_ms_avg,
#       wait_ratio_max,
#       wait_ms_max,
#       read_ratio_avg,
#       read_ms_avg,
#       read_ratio_max,
#       read_ms_max,
#       compute_ratio_avg,
#       compute_ms_avg,
#       compute_ratio_max,
#       compute_ms_max,
#       write_ratio_avg,
#       write_ms_avg,
#       write_ratio_max,
#       write_ms_max,
#       shuffle_output_bytes,
#       shuffle_output_bytes_spilled,
#       records_read,
#       records_written,
#       parallel_inputs,
#       completed_parallel_inputs,
#       status,
#       steps,
#       slot_ms
#     ]
#   }
}
