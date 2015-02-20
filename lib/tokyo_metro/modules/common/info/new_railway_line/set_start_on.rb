module TokyoMetro::Modules::Common::Info::NewRailwayLine::SetStartOn

  private

  def set_start_on( start_on )
    if start_on.instance_of?( ::Time ) or start_on.instance_of?( ::DateTime )
      start_on
    elsif start_on.instance_of?( ::String ) and /\A(\d{4})\.(\d{2})\.(\d{2})\Z/ =~ start_on
      ::DateTime.new( $1.to_i , $2.to_i , $3.to_i , 3 )
    elsif start_on.nil?
      nil
    else
      raise "Error"
    end
  end

end