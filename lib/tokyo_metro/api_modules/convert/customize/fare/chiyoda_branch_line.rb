module TokyoMetro::ApiModules::Convert::Customize::Fare::ChiyodaBranchLine

  def self.set_modules
    ::TokyoMetro::Api::Fare::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::Fare::ChiyodaBranchLine::KitaAyase::Info
    end

    ::TokyoMetro::Factories::Generate::Api::Fare::List.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Customize::Fare::ChiyodaBranchLine::Ayase::Generate::List
    end
  end
end