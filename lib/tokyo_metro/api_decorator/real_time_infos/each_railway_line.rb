class TokyoMetro::ApiDecorator::RealTimeInfos::EachRailwayLine < TokyoMetro::Factory::Decorate::MetaClass

  STATUS_LIST_FOR_TEST = ::YAML.load_file( "#{ ::Rails.root }/lib/tokyo_metro/dictionary/view/train_information/status_list_for_test.yaml" )

  def initialize( request , railway_line , http_client )
    super( request )
    @railway_line = railway_line
    get_train_information( http_client )
    get_train_locations( http_client )
  end

  attr_reader :railway_line
  attr_reader :train_information
  attr_reader :train_locations

  def render_train_information( controller )
    @train_information.decorate( request , @railway_line , max_delay , controller ).render
  end

  def render_train_information_test
    h.render inline: <<-HAML , type: :haml , locals: { railway_line: @railway_line , status_list_for_test: STATUS_LIST_FOR_TEST }
- railway_line_decorated = railway_line.decorate
- status_list_for_test.each do | test_status |
  %div{ class: [ :train_information_test , :railway_line ] }
    = railway_line_decorated.render_matrix( make_link_to_railway_line: true , size: :small , link_controller_name: :train_information )
    %div{ class: [ :status , test_status[ "status_type" ] ] }
      %div{ class: :infos }
        %div{ class: :icon }<
          = ::TokyoMetro::App::Renderer::Icon.send( test_status[ "status_type" ] , request , 3 ).render
        %div{ class: :text }
          %p{ class: :text_ja }<
            = test_status[ "status_text_ja" ]
          %p{ class: :text_en }<
            = test_status[ "status_text_en" ]
        - if test_status[ "additional_info_abstruct" ].present? or test_status[ "additional_info_precise" ].present?
          %div{ class: :additional_infos }<
            - if test_status[ "additional_info_abstruct" ].present?
              %div{ class: :abstruct }<
                = test_status[ "additional_info_abstruct" ]
            - if test_status[ "additional_info_precise" ].present?
              %div{ class: :precise }<
                = test_status[ "additional_info_precise" ]
    HAML
  end

  def render_train_information_precise_version
    @train_information.decorate( @railway_line , max_delay ).render_precise_version
  end

  def render_train_locations
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
= info.train_locations.exclude_toei_mita_line.decorate( request , info.railway_line ).render
    HAML
  end

  private

  def get_train_information( http_client )
    train_informations = ::TokyoMetro::Api::TrainInformation.get(
      http_client ,
      railway_line: @railway_line.same_as ,
      perse_json: true ,
      generate_instance: true
    )
    if train_informations.length > 1
      raise "Error"
    end
    @train_information = train_informations.first
    sleep( 0.2 )
  end

  def get_train_locations( http_client )
    @train_locations = ::TokyoMetro::Api::TrainLocation.get(
      http_client ,
      @railway_line.same_as ,
      perse_json: true ,
      generate_instance: true
    )
    sleep( 0.2 )
  end

  def max_delay
    @train_locations.max_delay
  end

end