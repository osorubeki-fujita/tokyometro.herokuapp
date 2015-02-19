class DocumentController < ApplicationController

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
    infos = RailwayDirection.all.includes( :railway_line , :station , railway_line: :operator )
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
    render 'document/how_to_use' , layout: 'application'
  end

end