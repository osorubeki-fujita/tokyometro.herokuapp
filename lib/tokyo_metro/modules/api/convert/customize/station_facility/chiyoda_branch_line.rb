module TokyoMetro::Modules::Api::Convert::Customize::StationFacility::ChiyodaBranchLine

  def self.set_modules
    ::TokyoMetro::Api::StationFacility::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::StationFacility::ChiyodaBranchLine::Info
    end
  end

end