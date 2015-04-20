class TokyoMetro::ApiDecorator::RealTimeInfos < TokyoMetro::Factory::Decorate::MetaClass

  def initialize( request , railway_lines , http_client = ::HTTPClient.new )
    super( request )
    @railway_lines = railway_lines.except_for_branch_lines
    @infos_of_each_railway_line = ::Array.new( @railway_lines.map { | railway_line |
      ::TokyoMetro::ApiDecorator::RealTimeInfos::EachRailwayLine.new( request , railway_line , http_client )
    } )
    raise "Error" unless has_any_railway_line?
  end

  attr_reader :infos_of_each_railway_line

  def has_any_railway_line?
    @railway_lines.present?
  end

  def has_one_railway_line?
    @railway_lines.length == 1
  end

  def has_multiple_railway_lines?
    @railway_lines.length > 1
  end

  def has_train_locations?
    @infos_of_each_railway_line.map( &:train_locations ).any?( &:present? )
  end

  def dc_date_times_of_train_information
    @infos_of_each_railway_line.map( &:train_information ).map( &:dc_date )
  end

  def validity_times_of_train_information
    @infos_of_each_railway_line.map( &:train_information ).map( &:validity )
  end

  def dc_date_times_of_train_location_info
    @infos_of_each_railway_line.map( &:train_locations ).flatten.map( &:dc_date )
  end

  def validity_times_of_train_location_info
    @infos_of_each_railway_line.map( &:train_locations ).flatten.map( &:validity )
  end

  def frequency_of_train_location_info
    @infos_of_each_railway_line.map( &:train_locations ).flatten.map( &:frequency )
  end

  def render( make_test: false , add_precise_version: false , include_train_locations: false , controller: :train_information , options: nil )
    if options.present?
      options = [ options ].flatten
    end

    h_locals = {
      info: self ,
      request: @request ,
      make_test: make_test ,
      add_precise_version: add_precise_version ,
      include_train_locations: include_train_locations ,
      controller: controller ,
      index_of_train_location: options.try( :include? , :index_of_train_location )
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :train_informations }
  = info.render_title_of_train_informations( index_of_train_location: index_of_train_location )
  = info.render_train_informations( controller , index_of_train_location )
  - if add_precise_version
    = info.render_train_informations_precise_version
  - if make_test
    = info.render_train_informations_test_version
  - if include_train_locations
    - if info.has_train_locations?
      = info.render_title_of_train_locations
      = info.render_train_locations
    HAML
  end

  def render_real_time_info_and_update_button_of_train_informations( include_train_locations: false )
    h_locals = {
      info: self ,
      requset: @requset ,
      include_train_locations: include_train_locations
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :real_time_info_and_update_button }
  = info.render_title_of_real_time_infos
  %ul{ class: :time_infos }
    = info.render_time_info_of_train_informations
    - if info.has_train_locations?
      - if include_train_locations
        = info.render_time_info_of_train_locations( include_train_locations: true )
      - else
        = info.render_time_info_of_train_locations( include_train_locations: false )
    HAML
  end

  def render_time_info_of_train_informations
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%li{ class: :train_information }
  %ul{ class: :titles }
    %li{ class: :title }<
      %div{ class: :icon }<
        = ::TokyoMetro::App::Renderer::Icon.train_information( request , 1 ).render
      %div{ class: :text }<
        %p{ class: :text_ja }<
          = ::TrainInformationDecorator.common_title_ja
        %p{ class: :text_en }<
          = ::TrainInformationDecorator.common_title_en
  %ul{ class: :time_infos_of_category }
    %li{ class: :dc_date }
      %div{ class: :title_of_time_info }<
        = "データ生成時刻："
      %div{ class: :time }<
        - ary = info.dc_date_times_of_train_information.sort.uniq.map( &:to_strf_normal_ja )
        - if ary.length <= 2
          = ary.join( " - " )
        - else
          = [ ary.first , ary.last ].join( " - " )
    %li{ class: :validity }
      %div{ class: :title_of_time_info }<
        = "データ有効期限・次回更新予定："
      %div{ class: :time }<
        - ary = info.validity_times_of_train_information.sort.uniq.map( &:to_strf_normal_ja )
        - if ary.length <= 2
          = ary.join( " - " )
        - else
          = [ ary.first , ary.last ].join( " - " )
    %ul{ class: [ :en , :text_en ] }<
      %li{ class: :dc_date }<
        %div{ class: :title_of_time_info_en }<
          = "As of"
        %div{ class: :time_en }<
          - ary = info.dc_date_times_of_train_information.sort.uniq.map( &:to_strf_normal_en )
          - if ary.length <= 2
            = ary.join( " - " )
          - else
            = [ ary.first , ary.last ].join( " - " )
      %li{ class: :validity }<
        %div{ class: :title_of_time_info_en }<
          = "Next Update:"
        %div{ class: :time_en }<
          - ary = info.validity_times_of_train_information.sort.uniq.map( &:to_strf_normal_en )
          - if ary.length <= 2
            = ary.join( " - " )
          - else
            = [ ary.first , ary.last ].join( " - " )
    HAML
  end

  def render_time_info_of_train_locations( include_delay: true , include_train_locations: false )
    raise "Error" if !( include_delay ) and !( include_train_locations )
    h_locals = {
      info: self ,
      include_delay: include_delay ,
      include_train_locations: include_train_locations
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
- frequency = info.frequency_of_train_location_info.sort.uniq.map( &:to_s ).join( " - " )
%li{ class: :train_locations }
  %ul{ class: :titles }
    - if include_delay
      %li{ class: :title }<
        %div{ class: :icon }<
          = ::TokyoMetro::App::Renderer::Icon.delay( request , 1 ).render
        %div{ class: :text }<
          %p{ class: :text_ja }<
            = "現在の遅れ"
          %p{ class: :text_en }<
            = "Delay"
    - if include_train_locations
      %li{ class: :title }<
        %div{ class: :icon }<
          = ::TokyoMetro::App::Renderer::Icon.train_location( request , 1 ).render
        %div{ class: :text }<
          %p{ class: :text_ja }<
            = ::TrainLocationDecorator.common_title_ja
          %p{ class: :text_en }<
            = ::TrainLocationDecorator.common_title_en
  %ul{ class: :time_infos_of_category }
    %li{ class: :dc_date }
      %div{ class: [ :title_of_time_info , :text_ja ] }<
        = "データ生成時刻："
      %div{ class: :time }<
        - ary = info.dc_date_times_of_train_location_info.sort.uniq.map( &:to_strf_normal_ja )
        - if ary.length <= 2
          = ary.join( " - " )
        - else
          = [ ary.first , ary.last ].join( " - " )
    %li{ class: :validity }
      %div{ class: [ :title_of_time_info , :text_ja ] }<
        = "データ有効期限・次回更新予定："
      %div{ class: :time }<
        - ary = info.validity_times_of_train_location_info.sort.uniq.map( &:to_strf_normal_ja )
        - if ary.length <= 2
          = ary.join( " - " )
        - else
          = [ ary.first , ary.last ].join( " - " )
    %li{ class: [ :frequency , :text_ja ] }<
      = frequency + "秒ごとに更新"
    %ul{ class: [ :en , :text_en ] }<
      %li{ class: :dc_date }<
        %div{ class: :title_of_time_info_en }<
          = "As of"
        %div{ class: :time_en }<
          - ary = info.validity_times_of_train_location_info.sort.uniq.map( &:to_strf_normal_en )
          - if ary.length <= 2
            = ary.join( " - " )
          - else
            = [ ary.first , ary.last ].join( " - " )
      %li{ class: :validity }<
        %div{ class: :title_of_time_info_en }<
          = "Next Update:"
        %div{ class: :time_en }<
          - ary = info.validity_times_of_train_location_info.sort.uniq.map( &:to_strf_normal_en )
          - if ary.length <= 2
            = ary.join( " - " )
          - else
            = [ ary.first , ary.last ].join( " - " )
      %li{ class: :frequency }<
        = "Updates at intervals of" + " " + frequency + " " + "seconds."
    HAML
  end

  def render_train_informations( controller , index_of_train_location )
    h_locals = {
      info: self ,
      controller: controller ,
      index_of_train_location: index_of_train_location
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
- info.infos_of_each_railway_line.each do | info_of_a_railway_line |
  = info_of_a_railway_line.render_train_information( controller )
    HAML
  end

  def render_train_informations_precise_version
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: [ :precise_version_title , :text_ja ] }<
  = ::TrainInformationDecorator.common_title_ja + " " + "詳細版"
- info.infos_of_each_railway_line.each do | info_of_a_railway_line |
  = info_of_a_railway_line.render_train_information_precise_version
    HAML
  end

  def render_train_informations_test_version
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: [ :test_title , :text_ja ] }<
  = ::TrainInformationDecorator.common_title_ja + " " + "テスト"
