view: january {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'bm_d_holiday_dt.dt_date'


      SELECT
      (bm_d_holiday_dt.dt ) AS bm_d_holiday_dt_dt_date,
      COALESCE(SUM(bm_f_passenger_subway_dd.foot_traffic_cnt ), 0) AS foot_traffic


      FROM `project_a_team.bm_f_passenger_subway_dd`
      AS bm_f_passenger_subway_dd
      LEFT JOIN `project_a_team.bm_d_holiday_dt`
      AS bm_d_holiday_dt ON bm_d_holiday_dt.dt = bm_f_passenger_subway_dd.dt
      WHERE ((((( bm_d_holiday_dt.dt  )) >= (DATE('2022-01-01')) AND (( bm_d_holiday_dt.dt  )) < (DATE('2022-01-31')))))
      GROUP BY
      1
      ORDER BY
      1

      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: bm_d_holiday_dt_dt_date {
    type: date
    datatype: date
    sql: ${TABLE}.bm_d_holiday_dt_dt_date ;;
  }

  dimension: bm_f_passenger_subway_dd_foot_traffic_cnt {
    type: number
    sql: ${TABLE}.foot_traffic ;;
  }

  # dimension: bm_f_passenger_subway_dd_passenger_cnt {
  #   type: number
  #   sql: ${TABLE}.bm_f_passenger_subway_dd_passenger_cnt ;;
  # }

  # dimension: bm_f_passenger_subway_dd_getoff_passenger_cnt {
  #   type: number
  #   sql: ${TABLE}.bm_f_passenger_subway_dd_getoff_passenger_cnt ;;
  # }

  # dimension: bm_f_passenger_subway_dd_clean_transported_cnt {
  #   type: number
  #   sql: ${TABLE}.bm_f_passenger_subway_clean_transported_cnt ;;
  # }

  set: detail {
    fields: [bm_d_holiday_dt_dt_date, bm_f_passenger_subway_dd_foot_traffic_cnt]
  }
}
