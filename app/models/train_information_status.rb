class TrainInformationStatus < ActiveRecord::Base
  has_many :train_informations
  has_many :train_information_olds

  def name_ja_for_display
    if name_ja.present?
      name_ja
    else
      in_api
    end
  end

  def name_en_for_display
    if name_en.present?
      name_en
    else
      nil
    end
  end

  def delayed?
    [ /ダイヤ乱れ/ , /遅延/ ].any? { | info | info === name_ja }
  end

  def suspended?
    [ "運転見合わせ" , /運休/ ].any? { | info | info === name_ja }
  end

end