module TokyoMetro::Modules::Common::ToFactory::Seed::Hash

  extend ActiveSupport::Concern
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Group

  module ClassMethods

    def factory_for_seeding_this_class
      factory_for_seeding_hash
    end

  end

end