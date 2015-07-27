class Station::InfoDecorator::AsDirectionInfo < TokyoMetro::Factory::Decorate::SubDecorator

  def name_ja
    "#{ object.name_ja_actual }方面"
  end

  def name_en
    "for #{ object.name_en }"
  end

  def render_name_ja( with_subname: false )
    decorator.render_name_ja( with_subname: with_subname , suffix: "方面" )
  end

  def render_name_en( with_subname: false )
    decorator.render_name_en( with_subname: with_subname , prefix: "for " )
  end

  def render_simply
    h.render inline: <<-HAML , type: :haml , locals: h_this
%div{ class: :text_ja }<
  = this.name_ja
%div{ class: :text_en }<
  = this.name_en
    HAML
  end

  def render_title
    h.render inline: <<-HAML , type: :haml , locals: h_this
%div{ class: :title_of_a_railway_direction }
  %h4{ class: :text_ja }<
    = this.name_ja
  %h5{ class: :text_en }<
    = this.name_en
    HAML
  end

  def render_precisely( with_subname: false )
    h_locals_i = h_this.merge({ with_subname: with_subname })
    h.render inline: <<-HAML , type: :haml , locals: h_locals_i
%div{ class: :railway_direction }
  %p{ class: :text_ja }<
    = this.render_name_ja( with_subname: false )
  %p{ class: :text_en }<
    = this.render_name_en( with_subname: false )
    HAML
  end

end
