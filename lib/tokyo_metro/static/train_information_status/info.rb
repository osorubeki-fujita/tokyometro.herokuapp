class TokyoMetro::Static::TrainInformationStatus::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainInformationStatus
  include ::TokyoMetro::CommonModules::ToFactory::Generate::Info
  include ::TokyoMetro::CommonModules::ToFactory::Seed::Info

  def initialize( in_api , name_ja )
    @in_api = in_api
    @name_ja = name_ja
  end

  attr_reader :in_api
  attr_reader :name_ja

end