module ApplicationHelper

  def self.tokyo_metro
    ::Operator.find_by_same_as( "odpt.Operator:TokyoMetro" )
  end
  
  def self.this_operator
    tokyo_metro
  end

  def self.common_title_ja
    "Rails on Ruby"
  end

  def self.common_title_en
    "Since Tokyo Metro Open Data Contest 2014"
  end

  def self.time_strf( h , m )
    m_2 = sprintf( "%2.2d" , m )
    "#{h}:#{m_2}"
  end

  def number_separated_by_comma( num )
    number_to_currency( num , unit: "" , format: "%n" , precision: 0 )
  end

  def time_info( title , time )
    render inline: <<-HAML , type: :haml , locals: { title: title , time: time }
%div{ class: :time_info }
  %div{ class: :title }<
    = title
  %div{ class: :time }<
    = time.to_strf_normal_ja
    HAML
  end

end
