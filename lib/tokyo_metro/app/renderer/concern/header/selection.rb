class TokyoMetro::App::Renderer::Concern::Header::Selection < TokyoMetro::App::Renderer::Concern::Header::MetaClass

  def initialize(
    request , text_ja , text_en , domain_id_name , domain_class_name , *icon_names ,
    icon_size: 3 ,
    additional_content: nil
  )
    super(
      request , text_ja , text_en ,
      domain_id_name: domain_id_name ,
      domain_class_name: domain_class_name ,
      additional_content: additional_content
    )
    @icon_names = icon_names
    @icon_size = icon_size
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: domain_id_name , class: domain_class_name }
  - if icon_names.length > 1
    %div{ class: :icons }
      - icon_names.each do | icon_name |
        %div{ class: :icon }
          = ::TokyoMetro::App::Renderer::Icon.send( icon_name , request , icon_size ).render
  - else
    %div{ class: :icon }
      = ::TokyoMetro::App::Renderer::Icon.send( icon_names.first , request , icon_size ).render
  %div{ class: :text }
    %h3{ class: :text_ja }<
      = text_ja
    %h4{ class: :text_en }<
      = text_en
    HAML
  end

  def self.railway_line( request )
    self.new( request , "路線をえらぶ" , "Select railway line" , :select_railway_line , :selection_header , :railway_line )
  end

  def self.station_from_list( request )
    self.new( request , "駅一覧から駅をえらぶ" , "Select station from list" , :select_station_from_list , :selection_header , :station )
  end

  def self.station_from_railway_line( request )
    self.new( request , "路線から駅をえらぶ" , "Select station from railway line" , :select_station_from_railway_line , :selection_header , :station )
  end

  private

  def h_locals
    super.merge({
      icon_names: @icon_names ,
      icon_size: @icon_size
    })
  end

end