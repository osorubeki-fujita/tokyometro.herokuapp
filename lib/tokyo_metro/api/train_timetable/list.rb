# 列車別の時刻表の情報の配列
class TokyoMetro::Api::TrainTimetable::List < TokyoMetro::Api::MetaClass::NotRealTime::List

  include ::TokyoMetro::ApiModules::List::Seed
  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  include ::TokyoMetro::ApiModules::Selection::RailwayLines

  alias :__seed__ :seed

  def seed
    operators = ::Operator.all
    railway_lines = ::RailwayLine.all
    stations = ::Station.all
    railway_directions = ::RailwayDirection.all
    train_owners = ::TrainOwner.all

    __seed__( method_name: __method__ ) do
      self.each.with_index(1) do | info , i |
        info.seed( operators , railway_lines , stations , railway_directions , train_owners , whole: self.length , now_at: i , indent: 1 )
      end
    end
  end

end