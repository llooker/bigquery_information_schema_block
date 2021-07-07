- dashboard: job_lookup_dashboard
  title: Job Lookup Dashboard
  layout: newspaper
  elements:
  - title: Job Stages
    name: Job Stages
    model: bigquery_information_schema
    explore: query_jobs
    type: looker_grid
    fields: [job_stages.name, job_stages.total_slot_ms,
      job_stages.total_shuffle_output_bytes]
    sorts: [job_stages.total_slot_ms desc]
    limit: 500
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
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      job_stages.total_slot_ms:
        is_active: true
      job_stages.total_shuffle_output_bytes:
        is_active: true
        value_display: true
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    listen:
      Job Id: jobs.job_id
    row: 3
    col: 0
    width: 24
    height: 8
  - title: New Tile
    name: New Tile
    model: bigquery_information_schema
    explore: query_jobs
    type: single_value
    fields: [jobs.user_email]
    sorts: [jobs.user_email]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Job Id: jobs.job_id
    row: 0
    col: 0
    width: 8
    height: 3
  - title: Total GiB Processed
    name: Total GiB Processed
    model: bigquery_information_schema
    explore: query_jobs
    type: single_value
    fields: [jobs.total_gb_processed]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Job Id: jobs.job_id
    row: 0
    col: 8
    width: 8
    height: 3
  - title: Bytes Spilled to Disk
    name: Bytes Spilled to Disk
    model: bigquery_information_schema
    explore: query_jobs
    type: single_value
    fields: [jobs.average_shuffle_output_bytes_spilled]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Job Id: jobs.job_id
    row: 0
    col: 16
    width: 8
    height: 3
  filters:
  - name: Job Id
    title: Job Id
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: bigquery_information_schema
    explore: query_jobs
    listens_to_filters: []
    field: jobs.job_id
