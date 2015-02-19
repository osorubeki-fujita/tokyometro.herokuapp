# 東京メトロ オープンデータの API から提供される情報を扱うモジュール
module TokyoMetro::Api

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  def self.station_train_time
    ::TokyoMetro::Api::StationTrainTime
  end

  def self.list_of_constants
    [ :station_facility , :passenger_survey , :station , :railway_line , :point , :fare , :station_timetable , :train_timetable ]
  end

  # 東京メトロ オープンデータに関する定数を定義するメソッド (2) - API から取得し保存したデータからインスタンスを作成し、定数とする
  # @return [nil]
  def self.set_constants( *configs_of_api_constants )
    config_of_api_constants = set_config_of_api_constants( *configs_of_api_constants )

    if config_of_api_constants.present?
      list_of_constants.each do | symbol |
        if config_of_api_constants[ symbol ]
          set_constant( symbol )
        end
      end
    end

    return nil
  end

  def self.barrier_free_facilities
    STATION_FACILITY.send( __method__ )
  end

  class << self

    def method_missing( method_name , *args )
      if costants_converted_by_method_missing.include?( method_name.singularize.upcase )
        return const_get( method_name.singularize.upcase )
      else
        super( method_name , *args )
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

    def set_config_of_api_constants( *configs_of_api_constants )
      if configs_of_api_constants.blank? or configs_of_api_constants.all?( &:blank? )
        ary_for_display = ::Array.new
        ary_for_display << :none
        list_of_constants.each do | constant |
          ary_for_display << constant
        end

        numbers = numbers_of_constants( ary_for_display )

        if numbers.include?(0)
          return nil
        end

        h = ::Hash.new
        numbers.each do | i |
          h[ ary_for_display[i] ] = true
        end

        return h

      elsif configs_of_api_constants.instance_of?( ::Array )
        if configs_of_api_constants.length == 1 and configs_of_api_constants.first.instance_of?( ::Hash )
          h = configs_of_api_constants.first
          if h.keys.all? { | key | list_of_constants.include?( key ) }
            return h
          end

        elsif configs_of_api_constants.all? { | item | ( item.instance_of?( ::String ) or item.instance_of?( ::Symbol ) ) and list_of_constants.include?( item ) }
          h = ::Hash.new
          configs_of_api_constants.each do | key |
            h[ key.intern ] = true
          end
          return h
        end
      end

      raise "Error: #{ configs_of_api_constants.to_s } is not valid."
    end

    def numbers_of_constants( ary_for_display )
      puts "Set api constants"
      puts "  - Please select constant number(s)."
      puts "  - If you want to set multiple constants, please input the number of each constant and input a space between them."
      puts ""

      ary_for_display.each_with_index do | constant , i |
        puts ( constant.to_s.ljust(24) + " : " + i.to_s.rjust(2) )
        if i == 0
          puts ""
        end
      end

      puts ""

      numbers = gets.chomp
      unless /\A\d+(?: \d+)*\Z/ === numbers
        return numbers_of_constants( ary_for_display )
      end

      ary = numbers.split( / / ).map( &:to_i ).sort
      if ary.include?(0) and ary.length > 1
        puts "Do you want to set no constant? Multiple numbers are input."
        numbers_of_constants( ary_for_display )
      end

      ary
    end

  end

  # 東京メトロ オープンデータに関する定数を定義するメソッド (1) - 時刻表の列車の補足情報に関する定数
  # @return [nil]
  def self.set_constants_for_timetable
    #---- 時刻表 到着ホーム
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ArriveAt::set_constants

    #---- 時刻表 出発ホーム
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::PlatformNumber::set_constant
  end

  def self.timetable_notes_of_arrival_at_asakusa
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ArriveAt::ASAKUSA
  end

  def self.timetable_notes_of_departure
    ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::PlatformNumber::LIST
  end

end