class Railway::DirectionDecorator < Draper::Decorator

  delegate_all

  [ :in_document , :in_station_timetable , :in_platform_transfer_info , :title ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        ::Railway::DirectionDecorator::#{ method_name.camelize }.new( self )
      end
    DEF
  end

end
