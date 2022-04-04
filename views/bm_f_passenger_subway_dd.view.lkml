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


  parameter: p_date_from {
    view_label: "Date_Parameter"
    type: date
  }

  parameter: p_date_to {
    view_label: "Date_Parameter"
    type: date
  }

  dimension: period {
    type: string
    sql: case when ${dt_date} >= date({% parameter p_date_from%})
                  and ${dt_date} <= date({% parameter p_date_to%}) then "당기"
              when ${dt_date} >= date_dub({% parameter p_date_from%}}, interval 1 month)
                  and ${dt_date} <= date_sub(date({% parameter p_date_to%}), interval 1 month) then "전기"
        end ;;
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
