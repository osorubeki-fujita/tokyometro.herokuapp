module ForRails::RegexpLibrary

  extend ::ActiveSupport::Concern

  module ClassMethods

    # HAML で使用する、括弧に対する正規表現
    # @return [Regexp]
    def parentheses
      /((?:\(（|【).+(?:】|）)\))\Z/
    end

  end

end