- info.infos_of_each_railway_line.each do | info_of_a_railway_line |
  = info_of_a_railway_line.render_train_information_test
    HAML
  end

  def render_train_locations
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :train_locations }
  - if info.has_one_railway_line?
    - info.infos_of_each_railway_line.each do | info_of_a_railway_line |
      = info_of_a_railway_line.render_train_locations
  - else
    - info.infos_of_each_railway_line.each do | info_of_a_railway_line |
      - if info_of_a_railway_line.train_locations.present?
        = info_of_a_railway_line.railway_line.decorate.render_title_in_train_location
        = info_of_a_railway_line.render_train_locations
    HAML
  end

  def render_title_of_train_informations( index_of_train_location: false )
    proc_for_additional_content = ::Proc.new {
      h.render inline: <<-HAML , type: :haml , locals: { info: self , index_of_train_location: index_of_train_location }
- if index_of_train_location and info.has_train_locations?
  %div{ class: :link_info_to_train_location_of_each_railway_line }
    %div{ class: :icon }<
      = ::TokyoMetro::App::Renderer::Icon.train_location( request , 2 ).render
    %div{ class: :text }<
      %p{ class: :text_ja }<
        = "路線名をクリックすると、各路線で現在運行している列車が表示されます。"
      %p{ class: :text_en }<
        = "To display train locations of each railway line, please click the railway line name."
      HAML
    }

    ::TokyoMetro::App::Renderer::Concern::Header::Content.new(
      @request ,
      :title_of_train_informations ,
      :train_information ,
      ::TrainInformationDecorator.common_title_ja ,
      ::TrainInformationDecorator.common_title_en ,
      additional_content: proc_for_additional_content
    ).render
  end

  def render_title_of_train_locations
    ::TokyoMetro::App::Renderer::Concern::Header::Content.new(
      @request ,
      :title_of_train_locations ,
      :train_location ,
      ::TrainLocationDecorator.common_title_ja ,
      ::TrainLocationDecorator.common_title_en
    ).render
  end

  def render_title_of_real_time_infos
    ::TokyoMetro::App::Renderer::Concern::Header::Content.new(
      @request ,
      :real_time_infos ,
      :real_time_infos ,
      "リアルタイム情報" ,
      "About real-time informations" ,
      add_update_button: true ,
      update_button_id: :update_button_in_content_header_of_real_time_infos ,
      contoller_of_updating_real_time_info_form: :update ,
      action_of_updating_real_time_info_form: :normal ,
      icon_size: 2
    ).render
  end

end