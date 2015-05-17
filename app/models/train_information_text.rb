class TrainInformationText < ActiveRecord::Base

  has_many :train_informations
  has_many :train_information_olds

  def on_schedule?
    in_api == "現在、平常どおり運転しています。"
  end

  # 運行障害が発生した場所を取得するメソッド
  # @return [String]
  def place
    if in_api.string?
      if /(.+線) *(.+)駅?\s*[-ー－~～―‐・･]\s*(.+)駅?間?で発生/ === in_api
        if $1.present?
          "（#{$1}）#{$2} - #{$3}"
        else
          "#{$2} - #{$3}"
        end
      elsif /(.+線) *(.+)駅?(?:構内)?で発生/ === in_api
        if $1.present?
          "（#{$1}）#{$2}"
        else
          "#{$2}"
        end
      else
        nil
      end
    else
      nil
    end
  end

  def self.review!
    ::TrainInformationText.all.each do | text |
      text_in_api = text.in_api
      text_in_api_new = text.in_api.process_train_operation_info_text
      text.update( in_api: text_in_api_new )
    end
    return nil
  end

end