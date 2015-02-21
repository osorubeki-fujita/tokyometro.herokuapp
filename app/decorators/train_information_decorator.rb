class TrainInformationDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer

  def self.common_title_ja
    "この駅からの運行状況"
  end

  def self.common_title_en
    "Information of trains from stations"
  end

  def self.render_table( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :train_information }
  - infos.each do | railway_line |
    - #
    HAML
  end
  
  class << self
    
    private
    
    def render_info( status_type , additional_info: nil )
      h.render inline: <<-HAML , type: :haml , locals: { status_type: status_type , additional_info: additional_info }
  %div{ class: [ :status , status_type ] }
    = ::TrainInformationDecorator.render_status_type_image( status_type )
    = ::TrainInformationDecorator.render_status_text( status_type )
    - if additional_info.present?
      = ::TrainInformationDecorator.render_additional_info( additional_info )
      HAML
    end

    def render_additional_info( additional_info )
      h.render inline: <<-HAML , type: :haml , locals: { info: str }
  %div{ class: :additional_info }
    = str
      HAML
    end
  
    def render_status_type_image( status_type )
      h.content_tag( :div , class: :image ) do
        concat image_tag( "train_information/status/#{status_type}.png" )
      end
    end
      
    def render_status_text( status_type )
      case status_type
      when :on_time
        text_ja , text_en = "平常運転" , "Now on time"
      when :nearly_on_time
        text_ja , text_en = "ほぼ平常運転" , "Now on time"
      when :delay
        text_ja , text_en = "遅れあり" , "Delay"
      when :suspended
        text_ja , text_en =  "運転見合わせ" , "Operation suspended"
      end
  
      h.render inline: <<-HAML , type: :haml , locals: { text_ja: text_ja , text_en: text_en }
  %div{ class: :text }
    %p{ class: :text_ja }<
      = text_ja
    %p{ class: :text_en }<
      = text_en
      HAML
    end
  
  end

end