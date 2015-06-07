class Station::InfoDecorator::InTrainLocation < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render_as_terminal_station
    h.render inline: <<-HAML , type: :haml , locals: { this: decorator }
%div{ class: [ :terminal_station , :clearfix ] }
  - if this.object.station_code.present?
    = this.render_station_code_image
  %div{ class: :text }
    %p{ class: :text_ja }<
      = this.render_name_ja( with_subname: true , suffix: " 行き" )
    %p{ class: :text_en }<
      = this.render_name_en( with_subname: true , prefix: "for " )
    HAML
  end

  def render_as_starting_station
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: [ :starting_station , :clearfix ] }
  %div{ class: :starting_station_title }
    %p{ class: :text_ja }<
      = "始発駅"
    %p{ class: :text_en }<
      = "Started at"
  = this.render_name
    HAML
  end

  def render_name
    h.render inline: <<-HAML , type: :haml , locals: { this: decorator }
%div{ class: [ :station_info , :clearfix ] }
  - if this.object.station_code.present?
    = this.render_station_code_image
  %div{ class: :text }
    %p{ class: :text_ja }<
      = this.render_name_ja( with_subname: true )
    %p{ class: :text_en }<
      = this.render_name_en( with_subname: true )
    HAML
  end

end
