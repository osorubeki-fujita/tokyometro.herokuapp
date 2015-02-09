# トイレの補助設備の情報
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Assistant

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::CommonModules::ToFactory::Generate::Info
  include ::TokyoMetro::CommonModules::ToFactory::Seed::Info

  def initialize( wheelchair_accessible , baby_chair , baby_changing_table , ostomate )
    @wheelchair_accessible = wheelchair_accessible
    @baby_chair = baby_chair
    @baby_changing_table = baby_changing_table
    @ostomate = ostomate
  end

  # 車いすが利用可能か否か
  # @return [Boolean]
  attr_reader :wheelchair_accessible

  # 幼児用の椅子が設置されているか否か
  # @return [Boolean]
  attr_reader :baby_chair

  # おむつ交換台が設置されているか否か
  # @return [Boolean]
  attr_reader :baby_changing_table

  # オストメイト設備が設置されているか否か
  # @return [Boolean]
  attr_reader :ostomate

  alias :wheelchair_accessible? :wheelchair_accessible

  [ :baby_chair , :baby_changing_table , :ostomate ].each do | instance_variable_name |
    eval <<-DEF
      alias :#{ instance_variable_name }_available? :#{ instance_variable_name }
      alias :has_#{ instance_variable_name }? :#{ instance_variable_name }
    DEF
  end

  # 幼児用の設備があるか否かを判定するメソッド
  # @return [Boolean]
  def facility_for_baby_available?
    baby_chair_available? or baby_changing_table_available?
  end

  alias :has_facility_for_baby? :facility_for_baby_available?

  def to_s
    str_ary = ::Array.new
    if @wheelchair_accessible
      str_ary << "車いす対応"
    end
    if @baby_chair
      str_ary << "幼児用椅子"
    end
    if @baby_changing_table
      str_ary << "おむつ交換台"
    end
    if @ostomate
      str_ary << "オストメイト設備"
    end

    str_ary.join("／")
  end

  def to_h
    h = ::Hash.new
    [ :wheelchair_accessible , :baby_chair , :baby_changing_table , :ostomate ].each do | key_name |
      h[ key_name ] = self.send( key_name )
    end
    h
  end

  # @!group クラスメソッド

  def self.factory_for_this_class
    factory_for_generating_barrier_free_toilet_assistant_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_toilet_service_detail_assistant_info
  end

  # @!endgroup

end