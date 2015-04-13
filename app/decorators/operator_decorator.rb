class OperatorDecorator < Draper::Decorator
  delegate_all

  include TwitterRenderer

  def twitter_title
    "Twitter #{ object.name_ja_normal_precise }【公式】"
  end

  def render_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: [ :document_info_box_normal , info.css_class_name ] }
  = ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
  %div{ class: :operator_name }
    = info.render_name_ja_in_document_info_box
    = info.render_name_en_in_document_info_box
  = info.render_color_info_in_document_info_box
    HAML
  end

  def render_name_ja_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
- regexp_of_parentheses = ::ApplicationHelper.regexp_for_parentheses_normal
- operator_name_ja = info.name_ja_to_haml
%div{ class: :text_ja}<
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
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
- regexp_of_parentheses = ::ApplicationHelper.regexp_for_parentheses_for_quotation
- operator_name_en = info.name_en_to_haml
%div{ class: :text_en }<
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
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :color_info }
  %div{ class: :web_color }<
    = info.color
  - if info.color.present?
    %div{ class: :rgb_color }<
      = ::ApplicationHelper.rgb_in_parentheses( info.color )
    HAML
  end

end