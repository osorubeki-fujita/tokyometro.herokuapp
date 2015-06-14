class OperatorDecorator < Draper::Decorator
  delegate_all

  include TwitterRenderer

  def twitter_title
    "Twitter #{ object.name_ja_normal_precise }【公式】"
  end

  def render_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%li{ class: [ :document_info_box_normal , :operator , this.css_class_name , :clearfix ] }
  = ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
  %div{ class: :texts }
    = this.render_main_domain_in_document_info_box
    %div{ class: [ :button_area , :clearfix ] }
    %ul{ class: [ :sub_infos , :clearfix ] }
      - [ :id , :same_as ].each do | column |
        %li{ class: :clearfix }<
          %dd<
            = column.to_s + " :"
          %dt<
            = this.send( column )
    HAML
  end

  def render_main_domain_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: [ :main , :clearfix ] }
  %div{ class: :operator_name }
    = this.render_name_ja_in_document_info_box
    = this.render_name_en_in_document_info_box
  = this.render_color_info_in_document_info_box
    HAML
  end

  def render_name_ja_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- regexp_of_parentheses = ::PositiveStringSupport::RegexpLibrary.regexp_for_parentheses_ja
- operator_name_ja = this.name_ja_to_haml
%p{ class: :text_ja}<
  - if regexp_of_parentheses =~ operator_name_ja
    - out_of_parentheses = operator_name_ja.gsub( regexp_of_parentheses , "" )
    - in_parentheses =  $1
    = out_of_parentheses
    %span{ class: :sub }<
      = in_parentheses
  - else
    = operator_name_ja
    HAML
  end

  def render_name_en_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- regexp_of_parentheses = ::PositiveStringSupport::RegexpLibrary.regexp_for_quotation
- operator_name_en = this.name_en_to_haml
%p{ class: :text_en }<
  - if regexp_of_parentheses =~ operator_name_en
    - out_of_parentheses = operator_name_en.gsub( regexp_of_parentheses , "" )
    - in_parentheses =  $1
    %div{ class: :main }<
      = out_of_parentheses
    %div{ class: :sub }<
      = in_parentheses
  - else
    = operator_name_en
    HAML
  end

  def render_color_info_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :color_info }
  %div{ class: :web_color }<
    = this.color
  - if this.color.present?
    %div{ class: :rgb_color }<
      = this.color.to_rgb_color_in_parentheses
    HAML
  end

end
