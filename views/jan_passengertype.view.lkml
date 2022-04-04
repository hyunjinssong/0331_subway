view: jan_passengertype {
  derived_table: {
    sql: SELECT
          (bm_f_passenger_subway_dd.dt ) AS bm_f_passenger_subway_dd_dt_date,
          bm_d_passenger_type_cd.passenger_type_nm  AS bm_d_passenger_type_cd_passenger_type_nm,
          COALESCE(SUM(bm_f_passenger_subway_dd.passenger_cnt ), 0) AS bm_f_passenger_subway_dd_passenger_cnt,
          COALESCE(SUM(bm_f_passenger_subway_dd.getoff_passenger_cnt ), 0) AS bm_f_passenger_subway_dd_getoff_passenger_cnt,
          COALESCE(SUM(bm_f_passenger_subway_dd.foot_traffic_cnt ), 0) AS bm_f_passenger_subway_dd_foot_traffic_cnt,
          COALESCE(SUM(bm_f_passenger_subway_dd.clean_transported_cnt ), 0) AS bm_f_passenger_subway_dd_clean_transported_cnt
      FROM `project_a_team.bm_f_passenger_subway_dd`
           AS bm_f_passenger_subway_dd
      LEFT JOIN `project_a_team.bm_d_passenger_type_cd`
           AS bm_d_passenger_type_cd ON bm_d_passenger_type_cd.passenger_type_cd = bm_f_passenger_subway_dd.passenger_type_cd
      WHERE ((( bm_f_passenger_subway_dd.dt  ) >= (DATE('2022-01-01')) AND ( bm_f_passenger_subway_dd.dt  ) < (DATE('2022-01-31'))))
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

  dimension: minus {
    type: number
    value_format_name: percent_2
    sql: (bm_f_passenger_subway_dd_foot_traffic_cnt *1.0/ january_bm_f_passenger_subway_dd_foot_traffic_cnt) -1 ;;
    html: {% if value > 0 %}
         <p style="color: #990000">▲  {{ rendered_value }}</p>
      {% elsif value < 0 %}
        <p style="color: #009900">▼  {{ rendered_value }}</p>
      {% else %}
        <p style="color: #000000">{{ rendered_value }}</p>
      {% endif %} ;;
  }

  dimension: bm_f_passenger_subway_dd_dt_date {
    type: date
    datatype: date
    sql: ${TABLE}.bm_f_passenger_subway_dd_dt_date ;;
  }

  dimension: bm_d_passenger_type_cd_passenger_type_nm {
    type: string
    sql: ${TABLE}.bm_d_passenger_type_cd_passenger_type_nm ;;
  }

  dimension: bm_d_passenger_type_cd {
    type: string
    sql: ${TABLE}.bm_d_passenger_type_cd ;;
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

  measure:lastyear_foot_traffic_cnt {
    type: sum
    sql: ${TABLE}.bm_f_passenger_subway_dd_foot_traffic_cnt ;;
  }

  dimension: bm_f_passenger_subway_dd_clean_transported_cnt {
    type: number
    sql: ${TABLE}.bm_f_passenger_subway_dd_clean_transported_cnt ;;
  }

  set: detail {
    fields: [
      bm_f_passenger_subway_dd_dt_date,
      bm_d_passenger_type_cd,
      bm_d_passenger_type_cd_passenger_type_nm,
      bm_f_passenger_subway_dd_passenger_cnt,
      bm_f_passenger_subway_dd_getoff_passenger_cnt,
      bm_f_passenger_subway_dd_foot_traffic_cnt,
      bm_f_passenger_subway_dd_clean_transported_cnt
    ]
  }
}
