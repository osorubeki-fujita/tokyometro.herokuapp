class Train::Type::Note::Info < ActiveRecord::Base

  belongs_to :info , class: ::Train::Type::Info
  belongs_to :text , class: ::Train::Type::Note::Text

  has_many :additional_infos , class: ::Train::Type::Note::Additional::Info , foreign_key: :note_info_id
  has_many :additional_texts , class: ::Train::Type::Note::Additional::Text , through: :additional_infos

end
