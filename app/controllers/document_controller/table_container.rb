class DocumentController::TableContainer

  @@models = ::TokyoMetro::App::Db::Dictionary::Models.list

  def initialize( params )
    @rows_in_a_page = 100
    @params = params

    model_info = @@models.find { | info | info[ :model ].underscore.gsub( "/" , "_" ) == model_namespace_in_url }
    @model_namespace_in_rails = eval( model_info[ :model ] )
    @count = model_info[ :count ]
  end

  attr_reader :rows_in_a_page
  attr_reader :model_namespace_in_rails

  def infos_to_render_normally
    {
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

  def model_namespace_in_url
    @params[ :model_namespace_in_url ]
  end

  private

  def page
    @params[ :page ].with_default_value(1).to_i
  end

  def title
    "#{ @model_namespace_in_rails } (#{ page }/#{ page_number_max })"
  end

  def datum
    @model_namespace_in_rails.order( :id ).page( page ).per( rows_in_a_page )
  end

end
