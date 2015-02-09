module TokyoMetro::ApiModules::Convert::Customize::Station::StationCodeOfNakanoSakaueOnMarunouchiBranchLine

  def self.set_modules
    ::TokyoMetro::Api::Station::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::Station::StationCodeOfNakanoSakaueOnMarunouchiBranchLine::Info
    end
  end

end