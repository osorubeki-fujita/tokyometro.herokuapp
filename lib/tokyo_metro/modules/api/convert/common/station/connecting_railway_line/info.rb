# @note
#   This module is included
#     to {TokyoMetro::Api::Station::Info}
#     by {TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine.set_modules} .
module TokyoMetro::Modules::Api::Convert::Common::Station::ConnectingRailwayLine::Info

  private

  def convert_and_delete_connecting_railway_line_names( replacing: nil , ignored: nil )
    if @connecting_railway_lines.present?
      ary = self.class.connecting_railway_line_list_class.new
      @connecting_railway_lines.each do | info |
        replace_railway_line_info( replacing , ignored , ary , info , inherit_info: false )
      end
      @connecting_railway_lines = ary
    end
  end

  def railway_line_info_after_conversion( replacing_railway_line_name )
    self.class.connecting_railway_line_info_class.new( replacing_railway_line_name )
  end

end