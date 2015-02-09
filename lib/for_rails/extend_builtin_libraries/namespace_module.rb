module ForRails::ExtendBuiltinLibraries::NamespaceModule

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group 名前空間に関するメソッド

    # 上位の名前空間が存在するか否かを判定するメソッド
    # @return [Boolean]
    def upper_namespace_exist?
      # Module.nesting.length > 1
      upper_namespace_exist_sub?
    end

    # 上位の名前空間の名称を取得するメソッド
    # @return [Const (classname)]
    def upper_namespace
      if upper_namespace_exist?
        eval( self.name.split( "::" )[0..-2].join( "::" ) )
        # Module.nesting[1]
      else
        raise "Error: \"#{self.name}\" does not have an upper namespace."
      end
    end

    private

    def upper_namespace_exist_sub?
      class_name = name
      /\:\:/ === class_name
    end

  end

end