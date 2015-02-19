module TokyoMetro::Modules::Db::Model

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  GROUP = ::YAML.load_file( "#{ ::TokyoMetro.dictionary_dir }/models.yaml" )

  def self.list
    make_list( group )
  end

  def self.list_sort_by_alphabet
    make_list( { "All" => group.values.flatten.sort } )
  end

  class << self

    private

    def make_list(h)
      model_ary = ::Array.new
      h.each do | category , models |
        models.each.with_index(1) do | model , i |
          if i == 1
            category_name = category
          else
            category_name = nil
          end
          model_ary << [ category_name , model , eval( "::#{model}.all.count" ) ]
        end
      end
      model_ary
    end

  end

end