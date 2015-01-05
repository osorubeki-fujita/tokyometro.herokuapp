class TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine::Factory::ValidStationTimesOfWeekdays

  def initialize( invalid_train , valid_train )
    @invalid_train = invalid_train
    @valid_train = valid_train
    @direction = set_direction
  end

  # @note 有楽町線
  attr_reader :invalid_train

  # @note 副都心線
  attr_reader :valid_train

  def to_a
    ary = ::Array.new
    case @direction
    when :a
      departure_time_between_wakoshi_and_hikawadai = self.class.list_class.new( @invalid_train.weekdays[ 0..(-2) ] )
      departure_time_between_senkawa_and_shibuya = self.class.list_class.new( @valid_train.weekdays[ 1..(-1) ] )

      ary += departure_time_between_wakoshi_and_hikawadai.convert_invalid_station_names_of_yurakucho_line
      ary << station_time_of_kotake_mukaihara
      ary += departure_time_between_senkawa_and_shibuya

    when :b
      departure_time_between_shibuya_and_senkawa = self.class.list_class.new( @valid_train.weekdays[ 0..(-2) ] )
      departure_time_between_hikawadai_and_wakoshi = self.class.list_class.new( @invalid_train.weekdays[ 1..(-1) ] )

      ary += departure_time_between_shibuya_and_senkawa
      ary << station_time_of_kotake_mukaihara
      ary += departure_time_between_hikawadai_and_wakoshi.convert_invalid_station_names_of_yurakucho_line
    end
    self.class.list_class.new( ary )
  end

  def self.valid_station_times_of_weekdays( invalid_train , valid_train )
    self.new( invalid_train , valid_train ).to_a
  end

  def self.list_class
    ::TokyoMetro::Api::TrainTimetable::Info::StationTime::List
  end

  def self.station_time_class
    ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info
  end

  private

  def set_direction
    if @invalid_train.is_direction_a? and ( @invalid_train.is_terminating_on_fukutoshin_line? or @invalid_train.is_terminating_on_tokyu_toyoko_line? or @invalid_train.is_terminating_on_minatomirai_line? )
      :a
    elsif @invalid_train.is_direction_b? and ( @invalid_train.is_terminating_at_wakoshi? or @invalid_train.is_terminating_on_tobu_tojo_line? )
      :b
    else
      message_ary = ::Array.new
      message_ary << "\n"
      message_ary << "Error: The terminal station of the invalid train should be Wakoshi or"
      message_ary << "\n"
      message_ary << "in Tobu Tojo Line, Fukutoshin Line, Tokyu Toyoko Line or Minatomirai Line (\"#{@invalid_train.terminal_station}\" is not valid."
      raise message_ary.join
    end
  end

  def arrival_time_of_kotake_mukaihara
    case @direction
    when :a
      ary = @invalid_train
    when :b
      ary = @valid_train
    end
    ary.weekdays.last
  end

  def departure_time_of_kotake_mukaihara
    case @direction
    when :a
      ary = @valid_train
    when :b
      ary = @invalid_train
    end
    ary.weekdays.first
  end

  def station_time_of_kotake_mukaihara
    station_name = "odpt.Station:TokyoMetro.Fukutoshin.KotakeMukaihara"

    arrival = arrival_time_of_kotake_mukaihara.arrival_time
    departure = departure_time_of_kotake_mukaihara.departure_time

    self.class.station_time_class.new( arrival , station_name , departure , station_name )
  end

end