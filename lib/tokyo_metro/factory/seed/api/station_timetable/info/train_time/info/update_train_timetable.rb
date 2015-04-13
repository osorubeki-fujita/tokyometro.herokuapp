class TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Info::UpdateTrainTimetable

  TRAIN_TIMETABLE_OPTIONAL_INFOS = [
    :car_composition ,
    :train_timetable_arrival_info_id ,
    # :train_timetable_connection_info_id , # 接続情報は station_train_time に対して定義する。
    :train_timetable_train_type_in_other_operator_id
  ]

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  def initialize( train , station_timetable_in_db , train_timetable_in_db )
    @train = train
    @station_timetable_in_db = station_timetable_in_db
    @train_timetable_in_db = train_timetable_in_db

    @hash_for_update = ::Hash.new
  end

  def process
    set_optional_infos
    update_train_timetable
  end

  def self.process( train , station_timetable , train_timetable )
    self.new( train , station_timetable , train_timetable ).process
  end

  private

  def set_optional_infos
    self.class.train_timetable_optional_infos.each do | method_name |
      optional_info_id = self.send( method_name )
      if optional_info_id.present?
        optional_info_id_in_train_timetable = @train_timetable_in_db.send( method_name )

        # @hash_for_update への追加／エラー ここから
        if optional_info_id_in_train_timetable.nil?
          @hash_for_update[ method_name ] = optional_info_id
        else
          unless optional_info_id_in_train_timetable == optional_info_id
            error_msg = [
              "Error: #{ method_name } in the train timetable \'#{ @train_timetable_in_db.same_as }\' is not valid." ,
              "id in the train timetable: #{ optional_info_id_in_train_timetable }" ,
              "id in the station timetable: #{ optional_info_id }"
            ].join( "\n" )
            raise error_msg
          end
        end
        # @hash_for_update への追加／エラー ここまで
      end
    end
  end

  def car_composition
    @train.car_composition
  end

  [ :arrival_info_id , :starting_station_info_id , :connection_info_id ].each do | method_base_name |
    eval <<-DEF
      def train_timetable_#{ method_base_name }
        @train.#{ method_base_name }( railway_line_ids )
      end
    DEF
  end

  def train_timetable_train_type_in_other_operator_id
    @train.train_type_in_other_operator_id
  end

  def railway_line_ids
    @station_timetable_in_db.railway_lines.pluck( :id )
  end

  def update_train_timetable
    if @hash_for_update.present?
      @train_timetable_in_db.update( @hash_for_update )
    end
  end

end