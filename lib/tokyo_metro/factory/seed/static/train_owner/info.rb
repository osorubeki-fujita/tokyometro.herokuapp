class TokyoMetro::Factory::Seed::Static::TrainOwner::Info < TokyoMetro::Factory::Seed::Static::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainOwner
  include ::TokyoMetro::Factory::Seed::Reference::Operator

  private

  def hash_to_db
    {
      same_as: @info.same_as ,
      operator_id: operator_id
    }
  end

  [ :operator_in_db , :operator_id ].each do | method_name |
    eval <<-DEF
      def #{method_name}( whole = nil , search_by: @info.operator.same_as )
        super( whole , search_by: search_by )
      end
    DEF
  end

end