module TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::ToiletAssistant

  def facility_for_ostomate
    ostomate
  end

  # 幼児用の設備があるか否かを判定するメソッド
  # @return [Boolean]
  def facility_for_baby
    baby_chair or baby_changing_table
  end

  [ :baby_chair , :baby_changing_table , :facility_for_ostomate , :facility_for_baby ].each do | instance_variable_name |
    eval <<-DEF
      def has_#{ instance_variable_name }?
        #{ instance_variable_name }
      end

      def #{ instance_variable_name }_available?
        #{ instance_variable_name }
      end
    DEF
  end

  [ :ostomate , :baby ].each do | instance_variable_base_name |
    [ "for_#{ instance_variable_base_name }?" , "available_to_#{ instance_variable_base_name }?" ].each do | method_name |
      eval <<-DEF
        def #{ method_name }
          facility_for_#{ instance_variable_base_name }
        end
      DEF
    end
  end

  def method_missing( method_name , *args )
    if args.empty? and /(?:baby|babies|ostomate)/ === method_name.to_s
      valid_method_name = method_missing__valid_method( method_name )
      if valid_method_name.present?
        send( valid_method_name )
      end
    end

    super
  end

  def to_a
    ary = ::Array.new
    if wheel_chair_accessible?
      ary << "車いす対応"
    end
    if has_baby_chair?
      ary << "乳幼児用いす"
    end
    if has_baby_changing_table?
      ary << "おむつ交換台"
    end
    if has_facility_for_ostomate?
      ary << "オストメイト対応設備"
    end
    ary
  end

  def to_s
    to_a.join("／")
  end

  def to_h
    h = ::Hash.new
    [ :wheel_chair_accessible , :baby_chair , :baby_changing_table , :ostomate ].each do | key_name |
      h[ key_name ] = self.send( key_name )
    end
    h
  end

  private

  def method_missing__valid_method( method_name )
    case method_name.to_s
    when /\Ahas_/
      if /\Ahas_(baby_(?:chair|changing_table))(?:s)?(?:\?)?\Z/ =~ method_name.to_s
        return "has_#{$1}?"
      elsif /\Ahas_facilit(?:y|ies)_for_(ostomate(?:s)?|bab(?:y|ies))(?:\?)?\Z/ =~ method_name.to_s
        return "has_facility_for_#{$1.singularize}?"
      end
    when /_available(?:\?)?\Z/
      if /\A(baby_(?:chair|changing_table))(?:_is|s_are)?_available(?:\?)?\Z/ =~ method_name.to_s
        return "#{$1}_available?"
      elsif /\A(?:(?:is_)(.+)|(.+)(?:_is))_available(?:\?)?\Z/ =~ method_name.to_s
        if /\Afacility_for_(ostomate(?:s)?|bab(?:y|ies))/ =~ $1
          return "facility_for_#{$1.singularize}_available?"
        end
      elsif /\A(?:(?:are_)(.+)|(.+)(?:_is))_available(?:\?)?\Z/ =~ method_name.to_s
        if /\Afacilities_for_(ostomate(?:s)?|bab(?:y|ies))/ =~ $1
          return "facility_for_#{$1.singularize}_available?"
        end
      elsif /\A(.+)_available(?:\?)?\Z/ =~ method_name.to_s
        if /\Afacilit(?:y|ies)_for_(ostomate(?:s)?|bab(?:y|ies))/ =~ $1
          return "facility_for_#{$1.singularize}_available?"
        end
      end
    when /\A(?:is_)?for_(ostomate(?:s)?|bab(?:y|ies))(?:\?)?\Z/
      return "for_#{$1.singularize}?"
    when /\A(?:is_)?available_(?:to|for)_(ostomate(?:s)?|bab(?:y|ies))(?:\?)?\Z/
      return "available_to_#{$1.singularize}?"
    end

    nil
  end

end