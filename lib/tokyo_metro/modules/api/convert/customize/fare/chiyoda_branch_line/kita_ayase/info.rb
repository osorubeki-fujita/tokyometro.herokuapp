module TokyoMetro::Modules::Api::Convert::Customize::Fare::ChiyodaBranchLine::KitaAyase::Info

  def initialize( *variables )
    super( *variables )
    convert_infos_related_to_kita_ayase
  end

  private

  def convert_infos_related_to_kita_ayase
    regexp = /Chiyoda(?=\.KitaAyase(?:\.|\Z))/
    if regexp === @from_station
      @same_as = @same_as.gsub( regexp , "ChiyodaBranch" )
      @from_station = @from_station.gsub( regexp , "ChiyodaBranch" )
    elsif regexp === @to_station
      @same_as = @same_as.gsub( regexp , "ChiyodaBranch" )
      @to_station = @to_station.gsub( regexp , "ChiyodaBranch" )
    end
  end

end