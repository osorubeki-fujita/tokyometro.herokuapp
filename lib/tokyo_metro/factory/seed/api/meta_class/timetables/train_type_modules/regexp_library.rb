module TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::RegexpLibrary

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
    elsif namboku_line? or toei_mita_line?
      regexp_to_select_train_type_namboku_and_toei_mita
    else
      raise error_msg
    end
  end

  def regexp_to_select_train_type_tozai
    if terminating_at_mitaka?
      /ForMitaka\Z/
    elsif terminating_at_tsudanuma?
      /ForTsudanuma\Z/
    elsif terminating_on_toyo_rapid_line?
      /ForToyoRapidRailway\Z/
    else
      /Normal\Z/
    end
  end

  # 千代田線の列車種別を選択するためのメソッド
  # @return [Regexp]
  # @note {#regexp_to_select_train_type_chiyoda_except_for_for_odakyu_or_jr_joban_line} は必要に応じてサブクラスで上書きする。
  def regexp_to_select_train_type_chiyoda
    if terminating_on_odakyu_line?
      /Odakyu\Z/
    elsif terminating_on_jr_joban_line?
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
    if terminating_on_tokyu_den_en_toshi_line?
      /ToTokyu\Z/
    elsif terminating_on_tobu_main_line?
      /ToTobu\Z/
    else
      /Normal\Z/
    end
  end

  def regexp_to_select_train_type_namboku_and_toei_mita
    #-------- 東急直通
    #   @note 日吉から先、菊名、横浜、元町・中華街方面への乗り入れも想定
    # 南北線
    if namboku_line_train_terminating_on_tokyu_lines?
      /TokyoMetro\.Namboku\.[[:alpha:]]+\.ToTokyu\Z/
    # 都営三田線
    elsif toei_mita_line_train_terminating_on_tokyu_lines?
      /Toei\.Mita\.[[:alpha:]]+\.ToTokyu\Z/

    #-------- 南北線内止まり or 埼玉高速鉄道直通
    elsif namboku_line_train_terminating_on_namboku_or_saitama_railway_line?
      /TokyoMetro\.Namboku\.Local\.Normal\Z/
    else
      raise "Error: The terminal station \"#{ @terminal_station_in_db.same_as }\" is not valid."
    end
  end

end