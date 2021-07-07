
# This is a multi-fact explore to support qureies that include, e.g. both reservations and jobs metrics codimensioned by project
#
# Note: Date is not a supported codimension, since only jobs has a date dimension. As of 2020-05, capacity commitments and reservatoins
#       do not support historical states. The relevant change tables do provide some information about recent changes, but not enough
#       to reconstruct a historical state.

include: "/views/reservations/capacity_commitments.view.lkml"
include: "/views/reservations/reservations.view.lkml"
include: "/views/jobs.view.lkml"

view: none {
  derived_table: {
    sql: SELECT NULL FROM UNNEST([])  ;;
  }
}

explore: all {
  from: none

  join: capacity_commitments {
    relationship: one_to_one
    type: full_outer
    sql_on: FALSE ;;
  }
  join: reservations {
    relationship: one_to_one
    type: full_outer
    sql_on: FALSE ;;
  }
  join: jobs {
    relationship: one_to_one
    type: full_outer
    sql_on: FALSE ;;
  }


  # Codimension views

  join: project_id {
    type: cross
    relationship: one_to_one
  }

}

view: project_id {
  label: "Project"
  sql_table_name: UNNEST([COALESCE(
    {% if jobs._in_query %} jobs.project_id, {% endif %}
    {% if capacity_commitments._in_query %} capacity_commitments.project_id, {% endif %}
    {% if reservations._in_query %} reservations.project_id, {% endif %}
    NULL
    )]) ;;

    dimension: _info {
      label: "[View Info]"
      sql: NULL ;; #This field is for information/description only
      description: "This view is a codimension view. It does not list projects on its own. Instead it will show the projects associated with any other views in your query (e.g. commitments, jobs, reservations, etc)"
    }

    dimension: project_id {
      label: "Project ID"
      sql: ${TABLE} ;;
    }

}

# view: admin_project_id {
#   # It will be helpful to have multiple project fields, since some views are associated with multiple projects in different ways
#   # e.g. assignments have both the admin/billing project ID, and sometimes an assignee project ID
#   # Job table scan steps might have both a job project ID and a table project ID

#   label: "Project"
#   sql_table_name: UNNEST([COALESCE(
#     {% if capacity_commitments._in_query %} capacity_commitments.project_id, {% endif %}
#     {% if reservations._in_query %} reservations.project_id, {% endif %}
#     NULL
#     )]) ;;

#   dimension: admin_project_id {
#     label: "Admin Project ID"
#     sql: ${TABLE} ;;
#   }
# }
