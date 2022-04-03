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
    label: "날짜"
    type: date
    datatype: date
    sql: ${TABLE}.dt ;;
  }

  dimension: subway_line_nm {
    label: "호선"
    type: string
    sql: ${TABLE}.subway_line_nm ;;
  }

  dimension: station_nm {
    label: "역명"
    type: string
    sql: ${TABLE}.station_nm ;;
  }

  dimension: passenger_cnt {
    type: number
    sql: ${TABLE}.passenger_cnt ;;
  }

  measure: in {
    type: sum
    label: "총승차인원수"
    sql: ${TABLE}.passenger_cnt ;;
  }

  measure: double_in {
    label: "전체 승차인원수"
    type: sum
    sql:${TABLE}.passenger_cnt ;;
  }

  dimension: getoff_passenger_cnt {
    type: number
    sql: ${TABLE}.getoff_passenger_cnt ;;
  }


  measure: out {
    type: sum
    label: "총하차인원수"
    sql: ${TABLE}.getoff_passenger_cnt ;;
  }

  dimension: foot_traffic_cnt {
    type: number
    sql: ${TABLE}.foot_traffic_cnt ;;
  }

  measure: yudong {
    type: sum
    label: "유동인원수"
    sql: ${TABLE}.foot_traffic_cnt ;;
  }

  dimension: clean_transported_cnt {
    type: number
    sql: ${TABLE}.clean_transported_cnt ;;
  }

  measure: sunsusong {
    type: sum
    label: "순수송인원수"
    sql: ${TABLE}.clean_transported_cnt ;;
  }

  # measure: sunsusong_rate {
  #   label: "수송분담율"
  #   type: number
  #   sql: ${clean_transported_cnt} / ${line_sunsusong.bm_card_subway_ver2_sunsusong};;
  #   value_format: "0%"
  # }
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
