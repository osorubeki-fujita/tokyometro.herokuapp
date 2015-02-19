class TokyoMetro::Api::StationTrainTime

  include ::TokyoMetro::ClassNameLibrary::Api::StationTrainTime
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  # Constructor
  # @param station_timetables [TokyoMetro::Api::StationTimetable::List <TokyoMetro::Api::StationTimetable::Info>] 流し込みの対象となる列車時刻に関連する駅時刻表
  # @param train_timetables [TokyoMetro::Api::TrainTimetable::List <TokyoMetro::Api::TrainTimetable::Info>] 流し込みの対象となる列車時刻に関連する列車時刻表
  def initialize( station_timetables , train_timetables )
    @station_timetables = station_timetables
    @train_timetables = train_timetables
  end

  # @return [TokyoMetro::Api::StationTimetable::List <TokyoMetro::Api::StationTimetable::Info>] 流し込みの対象となる列車時刻に関連する駅時刻表
  attr_reader :station_timetables

  # @return [TokyoMetro::Api::TrainTimetable::List <TokyoMetro::Api::TrainTimetable::Info>] 流し込みの対象となる列車時刻に関連する列車時刻表
  attr_reader :train_timetables

  def select_timetables!( *method_names_for_selecting_railway_line )
    unless method_names_for_selecting_railway_line.empty?
      @station_timetables = self.class.send( :proc_for_select_timetables ).call( method_names_for_selecting_railway_line , @station_timetables )
      @train_timetables = self.class.send( :proc_for_select_timetables ).call( method_names_for_selecting_railway_line , @train_timetables )
    end

    process_station_timetable_of_marunouchi_line( method_names_for_selecting_railway_line )
    process_station_timetable_of_namboku_line( method_names_for_selecting_railway_line )
  end

  # 駅時刻表、列車時刻表を限定し DB への流し込みを行うクラスメソッド
  # @param method_names_for_selecting_railway_line [::Array <Symbol>] 駅時刻表、列車時刻表を限定するためのメソッドの名称（可変長引数）
  # @note method_names_for_selecting_railway_line を指定しない場合は、すべての駅時刻表・列車時刻表に対し処理を行う。
  def self.seed( *method_names_for_selecting_railway_line )
    station_train_time_infos = self.new( ::TokyoMetro::Api.station_timetables , ::TokyoMetro::Api.train_timetables )
    station_train_time_infos.select_timetables!( *method_names_for_selecting_railway_line )
    station_train_time_infos.seed
  end

  class << self

    private

    def proc_for_select_timetables
      # method_list は、method_names_for_selecting_railway_line に相当
      Proc.new { | method_list , timetables |
        timetables.class.new( method_list.flatten.map { | method | timetables.send( method ) }.flatten )
      }
    end

  end

  private

  def process_station_timetable_of_specific_line( method_names_for_selecting_railway_line , proc_for_checking_method_name , procs_for_selecting_station_timetables )
    if method_names_for_selecting_railway_line.any?( &proc_for_checking_method_name )
      station_timetable_list_class = @station_timetables.class
      procs_for_selecting_station_timetables = [ procs_for_selecting_station_timetables ].flatten

      station_timetables_new = ::Array.new

      procs_for_selecting_station_timetables.each do | procedure_for_selecting_station_timetable |
        station_timetables_new += @station_timetables.select( &procedure_for_selecting_station_timetable )
        @station_timetables.delete_if( &procedure_for_selecting_station_timetable )
      end

      station_timetables_new += @station_timetables

      @station_timetables = station_timetable_list_class.new( station_timetables_new )
    end
  end

  def process_station_timetable_of_marunouchi_line( method_names_for_selecting_railway_line )
    proc_for_checking_method_name = ::Proc.new { | method_name | /\marunouchi/ === method_name.to_s }

    procs_for_selecting_station_timetables_1 = ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_sakaue_in_system.map { | sta |
      ::Proc.new { | item | item.same_as == "odpt.StationTimetable:TokyoMetro.MarunouchiBranch.#{sta}.Honancho" }
    }
    procs_for_selecting_station_timetables_2 = ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_shimbashi_in_system.map { | sta |
      ::Proc.new { | item | item.same_as == "odpt.StationTimetable:TokyoMetro.MarunouchiBranch.#{sta}.NakanoSakaue" }
    }

    process_station_timetable_of_specific_line(
      method_names_for_selecting_railway_line ,
      proc_for_checking_method_name ,
      procs_for_selecting_station_timetables_1 + procs_for_selecting_station_timetables_2
    )
  end

  def process_station_timetable_of_namboku_line( method_names_for_selecting_railway_line )
    proc_for_checking_method_name = ::Proc.new { | method_name | /\Anamboku_(?:or|and)_toei_mita(?:_line)?\Z/ === method_name.to_s }

    procs_for_selecting_station_timetables_1 = [ "ShirokaneTakanawa" , "Shirokanedai" ].map { | sta |
      ::Proc.new { | item | item.same_as == "odpt.StationTimetable:TokyoMetro.Namboku.#{sta}.Meguro.Toei.Mita.#{sta}.Meguro" }
    }
    procs_for_selecting_station_timetables_2 = [ "Meguro" , "Shirokanedai" ].map { | sta |
      ::Proc.new { | item | item.same_as == "odpt.StationTimetable:TokyoMetro.Namboku.#{sta}.AkabaneIwabuchi.Toei.Mita.#{sta}.NishiTakashimadaira" }
    }

    process_station_timetable_of_specific_line(
      method_names_for_selecting_railway_line ,
      proc_for_checking_method_name ,
      procs_for_selecting_station_timetables_1 + procs_for_selecting_station_timetables_2
    )
  end

end