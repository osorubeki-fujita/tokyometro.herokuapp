require_relative 'add_change_to_db.rb'
load 'C:/RubyPj/rails_tokyo_metro_dev/lib/tokyo_metro.rb'

# db_add_train_times_of_zhmnty
# seed_train_operation_info_status
# db_add_train_times_of_namboku_line_meguro_and_later
# db_update_to_station_info_id_of_namboku_line_train_bound_for_musashi_kosugi

reset_train_types_20141118_0608

TokyoMetro::Factory::Scss::TrainType.make
