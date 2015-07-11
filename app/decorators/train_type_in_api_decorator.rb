class TrainTypeInApiDecorator < Draper::Decorator
  delegate_all

  def render_name_in_box( icon: false )
    if icon and object.same_as == "odpt.TrainType:Toei.AirportLimitedExpress"
      render_name_of_airport_limited_express_in_box
    else
      render_name_in_box_normally
    end
  end

  def render_name_in_travel_time_info
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :name_ja_normal }<
  = this.name_ja_normal
    HAML
  end

  alias :render_in_train_location :render_name_in_box

  private

  def render_name_in_box_normally
    h.render inline: <<-HAML , type: :haml , locals: { name_ja: object.name_ja_normal , name_en: object.name_en_normal }
%p{ class: :text_ja }<
  = name_ja
%p{ class: :text_en }<
  = name_en
    HAML
  end

  def render_name_of_airport_limited_express_in_box
    name_ja_in_box = object.name_ja_normal.to_s.gsub( /^エアポート/ , "" )
    h.render inline: <<-HAML , type: :haml , locals: { name_ja: name_ja_in_box , name_en: object.name_en_normal }
%p{ class: :text_ja }<
  = ::TokyoMetro::App::Renderer::Icon.airplane( nil , 1 ).render
  != name_ja
%p{ class: :text_en }<
  = name_en
    HAML
  end

end
