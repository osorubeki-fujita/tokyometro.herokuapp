module TokyoMetro::Modules::Common::Info::Decision::SameAs

  def same_as?( *variables )
    compare_base( variables , self.same_as )
  end

end