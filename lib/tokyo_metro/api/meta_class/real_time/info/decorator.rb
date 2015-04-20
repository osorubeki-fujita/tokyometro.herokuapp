class TokyoMetro::Api::MetaClass::RealTime::Info::Decorator < TokyoMetro::Factory::Decorate::MetaClass

  def initialize( request , obj )
    super( request )
    @object = obj
  end

  attr_reader :object

  def render_railway_line_name
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :railway_line }
  - railway_line = ::RailwayLine.find_by( same_as: info.object.railway_line )
  %div{ class: :text_ja }
    = railway_line.name_ja_with_operator_name
  %div{ class: :text_en }
    = railway_line.name_en_with_operator_name
    HAML
  end

  def render_dc_date_of_precise_version
    render_info_of_precise_version( "データ生成時刻" , :dc_date , :time , object.dc_date.to_strf_normal_ja )
  end

  def render_validity_of_precise_version
    render_info_of_precise_version( "データ有効期限" , :validity , :time , object.validity.to_strf_normal_ja )
  end

  private

  def render_info_of_precise_version( title , class_name_of_whole_domain , class_name_of_precise_info_domain , precise_info )
    h_locals = {
      title: title ,
      class_name_of_whole_domain: class_name_of_whole_domain ,
      class_name_of_precise_info_domain: class_name_of_precise_info_domain ,
      precise_info: precise_info
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%p{ class: class_name_of_whole_domain }
  %span{ class: :title }<
    = title
  %span{ class: class_name_of_precise_info_domain }<
    = precise_info
    HAML
  end

end