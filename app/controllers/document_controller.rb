class DocumentController < ApplicationController

  include TwitterProcessor

  def index
    @title = "開発ドキュメント"
    @models = ::TokyoMetro::Factory::Db::Model.list

    render 'document/index' , layout: 'application'
  end

  def operator_infos
    @operator_infos = ::Operator::Info.all
    @title = "鉄道事業者"
    @title_en = "Operators"
    @title_ja = @title
    render 'document/operator_infos' , layout: 'application'
  end

  def train_owners
    @train_owners = ::Operator::AsTrainOwner.all.includes( :operator_info )
    @title = "車両所有事業者"
    @title_en = "Train owners"
    @title_ja = @title
    render 'document/train_owners' , layout: 'application'
  end

  def railway_line_infos
    @railway_line_infos = ::Railway::Line::Info.all.includes( :operator_info )
    @title = "路線"
    @title_en = "Railway lines"
    @title_ja = @title
    render 'document/railway_line_infos' , layout: 'application_wide'
  end

  def railway_directions
    infos = ::Railway::Direction.all.includes( :railway_line_info , :station_info , railway_line_info: :operator_info )
    @title = "路線の行先（方面）"
    @title_en = "Railway directions"
    @title_ja = @title

    @railway_directions = infos
    render 'document/railway_directions' , layout: 'application'
  end

  def train_type_infos
    infos = ::Train::Type::Info.all.includes( :railway_line_info , :in_api , # :train_type_stopping_patterns ,
      # train_type_stopping_patterns: :stopping_patterns ,
      railway_line_info: :operator_info
    )
    @title = "列車種別"
    @title_en = "Train types"
    @title_ja = @title

    @train_type_infos = infos
    render 'document/train_type_infos' , layout: 'application_wide'
  end

  def how_to_use
    @title = "使い方・機能のご説明"
    @title_en = "How to use"
    @title_ja = @title
    set_twitter_processor( :tokyo_metro )
    render 'document/how_to_use' , layout: 'application'
  end

  def csv_table
    table_container = TableContainer.new( params )

    if table_container.redirect_to_index_from_table_page?
      redirect_to( controller: :document , action: :index , status: :not_found )
      return
    end

    @datum = table_container.model_namespace_in_rails.all
    render 'document/csv_table.csv' , layout: nil
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

    @model_namespace_in_url = table_container.model_namespace_in_url
    @model_namespace_in_rails = table_container.model_namespace_in_rails

    infos = table_container.infos_to_render_normally

    @title = infos[ :title ]
    @datum = infos[ :datum ]
    render 'document/table' , layout: 'application_wide'
  end

  private

  def redirect_if_page_is_invalid( actual_page )
    redirect_to( controller: :document , action: :table , model_namespace_in_url: @model_namespace_in_url , page: actual_page , status: :see_other )
  end

end
