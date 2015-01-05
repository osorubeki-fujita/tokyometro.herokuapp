# 東京メトロ オープンデータの API から提供される情報を扱うモジュール
module TokyoMetro::Api

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  # 東京メトロ オープンデータに関する定数を定義するメソッド (2) - API から取得し保存したデータからインスタンスを作成し、定数とする
  # @return [nil]
  def self.set_constants( config_of_api_constants )
    unless config_of_api_constants.nil?
      [ :station_facility , :passenger_survey , :station , :railway_line , :point , :fare , :station_timetable , :train_timetable ].each do | symbol |
        if config_of_api_constants[ symbol ]
          set_constant( symbol )
        end
      end
    end
    return nil
  end

  class << self

    def method_missing( method_name )
      called_method_name = method_name.singularize.upcase
      if costants_converted_by_method_missing.include?( called_method_name )
        const_get( called_method_name )
      else
        super
      end
    end

    private

    def set_constant( const_name_underscore )
      const_name_base = const_name_underscore.to_s.underscore.downcase
      const_name = const_name_base.upcase.intern
      class_name = "::TokyoMetro::Api::#{ const_name_base.camelize }"
      puts const_name.to_s.ljust(48) + class_name
      const_set( const_name , eval( class_name ).generate_from_saved_json )
    end

  end

  # 東京メトロ オープンデータに関する定数を定義するメソッド (1) - 時刻表の列車の補足情報に関する定数
  # @return [nil]
  def self.set_constants_for_timetable
    #---- 時刻表 到着ホーム
    ::TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::ArriveAt::set_constants

    #---- 時刻表 出発ホーム
    ::TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::DepartFrom::set_constant
  end

  def self.timetable_notes_of_arrival_at_asakusa
    ::TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::ArriveAt::ASAKUSA
  end

  def self.timetable_notes_of_departure
    ::TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::DepartFrom::LIST
  end

end

# api/meta_class.rb

# api/station_timetable.rb
# api/train_timetable.rb

# api/train_information.rb
# api/train_location.rb
# api/station.rb
# api/station_facility.rb
# api/passenger_survey.rb
# api/railway_line.rb
# api/fare.rb

# api/point.rb

# api/mlit_railway_line.rb
# api/mlit_station.rb