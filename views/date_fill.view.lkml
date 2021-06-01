include: "/views/date.view.lkml"

# This view implements a datefill table, when needed, but still depends on separate "date" view for field references,
# so the two views should be combined with a bare join in an explore if date-fill functionality is required

view: date_fill {
  derived_table: {
    sql:
    SELECT d
    -- Test: {% if date.date_filter._is_filtered %} true {% else %} false {% endif %}
    FROM UNNEST(GENERATE_TIMESTAMP_ARRAY(
      {% date_start date.date_filter %},
      {% date_end date.date_filter %},
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
}
