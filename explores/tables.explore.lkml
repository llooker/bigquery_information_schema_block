include: "/views/tables.view.lkml"

include: "/views/columns.view.lkml"


explore: tables {
  view_label: "[Tables]"

  join: partition_columns {
    view_label: "Partition Column"
    from: columns
    type: left_outer
    relationship: one_to_many
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

}
