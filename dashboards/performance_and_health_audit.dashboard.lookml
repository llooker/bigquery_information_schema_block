- dashboard: performance_and_health_audit
  title: Performance and Health Audit
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: Average Slot Utilization by Hour of Day and Day of Week
    name: Average Slot Utilization by Hour of Day and Day of Week
    model: bigquery_performance_monitoring_by_project
    explore: jobs_timeline_by_project
    type: looker_line
    fields: [jobs_timeline_by_project.period_start_hour_of_day, jobs_timeline_by_project.period_start_day_of_week,
      jobs_timeline_by_project.slots_per_30_days_hour]
    pivots: [jobs_timeline_by_project.period_start_day_of_week]
    fill_fields: [jobs_timeline_by_project.period_start_day_of_week, jobs_timeline_by_project.period_start_hour_of_day]
    filters:
      jobs_timeline_by_project.job_creation_time_date: 30 days
    sorts: [jobs_timeline_by_project.period_start_day_of_week 0]
    limit: 1440
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    color_application:
      collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
      palette_id: dd87bc4e-d86f-47b1-b0fd-44110dc0b469
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_types: {}
    series_labels:
      jobs_timeline_by_project.period_start_hour_of_day: Hour of Day
      jobs_timeline_by_project.total_slot_hours: Slots Used
      jobs_timeline_by_project.period_start_day_of_week: Day of Week
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      jobs_timeline_by_project.total_slot_hours:
        is_active: false
      jobs_timeline_by_project.period_start_hour_of_day:
        is_active: false
    series_text_format:
      jobs_timeline_by_project.period_start_hour_of_day:
        bold: true
      jobs_timeline_by_project.period_start_day_of_week:
        bold: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#173589",
        font_color: !!null '', color_application: {collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5,
          palette_id: 46a4b248-19f7-4e71-9cf0-59fcc2c3039e, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    defaults_version: 1
    hidden_fields: []
    listen: {}
    row: 29
    col: 0
    width: 24
    height: 6
  - title: GB Spilled
    name: GB Spilled
    model: bigquery_performance_monitoring_by_project
    explore: jobs_by_project_raw
    type: single_value
    fields: [jobs_by_project_raw__job_stages.total_shuffle_output_gibibytes_spilled]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Shuffle GB Spilled to Disk
    comparison_label: vs Previous Period
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    listen:
      Reporting Period: jobs_by_project_raw.creation_date
    row: 2
    col: 16
    width: 8
    height: 4
  - title: GB Processed
    name: GB Processed
    model: bigquery_performance_monitoring_by_project
    explore: jobs_by_project_raw
    type: single_value
    fields: [jobs_by_project_raw.total_gb_processed]
    sorts: [jobs_by_project_raw.total_gb_processed desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: GB Processed This Period
    value_format: 0.00,,"M"
    comparison_label: vs Previous
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    listen:
      Reporting Period: jobs_by_project_raw.creation_date
    row: 2
    col: 0
    width: 8
    height: 4
  - title: Power Users
    name: Power Users
    model: bigquery_performance_monitoring_by_project
    explore: jobs_by_project_raw
    type: looker_grid
    fields: [jobs_by_project_raw.count_of_jobs, jobs_by_project_raw.total_gb_processed,
      jobs_by_project_raw.user_email, jobs_by_project_raw.average_duration_seconds]
    sorts: [jobs_by_project_raw.total_gb_processed desc]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
      palette_id: dd87bc4e-d86f-47b1-b0fd-44110dc0b469
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      jobs_by_project_raw.count_of_jobs: Total Jobs
      jobs_by_project_raw.total_gb_processed: GB Processed
      jobs_by_project_raw.average_gb_processed: Avg GB processed
      jobs_by_project_raw.average_slot_utilization: Avg Slots Used
      jobs_by_project_raw.average_duration_seconds: Avg Duration (sec)
    series_column_widths: {}
    series_cell_visualizations:
      jobs_by_project_raw.total_gb_processed:
        is_active: false
        palette:
          palette_id: 46a4b248-19f7-4e71-9cf0-59fcc2c3039e
          collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
        value_display: false
      jobs_by_project_raw.average_slot_utilization:
        is_active: true
        palette:
          palette_id: 471a8295-662d-46fc-bd2d-2d0acd370c1e
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      jobs_by_project_raw.count_of_jobs:
        is_active: false
        palette:
          palette_id: 46a4b248-19f7-4e71-9cf0-59fcc2c3039e
          collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
      jobs_by_project_raw.average_duration_seconds:
        is_active: true
    conditional_formatting: []
    series_value_format:
      jobs_by_project_raw.total_gb_processed:
        name: decimal_4
        format_string: "#,##0.0000"
        label: Decimals (4)
      jobs_by_project_raw.average_slot_utilization:
        name: percent_2
        format_string: "#,##0.00%"
        label: Percent (2)
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 23
    col: 13
    width: 11
    height: 6
  - title: GB Processed by Hour of Day and Day of Week
    name: GB Processed by Hour of Day and Day of Week
    model: bigquery_performance_monitoring_by_project
    explore: jobs_by_project_raw
    type: looker_line
    fields: [jobs_by_project_raw.total_gb_processed, jobs_by_project_raw.creation_hour_of_day,
      jobs_by_project_raw.creation_day_of_week]
    pivots: [jobs_by_project_raw.creation_day_of_week]
    fill_fields: [jobs_by_project_raw.creation_day_of_week, jobs_by_project_raw.creation_hour_of_day]
    sorts: [jobs_by_project_raw.creation_day_of_week]
    limit: 1440
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    color_application:
      collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
      palette_id: dd87bc4e-d86f-47b1-b0fd-44110dc0b469
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_types: {}
    series_labels:
      jobs_by_project_raw.creation_time_hour_of_day: Hour of Day
      jobs_by_project_raw.average_slot_utilization: Slots Used
      jobs_by_project_raw.creation_time_day_of_week: Day of Week
      jobs_by_project_raw.average_slots_used: Slots Used
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      jobs_by_project_raw.average_slot_utilization:
        is_active: false
      jobs_by_project_raw.creation_time_hour_of_day:
        is_active: false
    series_text_format:
      jobs_by_project_raw.creation_time_hour_of_day:
        bold: true
      jobs_by_project_raw.creation_time_day_of_week:
        bold: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#173589",
        font_color: !!null '', color_application: {collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5,
          palette_id: 46a4b248-19f7-4e71-9cf0-59fcc2c3039e, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    defaults_version: 1
    listen: {}
    row: 35
    col: 0
    width: 24
    height: 6
  - title: Slots Used, Duration, Bytes Spilled, GB Processed by Jobs
    name: Slots Used, Duration, Bytes Spilled, GB Processed by Jobs
    model: bigquery_performance_monitoring_by_project
    explore: jobs_by_project_raw
    type: looker_grid
    fields: [jobs_by_project_raw.job_id, jobs_by_project_raw.user_email,
      jobs_by_project_raw.query_total_slot, jobs_by_project_raw.duration_seconds,
      jobs_by_project_raw.total_gb_processed]
    filters:
      jobs_by_project_raw.creation_date: 30 days
    sorts: [jobs_by_project_raw.total_gb_processed desc]
    limit: 20
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
      palette_id: dd87bc4e-d86f-47b1-b0fd-44110dc0b469
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      jobs_by_project_raw.query_total_slot: Slots Used
      jobs_by_project_raw.total_gb_processed: Total GB
      jobs_by_project_raw.duration_seconds: Duration (Sec)
      jobs_by_project_raw.sum_shuffle_output_bytes_spilled: Bytes Spilled
    series_column_widths: {}
    series_cell_visualizations:
      jobs_by_project_raw.total_gb_processed:
        is_active: false
        palette:
          palette_id: 46a4b248-19f7-4e71-9cf0-59fcc2c3039e
          collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
        value_display: false
      jobs_by_project_raw.average_slot_utilization:
        is_active: false
        palette:
          palette_id: b477b8ad-b459-06b8-fe09-47fc095a7e86
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - "#27fa1a"
          - "#6ede13"
          - "#cdd61f"
          - "#bf881e"
          - "#c21816"
      jobs_by_project_raw.query_total_slot:
        is_active: true
        palette:
          palette_id: 46a4b248-19f7-4e71-9cf0-59fcc2c3039e
          collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
      jobs_by_project_raw.duration_ms:
        is_active: true
        palette:
          palette_id: 46a4b248-19f7-4e71-9cf0-59fcc2c3039e
          collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
      jobs_by_project_raw.duration_seconds:
        is_active: true
        palette:
          palette_id: 46a4b248-19f7-4e71-9cf0-59fcc2c3039e
          collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#173589",
        font_color: !!null '', color_application: {collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5,
          palette_id: 46a4b248-19f7-4e71-9cf0-59fcc2c3039e, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: []}]
    series_value_format:
      jobs_by_project_raw.total_gb_processed:
        name: decimal_4
        format_string: "#,##0.0000"
        label: Decimals (4)
      jobs_by_project_raw.average_slot_utilization:
        name: decimal_4
        format_string: "#,##0.0000"
        label: Decimals (4)
      jobs_by_project_raw.query_total_slot:
        name: decimal_2
        format_string: "#,##0.00"
        label: Decimals (2)
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    hidden_fields:
    listen: {}
    row: 23
    col: 0
    width: 13
    height: 6
  - title: New Tile
    name: New Tile
    model: bigquery_performance_monitoring_by_project
    explore: jobs_by_project_raw
    type: single_value
    fields: [jobs_by_project_raw.count_cached_queries]
    sorts: [jobs_by_project_raw.count_cached_queries desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Queries Cached
    comparison_label: vs Previous Period
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    listen:
      Reporting Period: jobs_by_project_raw.creation_date
    row: 2
    col: 8
    width: 8
    height: 4
  - name: BigQuery Monitoring
    type: text
    title_text: BigQuery Monitoring
    subtitle_text: How much is being consumed?
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  filters:
  - name: Reporting Period
    title: Reporting Period
    type: date_filter
    default_value: 6 hours
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
