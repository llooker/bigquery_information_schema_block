view: count_interval {
  derived_table: {
    sql: WITH
      raw_date_range as (
      SELECT
        EXTRACT(HOUR from timestamp AT TIME ZONE 'EST') as day,
        MOD(EXTRACT(DAYOFWEEK from timestamp AT TIME ZONE 'EST') + 5, 7) as dayofweek,
        EXTRACT(HOUR from timestamp AT TIME ZONE 'EST') as hour
      FROM UNNEST(GENERATE_TIMESTAMP_ARRAY(TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)) as timestamp)
      SELECT dayofweek,hour, count(*) as totalhours
      FROM raw_date_range r
      GROUP BY dayofweek, hour
      order by dayofweek, hour
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: dayofweek {
    type: number
    sql: ${TABLE}.dayofweek ;;
  }

  dimension: hour {
    type: number
    sql: ${TABLE}.hour ;;
  }

  dimension: totalhours {
    type: number
    sql: ${TABLE}.totalhours ;;
  }

  measure: max_total_hours {
    type: max
    sql: ${totalhours} ;;
  }

  set: detail {
    fields: [dayofweek, hour, totalhours]
  }
}
