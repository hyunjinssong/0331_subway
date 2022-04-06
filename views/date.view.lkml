view: date {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'date_subway.bm_f_card_subway_dd_dt_date'


      WITH date_subway AS (SELECT
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
      )
      SELECT
      (date_subway.bm_f_card_subway_dd_dt_date ) AS date_subway_bm_f_card_subway_dd_dt_date,
      COALESCE(SUM(CAST(date_subway.bm_f_card_subway_dd_foot_traffic_cnt AS FLOAT64)), 0) AS calculation
      FROM date_subway
      GROUP BY
      1
      ORDER BY
      1 DESC
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  dimension: id {
    primary_key: yes
    sql: ${TABLE}.date_subway_bm_f_card_subway_dd_dt_date ;;
  }
  dimension: date_subway_bm_f_card_subway_dd_dt_date {
    type: date
    datatype: date
    sql: ${TABLE}.date_subway_bm_f_card_subway_dd_dt_date ;;
  }

  dimension: calculation {
    type: number
    label: "역 전체 유동인구"
    sql: ${TABLE}.calculation/10000 ;;
  }

  set: detail {
    fields: [date_subway_bm_f_card_subway_dd_dt_date, calculation]
  }
}
