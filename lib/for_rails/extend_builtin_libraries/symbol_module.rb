module ForRails::ExtendBuiltinLibraries::SymbolModule

  [ :underscore , :camelize , :singularize , :pluralize ].each do | method_name |
    eval <<-DEF
      def #{method_name.to_s}
        self.to_s.#{method_name.to_s}.intern
      end
    DEF
  end

end