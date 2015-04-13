class TokyoMetro::Factory::Seed::Static::Station::RailwayLines < TokyoMetro::Factory::Seed::Static::RailwayLine::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::Station

  private

  def set_array_to_seed(h)
    @h = h
  end

  def seed_main_infos
    @h.each do | railway_line , in_each_railway_line |
      puts " " * 4 * ( @indent + 1 ) + "窶ｻ #{ railway_line }"
      puts ""
      in_each_railway_line.seed( railway_line , @indent + 2 )
    end
  end

  def seed_instance_for_escaping_undefined
    puts "seed_instance_for_escaping_undefined"
    self.class.db_instance_class.find_or_create_by(
      same_as: "odpt.Station:Undefined" ,
      name_ja: "未定義" ,
      name_en: "Undefined" ,
      railway_line_id: ::RailwayLine.find_by( same_as: "odpt.Railway:Undefined" ).id ,
      operator_id: ::Operator.find_by( same_as: "odpt.Operator:Undefined" ).id
    )
  end

end