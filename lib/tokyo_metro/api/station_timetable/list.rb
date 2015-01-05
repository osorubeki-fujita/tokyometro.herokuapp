# 各駅・各路線・各方面の時刻表の情報の配列
class TokyoMetro::Api::StationTimetable::List < TokyoMetro::Api::MetaClass::NotRealTime::List

  include ::TokyoMetro::ApiModules::List::Seed
  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable
  include ::TokyoMetro::ApiModules::Selection::RailwayLines

  alias :__seed__ :seed

  def seed
    operators = ::Operator.all
    railway_lines = ::RailwayLine.all
    stations = ::Station.all
    railway_directions = ::RailwayDirection.all

    __seed__( method_name: __method__ ) do
      self.each.with_index(1) do | info , i |
        info.seed( operators , railway_lines , stations , railway_directions , whole: self.length , now_at: i , indent: 1 )
      end
    end
  end

end