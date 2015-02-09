class TokyoMetro::Factories::Seed::Static::Operator::Hash < TokyoMetro::Factories::Seed::Static::MetaClass::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::Operator

  private

  def seed_optional_infos
    seed_instance_for_escaping_undefined
  end

  def seed_instance_for_escaping_undefined
    self.class.db_instance_class.create(
      same_as: "odpt.Operator:Undefined" ,
      name_ja: "未定義" ,
      name_en: "Undefined"
    )
  end

end