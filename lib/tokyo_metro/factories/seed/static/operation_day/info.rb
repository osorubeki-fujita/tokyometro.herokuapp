class TokyoMetro::Factories::Seed::Static::OperationDay::Info < TokyoMetro::Factories::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::OperationDay

  private

  def hash_to_db
    @info.to_h
  end

end