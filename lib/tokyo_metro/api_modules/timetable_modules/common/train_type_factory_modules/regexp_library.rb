module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::RegexpLibrary

  private

  def regexp_to_select_train_type
    #-------- 東西線
    if tozai_line?
      regexp_to_select_train_type_tozai
    #-------- 千代田線
    elsif chiyoda_line?
      regexp_to_select_train_type_chiyoda
    #-------- 半蔵門線
    elsif hanzomon_line?
      regexp_to_select_train_type_hanzomon
    #-------- 南北線
    elsif namboku_line?
      regexp_to_select_train_type_namboku
    else
      raise error_msg
    end
  end

  def regexp_to_select_train_type_tozai
    if is_terminating_at_mitaka?
      /ForMitaka\Z/
    elsif is_terminating_at_tsudanuma?
      /ForTsudanuma\Z/
    elsif is_terminating_on_toyo_rapid_line?
      /ForToyoRapidRailway\Z/
    else
      /Normal\Z/
    end
  end

  # 千代田線の列車種別を選択するためのメソッド
  # @return [Regexp]
  # @note {#regexp_to_select_train_type_chiyoda_except_for_for_odakyu_or_jr_joban_line} は必要に応じてサブクラスで上書きする。
  def regexp_to_select_train_type_chiyoda
    if is_terminating_on_odakyu_line?
      /Odakyu\Z/
    elsif is_terminating_on_jr_joban_line?
      /ForJR\Z/
    else
      regexp_to_select_train_type_chiyoda_except_for_for_odakyu_or_jr_joban_line
    end
  end

  # 千代田線の列車種別を選択するためのメソッド（乗り入れがない場合）
  # @return [Regexp]
  # @note 必要に応じてサブクラスで上書きする。
  def regexp_to_select_train_type_chiyoda_except_for_for_odakyu_or_jr_joban_line
    /Normal\Z/
  end

  def regexp_to_select_train_type_hanzomon
    if is_terminating_on_tokyu_den_en_toshi_line?
      /ToTokyu\Z/
    elsif is_terminating_on_tobu_main_line?
      /ToTobu\Z/
    else
      /Normal\Z/
    end
  end

  def regexp_to_select_train_type_namboku
    if is_terminating_on_tokyu_meguro_line? or is_terminating_on_tokyu_toyoko_line? # 日吉から先、菊名、横浜、元町・中華街方面への乗り入れも想定
      /TokyoMetro\.Namboku\.[[:alpha:]]+\.ToTokyu\Z/
    elsif is_terminating_on_namboku_line? or is_terminating_on_saitama_railway_line?
      /TokyoMetro\.Namboku\.Local\.Normal\Z/
    else
      raise "Error: The terminal station \"#{ @terminal_station_instance.same_as }\" is not valid."
    end
  end

end