# トイレの補助設備の情報 (Struct)
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Assistant < ::Struct.new( :wheelchair_accessible , :baby_chair , :baby_changing_table , :ostomate )

  def to_s
    str_ary = ::Array.new
    if wheelchair_accessible
      str_ary << "車いす対応"
    end
    if baby_chair
      str_ary << "幼児用椅子"
    end
    if baby_changing_table
      str_ary << "おむつ交換台"
    end
    if ostomate
      str_ary << "オストメイト設備"
    end

    str_ary.join("／")
  end

  def seed( bf_instance_id )
    puts "Begin \[Toilet\]: #{bf_instance_id}"
    pattern_h = {
      wheelchair_accessible: self.wheelchair_accessible ,
      baby_chair: self.baby_chair ,
      baby_changing_table: self.baby_changing_table ,
      ostomate: self.ostomate
    }
    pattern = ::BarrierFreeFacilityToiletAssistantPattern.find_or_create_by( pattern_h )
    raise "Error" if pattern.nil?

    h = {
      barrier_free_facility_id: bf_instance_id ,
      barrier_free_facility_toilet_assistant_pattern_id: pattern.id
    }
    ::BarrierFreeFacilityToiletAssistant.create(h)
    puts "Complete \[Toilet\]: #{bf_instance_id}"
  end

  # @!group インスタンスメソッド

  # 車いすが利用か否かを判定するメソッド
  # @return [Boolean]
  def wheelchair_accessible
    self[ :wheelchair_accessible ]
  end

  # 幼児用の椅子が設置されているか否かを判定するメソッド
  # @return [Boolean]
  def baby_chair
    self[ :baby_chair ]
  end

  # おむつ交換台が設置されているか否かを判定するメソッド
  # @return [Boolean]
  def baby_changing_table
    self[ :baby_changing_table ]
  end

  # オストメイト設備が設置されているか否かを判定するメソッド
  # @return [Boolean]
  def ostomate
    self[ :ostomate ]
  end

  alias :wheelchair_accessible? :wheelchair_accessible
  alias :baby_chair_available? :baby_chair
  alias :baby_changing_table_available? :baby_changing_table
  alias :ostomate_available? :ostomate

  # 幼児用の設備があるか否かを判定するメソッド
  # @return [Boolean]
  def facility_for_baby_available?
    self.baby_chair_available? or self.baby_changing_table_available?
  end

  # @!endgroup

  # @!group クラスメソッド

# JSON をパースして得られた配列からインスタンスを作成するメソッド
# @param ary [::Array] JSON をパースして得られた配列
# @return [Assistant]
  def self.generate_from_array( ary )
    variables = [
      # JSON
      "spac:WheelchairAssesible" , "ug:BabyChair" , "ug:BabyChangingTable" , "ug:ToiletForOstomate"
      # ドキュメント
      # "spac:WheelchairAssessible" , "ug:BabyChair" , "ug:BabyChangingTable" , "ug:ToiletForOstomate"
      # 正しい英語
      # "spac:WheelchairAccessible" , "ug:BabyChair" , "ug:BabyChangingTable" , "ug:ToiletForOstomate"
    ].map { | str |
      ary.include?( str )
    }
    # puts "::Array: #{ary.to_s}"
    # puts "Variables: #{ variables.to_s }"
    # puts "OK?"
    # puts ""
    # a = gets

    self.new( *variables )
  end

  # @!endgroup

end