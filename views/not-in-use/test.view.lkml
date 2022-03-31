view: test {
  sql_table_name: `project_a_team.test`
    ;;

  dimension_group: dt {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dt ;;
  }

  dimension: get {
    type: number
    sql: ${TABLE}.get ;;
  }

  dimension: gett_off_gb {
    type: number
    sql: ${TABLE}.gett_off_gb ;;
  }

  dimension: passenger_info_gb {
    type: string
    sql: ${TABLE}.passenger_info_gb ;;
  }

  dimension: station_nm {
    type: string
    sql: ${TABLE}.station_nm ;;
  }

  dimension: station_no {
    type: number
    sql: ${TABLE}.station_no ;;
  }

  dimension: subway_route_nm {
    type: number
    sql: ${TABLE}.subway_route_nm ;;
  }

  dimension: tm_dt {
    type: string
    sql: ${TABLE}.tm_dt ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
