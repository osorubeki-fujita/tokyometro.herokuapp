module TokyoMetro::Modules::Common::ToFactory::Seed::Info

  extend ActiveSupport::Concern

  def seed( *variables )
    variables_send_to_factory = ::Array.new
    variables_send_to_factory << self
    variables_send_to_factory += variables
    self.class.factory_for_seeding_this_class.process( *variables_send_to_factory )
  end

  module ClassMethods

    # DB への流し込みに使用する Factory Pattern クラス
    # @note .factory_for_seeding_info 以外を使用する場合は上書きする。
    def factory_for_seeding_this_class
      factory_for_seeding_info
    end

  end

end