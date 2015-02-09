class TokyoMetro::Factories::Seed::Static::TrainInformationStatus::Info < TokyoMetro::Factories::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainInformationStatus

  private

  def hash_to_db
    { in_api: @info.in_api , name_ja: @info.name_ja }
  end

end