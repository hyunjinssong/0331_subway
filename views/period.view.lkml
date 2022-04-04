view: period {
  derived_table: {
    sql: SELECT
          (bm_f_passenger_subway_dd.dt ) AS bm_f_passenger_subway_dd_dt_date,
          bm_f_passenger_subway_dd.subway_line_cd  AS bm_f_passenger_subway_dd_subway_line_cd,
          "총승차인원수" as gubun,
          COALESCE(SUM(bm_f_passenger_subway_dd.passenger_cnt ), 0) AS cnt,
      FROM `project_a_team.bm_f_passenger_subway_dd`
           AS bm_f_passenger_subway_dd
      GROUP BY
          1,
          2

      UNION all

      SELECT
          (bm_f_passenger_subway_dd.dt ) AS bm_f_passenger_subway_dd_dt_date,
          bm_f_passenger_subway_dd.subway_line_cd  AS bm_f_passenger_subway_dd_subway_line_cd,
          "총하차인원수" as gubun,
          COALESCE(SUM(bm_f_passenger_subway_dd.getoff_passenger_cnt ), 0) AS cnt,
      FROM `project_a_team.bm_f_passenger_subway_dd`
           AS bm_f_passenger_subway_dd
      GROUP BY
          1,
          2

      UNION all

      SELECT
          (bm_f_passenger_subway_dd.dt ) AS bm_f_passenger_subway_dd_dt_date,
          bm_f_passenger_subway_dd.subway_line_cd  AS bm_f_passenger_subway_dd_subway_line_cd,
          "유동인원수" as gubun,
          COALESCE(SUM(bm_f_passenger_subway_dd.foot_traffic_cnt ), 0) AS cnt
      FROM `project_a_team.bm_f_passenger_subway_dd`
           AS bm_f_passenger_subway_dd
      GROUP BY
          1,
          2
      UNION all

      SELECT
          (bm_f_passenger_subway_dd.dt ) AS bm_f_passenger_subway_dd_dt_date,
          bm_f_passenger_subway_dd.subway_line_cd  AS bm_f_passenger_subway_dd_subway_line_cd,
          "순수송인원수" as gubun,
          COALESCE(SUM(bm_f_passenger_subway_dd.clean_transported_cnt ), 0) AS cnt
      FROM `project_a_team.bm_f_passenger_subway_dd`
           AS bm_f_passenger_subway_dd
      GROUP BY
          1,
          2

       ;;

  }

  dimension: bm_f_passenger_subway_dd_dt_date {
    type: date
    datatype: date
    sql: ${TABLE}.bm_f_passenger_subway_dd_dt_date ;;
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
    sql: case when ${TABLE}.bm_f_passenger_subway_dd_dt_date >= date({% parameter p_date_from%})
                   and ${TABLE}.bm_f_passenger_subway_dd_dt_date <= date({% parameter p_date_to%}) then "당기"
              when ${TABLE}.bm_f_passenger_subway_dd_dt_date >= date_sub(date({% parameter p_date_from%}), interval 1 month)
                   and ${TABLE}.bm_f_passenger_subway_dd_dt_date <= date_sub(date({% parameter p_date_to%}), interval 1 month) then "전기"
         end ;;
  }


  measure: cnt {
    type: sum
    sql: ${TABLE}.cnt ;;
  }

  dimension: gubun {
    type: string
    sql: ${TABLE}.gubun ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension: bm_f_passenger_subway_dd_subway_line_cd {
    type: string
    sql: ${TABLE}.bm_f_passenger_subway_dd_subway_line_cd ;;
  }

  dimension: bm_f_passenger_subway_dd_passenger_cnt {
    type: number
    sql: ${TABLE}.bm_f_passenger_subway_dd_passenger_cnt ;;
  }

  dimension: bm_f_passenger_subway_dd_getoff_passenger_cnt {
    type: number
    sql: ${TABLE}.bm_f_passenger_subway_dd_getoff_passenger_cnt ;;
  }

  dimension: bm_f_passenger_subway_dd_foot_traffic_cnt {
    type: number
    sql: ${TABLE}.bm_f_passenger_subway_dd_foot_traffic_cnt ;;
  }

  dimension: bm_f_passenger_subway_dd_clean_transported_cnt {
    type: number
    sql: ${TABLE}.bm_f_passenger_subway_dd_clean_transported_cnt ;;
  }

  set: detail {
    fields: [
      bm_f_passenger_subway_dd_dt_date,
      bm_f_passenger_subway_dd_subway_line_cd,
      bm_f_passenger_subway_dd_passenger_cnt,
      bm_f_passenger_subway_dd_getoff_passenger_cnt,
      bm_f_passenger_subway_dd_foot_traffic_cnt,
      bm_f_passenger_subway_dd_clean_transported_cnt
    ]
  }
}
