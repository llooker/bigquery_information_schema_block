view: job_stages {

  sql_table_name: UNNEST(${jobs.SQL_TABLE_NAME}.job_stages) ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: ${jobs.job_id} || "-" || CAST(${stage_id} AS STRING) ;;
  }

  dimension: stage_id {
    label: "[ID]"
    description: "Unique ID for the stage within the plan."
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    label: "[Name]"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: input_stages {
    description: "IDs for stages that are inputs to this stage"
    type: string
    sql: TO_JSON_STRING(${TABLE}.input_stages) ;;
  }

  # Dimension group: start time {
  dimension: start_epoch_ms {
    group_label: "Start Date"
    description: "Stage start time represented as milliseconds since the epoch"
    type: number
    sql: ${TABLE}.start_ms ;;
  }
  dimension_group: start {
    description: "Stage start time represented as milliseconds since the epoch"
    type: time
    sql: TIMESTAMP_MILLIS(${start_epoch_ms}) ;;
    timeframes: [raw,time,time_of_day]
  }
  # }

  # Dimension group: end time {
  dimension: end_epoch_ms {
    group_label: "End Date"
    description: "Stage end time represented as milliseconds since the epoch."
    type: number
    sql: ${TABLE}.end_ms ;;
  }
  dimension_group: end {
    description: "Stage end time represented as milliseconds since the epoch"
    type: time
    sql: TIMESTAMP_MILLIS(${end_epoch_ms}) ;;
    timeframes: [raw,time,time_of_day]
  }
  # }

  dimension: wait_ratio_avg {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Wait Time"
    description: "Relative amount of time the average shard spent waiting to be scheduled"
    type: number
    sql: ${TABLE}.wait_ratio_avg ;;
  }

  dimension: wait_ms_avg {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Wait Time"
    description: "Milliseconds the average shard spent waiting to be scheduled"
    type: number
    sql: ${TABLE}.wait_ms_avg ;;
  }

  dimension: wait_ratio_max {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Wait Time"
    description: "Relative amount of time the slowest shard spent waiting to be scheduled"
    type: number
    sql: ${TABLE}.wait_ratio_max ;;
  }

  dimension: wait_ms_max {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Wait Time"
    description: "Milliseconds the slowest shard spent waiting to be scheduled"
    type: number
    sql: ${TABLE}.wait_ms_max ;;
  }

  dimension: read_ratio_avg {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Read Time"
    description: "Relative amount of time the average shard spent reading input"
    type: number
    sql: ${TABLE}.read_ratio_avg ;;
  }

  dimension: read_ms_avg {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Read Time"
    description: "Milliseconds the average shard spent reading input"
    type: number
    sql: ${TABLE}.read_ms_avg ;;
  }

  dimension: read_ratio_max {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Read Time"
    description: "Relative amount of time the slowest shard spent reading input"
    type: number
    sql: ${TABLE}.read_ratio_max ;;
  }

  dimension: read_ms_max {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Read Time"
    description: "Milliseconds the slowest shard spent reading input"
    type: number
    sql: ${TABLE}.read_ms_max ;;
  }

  dimension: compute_ratio_avg {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Compute Time"
    description: "Relative amount of time the average shard spent on CPU-bound tasks"
    type: number
    sql: ${TABLE}.compute_ratio_avg ;;
  }

  dimension: compute_ms_avg {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Compute Time"
    description: "Milliseconds the average shard spent on CPU-bound tasks"
    type: number
    sql: ${TABLE}.compute_ms_avg ;;
  }

  dimension: compute_ratio_max {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Compute Time"
    description: "Relative amount of time the slowest shard spent on CPU-bound tasks"
    type: number
    sql: ${TABLE}.compute_ratio_max ;;
  }

  dimension: compute_ms_max {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Compute Time"
    description: "Milliseconds the slowest shard spent on CPU-bound tasks"
    type: number
    sql: ${TABLE}.compute_ms_max ;;
  }

  dimension: write_ratio_avg {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Write Time"
    description: "Relative amount of time the average shard spent on writing output"
    type: number
    sql: ${TABLE}.write_ratio_avg ;;
  }

  dimension: write_ms_avg {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Write Time"
    description: "Milliseconds the average shard spent on writing output"
    type: number
    sql: ${TABLE}.write_ms_avg ;;
  }

  dimension: write_ratio_max {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Write Time"
    description: "Relative amount of time the slowest shard spent on writing output"
    type: number
    sql: ${TABLE}.write_ratio_max ;;
  }

  dimension: write_ms_max {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Write Time"
    description: "Milliseconds the slowest shard spent on writing output"
    type: number
    sql: ${TABLE}.write_ms_max ;;
  }

  dimension: shuffle_output_bytes {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Shuffle"
    description: "Total number of bytes written to shuffle"
    type: number
    sql: ${TABLE}.shuffle_output_bytes ;;
  }

  dimension: shuffle_spilled_bytes {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    group_label: "Shuffle"
    description: "Number of bytes written to shuffle and spilled to disk"
    type: number
    sql: ${TABLE}.shuffle_output_bytes_spilled ;;
  }

  dimension: records_read {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    description: "Number of records read into the stage"
    type: number
    sql: ${TABLE}.records_read ;;
  }

  dimension: records_written {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    description: "Number of records written by the stage"
    type: number
    sql: ${TABLE}.records_written ;;
  }

  dimension: slot_ms {
    hidden:  no # Usually would prefer measures, but with so many variations, custom measures will have to do for now
    label: "Slot ms"
    description: "Slot-milliseconds used by the stage"
    type: number
    sql: ${TABLE}.slot_ms ;;
  }

  dimension: parallel_inputs {
    description: "Number of parallel input segments to be processed"
    type: number
    sql: ${TABLE}.parallel_inputs ;;
  }

  dimension: completed_parallel_inputs {
    description: "Number of parallel input segments completed"
    type: number
    sql: ${TABLE}.completed_parallel_inputs ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  # Dimension Group: Step details {

  dimension: steps_json {
    group_label: "Steps"
    label: "All Steps (JSON)"
    description: "tabledata.list of operations within the stage in dependency order (approximately chronological)"
    type: string
    # hidden: yes
    sql: TO_JSON_STRING(${TABLE}.steps, true) ;;
  }

  dimension: steps {
    group_label: "Steps"
    label: "All Steps"
    description: "tabledata.list of operations within the stage in dependency order (approximately chronological)"
    type: string
    # hidden: yes
    sql: (
      SELECT STRING_AGG(
        step.kind || ": " || TO_JSON_STRING(step.substeps)
        , "\n"
        ORDER BY s ASC
      )
      FROM UNNEST(${TABLE}.steps) AS step WITH OFFSET s ) ;;
    html: <div style="white-space:pre-line">{{value}}</div> ;;
  }

  dimension: steps_collapsed {
    group_label: "Steps"
    label: "All Steps (Collapsed)"
    description: "tabledata.list of operations within the stage in dependency order (approximately chronological)"
    type: string
    # hidden: yes
    sql: ${steps} ;;
    html: <details><summary style="text-decoration:underline">{{name._value}}</summary><div style="white-space:pre-line">{{value}}</div></details> ;;

  }


  # }

  measure: count {
    type: count
    filters: [stage_id: "NOT NULL"]
    drill_fields: [detail*]
  }

  # Measure group: Shuffle {
  measure: total_shuffle_spilled_bytes {
    group_label: "Shuffle"
    label: "Total Shuffle Spilled Bytes"
    description: "Total number of bytes written to shuffle and spilled to disk"
    type: sum
    sql: ${shuffle_spilled_bytes} ;;
    drill_fields: [detail*]
  }

  measure: total_shuffle_spilled_gib {
    group_label: "Shuffle"
    label: "Total Shuffle Spilled GiB"
    description: "Total number of bytes written to shuffle and spilled to disk, in gigibytes (2^30 bytes)"
    type: number
    sql: ${total_shuffle_spilled_bytes} / (1024*1024*1024) ;;
    value_format_name: decimal_3
    drill_fields: [detail*]
  }

  measure: total_shuffle_output_bytes {
    hidden: yes # Larger units more practical
    group_label: "Shuffle"
    label: "Total Shuffle Bytes"
    description: "Total number of bytes written to shuffle"
    type: sum
    sql: ${shuffle_output_bytes} ;;
    drill_fields: [detail*]
  }

  measure: total_shuffle_output_gib {
    group_label: "Shuffle"
    label: "Total Shuffle GiB"
    description: "Total number of bytes written to shuffle, in gigibytes (2^30 bytes)"
    type: number
    sql: ${total_shuffle_output_bytes} / (1024*1024*1024) ;;
    value_format_name: decimal_3
    drill_fields: [detail*]
  }
  # }

  # Measure group: Records {

  measure: total_records_read {
    group_label: "Records"
    description: "Total number of records read across stages"
    type: sum
    sql: ${records_read} ;;
    drill_fields: [detail*]
  }

  measure: total_records_written {
    group_label: "Records"
    description: "Total number of records written across stages"
    type: sum
    sql: ${records_written} ;;
    drill_fields: [detail*]
  }

  # }

  measure: total_slot_ms {
    group_label: "Slots"
    label: "Total Slot ms"
    description: "Total of slot-milliseconds used across stages"
    type: sum
    sql: ${slot_ms} ;;
    drill_fields: [detail*]
  }


  set: detail {
    fields: [
      stage_id,
      steps_collapsed,
      start_time,
      wait_ms_max,
      read_ms_max,
      compute_ms_max,
      write_ms_max,
      shuffle_output_bytes,
      shuffle_spilled_bytes,
      records_read,
      records_written,
      slot_ms
    ]
  }
}
