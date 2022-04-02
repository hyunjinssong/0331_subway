view: bm_card_subway_ver2 {
  derived_table: {
    sql: SELECT * FROM `mzcdsc-team-200716.project_a_team.bm_f_card_subway_dd`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: dt {
    type: date
    datatype: date
    sql: ${TABLE}.dt ;;
  }

  dimension: subway_line_nm {
    type: string
    sql: ${TABLE}.subway_line_nm ;;
  }

  dimension: station_nm {
    type: string
    sql: ${TABLE}.station_nm ;;
  }

  dimension: passenger_cnt {
    type: number
    sql: ${TABLE}.passenger_cnt ;;
  }

  dimension: getoff_passenger_cnt {
    type: number
    sql: ${TABLE}.getoff_passenger_cnt ;;
  }

  dimension: foot_traffic_cnt {
    type: number
    sql: ${TABLE}.foot_traffic_cnt ;;
  }

  dimension: clean_transported_cnt {
    type: number
    sql: ${TABLE}.clean_transported_cnt ;;
  }

  set: detail {
    fields: [
      dt,
      subway_line_nm,
      station_nm,
      passenger_cnt,
      getoff_passenger_cnt,
      foot_traffic_cnt,
      clean_transported_cnt
    ]
  }
}
