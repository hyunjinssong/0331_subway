view: bm_f_passenger_subway_dd {
  sql_table_name: `project_a_team.bm_f_passenger_subway_dd`
    ;;

  measure: clean_transported_cnt {
    type: sum
    label: "순수송인원수"
    sql: ${TABLE}.clean_transported_cnt ;;
  }

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

  measure: foot_traffic_cnt {
    type: sum
    label: "유동인원수"
    sql: ${TABLE}.foot_traffic_cnt ;;
  }

  dimension: lastyear {
    type: date
    label: "전기"
    sql: Datesub(${dt_date}, interval 1 month) ;;
  }


  dimension: youdong {
    type: number
    label: "유동인원수"
    sql: ${TABLE}.foot_traffic_cnt ;;
  }

  measure: getoff_passenger_cnt {
    type: sum
    label: "총하차인원수"
    sql: ${TABLE}.getoff_passenger_cnt ;;
  }

  measure: passenger_cnt {
    type: sum
    label: "총승차인원수"
    sql: ${TABLE}.passenger_cnt ;;
  }

  dimension: passenger_type_cd {
    type: string
    sql: ${TABLE}.passenger_type_cd ;;
  }

  dimension: station_cd {
    type: string
    sql: ${TABLE}.station_cd ;;
  }

  dimension: subway_line_cd {
    type: string
    sql: ${TABLE}.subway_line_cd ;;
  }

  dimension: tm_range_cd {
    type: string
    sql: ${TABLE}.tm_range_cd ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
