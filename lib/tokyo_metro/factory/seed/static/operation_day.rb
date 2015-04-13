module TokyoMetro::Factory::Seed::Static::OperationDay

  def self.find_or_create_by_and_get_ids_of( *ary )
    ary = ary.flatten
    unless ary.all?{ | element | element.instance_of?( ::String ) }
      raise "Error: #{ary.to_s} is not valid. Please set string(s)."
    end

    days = ary.map { | str | str.split( /[\,\/、・･／] */ ) }.flatten.map { | str | str.gsub( /s\Z/ , "" ) }
    ary_of_ids = ::Array.new
    days.each do | operation_day |
      info = ::TokyoMetro::Static.operation_days.find { | item | item.match?( operation_day ) }
      if info.blank?
        raise "Error: \'#{ operation_day }\' is not defined in \'::TokyoMetro::Static.operation_days\'."
      end
      ary_of_ids << ::OperationDay.find_or_create_by( info.to_h ).id
    end
    return ary_of_ids
  end

end