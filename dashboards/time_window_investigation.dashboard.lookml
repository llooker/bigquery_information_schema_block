- dashboard: time_window_investigation
  title: Time Window Investigation
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: GB Processed
    name: GB Processed
    model: bigquery_performance_monitoring_by_project
    explore: jobs_by_project_raw
    type: single_value
    fields: [jobs_by_project_raw.total_gb_processed, jobs_by_project_raw__job_stages.total_shuffle_output_gibibytes_spilled]
    sorts: [jobs_by_project_raw.total_gb_processed desc]
    limit: 500
    dynamic_fields: [{table_calculation: percent_of_gb_shuffled, label: Percent of
          GB Shuffled, expression: "${jobs_by_project_raw__job_stages.total_shuffle_output_gibibytes_spilled}/${jobs_by_project_raw.total_gb_processed}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: GB Processed
    value_format: '#,##0.0,"K"'
    comparison_label: of GB Shuffled to Disk
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
    hidden_fields: [jobs_by_project_raw__job_stages.total_shuffle_output_gibibytes_spilled]
    row: 2
    col: 0
    width: 11
    height: 4
  - title: New Tile
    name: New Tile
    model: bigquery_performance_monitoring_by_project
    explore: jobs_by_project_raw
    type: single_value
    fields: [jobs_by_project_raw.count_cached_queries, jobs_by_project_raw.percent_of_queries_cached]
    sorts: [jobs_by_project_raw.count_cached_queries desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Queries Cached
    comparison_label: of Total Queries
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
    row: 2
    col: 13
    width: 11
    height: 4
  - name: BigQuery Monitoring
    type: text
    title_text: BigQuery Monitoring
    subtitle_text: How much is being consumed?
    body_text: Links to Documentation
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Slots Used by Project
    name: Slots Used by Project
    model: bigquery_performance_monitoring_by_project
    explore: jobs_timeline_by_project
    type: looker_area
    fields: [jobs_timeline_by_project.period_start_minute5, jobs_timeline_by_project.total_slot_5minutes,
      jobs_timeline_by_project.project_id]
    pivots: [jobs_timeline_by_project.project_id]
    fill_fields: [jobs_timeline_by_project.period_start_minute5]
    filters: {}
    sorts: [jobs_timeline_by_project.period_start_minute5 desc, jobs_timeline_by_project.project_id]
    limit: 500
    query_timezone: America/Los_Angeles
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    defaults_version: 1
    row: 13
    col: 0
    width: 24
    height: 6
  - title: Query Concurrency
    name: Query Concurrency
    model: bigquery_performance_monitoring_by_project
    explore: concurrency_per_second
    type: looker_line
    fields: [concurrency_per_second.timestamp_minute5, concurrency_per_second.avg_running,
      concurrency_per_second.max_running, concurrency_per_second.max_pending]
    filters:
      concurrency_per_second.timestamp_minute5: 6 hours
    sorts: [concurrency_per_second.timestamp_minute5 desc]
    limit: 500
    query_timezone: America/Los_Angeles
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
    row: 19
    col: 0
    width: 24
    height: 7
  - name: Slots vs Commitments
    title: Slots vs Commitments
    model: bigquery_performance_monitoring_by_project
    explore: timeline_with_commits
    type: looker_line
    fields: [timeline_with_commits.period_start_minute5, timeline_with_commits.total_slot_5minutes,
      commit_facts.annual_commit, commit_facts.flex_commit, commit_facts.monthly_commit]
    fill_fields: [timeline_with_commits.period_start_minute5]
    filters: {}
    sorts: [timeline_with_commits.period_start_minute5 desc]
    limit: 500
    query_timezone: America/Los_Angeles
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: !!null '', orientation: left, series: [{axisId: commit_facts.annual_commit,
            id: commit_facts.annual_commit, name: Annual Commit}, {axisId: commit_facts.flex_commit,
            id: commit_facts.flex_commit, name: Flex Commit}, {axisId: commit_facts.monthly_commit,
            id: commit_facts.monthly_commit, name: Monthly Commit}, {axisId: timeline_with_commits.total_slot_5minutes,
            id: timeline_with_commits.total_slot_5minutes, name: Slots Used by 5 Minutes}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types:
      timeline_with_commits.total_slot_5minutes: column
    defaults_version: 1
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Reporting Period: timeline_with_commits.job_creation_time_date
    row: 6
    col: 0
    width: 24
    height: 7
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
