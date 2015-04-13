module TokyoMetro::Modules::Api::Convert::Customize::Fare::ChiyodaBranchLine

  def self.set_modules
    ::TokyoMetro::Api::Fare::Info.class_eval do
      prepend ::TokyoMetro::Modules::Api::Convert::Customize::Fare::ChiyodaBranchLine::KitaAyase::Info
    end

    ::TokyoMetro::Factory::Generate::Api::Fare::List.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Customize::Fare::ChiyodaBranchLine::Ayase::Generate::List
    end
  end
end