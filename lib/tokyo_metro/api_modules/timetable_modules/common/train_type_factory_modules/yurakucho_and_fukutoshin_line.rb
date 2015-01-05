module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::YurakuchoAndFukutoshinLine

  private

  # 有楽町線・副都心線の列車種別を取得するメソッド
  # @note 必要に応じてサブクラスで上書きする。
  # @return [TrainType(s)]
  def yurakucho_and_fukutoshin_train_type
    #-------- 「休日急行」（明治神宮前に停車）対策
    process_holiday_express_of_fukutoshin_line

    #-------- 列車種別（API）の取得
    train_type_in_api_instance = ::TrainTypeInApi.find_by_same_as( @train_type_same_as )

    #-------- 小竹向原から和光市方面に行く場合 or 西武線方面へ行く場合
    if ( is_terminating_on_tobu_tojo_line? or is_terminating_at_wakoshi? ) or is_terminating_on_seibu_line?
      h = {
        railway_line_id: @railway_line_instance.id ,
        train_type_in_api: train_type_in_api_instance.id
      }
      train_types = ::TrainType.where(h).select_colored_if_exist
      puts train_types.to_s
    #-------- 終着駅が有楽町線内・副都心線内・東急方面の場合
    else
      train_types = select_train_types_to_yurakucho_fukutoshin_or_tokyu_mm_line( train_type_in_api_instance )
    end

    select_one_from_multiple_train_types( train_types )
  end

  # @!group 列車種別を処理するメソッド

  # 副都心線の休日の急行列車（明治神宮前に停車）か否かを判定し、判定結果が真であればインスタンス変数 train_type_same_as を変更するメソッド
  # @return [nil]
  def process_holiday_express_of_fukutoshin_line
    if express? and operated_on_holiday? and yurakucho_or_fukutoshin_line?
      @train_type_same_as = "odpt.TrainType:TokyoMetro.HolidayExpress"
    end
    return nil
  end

  # @!endgroup

  # 終着駅が有楽町線内・副都心線内・東急方面の場合の列車種別を取得するメソッド
  # @return [TrainType(s)]
  def select_train_types_to_yurakucho_fukutoshin_or_tokyu_mm_line( train_type_in_api_instance )
    if is_terminating_on_yurakucho_line?
      h = {
        railway_line_id: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Yurakucho" ).id ,
        train_type_in_api: train_type_in_api_instance.id
      }
      ::TrainType.where(h).select { | train_type | train_type.colored? }

    elsif is_terminating_on_fukutoshin_line? or is_terminating_on_tokyu_toyoko_line? or is_terminating_on_minatomirai_line?
      h = {
        railway_line_id: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Fukutoshin" ).id ,
        train_type_in_api: train_type_in_api_instance.id
      }
      train_types = ::TrainType.where(h)
      puts "#{ self.class.name }"
      puts "☆ Train type #{ @train_type_same_as }"
      if local?
        train_types = train_types.select { | train_type | train_type.colored? }
      end
      train_types

    else
      raise "Error: The terminal station \"#{ @terminal_station_instance.same_as } is not valid."
    end
  end

end