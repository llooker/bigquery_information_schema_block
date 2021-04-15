view: date {
  view_label: "[Date]"

  filter: view_description {
    label: "(info) -➤"
    description: "This is a dynamic view. These fields do not list dates on their own, only in conjunction with one or more tables (e.g., the dates of activity in Pinger Events and/or Zendesk Tickets, if events and/or tickets are in your query)"
    sql: TRUE /*This field is just a description, not useful in a query */;;
  }

  derived_table: {
    sql:
    SELECT d
    -- Test: {% if date.date_filter._is_filtered %} true {% else %} false {% endif %}
    FROM UNNEST(GENERATE_TIMESTAMP_ARRAY(
      {% date_start date_filter %},
      {% date_end date_filter %},
      {% if date.__millisecond100._is_selected %} INTERVAL 100 MILLISECOND {%
      elsif date.__second._is_selected         %} INTERVAL 1 SECOND {%
      elsif date.__minute._is_selected         %} INTERVAL 1 MINUTE {%
      elsif date.__minute5._is_selected        %} INTERVAL 5 MINUTE {%
      elsif date.__minute15._is_selected       %} INTERVAL 15 MINUTE {%
      elsif date.__hour._is_selected           %} INTERVAL 1 HOUR {%
      elsif date.__day._is_selected            %} INTERVAL 1 DAY {%
      else                                 %} INTERVAL 1000 DAY {%
      endif %}
      )) AS d
    ;;
  }

  filter: date_filter {
    type: date_time #TODO: Confirm this ok, if not revert to date
    datatype: timestamp
    label: "Date Limit"
    hidden: yes # For use with always_filter
    sql: COALESCE({% condition %} ${TABLE} {% endcondition %},TRUE);; # True if null, i.e. applied to a row with no date column
  }
  dimension_group: _ {
    type: time
    datatype: timestamp
    sql: ${TABLE} ;;
    timeframes: [date,hour,minute15,minute5,minute,second,millisecond100,raw]
  }
  dimension_group: _parts_of{
    type: time
    datatype: timestamp
    sql: ${TABLE} ;;
    timeframes: [quarter_of_year,month_name,week_of_year, day_of_month, day_of_week, hour_of_day]
  }
  dimension: days_ago {
    # Temporary workaround since date functions in custom fields are kinda wonky at the moment
    # https://dig.looker.com/t/custom-fields-holy-shit/3519/2?u=fabio
    hidden: yes
    type: number
    sql: DATE_DIFF(CURRENT_DATE(),${__date}, DAY) ;;
  }
}
