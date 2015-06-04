class DocumentController < ApplicationController

  include TwitterProcessor

  def index
    @title = "開発ドキュメント"
    @models = ::TokyoMetro::Modules::Db::Model.list

    render 'document/index' , layout: 'application'
  end

  def operators
    @operators = Operator.all
    @title = "鉄道事業者"
    @title_en = "Operators"
    @title_ja = @title
    render 'document/operators' , layout: 'application'
  end

  def train_owners
    @train_owners = TrainOwner.all.includes( :operator )
    @title = "車両所有事業者"
    @title_en = "Train owners"
    @title_ja = @title
    render 'document/train_owners' , layout: 'application'
  end

  def railway_lines
    @railway_lines = RailwayLine.all.includes( :operator )
    @title = "路線"
    @title_en = "Railway lines"
    @title_ja = @title
    render 'document/railway_lines' , layout: 'application'
  end

  def railway_directions
    infos = RailwayDirection.all.includes( :railway_line , :station_info , railway_line: :operator )
    @title = "路線の行先（方面）"
    @title_en = "Railway directions"
    @title_ja = @title

    @railway_directions = infos
    render 'document/railway_directions' , layout: 'application'
  end

  def train_types
    infos = TrainType.all.includes( :railway_line , :train_type_in_api , # :train_type_stopping_patterns ,
      # train_type_stopping_patterns: :stopping_patterns ,
      railway_line: :operator
    )
    @title = "列車種別"
    @title_en = "Train types"
    @title_ja = @title

    @train_types = infos
    render 'document/train_types' , layout: 'application_wide'
  end

  def how_to_use
    @title = "使い方・機能のご説明"
    @title_en = "How to use"
    @title_ja = @title
    set_twitter_processor( :tokyo_metro )
    render 'document/how_to_use' , layout: 'application'
  end

  def table
    table_container = TableContainer.new( params )

    if table_container.redirect_to_index_from_table_page?
      redirect_to( controller: :document , action: :index , status: :not_found )
      return

    elsif table_container.invalid_page?
      redirect_if_page_is_invalid( table_container.page_number_max )
      return

    end

    infos = table_container.infos_to_render_normally

    @model_namespace_in_rails = infos[ :model_namespace_in_rails ]
    @title = infos[ :title ]
    # @datum = infos[ :datum ]
    @datum = @model_namespace_in_rails.order( :id ).page( table_container.send( :page ) ).per( table_container.rows_in_a_page )
    render 'document/table' , layout: 'application_wide'
  end

  private

  def redirect_if_page_is_invalid( actual_page )
    redirect_to( controller: :document , action: :table , model_namespace_in_url: @model_namespace_in_url , page: actual_page , status: :see_other )
  end

  class TableContainer

    @@models = ::TokyoMetro::Modules::Db::Model.list

    def initialize( params )
      @rows_in_a_page = 100
      @params = params

      model_info = @@models.find { | info | info[ :model ].underscore.gsub( "/" , "_" ) == model_namespace_in_url }
      @model_namespace_in_rails = eval( model_info[ :model ] )
      @count = model_info[ :count ]
    end

    attr_reader :rows_in_a_page

    def infos_to_render_normally
      {
        model_namespace_in_rails: @model_namespace_in_rails ,
        title: title ,
        datum: datum
      }
    end

    def no_data?
      @count == 0
    end

    def redirect_to_index_from_table_page?
      no_data?
    end

    def invalid_page?
      page_number_max < page
    end

    def page_number_max
      if no_data?
        0
      else
        ( @count * 1.0 / @rows_in_a_page ).ceil
      end
    end

    private
    
    def model_namespace_in_url
      @params[ :model_namespace_in_url ]
    end
    
    def page
      @params[ :page ].with_default_value(1).to_i
    end

    def title
      "#{ @model_namespace_in_rails } (#{ page }/#{ page_number_max })"
    end

    # def id_min
      # [ @count , ( page - 1 ) * @rows_in_a_page + 1 ].min
    # end

    # def id_max
      # [ page * @rows_in_a_page , @count ].min
    # end

    # def id_range
      # ( id_min..id_max ).to_a
    # end

    def datum
      @model_namespace_in_rails.page( page ).per( @rows_in_a_page ).order( :id )
    end

  end

end