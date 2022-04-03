view: line_sunsusong {
  derived_table: {
    sql: WITH bm_card_subway_ver2 AS (SELECT * FROM `mzcdsc-team-200716.project_a_team.bm_f_card_subway_dd`
      )
SELECT
    bm_card_subway_ver2.subway_line_nm  AS bm_card_subway_ver2_subway_line_nm,
        (bm_card_subway_ver2.dt ) AS bm_card_subway_ver2_dt,
    COALESCE(SUM(bm_card_subway_ver2.clean_transported_cnt ), 0) AS bm_card_subway_ver2_sunsusong,
    COALESCE(SUM(bm_card_subway_ver2.foot_traffic_cnt ), 0) AS bm_card_subway_ver2_yudong,
    COALESCE(SUM(bm_card_subway_ver2.passenger_cnt ), 0) AS bm_card_subway_ver2_in,
    COALESCE(SUM(bm_card_subway_ver2.getoff_passenger_cnt ), 0) AS bm_card_subway_ver2_out
FROM bm_card_subway_ver2
GROUP BY
    1,
    2
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: bm_card_subway_ver2_subway_line_nm {
    type: string
    sql: ${TABLE}.bm_card_subway_ver2_subway_line_nm ;;
  }

  dimension: bm_card_subway_ver2_dt {
    type: date
    datatype: date
    sql: ${TABLE}.bm_card_subway_ver2_dt ;;
  }

  dimension: bm_card_subway_ver2_sunsusong {
    type: number
    label: "호선별 순수송인원수"
    sql: ${TABLE}.bm_card_subway_ver2_sunsusong ;;
  }

  dimension: bm_card_subway_ver2_yudong {
    type: number
    sql: ${TABLE}.bm_card_subway_ver2_yudong ;;
  }

  dimension: bm_card_subway_ver2_in {
    type: number
    sql: ${TABLE}.bm_card_subway_ver2_in ;;
  }

  dimension: bm_card_subway_ver2_out {
    type: number
    sql: ${TABLE}.bm_card_subway_ver2_out ;;
  }

  set: detail {
    fields: [
      bm_card_subway_ver2_subway_line_nm,
      bm_card_subway_ver2_dt,
      bm_card_subway_ver2_sunsusong,
      bm_card_subway_ver2_yudong,
      bm_card_subway_ver2_in,
      bm_card_subway_ver2_out
    ]
  }
}
