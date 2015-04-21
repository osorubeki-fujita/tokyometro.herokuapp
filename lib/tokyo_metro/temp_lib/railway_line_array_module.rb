module TokyoMetro::TempLib::RailwayLineArrayModule

  # タイトルの路線名（日本語表記）を取得するメソッド
  def to_railway_line_name_text_ja
    if normal_line?
      self.first.name_ja
    elsif marunouchi_line_including_branch?
      self.find { | railway_line | railway_line.same_as == "odpt.Railway:TokyoMetro.Marunouchi" }.name_ja
    elsif chiyoda_line?
      self.find { | railway_line | railway_line.same_as == "odpt.Railway:TokyoMetro.Chiyoda" }.name_ja
    elsif yurakucho_and_fukutoshin_line?
      self.map( &:name_ja ).join( "・" )
    else
      raise "Error: " + self.map( &:name_ja ).to_s
    end
  end

  # タイトルの路線名（ローマ字表記）を取得するメソッド
  def to_railway_line_name_text_en
    if self.empty?
      "Undefined"
    elsif normal_line? or marunouchi_line_including_branch? or chiyoda_line?
      self.first.name_en
    elsif yurakucho_and_fukutoshin_line?
      self.map { | railway_line | railway_line.name_en.gsub( / Line\Z/ , "" ) }.join( " and " ) + " Line"
    else
      raise "Error"
    end
  end

  # 路線色の SCSS のクラスを取得するメソッド
  def to_title_color_class
    if self.empty?
      "default"
    elsif normal_line? or marunouchi_line_including_branch? or chiyoda_line?
      self.first.css_class_name
    else
      self.map( &:css_class_name ).join( "_" )
    end
  end

  private

  def normal_line?
    self.length == 1
  end

  def marunouchi_line_including_branch?
    self.map( &:same_as ) == ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.marunouchi_main_and_branch_line_same_as
  end

  def chiyoda_line?
    self.map( &:same_as ) == ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.chiyoda_main_and_branch_line_same_as
  end

  def yurakucho_and_fukutoshin_line?
    self.map( &:same_as ).sort == ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.yurakucho_and_fukutoshin_line_same_as.sort
  end

end