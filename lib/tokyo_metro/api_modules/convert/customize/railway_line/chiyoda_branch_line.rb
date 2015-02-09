module TokyoMetro::ApiModules::Convert::Customize::RailwayLine::ChiyodaBranchLine

  def self.set_modules
    ::TokyoMetro::Factories::Generate::Api::RailwayLine::List.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Customize::RailwayLine::ChiyodaBranchLine::Generate::List
    end
  end

end