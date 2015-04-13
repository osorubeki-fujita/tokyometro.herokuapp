module TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::YurakuchoAndFukutoshinLine

  private

  # 有楽町線・副都心線の列車種別を取得するメソッド
  # @note 必要に応じてサブクラスで上書きする。
  # @return [TrainType(s)]
  def yurakucho_and_fukutoshin_train_type
    process_holiday_express_of_fukutoshin_line
    select_one_from_multiple_train_types( considered_train_types_of_yurakucho_and_fukutoshin_line )
  end

  def considered_train_types_of_yurakucho_and_fukutoshin_line

    #-------- 小竹向原から和光市方面に行く場合 or 西武線方面へ行く場合
    if ( terminating_on_tobu_tojo_line? or terminating_at_wakoshi? ) or terminating_on_seibu_line?
      train_types.select_colored_if_exist

    #-------- 終着駅が有楽町線内・副都心線内・東急方面の場合
    else
      select_train_types_to_yurakucho_fukutoshin_or_tokyu_mm_line
    end
  end

  # @!group 列車種別を処理するメソッド

  # 「休日急行」（明治神宮前に停車）対策
  #   副都心線の休日の急行列車（明治神宮前に停車）か否かを判定し、判定結果が真であればインスタンス変数 train_type を変更する。
  # @return [nil]
  def process_holiday_express_of_fukutoshin_line
    if ( holiday_express? or express? ) and operated_on_holiday? and yurakucho_or_fukutoshin_line?
      @train_type = "odpt.TrainType:TokyoMetro.HolidayExpress"
    end
    return nil
  end

  # @!endgroup

  # 終着駅が有楽町線内・副都心線内・東急方面の場合の列車種別を取得するメソッド
  # @return [TrainType(s)]
  def select_train_types_to_yurakucho_fukutoshin_or_tokyu_mm_line

    if terminating_on_yurakucho_line?
      train_types( __railway_line_id__: railway_line_id( search_by: "odpt.Railway:TokyoMetro.Yurakucho" ) ).select( &:colored? )

    elsif terminating_on_fukutoshin_line? or terminating_on_tokyu_toyoko_line? or terminating_on_minatomirai_line?
      _train_types = train_types( __railway_line_id__: railway_line_id( search_by: "odpt.Railway:TokyoMetro.Fukutoshin" ) )
      # puts "#{ self.class.name }"
      # puts "☆ Train type #{ @train_type }"

      if local?
        _train_types.select( &:colored? )
      else
        _train_types
      end

    else
      raise "Error: The terminal station \"#{ @terminal_station_in_db.same_as } is not valid."
    end
  end

end