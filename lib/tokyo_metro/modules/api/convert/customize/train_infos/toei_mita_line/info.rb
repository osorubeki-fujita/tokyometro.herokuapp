module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ToeiMitaLine::Info

  def initialize( *variables )
    super( *variables )
    convert_infos_of_toei_mita_line_train_on_namboku_line
  end

  private

  def convert_infos_of_toei_mita_line_train_on_namboku_line
    if toei_mita_line_train_including_on_namboku_line?
      @railway_line = "odpt.Railway:Toei.Mita"
      @operator = "odpt.Operator:Toei"

      case @railway_direction
      when "odpt.RailDirection:TokyoMetro.Meguro"
        @railway_direction = "odpt.RailDirection:Toei.Meguro"
      when "odpt.RailDirection:TokyoMetro.ShirokaneTakanawa"
        @railway_direction = "odpt.RailDirection:Toei.NishiTakashimadaira"
      end

      case @train_type
      when "odpt.TrainType:TokyoMetro.Local"
        @train_type = "odpt.TrainType:Toei.Local"
      when "odpt.TrainType:TokyoMetro.Express"
        @train_type = "odpt.TrainType:Toei.Express"
      end
    end
  end

end