class ConnectingRailwayLine::Note < ActiveRecord::Base
  has_many :infos , class: ::ConnectingRailwayLine::Info

  def connecting_railway_line_infos
    infos
  end

  def railway_lines
    infos
  end

  def to_s
    ja
  end

  def to_a
    ja.gsub( /。\n?/ , "。\n" ).split( /\n/ )
  end

end
