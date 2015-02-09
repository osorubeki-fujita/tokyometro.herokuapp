module TokyoMetro::CommonModules::ToFactory::Seed::List

  extend ActiveSupport::Concern
  include ::TokyoMetro::CommonModules::ToFactory::Seed::Group

  module ClassMethods

    def factory_for_seeding_this_class
      factory_for_seeding_list
    end

  end

end