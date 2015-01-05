module TokyoMetro::Seed::OperationDayProcesser

  def self.find_or_create_by_and_get_ids_of( *ary )
    raise "Error" unless ary.all?{ | element | element.instance_of?( ::String ) }
    days = ary.map { | str | str.split( /[\,\/、・･／] */ ) }.flatten.map { | str | str.gsub( /s\Z/ , "" ) }
    ary_of_ids = ::Array.new
    days.each do | operation_day |
      name_ja , name_en = name_ja_and_en( operation_day )
      unless ::OperationDay.exists?( name_ja: name_ja , name_en: name_en )
        ::OperationDay.create(
          name_ja: name_ja ,
          name_en: name_en
        )
      end
      ary_of_ids << ::OperationDay.find_by( name_ja: name_ja , name_en: name_en ).id
    end
    return ary_of_ids
  end

  class << self

    private
    def name_ja_and_en( operation_day )
      [
        [ "平日" , "Weekday" ] ,
        [ "月曜" , "Monday" ] ,
        [ "火曜" , "Tuesday" ] ,
        [ "水曜" , "Wednesday" ] ,
        [ "木曜" , "Thurasday" ] ,
        [ "金曜" , "Friday" ] ,
        [ "土曜" , "Saturday" ] ,
        [ "日曜" , "Sunday" ] ,
        [ "土休日" , "Holiday" ] ,
        [ "土日祝" , "Holiday" ] ,
        [ "土休日" , "Saturday and holiday" ]
      ].each do | ary |
        if ary.include?( operation_day )
          return ary
        end
      end
      raise "Error: \"#{operation_day}\" is not valid."
    end
  end

end