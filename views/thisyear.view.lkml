view: thisyear {
  derived_table: {
    sql: SELECT
          (bm_f_passenger_subway_dd.dt ) AS bm_f_passenger_subway_dd_dt_date,
          bm_f_passenger_subway_dd.passenger_type_cd  AS bm_f_passenger_subway_dd_passenger_type_cd,
          COALESCE(SUM(bm_f_passenger_subway_dd.passenger_cnt ), 0) AS bm_f_passenger_subway_dd_passenger_cnt,
          COALESCE(SUM(bm_f_passenger_subway_dd.getoff_passenger_cnt ), 0) AS bm_f_passenger_subway_dd_getoff_passenger_cnt,
          COALESCE(SUM(bm_f_passenger_subway_dd.foot_traffic_cnt ), 0) AS bm_f_passenger_subway_dd_foot_traffic_cnt,
          COALESCE(SUM(bm_f_passenger_subway_dd.clean_transported_cnt ), 0) AS bm_f_passenger_subway_dd_clean_transported_cnt
      FROM `project_a_team.bm_f_passenger_subway_dd`
           AS bm_f_passenger_subway_dd
      GROUP BY
          1,
          2
      ORDER BY
          1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: bm_f_passenger_subway_dd_dt_date {
    type: date
    datatype: date
    sql: ${TABLE}.bm_f_passenger_subway_dd_dt_date ;;
  }

  dimension: bm_f_passenger_subway_dd_passenger_type_cd {
    type: string
    sql: ${TABLE}.bm_f_passenger_subway_dd_passenger_type_cd ;;
  }

  measure: bm_f_passenger_subway_dd_passenger_cnt {
    type: sum
    sql: ${TABLE}.bm_f_passenger_subway_dd_passenger_cnt ;;
  }

  measure: bm_f_passenger_subway_dd_getoff_passenger_cnt {
    type: sum
    sql: ${TABLE}.bm_f_passenger_subway_dd_getoff_passenger_cnt ;;
  }

  measure: bm_f_passenger_subway_dd_foot_traffic_cnt {
    type: sum
    sql: ${TABLE}.bm_f_passenger_subway_dd_foot_traffic_cnt ;;
  }

  measure: bm_f_passenger_subway_dd_clean_transported_cnt {
    type: sum
    sql: ${TABLE}.bm_f_passenger_subway_dd_clean_transported_cnt ;;
  }

  set: detail {
    fields: [
      bm_f_passenger_subway_dd_dt_date,
      bm_f_passenger_subway_dd_passenger_type_cd,
      bm_f_passenger_subway_dd_passenger_cnt,
      bm_f_passenger_subway_dd_getoff_passenger_cnt,
      bm_f_passenger_subway_dd_foot_traffic_cnt,
      bm_f_passenger_subway_dd_clean_transported_cnt
    ]
  }
}
