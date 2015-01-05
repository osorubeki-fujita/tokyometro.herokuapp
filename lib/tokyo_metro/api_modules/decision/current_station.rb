module TokyoMetro::ApiModules::Decision::CurrentStation

  include ::TokyoMetro::CommonModules::Decision::CurrentStation

  private

  def station_same_as__is_in?( *variables , compared: nil )
    if compared.nil?
      super( *variables , @station )
    else
      super( *variables , compared )
    end
  end

end