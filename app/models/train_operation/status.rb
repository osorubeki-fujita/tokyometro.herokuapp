class TrainOperation::Status < ActiveRecord::Base

  has_many :train_operation_infos , class: ::TrainOperation::Info
  has_many :train_operation_old_infos , class: ::TrainOperation::OldInfo

  def name_ja_for_display
    if name_ja.present?
      name_ja
    elsif name_ja == "遅延"
      nil
    else
      in_api
    end
  end

  def name_en_for_display
    if name_ja == "遅延"
      nil
    elsif name_en.present?
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
