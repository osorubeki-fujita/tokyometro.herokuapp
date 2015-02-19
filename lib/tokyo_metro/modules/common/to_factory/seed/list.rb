module TokyoMetro::Modules::Common::ToFactory::Seed::List

  extend ActiveSupport::Concern
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Group

  module ClassMethods

    def factory_for_seeding_this_class
      factory_for_seeding_list
    end

  end

end