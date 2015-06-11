module RealTimeInfoProcessor

  private

  # @todo JSON::ParserError - A JSON text must at least contain two octets!
  def set_real_time_info_processor( railway_lines: @railway_lines )
    @real_time_info_processor = ::TokyoMetro::App::Renderer::RealTimeInfos.new( request , railway_lines )
  end

end

__END__

Started GET "/train_location/fukutoshin_line" for 127.0.0.1 at 2015-06-11 07:05:07 +0900
Processing by TrainLocationController#action_for_railway_line_page as HTML
  Parameters: {"railway_line"=>"fukutoshin_line"}
Completed 500 Internal Server Error in 2543ms (ActiveRecord: 0.0ms)

JSON::ParserError - A JSON text must at least contain two octets!:
  json (1.8.3) lib/json/common.rb:155:in `parse'
  tokyo_metro (0.6.2) lib/tokyo_metro/factory/get/api/meta_class/fundamental.rb:103:in `persed_json'
  tokyo_metro (0.6.2) lib/tokyo_metro/factory/get/api/meta_class/fundamental.rb:81:in `process_response'
  tokyo_metro (0.6.2) lib/tokyo_metro/factory/get/api/meta_class/fundamental.rb:51:in `get_data'
  tokyo_metro (0.6.2) lib/tokyo_metro/factory/get/api/data_search/train_location.rb:64:in `process'
  tokyo_metro (0.6.2) lib/tokyo_metro/api/train_location.rb:38:in `get'
  tokyo_metro (0.6.2) lib/tokyo_metro/app/renderer/real_time_infos/each_railway_line.rb:43:in `get_train_location_infos'
  tokyo_metro (0.6.2) lib/tokyo_metro/app/renderer/real_time_infos/each_railway_line.rb:9:in `initialize'
  tokyo_metro (0.6.2) lib/tokyo_metro/app/renderer/real_time_infos.rb:143:in `block in set_infos_of_each_railway_line'
  tokyo_metro (0.6.2) lib/tokyo_metro/app/renderer/real_time_infos.rb:142:in `set_infos_of_each_railway_line'
  tokyo_metro (0.6.2) lib/tokyo_metro/app/renderer/real_time_infos.rb:9:in `initialize'
  app/controllers/concerns/real_time_info_processor.rb:6:in `set_real_time_info_processor'
  app/controllers/train_location_controller.rb:21:in `block in action_for_railway_line_page'
  app/controllers/concerns/action_base_for_railway_line_page.rb:7:in `action_base_for_railway_line_page'
  app/controllers/train_location_controller.rb:19:in `action_for_railway_line_page'
