module TokyoMetro::Modules::Common::Info::Decision::ToeiMitaLine

  private

  # 南北線内の都営三田線の列車か否かを判定するメソッド
  # @return [Boolean]
  # @note 必要に応じてサブクラスで上書きする。
  def namboku_line_train_for_nishi_takashimadaira?
    namboku_line? and terminating_on_toei_mita_line?
  end

  def toei_mita_line_train_for_nishi_takashimadaira?
    toei_mita_line? and terminating_on_toei_mita_line?
  end

  def namboku_or_toei_mita_line_train_for_nishi_takashimadaira?
    namboku_line_train_for_nishi_takashimadaira? and toei_mita_line_train_for_nishi_takashimadaira?
  end

  def namboku_line_train_terminating_on_namboku_or_saitama_railway_line?
    namboku_line? and ( terminating_on_namboku_line? or terminating_on_saitama_railway_line? )
  end

  def terminating_on_tokyu_lines?
    terminating_on_tokyu_meguro_line? or terminating_on_tokyu_toyoko_line? or terminating_on_minatomirai_line?
  end

  def namboku_line_train_terminating_on_tokyu_lines?
    namboku_line? and terminating_on_tokyu_lines?
  end

  def toei_mita_line_train_terminating_on_tokyu_lines?
    toei_mita_line? and terminating_on_tokyu_lines?
  end

  def namboku_or_toei_mita_line_train_terminating_on_tokyu_lines?
    namboku_line_train_terminating_on_tokyu_line? or toei_mita_line_train_terminating_on_tokyu_line?
  end

  def toei_mita_line_train_including_on_namboku_line?
    ( toei_mita_line? or namboku_line? ) and ( starting_on_toei_mita_line? or terminating_on_toei_mita_line? )
  end

  [
    :namboku_line_train_for_nishi_takashimadaira? ,
    :toei_mita_line_train_for_nishi_takashimadaira? ,
    :namboku_or_toei_mita_line_train_for_nishi_takashimadaira? ,
    :namboku_line_train_terminating_on_namboku_or_saitama_railway_line? ,
    :terminating_on_tokyu_lines? ,
    :namboku_line_train_terminating_on_tokyu_lines? ,
    :toei_mita_line_train_terminating_on_tokyu_lines? ,
    :namboku_or_toei_mita_line_train_terminating_on_tokyu_lines? ,
    :toei_mita_line_train_including_on_namboku_line?
  ].each do | method_base_name |
    eval <<-DEF
      alias :is_#{ method_base_name } :#{ method_base_name }
    DEF
  end

end