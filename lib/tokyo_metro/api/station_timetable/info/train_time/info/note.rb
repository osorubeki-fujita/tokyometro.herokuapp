# 列車の補足情報を扱うクラス
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note

  # 列車の補足情報のインスタンスを取得するメソッド
  # @param str [String] 列車の補足情報の文字列
  # @return [classes under TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note]
  def self.generate_from_string( str )

    #---- 当駅始発

    if "当駅始発" == str
      StartFromThisStation.instance

    #---- 前駅始発

    elsif /\A(.+?)駅?始発\Z/ === str
      StartingStation.set_from_string( $1 )

    #---- 発着ホーム

    elsif /\A([１２３４５６７８９\d]+)番線発\Z/ === str
      PlatformNumber.set_from_string( $1.zen_num_to_han.to_i )
    elsif /\A(.+?)駅?([１２３４５６７８９\d]+)番線着/ === str
      ArriveAt.set_from_string( $1, $2.zen_num_to_han.to_i )

    #---- 白金高輪

    elsif "白金高輪駅で目黒方面行列車に接続しません。" == str
      ShirokaneTakanawa::NoConnection.instance
    elsif /\A白金高輪駅で東京メトロ南北線に接続します。(?:（ただし、列車の遅延等により接続できない場合もありますのでご了承ください）|（ただし、列車の遅れにより連絡しない場合もあります。?）)?\Z/ === str
      ShirokaneTakanawa::ToeiMitaLineConnectedToNambokuLine.instance

    #---- 小竹向原

    elsif /\A小竹向原駅で和光市行きに連絡します。(?:（ただし、列車の遅延等により接続できない場合もありますのでご了承ください）|（ただし、列車の遅れにより連絡しない場合もあります。?）)?\Z/ === str
      YurakuchoFukusohin::KotakeMukaihara::ConnectedForWakoshi.instance

    #---- 有楽町線・副都心線

    else
      if /\A東急線内(各駅|急行|通勤特急|特急)運転\Z/ === str
        YurakuchoFukusohin::TrainType::TokyuToyoko.set_from_string( $1 )
      elsif /\A東武線内(各駅)運転\Z/ === str
        YurakuchoFukusohin::TrainType::TobuTojo.set_from_string( $1 )
      elsif /\A西武線内(各駅|快速(?:急行)?|準急)運転\Z/ === str
        YurakuchoFukusohin::TrainType::SeibuIkebukuro.set_from_string( $1 )
      else
        puts "\"#{str}\""
        raise "Error: \"#{str}\" is not valid."
      end

    end

  end

end