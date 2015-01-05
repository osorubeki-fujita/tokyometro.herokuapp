module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::NambokuAndToeiMitaLine

  private

  # 南北線内の都営三田線の列車か否かを判定するメソッド
  # @return [Boolean]
  # @note 必要に応じてサブクラスで上書きする。
  def toei_mita_line_train_in_namboku_line?
    namboku_line? and is_terminating_on_toei_mita_line?
  end

end