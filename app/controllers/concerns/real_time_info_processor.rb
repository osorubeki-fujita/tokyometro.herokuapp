module RealTimeInfoProcessor

  private

  # @todo JSON::ParserError - A JSON text must at least contain two octets!
  def set_real_time_info_processor( railway_lines: @railway_lines )
    begin
      @real_time_info_processor = ::TokyoMetro::App::Renderer::RealTimeInfos.new( request , railway_lines )
    rescue ::SocketError
      puts "SocketError"
      @real_time_info_processor = nil
      # ::TokyoMetro::App::Renderer::RealTimeInfos::NetworkError.new( request )
    rescue ::JSON::ParserError
      puts "JSON::ParserError"
      @real_time_info_processor = nil
      # ::TokyoMetro::App::Renderer::RealTimeInfos::JsonPerserError.new( request )
    end
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

#--------

SocketError - getaddrinfo: ���̂悤�ȃz�X�g�͕s���ł��B  (https://api.tokyometroapp.jp:443):
  httpclient (2.6.0.1) lib/httpclient/session.rb:799:in `create_socket'
  httpclient (2.6.0.1) lib/httpclient/session.rb:747:in `block in connect'
  C:/Ruby21/lib/ruby/2.1.0/timeout.rb:91:in `block in timeout'
  C:/Ruby21/lib/ruby/2.1.0/timeout.rb:101:in `timeout'
  C:/Ruby21/lib/ruby/2.1.0/timeout.rb:127:in `timeout'
  httpclient (2.6.0.1) lib/httpclient/session.rb:746:in `connect'
  httpclient (2.6.0.1) lib/httpclient/session.rb:612:in `query'
  httpclient (2.6.0.1) lib/httpclient/session.rb:164:in `query'
  httpclient (2.6.0.1) lib/httpclient.rb:1191:in `do_get_block'
  httpclient (2.6.0.1) lib/httpclient.rb:974:in `block in do_request'
  httpclient (2.6.0.1) lib/httpclient.rb:1082:in `protect_keep_alive_disconnected'
  httpclient (2.6.0.1) lib/httpclient.rb:969:in `do_request'
  httpclient (2.6.0.1) lib/httpclient.rb:822:in `request'
  httpclient (2.6.0.1) lib/httpclient.rb:713:in `get'
  tokyo_metro (0.6.3) lib/tokyo_metro/factory/get/api/meta_class/fundamental.rb:71:in `response_from_api'
  tokyo_metro (0.6.3) lib/tokyo_metro/factory/get/api/meta_class/fundamental.rb:44:in `get_data'
  tokyo_metro (0.6.3) lib/tokyo_metro/factory/get/api/data_search/train_operation.rb:44:in `process'
  tokyo_metro (0.6.3) lib/tokyo_metro/api/train_operation.rb:28:in `get'
  tokyo_metro (0.6.3) lib/tokyo_metro/app/renderer/real_time_infos/each_railway_line.rb:29:in `get_train_operation_info'
  tokyo_metro (0.6.3) lib/tokyo_metro/app/renderer/real_time_infos/each_railway_line.rb:8:in `initialize'
  tokyo_metro (0.6.3) lib/tokyo_metro/app/renderer/real_time_infos.rb:143:in `block in set_infos_of_each_railway_line'
  C:0:in `map'
  tokyo_metro (0.6.3) lib/tokyo_metro/app/renderer/real_time_infos.rb:142:in `set_infos_of_each_railway_line'
  tokyo_metro (0.6.3) lib/tokyo_metro/app/renderer/real_time_infos.rb:9:in `initialize'
  app/controllers/concerns/real_time_info_processor.rb:7:in `set_real_time_info_processor'
  app/controllers/station_facility_controller.rb:30:in `block in action_for_station_page'
  app/controllers/concerns/action_base_for_station_page.rb:8:in `action_base_for_station_page'
  app/controllers/station_facility_controller.rb:24:in `action_for_station_page'
  actionpack (4.2.1) lib/action_controller/metal/implicit_render.rb:4:in `send_action'
