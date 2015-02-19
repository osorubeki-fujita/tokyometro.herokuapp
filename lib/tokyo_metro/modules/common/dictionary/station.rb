module TokyoMetro::Modules::Common::Dictionary::Station

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  STATION_NAME_SAME_AS_IN_DB = ::YAML.load_file( "#{ ::TokyoMetro::dictionary_dir }/station/same_as_in_db.yaml" )

  # @param title 
  # @note 変数 title は現在不使用だが、とりあえず残しておく
  def self.station_same_as_in_db( same_as , title = nil )
    station_alias_from_hash = station_name_same_as_in_db[ same_as ]
    if station_alias_from_hash.present?
      station_alias_from_hash
    else
      same_as
    end
  end

  class << self

    private

    def set_station_same_as_in_db__raise_error_when_nil( station_same_as , title )
      if station_same_as.nil?
        puts "★ #{ title } of \"#{ @train_number }\" is not defined."
        puts "Please investigate #{ title.downcase } of this train and input."
        station_same_as_new = gets.chomp
        puts "#{ title } of \"#{ @train_number }\" is"
        puts " " * 4 + station_same_as_new
        puts "OK? \[Y/n\]"
        yn = gets.chomp
        case yn.downcase
        when "y"
          station_same_as_new
        else
          set_station_same_as_in_db__raise_error_when_nil( station_same_as , title )
        end
      else
        station_same_as
      end
    end

  end

end