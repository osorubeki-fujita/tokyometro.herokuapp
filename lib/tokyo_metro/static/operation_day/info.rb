class TokyoMetro::Static::OperationDay::Info

  include ::TokyoMetro::ClassNameLibrary::Static::OperationDay
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  def initialize( name_ja , name_en )
    @name_ja = name_ja
    @name_en = name_en
  end

  attr_reader :name_ja
  attr_reader :name_en

  alias :ja :name_ja
  alias :en :name_en

  def to_a
    [ @name_ja , @name_en ]
  end

  def to_h
    { name_ja: @name_ja , name_en: @name_en }
  end

  def match?( operation_day )
    self.to_a.include?( operation_day ) or @name_en.gsub( /\,? / , "_" ).downcase.to_s == operation_day.to_s
  end

end