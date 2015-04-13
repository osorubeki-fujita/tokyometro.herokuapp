module TokyoMetro::Modules::Api::Convert::Customize::Station::ChiyodaBranchLine

  def self.set_modules
    ::TokyoMetro::Factory::Generate::Api::Station::List.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Customize::Station::ChiyodaBranchLine::Generate::List
    end
  end

end