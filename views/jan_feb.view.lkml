view: jan_feb {
  derived_table: {
    sql: WITH january AS (-- raw sql results do not include filled-in values for 'bm_d_holiday_dt.dt_date'


      SELECT
      (bm_d_holiday_dt.dt ) AS bm_d_holiday_dt_dt_date,
      COALESCE(SUM(bm_f_passenger_subway_dd.foot_traffic_cnt ), 0) AS bm_f_passenger_subway_dd_foot_traffic_cnt
      FROM `project_a_team.bm_f_passenger_subway_dd`
      AS bm_f_passenger_subway_dd
      LEFT JOIN `project_a_team.bm_d_holiday_dt`
      AS bm_d_holiday_dt ON bm_d_holiday_dt.dt = bm_f_passenger_subway_dd.dt
      WHERE ((((( bm_d_holiday_dt.dt  )) >= (DATE('2022-01-01')) AND (( bm_d_holiday_dt.dt  )) < (DATE('2022-01-31')))))
      GROUP BY
      1
      ORDER BY
      1

      )
      SELECT
      (january.bm_d_holiday_dt_dt_date ) AS january_bm_d_holiday_dt_dt_date,
      (bm_f_passenger_subway_dd.dt ) AS bm_f_passenger_subway_dd_dt_date,
      january.bm_f_passenger_subway_dd_foot_traffic_cnt  AS january_bm_f_passenger_subway_dd_foot_traffic_cnt,
      COALESCE(SUM(bm_f_passenger_subway_dd.foot_traffic_cnt ), 0) AS bm_f_passenger_subway_dd_foot_traffic_cnt
      FROM `project_a_team.bm_f_passenger_subway_dd`
      AS bm_f_passenger_subway_dd
      LEFT JOIN january ON january.bm_d_holiday_dt_dt_date + interval 1 month = bm_f_passenger_subway_dd.dt
      GROUP BY
      1,
      2,
      3
      ORDER BY
      1 DESC

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

  dimension: january_bm_d_holiday_dt_dt_date {
    type: date
    datatype: date
    sql: ${TABLE}.january_bm_d_holiday_dt_dt_date ;;
  }

  dimension: bm_f_passenger_subway_dd_dt_date {
    type: date
    datatype: date
    sql: ${TABLE}.bm_f_passenger_subway_dd_dt_date ;;
  }

  dimension: january_bm_f_passenger_subway_dd_foot_traffic_cnt {
    type: number
    sql: ${TABLE}.january_bm_f_passenger_subway_dd_foot_traffic_cnt ;;
  }

  dimension: bm_f_passenger_subway_dd_foot_traffic_cnt {
    type: number
    sql: ${TABLE}.bm_f_passenger_subway_dd_foot_traffic_cnt ;;
  }

  set: detail {
    fields: [january_bm_d_holiday_dt_dt_date, bm_f_passenger_subway_dd_dt_date, january_bm_f_passenger_subway_dd_foot_traffic_cnt, bm_f_passenger_subway_dd_foot_traffic_cnt]
  }
}
