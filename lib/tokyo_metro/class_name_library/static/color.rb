module TokyoMetro::ClassNameLibrary::Static::Color

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_class
      ::TokyoMetro::Static::Color
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::Color::Info
    end

  end

end