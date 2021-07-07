view: date {
  view_label: "[Date]"

  filter: view_description {
    label: "(info) -➤"
    description: "This is a co-dimension view. These fields combine the primary date dimensions from one or more tables (e.g., the job creation date in the jobs view, or the second-by-second period start in the jobs timeline view)"
    sql: TRUE /*This field is just a description, not useful in a query */;;
  }

  filter: date_filter {
    type: date_time
    datatype: timestamp
    label: "Date Limit"
    hidden: yes # For use with always_filter
    sql: COALESCE({% condition %} ${TABLE} {% endcondition %},TRUE);; # True if null, i.e. applied to a row with no date column
  }
  dimension_group: _ {
    type: time
    datatype: timestamp
    sql: ${TABLE} ;;
    timeframes: [week,date,hour,minute15,minute5,minute,second,millisecond100,raw]
  }
  dimension_group: _parts_of{
    type: time
    datatype: timestamp
    sql: ${TABLE} ;;
    timeframes: [day_of_week, hour_of_day]
  }
  dimension: days_ago {
    # Can be helpful in writing custom fields with flexible date logic, since date functions in custom fields are kinda wonky at the moment
    hidden: yes
    type: number
    sql: TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),${__date}, DAY) ;;
  }
}
