module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::RomanceCar::Info

  def initialize( *variables )
    super( *variables )
    convert_romance_car_on_chiyoda_line
  end

  attr_reader :train_name

  private

  def convert_romance_car_on_chiyoda_line
    if romance_car_on_chiyoda_line?
      @train_type = "odpt.TrainType:TokyoMetro.RomanceCar"
      _specific_train_name = specific_train_name
      if _specific_train_name.present?
        @train_name = _specific_train_name
      end
    end
  end

  def specific_train_name
    ::TokyoMetro::Modules::Common::Dictionary::RomanceCar.train_name[ @same_as ]
  end

end