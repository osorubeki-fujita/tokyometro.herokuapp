class TokyoMetro::Factory::Seed::Static::TrainInformationStatus::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainInformationStatus

  private

  def hash_to_db
    { in_api: @info.in_api , name_ja: @info.name_ja }
  end

end