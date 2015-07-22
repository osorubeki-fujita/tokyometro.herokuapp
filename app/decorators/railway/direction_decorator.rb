class Railway::DirectionDecorator < Draper::Decorator

  delegate_all

  [ :in_document , :in_station_timetable , :in_platform_transfer_info ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        ::Railway::DirectionDecorator::#{ method_name.camelize }.new( self )
      end
    DEF
  end

  def render_simple_title
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- station_info_deccorated = this.station_info.decorate
%div{ class: :title_of_a_railway_direction }
  %h4{ class: :text_ja }<
    = station_info_deccorated.name_ja_actual + "方面"
  %h5{ class: :text_en }<
    = "for " + station_info_deccorated.name_en
    HAML
  end

  alias :render_title_in_train_location :render_simple_title

end
