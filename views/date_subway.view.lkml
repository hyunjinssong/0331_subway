view: date_subway {
  derived_table: {
    sql: SELECT
          (bm_f_card_subway_dd.dt ) AS bm_f_card_subway_dd_dt_date,
          sum(bm_f_card_subway_dd.foot_traffic_cnt)  AS bm_f_card_subway_dd_foot_traffic_cnt,
          bm_f_card_subway_dd.station_nm  AS bm_f_card_subway_dd_station_nm
      FROM `project_a_team.bm_f_card_subway_dd`
           AS bm_f_card_subway_dd
      GROUP BY
          1,
          3
      ORDER BY
          1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: bm_f_card_subway_dd_dt_date {
    type: date
    datatype: date
    sql: ${TABLE}.bm_f_card_subway_dd_dt_date ;;
  }

  dimension: bm_f_card_subway_dd_foot_traffic_cnt {
    type: number
    sql: ${TABLE}.bm_f_card_subway_dd_foot_traffic_cnt/10000 ;;
  }

  dimension: bm_f_card_subway_dd_station_nm {
    type: string
    sql: ${TABLE}.bm_f_card_subway_dd_station_nm ;;
  }

  set: detail {
    fields: [bm_f_card_subway_dd_dt_date, bm_f_card_subway_dd_foot_traffic_cnt, bm_f_card_subway_dd_station_nm]
  }
}
