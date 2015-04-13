class TokyoMetro::ApiProcessor::RealTimeInfos::ProvisionStatus::EachRailwayLine

  def initialize( train_informations: :provided , train_locations: :provided )
    @train_informations = train_informations
    @train_locations = train_locations
  end

  attr_reader :train_informations
  attr_reader :train_locations

  def train_informations_are_provided?
    @train_informations == :provided
  end

  def train_informations_are_not_provided?

  end

  def train_locations_provided?
    @train_locations == :provided
  end

  def train_informations_are_not_provided!
    @train_informations = :not_provided
  end

  def train_locations_are_not_provided!
    @train_locations = :not_provided
  end

end