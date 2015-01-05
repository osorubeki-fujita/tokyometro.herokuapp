module ColorHelper

  extend ::ActiveSupport::Concern

  module ClassMethods

    def rgb_in_parentheses( web_color )
      web_color.to_rgb_color
    end

  end

end