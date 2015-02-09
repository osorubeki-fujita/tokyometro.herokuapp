class TokyoMetro::Factories::Seed::Static::RailwayLine::Hash < TokyoMetro::Factories::Seed::Static::Operator::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::RailwayLine

  private

  def seed_instance_for_escaping_undefined
    self.class.db_instance_class.create(
      same_as: "odpt.Railway:Undefined" ,
      name_ja: "未定義" ,
      name_en: "Undefined" ,
      operator_id: ::Operator.find_by( same_as: "odpt.Operator:Undefined" ).id
    )
  end

end