connection: "0331_grace"

# include all the views
include: "/views/**/*.view"

datagroup: 0331_grace_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: 0331_grace_default_datagroup

explore: bm_d_time_range_cd {}

explore: bw_card_subway_list {}

explore: bm_d_holiday_dt {}

explore: bw_passenger_subway_list {}

explore: bm_d_transfer_station {}

explore: bm_d_passenger_type_cd {}

explore: bm_f_card_subway_dd {}

explore: bm_f_passenger_subway_dd {}

explore: joey_bm_f_passenger_subway_dd {}

explore: test {}
