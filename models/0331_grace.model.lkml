connection: "0331_grace"

# include all the views
include: "/views/**/*.view"

datagroup: 0331_grace_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: 0331_grace_default_datagroup

explore: bm_f_card_subway_dd {
  join: bm_d_holiday_dt {
    type: left_outer

    sql_on: ${bm_d_holiday_dt.dt_date} = ${bm_f_card_subway_dd.dt_date};;
    relationship: many_to_one

}
  join: line_sunsusong{
    type: left_outer
    relationship: many_to_one
    sql_on: ${bm_f_card_subway_dd.subway_line_nm} = ${line_sunsusong.bm_card_subway_ver2_subway_line_nm}
    AND ${bm_f_card_subway_dd.dt_date} = ${line_sunsusong.bm_card_subway_ver2_dt};;

  }
}


explore: january {}
explore: period {}
explore: bm_d_transfer_station {}

explore: bm_d_passenger_type_cd {}

explore: bm_d_holiday_dt {}

explore: bm_d_time_range_cd {}

explore: jan_feb {}

explore: bm_card_subway_ver2 {
  join: line_sunsusong{
    type: left_outer
    relationship: many_to_one
    sql_on: ${bm_card_subway_ver2.subway_line_nm} = ${line_sunsusong.bm_card_subway_ver2_subway_line_nm}
    AND ${bm_card_subway_ver2.dt} = ${line_sunsusong.bm_card_subway_ver2_dt};;
  }
}
explore: thisyear {
  join: jan_sub {
    type: left_outer
    sql_on: ${jan_sub.bm_f_passenger_subway_dd_dt_date} + interval 1 month = ${thisyear.bm_f_passenger_subway_dd_dt_date}
          AND ${jan_sub.bm_f_passenger_subway_dd_passenger_type_cd} = ${thisyear.bm_f_passenger_subway_dd_passenger_type_cd}
            ;;
    relationship: many_to_many}

}
explore: bm_f_passenger_subway_dd {

  join: bm_d_time_range_cd {
    type: left_outer

    sql_on: ${bm_d_time_range_cd.tm_range_cd} = ${bm_f_passenger_subway_dd.tm_range_cd} ;;
    relationship: many_to_one
  }

  join: bm_d_holiday_dt {
    type: left_outer

    sql_on: ${bm_d_holiday_dt.dt_date} = ${bm_f_passenger_subway_dd.dt_date};;
    relationship: many_to_one
  }

  join: bm_d_transfer_station {
    type: left_outer

    sql_on: ${bm_d_transfer_station.station_cd} = ${bm_f_passenger_subway_dd.station_cd};;
    relationship: many_to_one
  }

  join: bm_d_passenger_type_cd {
    type: left_outer

    sql_on: ${bm_d_passenger_type_cd.passenger_type_cd} = ${bm_f_passenger_subway_dd.passenger_type_cd};;
    relationship: many_to_one
  }
  join: january {
    type: left_outer
    sql_on: ${january.bm_d_holiday_dt_dt_date} + interval 1 month = ${bm_f_passenger_subway_dd.dt_date};;
    relationship: one_to_one

  }

  join: jan_passengertype {
    type: left_outer
    sql_on: ${jan_passengertype.bm_f_passenger_subway_dd_dt_date} + interval 1 month = ${bm_f_passenger_subway_dd.dt_date}
    ;;
    relationship: one_to_one

  }


}
