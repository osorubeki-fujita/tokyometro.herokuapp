class ConnectingRailwayLineNote < ActiveRecord::Base
  has_many :connecting_railway_lines

  def railway_lines
    connecting_railway_lines
  end

  def to_s
    note
  end

  def to_a
    note.gsub( /。\n?/ , "。\n" ).split( /\n/ )
  end

end